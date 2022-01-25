import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/home/adapters/home.adapter.dart';
import 'package:education_helper/views/home/bloc/exams/exam.bloc.dart';
import 'package:education_helper/views/home/bloc/exams/exam.state.dart';
import 'package:education_helper/views/home/home.dart';
import 'package:education_helper/views/home/widgets/header_collections.dart';
import 'package:education_helper/views/widgets/button/custom_link_button.dart';
import 'package:education_helper/views/widgets/list/list_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/exam_collection_empty.dart';
import 'widgets/exam_collection_item.dart';

class ExamCollection extends StatefulWidget {
  const ExamCollection({
    Key? key,
  }) : super(key: key);

  @override
  _ExamCollectionState createState() => _ExamCollectionState();
}

class _ExamCollectionState extends State<ExamCollection> {
  String errorMessenger = '';
  List<Exam> exams = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ExamsBloc>(context).getExamCollection();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(55.0),
        color: isLightTheme ? kBlackColor : kWhiteColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SPACING.M.vertical,
          HeaderCollection(
            title: 'Exams',
            qunatity: exams.length,
            onPressMore: gotoExams,
          ),
          SPACING.M.vertical,
          // Build List scrole
          Expanded(
            child: BlocConsumer<ExamsBloc, ExamState>(
              listener: (context, state) {
                if (state is ExamFailState) {
                  BlocProvider.of<AppBloc>(context)
                      .showError(context, '${state.messenger}');
                  setState(() => errorMessenger = 'Exam loading error!');
                }
                if (state is ExamLoadedState) {
                  setState(() => exams = state.exams);
                }
              },
              builder: (context, state) {
                if (state is ExamLoadingState) {
                  return Center(
                      child: errorMessenger.isEmpty
                          ? const CircularProgressIndicator()
                          : Text(errorMessenger,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: kPlaceholderDarkColor,
                                  fontSize: SPACING.LG.size)));
                }

                return ListBuilder(
                  scrollDirection: Axis.horizontal,
                  emptyList: ExamCollectionEmpty(
                    gotoExams: gotoExams,
                  ),
                  shirinkWrap: true,
                  scrollBehavior: NormalScollBehavior(),
                  datas: exams,
                  itemBuilder: (index) {
                    final exam = exams[index];
                    return GestureDetector(
                      onTap: () => goToDetail(exam),
                      child: ExamCollectionItem(exam: exam),
                    );
                  },
                );
              },
            ),
          ),
          SPACING.M.vertical,
        ],
      ),
    );
  }

  Future<void> gotoExams() async {
    Home.adapter.goToExams(context);
  }

  Future<void> goToDetail(Exam exam) async {
    Home.adapter.goToExamDetail(context, exam.id);
  }
}