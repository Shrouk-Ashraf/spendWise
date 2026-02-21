import 'package:flutter/material.dart';
import 'package:spendwise/features/layout/presentation/widgets/bottom_nav.dart';
class ScaffoldWithBottomNav extends StatelessWidget {
  const ScaffoldWithBottomNav({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const BottomNav(),
    );
  }
}