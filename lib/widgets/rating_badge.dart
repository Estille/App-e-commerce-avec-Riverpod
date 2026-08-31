import 'package:flutter/material.dart';

/// Widget réutilisable : affiche une note avec une étoile.
class RatingBadge extends StatelessWidget {
  final double rating;

  const RatingBadge({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star, size: 14, color: Colors.amber),
        const SizedBox(width: 2),
        Text(rating.toStringAsFixed(1), style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
