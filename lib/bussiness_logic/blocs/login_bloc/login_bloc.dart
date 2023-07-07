import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fl_structure/bussiness_logic/models/response_wrapper.dart';
import 'package:fl_structure/utils/all_getter.dart';
import 'package:fl_structure/utils/constants.dart';
import 'package:fl_structure/utils/helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<GetLogin>(_onLogin);
  }

  Future<FutureOr<void>> _onLogin(
    GetLogin event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(LoginLoading());
      Map<String, dynamic> body = {
        BodyConst.email: event.email,
        BodyConst.password: event.password,
        BodyConst.deviceToken: getDeviceId
      };
      emit(LoginSuccess());
      // ResponseWrapper res = await getAuthRepo.userLogin(body: body);
      // if (res.status == RepoResponseStatus.success) {
      //   emit(LoginSuccess());
      // } else {
      //   emit(LoginFailed(res.message ?? someWentWrong));
      // }
    } catch (e) {
      blocLog(msg: e.toString(), bloc: "LoginBloc");
      emit(LoginFailed(e.toString()));
    }
  }
}
