import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swifty_companion/data/model/user.dart';
import 'package:swifty_companion/data/repository.dart';
// https://www.youtube.com/watch?v=FVpMjiImagg&ab_channel=CoderGroup

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final Repository repository;

  ProfileCubit({required this.repository}) : super(ProfileInitial());

  void fetchUserProfile(String username) async {
    var result = await repository.fetchUser_Profile(username);
    if (result != null) {
      emit(ProfileLoaded(user: result));
    } else {
      emit(ProfileError(error: "User not found"));
    }
  }
}
