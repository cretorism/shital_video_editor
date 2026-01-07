import 'package:flutter_test/flutter_test.dart';
import 'package:shital_video_editor/models/text.dart';

void main() {
  test('Sorting logic returns a copy and does not mutate source', () {
    // Mimic the Controller state
    String selectedTextId = '';

    int textComparator(TextTransformation a, TextTransformation b) {
      if (selectedTextId == a.id) return 1;
      if (selectedTextId == b.id) return -1;
      return a.msStartTime.compareTo(b.msStartTime);
    }

    // Mimic Project data
    final t1 =
        TextTransformation(text: 'First', msDuration: 1000, msStartTime: 1000);
    final t2 =
        TextTransformation(text: 'Second', msDuration: 1000, msStartTime: 0);

    final originalList = <TextTransformation>[t1, t2];

    // Mimic the fixed getter
    // get texts => List<TextTransformation>.from(project.transformations.texts)..sort(textComparator);
    final sortedList = List<TextTransformation>.from(originalList)
      ..sort(textComparator);

    // Sorted order: t2 (start 0), t1 (start 1000)
    expect(sortedList[0], t2);
    expect(sortedList[1], t1);

    // CRITICAL: Original list must NOT be modified
    expect(originalList[0], t1);
    expect(originalList[1], t2);

    // Verify pure sort on original list DOES mutate (to prove the fix is necessary)
    final mutatedList = originalList..sort(textComparator);
    expect(mutatedList[0], t2); // Mutated
    expect(originalList[0], t2); // Original is now mutated
  });
}
