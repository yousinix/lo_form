import 'package:flutter/material.dart';
import 'package:lo_form/lo_form.dart';

class FormStateSummary extends StatelessWidget {
  final LoFormState state;

  const FormStateSummary(this.state);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Form State',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Field')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Initial')),
              DataColumn(label: Text('Touched')),
            ],
            rows: [
              for (var key in state.values.keys) ...{
                DataRow(
                  cells: [
                    DataCell(Text(key)),
                    DataCell(_buildStatusChip(state.statuses[key]!)),
                    DataCell(Text('${state.initialValues?[key] ?? '-'}')),
                    DataCell(_buildBoolIcon(state.touched[key]!)),
                  ],
                )
              },
              DataRow(
                selected: true,
                cells: [
                  const DataCell(
                    Text(
                      'Form',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  DataCell(_buildStatusChip(state.status)),
                  const DataCell(SizedBox.shrink()),
                  const DataCell(SizedBox.shrink()),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Icon _buildBoolIcon(bool value) {
    return Icon(
      value ? Icons.check_circle : Icons.cancel,
      color: value ? Colors.green : Colors.red,
      size: 18,
    );
  }

  Chip _buildStatusChip(LoFormStatus status) {
    final colors = {
      LoFormStatus.pure: Colors.blue[700],
      LoFormStatus.valid: Colors.green[600],
      LoFormStatus.invalid: Colors.red[700],
      LoFormStatus.mixed: Colors.indigo[900],
      LoFormStatus.loading: Colors.blueGrey,
      LoFormStatus.success: Colors.green[800],
      LoFormStatus.failure: Colors.red[900],
    };

    return Chip(
      backgroundColor: colors[status],
      label: Text(
        status.toString().split('.').last,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );
  }
}
