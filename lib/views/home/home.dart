import 'package:education_helper/helpers/widgets/aler_dialog.dart';
import 'package:education_helper/helpers/widgets/circle_animation.dart';
import 'package:education_helper/models/user.model.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/home/adapters/home.adapter.dart';
import 'package:education_helper/views/home/pages/classrooms/classrooms.dart';
import 'package:education_helper/views/home/placeholders/classrooms_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final adapter = Root.ins.adapter.getAdapter(homeAdapter).as<HomeAdapter>();

  @override
  Widget build(BuildContext context) {
    // confirmDialog(
    //   context,
    //   title: 'Warning',
    //   content: "Can't get user or user is expired",
    //   okConfirm: () {
    //     print('check');
    //   },
    // );
    return Scaffold(
      body: AnimationCircleLayout(
        child: FutureBuilder<User?>(
          future: BlocProvider.of<AppBloc>(context).getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final user = snapshot.data;
              if (user != null) return Classrooms(user: user);
              confirmDialog(
                context,
                title: 'Warning',
                content: "Can't get user or user is expired",
                okConfirm: () async => await adapter.goToLogin(context),
              );
            }
            return const ClassroomsHeaderPlaceholder();
          },
        ),
      ),
    );
  }
}
