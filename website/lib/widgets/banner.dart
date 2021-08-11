import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../util/constants.dart';
import '../util/theme.dart';

class Banner extends StatelessWidget {
  static const kHeight = 320.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kHeight,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'LoForm',
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            'Lightweight Flutter form library',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.color
                  ?.withOpacity(0.64),
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 24,
            runSpacing: 16,
            children: [
              _InstallButton(),
              ElevatedButton(
                onPressed: () => launch(kDocsUrl),
                child: const Text('Get Started'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _InstallButton extends StatefulWidget {
  @override
  _InstallButtonState createState() => _InstallButtonState();
}

class _InstallButtonState extends State<_InstallButton> {
  late bool isCopied;

  @override
  void initState() {
    super.initState();
    isCopied = false;
  }

  @override
  Widget build(BuildContext context) {
    const dependency = 'lo_form: ^$kVersion';

    return Tooltip(
      message: 'Click to copy',
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              backgroundColor: MaterialStateProperty.all(
                AppColors.grey900,
              ),
            ),
        onPressed: () {
          Clipboard.setData(
            const ClipboardData(
              text: dependency,
            ),
          );

          setState(() => isCopied = true);
          Future.delayed(
            const Duration(seconds: 2),
            () => setState(() => isCopied = false),
          );
        },
        child: SizedBox(
          width: 200,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity:  Tween<double>(
                  begin: 0.0,
                  end: 1,
                ).animate(animation),
                child: child,
              );
            },
            child: Text(
              isCopied ? 'Copied' : dependency,
              key: ValueKey<bool>(isCopied),
              textAlign: TextAlign.center,
              style: GoogleFonts.robotoMono(),
            ),
          ),
        ),
      ),
    );
  }
}
