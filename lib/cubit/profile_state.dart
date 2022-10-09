// https://www.youtube.com/watch?v=FVpMjiImagg&ab_channel=CoderGroup
part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;

  ProfileLoaded({required this.user});
}

class ProfileError extends ProfileState {
  final String error;

  ProfileError({required this.error});
}
