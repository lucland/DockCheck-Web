import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/form_side_widget.dart';
import '../../widgets/menu_side_widget.dart';
import 'bloc/pesquisar_cubit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> listWidget = [
    Container(
      color: Colors.amber,
      height: 500,
    ),
    Container(
      color: Colors.purple,
      height: 500,
    )
  ];

  @override
  Widget build(BuildContext context) {
    context.read<UserCubit>().fetchUsers();
    return Scaffold(
      body: Row(
        children: [
          const MenuSide(),
          FormSide(listWidget: listWidget),
        ],
      ),
    );
  }
}
