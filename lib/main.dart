import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostro_mobile/core/theme/app_theme.dart';
import 'package:mostro_mobile/presentation/auth/bloc/auth_state.dart';
import 'package:mostro_mobile/providers/riverpod_providers.dart';
import 'package:mostro_mobile/services/nostr_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mostro_mobile/core/routes/app_routes.dart';
import 'package:mostro_mobile/presentation/home/bloc/home_bloc.dart';
import 'package:mostro_mobile/presentation/chat_list/bloc/chat_list_bloc.dart';
import 'package:mostro_mobile/presentation/profile/bloc/profile_bloc.dart';
import 'package:mostro_mobile/presentation/auth/bloc/auth_bloc.dart';
import 'package:mostro_mobile/data/repositories/auth_repository.dart';
import 'package:mostro_mobile/core/utils/biometrics_helper.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final nostrService = NostrService();
  await nostrService.init();

  final prefs = await SharedPreferences.getInstance();
  final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  final biometricsHelper = BiometricsHelper();

  runApp(ProviderScope(
      child: MyApp(
          isFirstLaunch: isFirstLaunch, biometricsHelper: biometricsHelper)));
}

class MyApp extends ConsumerWidget {
  final bool isFirstLaunch;
  final BiometricsHelper biometricsHelper;

  const MyApp({
    super.key,
    required this.isFirstLaunch,
    required this.biometricsHelper,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeBloc = ref.watch(homeBlocProvider);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authRepository: AuthRepository(
              biometricsHelper: biometricsHelper,
            ),
          ),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => homeBloc,
        ),
        BlocProvider<ChatListBloc>(
          create: (context) => ChatListBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated || state is AuthRegistrationSuccess) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.home);
          } else if (state is AuthUnregistered ||
              state is AuthUnauthenticated) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.welcome);
          }
        },
        child: MaterialApp(
          title: 'Mostro',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: AppTheme.dark1,
          ),
          initialRoute: isFirstLaunch ? AppRoutes.welcome : AppRoutes.home,
          routes: AppRoutes.routes,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
        ),
      ),
    );
  }
}
