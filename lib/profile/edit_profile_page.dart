import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/profile_cubit.dart';
import 'models/user.dart';
import 'profile_form_page.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    ageController.dispose();
    genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile Form Page'),
      ),
      drawer: const SideDrawer(),
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.isSaved) {
            // This is just listening state and doing a side effect by
            // showing a snack bar and not actually building the whole tree.
            // Show a snackbar.
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile Saved'),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                ),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: genderController,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                ),
              ),
              const SizedBox(height: 28.0),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return (state.isSaving)
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            // This should be not done like this.
                            // Create this object here for now.
                            // Since, main objective of this sample is to
                            // show case how to use Bloc.
                            final user = User(
                              id: 1,
                              name: nameController.text,
                              email: emailController.text,
                              age: ageController.text,
                              gender: genderController.text,
                            );

                            // Call the function in cubit.
                            context.read<ProfileCubit>().saveProfile(user);
                          },
                          child: const Text("Submit"),
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
