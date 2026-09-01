import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Widget réutilisable : gère de façon uniforme les 3 états d'un AsyncValue
/// (chargement / erreur / données) pour éviter de répéter .when() partout.
/// L'état d'erreur propose un bouton "Réessayer" qui invalide le provider
/// concerné, ce qui démontre concrètement la gestion d'erreur dans l'UI.
class AsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback? onRetry;

  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 12),
              Text('Une erreur est survenue :\n$error', textAlign: TextAlign.center),
              if (onRetry != null) ...[
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Réessayer'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
