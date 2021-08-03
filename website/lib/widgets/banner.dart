import 'package:flutter/material.dart';

class Banner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      padding: const EdgeInsets.all(24),
      color: const Color(0x111389fd),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'LoForm',
            style: Theme.of(context).textTheme.headline2?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Text("The next-gen lightweight Flutter's form library"),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Get Started'),
          )
        ],
      ),
    );
  }
}
