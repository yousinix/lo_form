import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lo_form/lo_form.dart';

void main() {
  group('LoCheckbox', () {
    testWidgets('renders correctly with initial value',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: LoForm<String>(
              onSubmit: (_, __) => true,
              builder: (form) => const LoCheckbox(
                loKey: 'test',
                initialValue: true,
                label: Text('Test Checkbox'),
              ),
            ),
          ),
        ),
      );

      final checkboxFinder = find.byType(Checkbox);
      expect(checkboxFinder, findsOneWidget);

      final checkbox = tester.widget<Checkbox>(checkboxFinder);
      expect(checkbox.value, true);

      expect(find.text('Test Checkbox'), findsOneWidget);
    });

    testWidgets('updates value on tap', (WidgetTester tester) async {
      bool? formValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: LoForm<String>(
              onSubmit: (_, __) => true,
              onChanged: (state) {
                formValue = state.fields['test']!.value as bool?;
              },
              builder: (form) => const LoCheckbox(
                loKey: 'test',
                label: Text('Test Checkbox'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      expect(formValue, true);
    });

    testWidgets('shows error message', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: LoForm<String>(
              onSubmit: (_, __) => true,
              builder: (form) => LoCheckbox(
                loKey: 'test',
                label: const Text('Test Checkbox'),
                validators: [
                  LoFieldValidator((v) => v != true ? 'Must be checked' : null),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Checkbox));
      await tester.pump();
      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      expect(find.text('Must be checked'), findsOneWidget);
    });

    testWidgets('applies custom props', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: LoForm<String>(
              onSubmit: (_, __) => true,
              builder: (form) => const LoCheckbox(
                loKey: 'test',
                label: Text('Test Checkbox'),
                props: CheckboxProps(
                  activeColor: Colors.red,
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.activeColor, Colors.red);
    });

    testWidgets('custom error style', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: LoForm<String>(
              onSubmit: (_, __) => true,
              builder: (form) => LoCheckbox(
                loKey: 'test',
                label: const Text('Test Checkbox'),
                validators: [
                  LoFieldValidator((v) => v != true ? 'Must be checked' : null),
                ],
                errorStyle: const TextStyle(color: Colors.orange),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Checkbox));
      await tester.pump();
      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      final errorText = tester.widget<Text>(find.text('Must be checked'));
      expect(errorText.style?.color, Colors.orange);
    });
  });
}
