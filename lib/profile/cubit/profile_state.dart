part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final User? user;
  final bool isSaving;
  final bool isSaved;

  const ProfileState({
    this.user,
    required this.isSaving,
    required this.isSaved,
  });

  // Copy with function for this class.
  ProfileState copyWith({
    User? user,
    bool? isSaving,
    bool? isSaved,
  }) {
    return ProfileState(
      user: user ?? this.user,
      isSaving: isSaving ?? this.isSaving,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  @override
  List<Object> get props => (user != null) ? [user!] : [];
}

const List<User> users = [
  User(
    id: 1,
    name: "John Doe",
    email: "john@email.com",
    age: "12",
    gender: "Male",
  ),
  User(
    id: 2,
    name: "Arteev",
    email: "john@email.com",
    age: "12",
    gender: "Male",
  ),
  User(
    id: 3,
    name: "Anant",
    email: "john@email.com",
    age: "12",
    gender: "Male",
  ),
];
