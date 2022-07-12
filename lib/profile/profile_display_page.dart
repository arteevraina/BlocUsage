import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_usage/profile/cubit/profile_cubit.dart';

import 'edit_profile_page.dart';

class ProfileDisplayPage extends StatelessWidget {
  const ProfileDisplayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Display View"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return BlocProvider.value(
                  value: context.read<ProfileCubit>(),
                  child: const EditProfilePage(),
                );
              },
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
        if (state.isSaved) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Name: ${state.user?.name}"),
                Text("Email: ${state.user?.email}"),
                Text("Age: ${state.user?.age}"),
                Text("Gender: ${state.user?.gender}"),
              ],
            ),
          );
        } else if (state.user == null) {
          return const Center(
            child: Text("Please Save Profile first"),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
