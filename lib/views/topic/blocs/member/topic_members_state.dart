import 'package:education_helper/constants/constant.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:equatable/equatable.dart';

abstract class TopicMembersState extends Equatable {
  const TopicMembersState();
}

class TopicMembersInitial extends TopicMembersState {
  @override
  List<Object?> get props => [];
}

class TopicMembersLoading extends TopicMembersState {
  @override
  List<Object?> get props => [];
}

class TopicMembersChanged extends TopicMembersState {
  final Classroom classroom;
  final List<dynamic> answers;

  const TopicMembersChanged(
    this.classroom,
    this.answers,
  );

  @override
  List<Object?> get props => [classroom, answers];
}

class TopicMembersLoaded extends TopicMembersState {
  final Classroom classroom;
  final List<Answer> answers;

  const TopicMembersLoaded(this.classroom, this.answers);

  @override
  List<Object?> get props => [classroom, answers];
}

class TopicMembersFailure extends TopicMembersState {
  final Messenger error;
  const TopicMembersFailure(this.error);

  @override
  List<Object?> get props => [error];
}
