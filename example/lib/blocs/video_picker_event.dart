import 'package:equatable/equatable.dart';

abstract class VideoPickerEvent extends Equatable {
  const VideoPickerEvent();

  @override
  List<Object?> get props => [];
}

class PickVideoPressed extends VideoPickerEvent {
  const PickVideoPressed();

  @override
  List<Object?> get props => [];
}

class VideoPicked extends VideoPickerEvent {
  final String? videoPath;

  const VideoPicked(this.videoPath);

  @override
  List<Object?> get props => [videoPath];
}

class OpenEditorPressed extends VideoPickerEvent {
  final String videoPath;

  const OpenEditorPressed(this.videoPath);

  @override
  List<Object?> get props => [videoPath];
}

class VideoEdited extends VideoPickerEvent {
  final String? editedVideoPath;

  const VideoEdited(this.editedVideoPath);

  @override
  List<Object?> get props => [editedVideoPath];
}

class VideoPickError extends VideoPickerEvent {
  final String error;

  const VideoPickError(this.error);

  @override
  List<Object?> get props => [error];
}