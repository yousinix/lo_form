import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:lo_form/lo_form.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
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
                      title: 'Form Demo',
                      height: cardsHeight,
                      padding: padding,
                      action: IconButton(
                        onPressed: () => launch(
                          '$kLoFormGhUrl/blob/master/${RegisterForm.kPath}',
                        ),
                        icon: const Icon(
                          Icons.code,
                          size: 16,
                        ),
                      ),
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
                      title: 'Form State',
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
  final String title;
  final Widget? action;

  const _PaddedCard({
    Key? key,
    required this.height,
    this.padding = 24,
    required this.child,
    required this.title,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 32,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    if (action != null) ...{
                      action!,
                    }
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
