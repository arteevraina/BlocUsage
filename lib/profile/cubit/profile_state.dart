part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileSaving extends ProfileState {}

class ProfileSaved extends ProfileState {
  final User user;
  const ProfileSaved({required this.user});
}
