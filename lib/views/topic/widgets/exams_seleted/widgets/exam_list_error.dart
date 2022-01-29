import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/views/exam/bloc/exam_bloc.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamListError extends StatelessWidget {
  const ExamListError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'An error occurred while loading data',
            style: TextStyle(
              color: kBlackColor,
              fontSize: 16.0,
            ),
          ),
          SPACING.LG.vertical,
          KTextButton(
            onPressed: BlocProvider.of<ExamBloc>(context).refresh,
            text: 'refresh',
          ),
        ],
      ),
    );
  }
}
