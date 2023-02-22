import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpense/core/constants/colors.dart';
import 'package:xpense/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:xpense/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:xpense/features/transactions/presentation/widgets/month_selector/cubit/month_selector_cubit.dart';
import 'core/util/bloc_observer.dart';
import 'core/util/helpers.dart';
import 'features/authentication/presentation/pages/splash.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => sl<AuthenticationBloc>(),
          ),
          BlocProvider(
            create: (_) => sl<TransactionsBloc>(),
          ),
          BlocProvider(
            create: (_) => sl<MonthSelectorCubit>(),
          ),
        ],
        child: MaterialApp(
          title: 'Xpense App',
          navigatorKey: AppHelper.navigatorKey,
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            brightness: Brightness.dark,
            primaryColor: AppColors.primaryColor,
            scaffoldBackgroundColor: AppColors.backgroundColor,
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
