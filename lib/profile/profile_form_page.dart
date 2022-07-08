import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_usage/profile/cubit/profile_cubit.dart';
import 'package:flutter_bloc_usage/profile/models/user.dart';
import 'package:flutter_bloc_usage/profile/profile_display_page.dart';

class ProfileFormPage extends StatelessWidget {
  const ProfileFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: const ProfileFormPageView(),
    );
  }
}

class ProfileFormPageView extends StatefulWidget {
  const ProfileFormPageView({Key? key}) : super(key: key);

  @override
  State<ProfileFormPageView> createState() => _ProfileFormPageViewState();
}

class _ProfileFormPageViewState extends State<ProfileFormPageView> {
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
    log("Whole Profile Form Page Rebuilt");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Form Page'),
      ),
      drawer: const SideDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Note here we are not creating a new Bloc.
          // We are providing previously created bloc to the new widget.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return BlocProvider.value(
                  value: context.read<ProfileCubit>(),
                  child: const ProfileDisplayPage(),
                );
              },
            ),
          );
        },
        child: const Icon(Icons.person),
      ),
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSaved) {
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
                  return (state is ProfileSaving)
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            // This should be not done like this.
                            // Create this object here for now.
                            // Since, main objective of this sample is to
                            // show case how to use Bloc.
                            final user = User(
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

class SideDrawer extends StatelessWidget {
  const SideDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileSaved) {
                  return Text("Name: ${state.user.name}");
                }

                return const SizedBox.shrink();
              },
            ),
          ),
          ListTile(
            title: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileSaved) {
                  return Text("Age: ${state.user.age}");
                }

                return const SizedBox.shrink();
              },
            ),
          ),
          ListTile(
            title: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileSaved) {
                  return Text("Gender: ${state.user.gender}");
                }

                return const SizedBox.shrink();
              },
            ),
          ),
          ListTile(
            title: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileSaved) {
                  return Text("Email: ${state.user.email}");
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
