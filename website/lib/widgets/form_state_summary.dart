import 'package:flutter/material.dart';
import 'package:lo_form/lo_form.dart';

class FormStateSummary extends StatelessWidget {
  final LoFormState state;

  const FormStateSummary(this.state);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
            ),
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Field')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Initial')),
                DataColumn(label: Text('Touched')),
              ],
              rows: [
                for (var field in state.fields.values) ...{
                  DataRow(
                    cells: [
                      DataCell(Text(field.name)),
                      DataCell(_buildStatusChip(field.status)),
                      DataCell(Text('${field.initialValue ?? '-'}')),
                      DataCell(_buildBoolIcon(field.touched)),
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
                    DataCell.empty,
                    DataCell.empty,
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Icon _buildBoolIcon(bool value) {
    return Icon(
      value ? Icons.check_circle : Icons.cancel,
      color: value ? Colors.green : Colors.red,
      size: 18,
    );
  }

  Chip _buildStatusChip(LoStatus status) {
    final colors = {
      LoStatus.pure: Colors.blue[700],
      LoStatus.valid: Colors.green[600],
      LoStatus.invalid: Colors.red[700],
      LoStatus.mixed: Colors.indigo[900],
      LoStatus.loading: Colors.blueGrey,
      LoStatus.success: Colors.green[800],
      LoStatus.failure: Colors.red[900],
    };

    return Chip(
      backgroundColor: colors[status],
      label: Text(
        status.toString().split('.').last,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
