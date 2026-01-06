import 'package:flutter/material.dart';
import 'package:shital_video_editor/controllers/editor_controller.dart';
import 'package:shital_video_editor/shared/custom_painters.dart';
import 'package:shital_video_editor/shared/core/constants.dart';
import 'package:get/get.dart';

class VideoTimeline extends StatefulWidget {
  const VideoTimeline({Key? key});

  @override
  State<VideoTimeline> createState() => _VideoTimelineState();
}

class _VideoTimelineState extends State<VideoTimeline> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditorController>(
      builder: (controller) {
        if (!controller.isVideoInitialized) {
          return const SizedBox.shrink();
        }

        // Calculate positions based on current trim values
        double startHandlePosition = (controller.trimStart / 1000.0) * 50.0;
        double endHandlePosition = (controller.trimEnd / 1000.0) * 50.0;
        double timelineWidth = (controller.videoDurationMs / 1000.0) * 50.0;

        // Base timeline widget
        Widget timelineContent = CustomPaint(
          painter: TrimPainter(
            controller.trimStart,
            controller.trimEnd,
            isTrimmingMode: controller.selectedOptions == SelectedOptions.TRIM,
          ),
          child: Container(
            width: timelineWidth,
            height: 50.0,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.video_camera_back,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    controller.project.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
            ),
          ),
        );

        // If in trim mode, use a Stack to overlay gesture detectors for handles
        Widget timelineWidget = timelineContent;
        if (controller.selectedOptions == SelectedOptions.TRIM) {
          const double handleTouchWidth = 40.0;
          timelineWidget = Stack(
            children: [
              timelineContent,
              // Start Handle Detector
              Positioned(
                left: startHandlePosition - (handleTouchWidth / 2),
                top: 0,
                bottom: 0,
                width: handleTouchWidth,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onHorizontalDragStart: (_) {
                    controller.isTimelineScrollLocked = true;
                    controller.update();
                  },
                  onHorizontalDragUpdate: (details) {
                    _updateTrimStart(controller, details.delta.dx);
                  },
                  onHorizontalDragEnd: (_) {
                    controller.isTimelineScrollLocked = false;
                    controller.update();
                  },
                  onHorizontalDragCancel: () {
                    controller.isTimelineScrollLocked = false;
                    controller.update();
                  },
                  child: Container(color: Colors.transparent),
                ),
              ),
              // End Handle Detector
              Positioned(
                left: endHandlePosition - (handleTouchWidth / 2),
                top: 0,
                bottom: 0,
                width: handleTouchWidth,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onHorizontalDragStart: (_) {
                    controller.isTimelineScrollLocked = true;
                    controller.update();
                  },
                  onHorizontalDragUpdate: (details) {
                    _updateTrimEnd(controller, details.delta.dx);
                  },
                  onHorizontalDragEnd: (_) {
                    controller.isTimelineScrollLocked = false;
                    controller.update();
                  },
                  onHorizontalDragCancel: () {
                    controller.isTimelineScrollLocked = false;
                    controller.update();
                  },
                  child: Container(color: Colors.transparent),
                ),
              ),
            ],
          );
        }

        return Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.5),
            timelineWidget,
            SizedBox(width: MediaQuery.of(context).size.width * 0.5),
          ],
        );
      },
    );
  }

  void _updateTrimStart(EditorController controller, double deltaPixels) {
    // Convert pixel delta to milliseconds
    double deltaMs = (deltaPixels / 50.0) * 1000;

    int newStartMs = controller.trimStart + deltaMs.toInt();
    int currentEndMs = controller.trimEnd;

    // Constraints
    // 1. Minimum 0
    if (newStartMs < 0) {
      newStartMs = 0;
    }
    // 2. Max must be less than end (with min duration check)
    if (newStartMs >= currentEndMs - 100) {
      newStartMs = currentEndMs - 100;
    }

    controller.project.transformations.trimStart =
        Duration(milliseconds: newStartMs);
    controller.update();
  }

  void _updateTrimEnd(EditorController controller, double deltaPixels) {
    // Convert pixel delta to milliseconds
    double deltaMs = (deltaPixels / 50.0) * 1000;

    int newEndMs = controller.trimEnd + deltaMs.toInt();
    int currentStartMs = controller.trimStart;

    // Constraints
    // 1. Max video duration
    if (newEndMs > controller.videoDurationMs) {
      newEndMs = controller.videoDurationMs.toInt();
    }
    // 2. Min must be greater than start (with min duration check)
    if (newEndMs <= currentStartMs + 100) {
      newEndMs = currentStartMs + 100;
    }

    controller.project.transformations.trimEnd =
        Duration(milliseconds: newEndMs);
    controller.update();
  }
}
