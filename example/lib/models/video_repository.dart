import 'package:image_picker/image_picker.dart';

class VideoRepository {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickVideoFromGallery() async {
    try {
      final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
      return video;
    } catch (e) {
      throw Exception('Failed to pick video: $e');
    }
  }
}