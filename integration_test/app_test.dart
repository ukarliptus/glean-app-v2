import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gelan_app_v2/main.dart' as app;
import 'package:gelan_app_v2/ui/common/app_strings.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App test', () {
    testWidgets('verify counter', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.text('Counter is: 0'), findsOneWidget);
      await tester.tap(find.byKey(const Key('counterButton')));
      await tester.pumpAndSettle();
      expect(find.text('Counter is: 1'), findsOneWidget);

      await Future.delayed(const Duration(seconds: 2));

      await tester.tap(find.byKey(const Key('showDialogButton')));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(Dialog, 'Stacked Rocks!'), findsOneWidget);
      await Future.delayed(const Duration(seconds: 2));

      await tester.tap(find.widgetWithText(GestureDetector, 'Got it'));
      await tester.pumpAndSettle();
      // expect to close the dialog
      expect(find.widgetWithText(Dialog, 'Stacked Rocks!'), findsNothing);
      await Future.delayed(const Duration(seconds: 2));

      await tester.tap(find.byKey(const Key('showBottomSheetButton')));
      await tester.pumpAndSettle();
      expect(find.text(ksHomeBottomSheetTitle), findsOneWidget);
      await Future.delayed(const Duration(seconds: 2));
      // tap outside the bottom sheet
      // tap center of the screen
      await tester.tapAt(const Offset(200, 200));
      await tester.pumpAndSettle();
      // expect to close the bottom sheet
    });
  });
}
