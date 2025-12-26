import 'package:equatable/equatable.dart';

abstract class VideoPickerState extends Equatable {
  const VideoPickerState();

  @override
  List<Object?> get props => [];
}

class VideoPickerInitial extends VideoPickerState {
  const VideoPickerInitial();
}

class VideoPickerLoading extends VideoPickerState {
  const VideoPickerLoading();
}

class VideoPickerSuccess extends VideoPickerState {
  final String videoPath;

  const VideoPickerSuccess(this.videoPath);

  @override
  List<Object?> get props => [videoPath];
}

class VideoEditorOpened extends VideoPickerState {
  final String videoPath;

  const VideoEditorOpened(this.videoPath);

  @override
  List<Object?> get props => [videoPath];
}

class VideoEditorSuccess extends VideoPickerState {
  final String editedVideoPath;

  const VideoEditorSuccess(this.editedVideoPath);

  @override
  List<Object?> get props => [editedVideoPath];
}

class VideoPickerError extends VideoPickerState {
  final String error;

  const VideoPickerError(this.error);

  @override
  List<Object?> get props => [error];
}