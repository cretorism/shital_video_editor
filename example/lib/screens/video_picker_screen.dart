import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:example/blocs/video_picker_bloc.dart';
import 'package:example/blocs/video_picker_event.dart';
import 'package:example/blocs/video_picker_state.dart';
import 'package:shital_video_editor/shital_video_editor.dart'; // Import the editor package

class VideoPickerScreen extends StatefulWidget {
  const VideoPickerScreen({Key? key}) : super(key: key);

  @override
  _VideoPickerScreenState createState() => _VideoPickerScreenState();
}

class _VideoPickerScreenState extends State<VideoPickerScreen> {
  VideoPlayerController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Picker with Editor'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocConsumer<VideoPickerBloc, VideoPickerState>(
        listener: (context, state) {
          if (state is VideoPickerError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is VideoPickerSuccess) {
            // After picking video, open the editor
            _openEditor(context, state.videoPath);
          } else if (state is VideoEditorOpened) {
            // Already handled in the UI logic
          } else if (state is VideoEditorSuccess) {
            // Video was edited, now show the edited video
            _controller?.dispose();
            _controller = null;
          }
        },
        builder: (context, state) {
          if (state is VideoPickerLoading || state is VideoEditorOpened) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is VideoEditorSuccess) {
            return _buildVideoPlayer(state.editedVideoPath);
          } else if (state is VideoPickerSuccess) {
            // Show the original video before opening editor
            _openEditor(context, state.videoPath);
            return const Center(child: CircularProgressIndicator());
          } else {
            return _buildInitialContent();
          }
        },
      ),
    );
  }

  void _openEditor(BuildContext context, String videoPath) {
    // Open the ShitalVE editor with the selected video
    context.read<VideoPickerBloc>().add(OpenEditorPressed(videoPath));

    // Navigate to the editor
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShitalVE(initialVideo: videoPath),
      ),
    ).then<void>((result) {
      // Handle the result after the editor is closed
      if (result != null && result is File) {
        // Use context.mounted to check if widget is still mounted
        if (context.mounted) {
          context.read<VideoPickerBloc>().add(VideoEdited(result.path));
        }
      }
    });
  }

  Widget _buildInitialContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.video_library,
            size: 100,
            color: Colors.grey,
          ),
          const SizedBox(height: 20),
          const Text(
            'No video selected',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              context.read<VideoPickerBloc>().add(const PickVideoPressed());
            },
            icon: const Icon(Icons.video_file),
            label: const Text('Pick Video from Gallery'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer(String videoPath) {
    // Create a new controller for the current video
    if (_controller != null) {
      _controller!.dispose();
    }

    _controller = VideoPlayerController.file(
      File(videoPath),
    )..initialize().then((_) {
        setState(() {});
        _controller!.play();
      });

    return Column(
      children: [
        Expanded(
          child: _controller!.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                )
              : Container(
                  color: Colors.black,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ),
        Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  if (_controller!.value.isPlaying) {
                    _controller!.pause();
                  } else {
                    _controller!.play();
                  }
                },
                icon: Icon(
                  _controller != null && _controller!.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
                label: Text(
                  _controller != null && _controller!.value.isPlaying
                      ? 'Pause'
                      : 'Play',
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<VideoPickerBloc>().add(const PickVideoPressed());
                },
                icon: const Icon(Icons.video_file),
                label: const Text('Change Video'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}