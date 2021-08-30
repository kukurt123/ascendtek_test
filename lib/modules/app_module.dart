import 'package:ascendtek_test/bloc/main_bloc.dart';
import 'package:ascendtek_test/screen/addition_page.dart';
import 'package:ascendtek_test/screen/list_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> binds = [
    Bind.factory((i) => MainBloc()),
  ];
  @override
  List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => const ListPage(),
    ),
    ChildRoute(
      '/add',
      child: (_, args) => const AdditionPage(),
    ),
  ];
}
