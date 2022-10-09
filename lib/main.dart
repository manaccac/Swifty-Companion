import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swifty_companion/pages/Home.dart';
import 'package:swifty_companion/pages/Profile.dart';
import 'cubit/profile_cubit.dart';
import 'data/model/user.dart';
import 'data/oauth_service.dart';
import 'data/repository.dart';

void main() {
  runApp(App(
    router: Navigation(),
  ));
}

class App extends StatelessWidget {
  final Navigation router;

  const App({Key? key, required this.router}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swifty companion',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
    );
  }
}

class Navigation {
  late Repository repository;
  late ProfileCubit profileCubit;

  Navigation() {
    repository = Repository(oauthService: OauthService());
    profileCubit = ProfileCubit(repository: repository);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: profileCubit,
            child: MyHomePage(),
          ),
        );
      case "/profile":
        final user = settings.arguments! as User;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: profileCubit,
            child: ProfilePage(
              user: user,
            ),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: profileCubit,
            child: MyHomePage(),
          ),
        );
    }
  }
}
