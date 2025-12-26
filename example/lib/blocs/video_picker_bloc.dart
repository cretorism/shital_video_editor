import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/blocs/video_picker_event.dart';
import 'package:example/blocs/video_picker_state.dart';
import 'package:example/models/video_repository.dart';

class VideoPickerBloc extends Bloc<VideoPickerEvent, VideoPickerState> {
  final VideoRepository _videoRepository;

  VideoPickerBloc({VideoRepository? videoRepository})
      : _videoRepository = videoRepository ?? VideoRepository(),
        super(const VideoPickerInitial()) {
    on<PickVideoPressed>(_onPickVideoPressed);
    on<OpenEditorPressed>(_onOpenEditorPressed);
    on<VideoEdited>(_onVideoEdited);
  }

  Future<void> _onPickVideoPressed(
    PickVideoPressed event,
    Emitter<VideoPickerState> emit,
  ) async {
    emit(const VideoPickerLoading());
    try {
      final video = await _videoRepository.pickVideoFromGallery();
      if (video != null) {
        emit(VideoPickerSuccess(video.path));
      } else {
        emit(const VideoPickerError('No video was selected'));
      }
    } catch (e) {
      emit(VideoPickerError('Failed to pick video: $e'));
    }
  }

  Future<void> _onOpenEditorPressed(
    OpenEditorPressed event,
    Emitter<VideoPickerState> emit,
  ) async {
    emit(VideoEditorOpened(event.videoPath));
  }

  Future<void> _onVideoEdited(
    VideoEdited event,
    Emitter<VideoPickerState> emit,
  ) async {
    if (event.editedVideoPath != null) {
      emit(VideoEditorSuccess(event.editedVideoPath!));
    } else {
      emit(const VideoPickerError('Edited video path is null'));
    }
  }
}