import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/views/topic/blocs/member/topic_members_bloc.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnswerListError extends StatelessWidget {
  const AnswerListError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'An occuss error when loading data',
          style: TextStyle(
            color: kBlackColor,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        SPACING.LG.vertical,
        KTextButton(onPressed: () => _refresh(context), text: 'Refresh'),
      ],
    );
  }

  void _refresh(BuildContext context) {
    BlocProvider.of<TopicMembersBloc>(context).refreshMembers();
  }
}
