import 'package:flutter/widgets.dart';
import 'package:lo_form/lo_form.dart';
import 'package:provider/provider.dart';

class LoForm extends StatelessWidget {
  final void Function(Map<String, dynamic>) onSubmit;
  final Widget Function(LoFormState) builder;

  const LoForm({
    Key? key,
    required this.onSubmit,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = LoFormState(onSubmit: onSubmit);

    return ChangeNotifierProvider(
      create: (_) => state,
      child: Consumer<LoFormState>(
        builder: (_, state, __) => builder(state),
      ),
    );
  }
}
