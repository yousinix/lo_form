import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lo_form/lo_form.dart';

void main() {
  group('LoDropdown', () {
    const items = [
      DropdownMenuItem(value: 1, child: Text('One')),
      DropdownMenuItem(value: 2, child: Text('Two')),
      DropdownMenuItem(value: 3, child: Text('Three')),
    ];

    testWidgets('renders correctly with initial value',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: LoForm<String>(
              onSubmit: (_, __) => true,
              builder: (form) => const LoDropdown<int>(
                loKey: 'test',
                initialValue: 2,
                items: items,
              ),
            ),
          ),
        ),
      );

      final dropdownFinder = find.byType(DropdownButton<int?>);
      expect(dropdownFinder, findsOneWidget);

      final dropdown = tester.widget<DropdownButton<int?>>(dropdownFinder);
      expect(dropdown.value, 2);
    });

    testWidgets('updates value on selection', (WidgetTester tester) async {
      int? formValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: LoForm<String>(
              onSubmit: (_, __) => true,
              onChanged: (state) {
                formValue = state.fields['test']!.value as int?;
              },
              builder: (form) => const LoDropdown<int>(
                loKey: 'test',
                items: items,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(DropdownButton<int?>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Three').last);
      await tester.pumpAndSettle();

      expect(formValue, 3);
    });

    testWidgets('shows error message', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: LoForm<String>(
              onSubmit: (_, __) => true,
              builder: (form) => Column(
                children: [
                  LoDropdown<int>(
                    loKey: 'test',
                    items: items,
                    validators: [
                      LoFieldValidator((v) => v == null ? 'Required' : null),
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

      await tester.tap(find.byType(DropdownButton<int?>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Three').last);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(DropdownButton<int?>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Choose an option').last);
      await tester.pumpAndSettle();

      expect(find.text('Required'), findsOneWidget);
    });

    testWidgets('applies custom props', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: LoForm<String>(
              onSubmit: (_, __) => true,
              builder: (form) => const LoDropdown<int>(
                loKey: 'test',
                items: items,
                props: DropdownProps(
                  icon: Icon(Icons.arrow_downward),
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
    });

    testWidgets('debounces value changes', (WidgetTester tester) async {
      int changeCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: LoForm<String>(
              onSubmit: (_, __) => true,
              onChanged: (_) => changeCount++,
              builder: (form) => const LoDropdown<int>(
                loKey: 'test',
                items: items,
                debounceTime: Duration(milliseconds: 100),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(DropdownButton<int?>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('One').last);
      await tester.pump(const Duration(milliseconds: 50));
      await tester.tap(find.byType(DropdownButton<int?>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Two').last);
      await tester.pump(const Duration(milliseconds: 100));

      expect(changeCount, 2);
    });
  });
}
