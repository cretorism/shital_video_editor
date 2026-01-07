import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:shital_video_editor/shared/helpers/video.dart';
import 'package:shital_video_editor/shared/core/constants.dart';

void main() {
  test('getTextAlignmentFromPosition handles all TextPosition values', () {
    for (var position in TextPosition.values) {
      try {
        final align = getTextAlignmentFromPosition(position);
        print('$position -> $align');
        expect(align.length, 2);
        expect(align[0], isA<MainAxisAlignment>());
        expect(align[1], isA<MainAxisAlignment>());
      } catch (e) {
        fail('Failed for position $position: $e');
      }
    }
  });
}
