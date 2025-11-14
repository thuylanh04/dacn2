import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_signup_screen.dart';
import 'screens/create_account_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/home_screen.dart';
import 'constants/colors.dart';
import 'providers/app_state_provider.dart';
import 'screens/quick_analysis_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/transaction_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/main_layout.dart';
import 'screens/transport_category_screen.dart';
import 'screens/add_expenses_screen.dart';

void main() {
  runApp(const ProviderScope(child: FinWiseApp()));
}

class FinWiseApp extends ConsumerWidget {
  const FinWiseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);

    final router = GoRouter(
      redirect: (context, state) {
        // Make redirect location-aware so that in the login/signup
        // state we allow navigation to '/signup' and '/forgot-password'.
        final location = state.uri.path;

        if (appState.appStatus == AppStatus.splash) {
          if (location != '/splash') return '/splash';
          return null;
        }

        if (appState.appStatus == AppStatus.onboarding) {
          if (location != '/onboarding') return '/onboarding';
          return null;
        }

        if (appState.appStatus == AppStatus.loginSignup) {
          // Allowed routes while in login/signup flow
          const allowed = ['/login', '/signup', '/forgot-password'];
          if (allowed.contains(location)) return null;
          // If user is at root or elsewhere, send to login
          return '/login';
        }

        // appStatus == home
        if (appState.appStatus == AppStatus.home) {
          // Allow navigation to home and other post-auth screens
          const allowedHome = [
            '/home',
            '/quick-analysis',
            '/categories',
            '/transaction',
            '/profile',
            '/transport',
            '/add-expense',
          ];
          if (allowedHome.contains(location)) return null;
          return '/home';
        }

        return null;
      },
      routes: [
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginSignupScreen(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => const CreateAccountScreen(),
        ),
        GoRoute(
          path: '/forgot-password',
          builder: (context, state) => const ForgotPasswordScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const MainLayout(initialIndex: 0),
        ),
        GoRoute(
          path: '/quick-analysis',
          builder: (context, state) => const MainLayout(initialIndex: 1),
        ),
        GoRoute(
          path: '/transaction',
          builder: (context, state) => const MainLayout(initialIndex: 2),
        ),
        GoRoute(
          path: '/categories',
          builder: (context, state) => const MainLayout(initialIndex: 3),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const MainLayout(initialIndex: 4),
        ),
        GoRoute(
          path: '/transport',
          builder: (context, state) => const TransportCategoryScreen(),
        ),
        GoRoute(
          path: '/add-expense',
          builder: (context, state) => const AddExpensesScreen(),
        ),
      ],
    );

    return MaterialApp.router(
      title: 'FinWise',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      routerConfig: router,
    );
  }
}
