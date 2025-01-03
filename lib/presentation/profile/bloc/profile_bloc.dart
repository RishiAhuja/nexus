import 'package:blog/data/models/profile/profile_model.dart';
import 'package:blog/domain/usecases/firestore/get_profile_usecase.dart';
import 'package:blog/presentation/profile/bloc/profile_event.dart';
import 'package:blog/presentation/profile/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(UserInitial()) {
    on<LoadUserData>(_onLoadUserData);
  }

  Future<void> _onLoadUserData(
      LoadUserData event, Emitter<ProfileState> emit) async {
    emit(UserLoading());
    final result = await GetProfileUsecase()
        .call(params: ProfileModel(uid: event.userUid));

    result.fold((l) {
      emit(UserError(l));
    }, (r) {
      emit(UserLoaded(r));
    });
  }
}
