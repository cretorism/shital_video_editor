import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/log.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:ffmpeg_kit_flutter_new/session.dart';
import 'package:ffmpeg_kit_flutter_new/statistics.dart';
import 'package:shital_video_editor/shared/core/constants.dart';
import 'package:shital_video_editor/shared/helpers/ffmpeg.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:get/get.dart';
import 'package:shital_video_editor/shared/translations/translation_keys.dart' as translations;
import 'package:shared_preferences/shared_preferences.dart';

class ExportController extends GetxController {
  static ExportController get to => Get.find();

  final String command;
  final String outputPath;
  final int videoDuration; // In milliseconds
  RxBool isExporting = true.obs;
  RxBool isSavingToGallery = true.obs;
  RxBool errorExporting = false.obs;
  RxDouble exportProgress = 0.0.obs;
  List<Log> logs = [];

  ExportController({required this.command, required this.outputPath, required this.videoDuration});

  @override
  void onInit() async {
    super.onInit();

    // Register fonts
    await registerFonts();

    // Start the export process
    _exportVideo();
  }


  _exportVideo() async {
    // Execute the export command. Save the video to the gallery if the export is successful.
    await FFmpegKit.executeAsync(command, (Session session) async {
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        isExporting.value = false;
        
        SaverGallery.saveFile(
          filePath: outputPath,
          fileName: 'video_export',
          skipIfExists: false,
        ).then((saved) => saved != null ? isSavingToGallery.value = false : true);
      } else if (ReturnCode.isCancel(returnCode)) {
        print('VIDEO EXPORT CANCELLED ${session.getLogsAsString()}');
      } else {
        // There was an error exporting the video
        logs = await session.getLogs();
        for (var element in logs) {
          print('${element.getMessage()}\n');
        }
        isExporting.value = false;
        errorExporting.value = true;
      }
    }, (Log log) {
      print('${log.getMessage()}\n');
    }, (Statistics statistics) {
      if (statistics.getTime() > 0) {
        exportProgress.value = statistics.getTime() / videoDuration;
        print('Progress: ${exportProgress.value * 100}%');
      }
    });
  }
}
