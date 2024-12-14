import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mostro_mobile/app/app_routes.dart';
import 'package:mostro_mobile/app/app_theme.dart';
import 'package:mostro_mobile/features/auth/providers/auth_notifier_provider.dart';
import 'package:mostro_mobile/generated/l10n.dart';
import 'package:mostro_mobile/features/auth/notifiers/auth_state.dart';
import 'package:mostro_mobile/shared/widgets/navigation_listener_widget.dart';
import 'package:mostro_mobile/shared/widgets/notification_listener_widget.dart';

class MostroApp extends ConsumerWidget {
  const MostroApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authNotifierProvider, (previous, state) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        if (state is AuthAuthenticated || state is AuthRegistrationSuccess) {
          context.go('/');
        } else if (state is AuthUnregistered || state is AuthUnauthenticated) {
          context.go('/welcome');
        }
      });
    });

    final navigatorKey = GlobalKey<NavigatorState>();

    return MaterialApp.router(
      title: 'Mostro',
      theme: AppTheme.theme,
      routerConfig: goRouter,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      builder: (context, child) {
        return NotificationListenerWidget(
            navigator: navigatorKey,
            child: NavigationListenerWidget(
                navigator: navigatorKey, child: child!));
      },
    );
  }
}
