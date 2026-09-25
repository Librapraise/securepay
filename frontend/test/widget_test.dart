import 'package:flutter_test/flutter_test.dart';
import 'package:securepay_frontend/main.dart';

void main() {
  testWidgets('SecurePayApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SecurePayApp());
    expect(find.byType(SecurePayApp), findsOneWidget);
  });
}
