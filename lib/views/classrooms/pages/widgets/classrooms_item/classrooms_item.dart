import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/views/classrooms/adapter/classroom.adapter.dart';
import 'package:education_helper/views/classrooms/classrooms.dart';
import 'package:education_helper/views/classrooms/dialogs/classroom_dialog.dart';
import 'package:flutter/material.dart';

import 'classroom_item_empty.dart';
import 'widgets/classroom_item_body.dart';
import 'widgets/classroom_item_header.dart';

class ClassroomItem extends StatelessWidget {
  final Classroom classroom;
  const ClassroomItem({
    required this.classroom,
    Key? key,
  }) : super(key: key);

  ClassroomAdapter get adapter => Classrooms.adapter;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => adapter.goToMembers(context, classroom.id),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SPACING.LG.vertical,
          ClassroomItemHeader(
            name: classroom.name,
            exams: classroom.exams.length,
            members: classroom.members.length,
            onAddCSV: () {},
            editClassroom: () => editClassroom(
              context,
              classroom.name,
              classroom.id,
            ),
            removeClassroom: () => deleteClassroom(
              context,
              classroom.name,
              classroom.id,
            ),
          ),
          SPACING.S.vertical,
          classroom.members.isNotEmpty
              ? ClassroomItemBody(members: classroom.members)
              : const ClassroomItemEmpty(),
        ],
      ),
    );
  }
}