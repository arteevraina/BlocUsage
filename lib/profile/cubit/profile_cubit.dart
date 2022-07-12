import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_usage/profile/models/user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit()
      : super(
          const ProfileState(user: null, isSaving: false, isSaved: false),
        );

  // Cubit level function to save the profile.
  void saveProfile(User user) async {
    emit(state.copyWith(isSaving: true));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(isSaved: true, user: user, isSaving: false));
  }
}
