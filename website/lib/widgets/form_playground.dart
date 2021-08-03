import 'package:flutter/material.dart';
import 'package:lo_form/lo_form.dart';

import '../forms/register_form.dart';
import 'form_state_summary.dart';

class FormPlayground extends StatefulWidget {
  @override
  _FormPlaygroundState createState() => _FormPlaygroundState();
}

class _FormPlaygroundState extends State<FormPlayground> {
  LoFormState? formState;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const cardsHeight = 500.0;
        final isSmallScreen = constraints.maxWidth < 720;
        final padding = isSmallScreen ? 16.0 : 24.0;
        final direction = isSmallScreen ? Axis.vertical : Axis.horizontal;
        final maxHeight = isSmallScreen ? double.infinity : cardsHeight;

        return Padding(
          padding: EdgeInsets.all(padding),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 1080,
                maxHeight: maxHeight,
              ),
              child: Flex(
                direction: direction,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: _PaddedCard(
                      height: cardsHeight,
                      padding: padding,
                      child: RegisterForm(
                        onStateChanged: (value) => setState(
                          () => formState = value,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: padding / 2,
                    height: padding / 2,
                  ),
                  Flexible(
                    child: _PaddedCard(
                      height: cardsHeight,
                      padding: padding,
                      child: formState != null
                          ? FormStateSummary(formState!)
                          : const SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PaddedCard extends StatelessWidget {
  final double height;
  final double padding;
  final Widget child;

  const _PaddedCard({
    Key? key,
    required this.height,
    this.padding = 24,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: child,
        ),
      ),
    );
  }
}
