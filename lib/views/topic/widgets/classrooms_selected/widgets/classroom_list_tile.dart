import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/views/classrooms/bloc/classroom_bloc.dart';
import 'package:education_helper/views/topic/topics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ClassroomListTile extends StatelessWidget {
  final Classroom data;
  final bool isSelected;
  const ClassroomListTile({
    required this.data,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)));

    return Material(
      elevation: 20.0,
      shadowColor: kPrimaryDarkColor.withOpacity(.7),
      shape: shape,
      child: ListTile(
        onTap: () {
          Navigator.maybePop<Classroom>(context, data);
        },
        shape: shape,
        enableFeedback: true,
        selected: isSelected,
        textColor: kBlackColor,
        selectedColor: kWhiteColor,
        selectedTileColor: kPrimaryColor,
        autofocus: true,
        trailing: IconButton(
          iconSize: 18,
          color: isSelected ? kSecondaryLightColor : kPrimaryColor,
          icon: const Icon(Fontisto.preview),
          onPressed: () => _goDetail(context),
        ),
        title: Text(
          data.name,
          style: TextStyle(
            color: isSelected ? kSecondaryLightColor : kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('Members: ${data.members.length}'),
      ),
    );
  }

  Future<void> _goDetail(BuildContext context) async {
    final isNeedRefresh = await Topics.adapter.goToClassroom(context, data.id);
    if (isNeedRefresh) {
      BlocProvider.of<ClassroomBloc>(context).refreshClassroom();
    }
  }
}
