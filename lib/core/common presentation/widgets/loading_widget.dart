import 'package:flutter/material.dart';

class LoadingWidgets extends StatelessWidget {
  const LoadingWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
