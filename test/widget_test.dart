import 'package:flutter_test/flutter_test.dart';
import 'package:gemstore/main.dart';

void main() {
  testWidgets('GemStore app test', (WidgetTester tester) async {
    await tester.pumpWidget(const GemStoreApp());

    expect(find.byType(GemStoreApp), findsOneWidget);
  });
}