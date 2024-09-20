import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lo_form/lo_form.dart';

void main() {
  group('LoTextField', () {
    testWidgets('renders correctly with initial value',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: LoForm<String>(
              onSubmit: (_, __) => true,
              builder: (form) => const LoTextField(
                loKey: 'test',
                initialValue: 'initial',
              ),
            ),
          ),
        ),
      );

      final textFieldFinder = find.byType(TextFormField);
      expect(textFieldFinder, findsOneWidget);

      final textField = tester.widget<TextFormField>(textFieldFinder);
      expect(textField.initialValue, 'initial');
    });

    testWidgets('updates value on change', (WidgetTester tester) async {
      String? formValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: LoForm<String>(
              onSubmit: (_, __) => true,
              onChanged: (state) {
                formValue = state.fields['test']!.value as String?;
              },
              builder: (form) => const LoTextField(
                loKey: 'test',
              ),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'new value');
      await tester.pump();

      expect(formValue, 'new value');
    });

    testWidgets('shows error message', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: LoForm<String>(
              onSubmit: (_, __) => true,
              builder: (form) => Column(
                children: [
                  LoTextField(
                    loKey: 'test',
                    validators: [
                      LoRequiredValidator('Field is required'),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: form.handleSubmit,
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      final textField = find.byType(TextFormField);
      await tester.enterText(textField, 'Hello');
      await tester.enterText(textField, '');
      final button = find.byType(ElevatedButton);
      await tester.tap(button);
      await tester.pump();

      expect(find.text('Field is required'), findsOneWidget);
    });

    testWidgets('applies custom props', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: LoForm<String>(
              onSubmit: (_, __) => true,
              builder: (form) => const LoTextField(
                loKey: 'test',
                props: TextFieldProps(
                  decoration: InputDecoration(
                    hintText: 'Custom hint',
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Custom hint'), findsOneWidget);
    });

    testWidgets('debounces value changes', (WidgetTester tester) async {
      int changeCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: LoForm<String>(
              onSubmit: (_, __) => true,
              onChanged: (_) => changeCount++,
              builder: (form) => const LoTextField(
                loKey: 'test',
                debounceTime: Duration(milliseconds: 110),
              ),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'a');
      await tester.pump(const Duration(milliseconds: 50));
      await tester.enterText(find.byType(TextFormField), 'ab');
      await tester.pump(const Duration(milliseconds: 50));
      await tester.enterText(find.byType(TextFormField), 'abc');
      await tester.pump(const Duration(milliseconds: 110));

      expect(changeCount, 2);
    });
  });
}
