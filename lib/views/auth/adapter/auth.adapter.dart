import 'package:education_helper/helpers/widgets/router_animation.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/parts/adapter.dart';
import 'package:education_helper/views/auth/bloc/auth_bloc.dart';
import 'package:education_helper/views/topic/adapter/topic.adapter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth.dart';

class AuthAdpater extends IAdapter {
  static final AuthAdpater _ins = AuthAdpater._internal();

  AuthAdpater._internal() {
    Root.ins.adapter.injectAdapter(authAdapter, this);
  }

  factory AuthAdpater() {
    return _ins;
  }

  IAdapter get _homeAdapter => Root.ins.adapter.getAdapter(homeAdapter);

  IAdapter get _topicAdapter => Root.ins.adapter.getAdapter(topicAdapter);

  @override
  Widget layout({Map<String, dynamic>? params}) {
    final localStorage = Root.ins.localStorage;
    final authBloc = AuthBloc(localStorage);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => authBloc),
      ],
      child: const Auth(),
    );
  }

  Future<void> goToHome(BuildContext context) async {
    Navigator.of(context).pushReplacement(
      RouterAnimation(child: _homeAdapter.layout()),
    );
  }

  Future<void> gotoTopic(BuildContext context, String id) async {
    final adapter = _topicAdapter.cast<TopicAdapter>();
    adapter.goToTopicDetail(context, id);
  }
}
