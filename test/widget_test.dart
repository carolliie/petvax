import 'package:flutter_test/flutter_test.dart';
import 'package:petvaxapp/main.dart';

void main() {
  testWidgets('PetVax smoke test — app renders', (WidgetTester tester) async {
    await tester.pumpWidget(const PetVaxApp());
    await tester.pump();
    // App started without throwing
    expect(tester.takeException(), isNull);
  });
}
