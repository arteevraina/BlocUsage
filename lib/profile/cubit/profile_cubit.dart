import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_usage/profile/models/user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  // Cubit level function to save the profile.
  void saveProfile(User user) async {
    emit(ProfileSaving());
    await Future.delayed(const Duration(seconds: 2));
    emit(ProfileSaved(user: user));
  }
}
