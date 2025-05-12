import 'package:flutter/material.dart';

class SimpleFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(T data) child;

  const SimpleFutureBuilder({
    super.key,
    required this.future,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          return child(data);
        }
        return Text("Error fetching member data");
      },
    );
  }
}
