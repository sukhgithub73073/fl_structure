import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

class ShowPasswordToggleBloc extends Bloc<bool, bool> {
  ShowPasswordToggleBloc() : super(false) {
    on<bool>((event, emit) {
      emit(event);
    });
  }
}

class ImageSelectedToggleBloc extends Bloc<String, String> {
  ImageSelectedToggleBloc() : super("") {
    on<String>((event, emit) {
      emit(event);
    });
  }
}




class AnimatedContainerToggleBloc extends Bloc<bool, bool> {
  AnimatedContainerToggleBloc() : super(false) {
    on<bool>((event, emit) {
      emit(event);
    });
  }
}

class AnimatedOpacityToggleBloc extends Bloc<bool, bool> {
  AnimatedOpacityToggleBloc() : super(false) {
    on<bool>((event, emit) {
      emit(event);
    });
  }
}


class SignUpUnderstoodBoxToggleBloc extends Bloc<bool, bool> {
  SignUpUnderstoodBoxToggleBloc() : super(false) {
    on<bool>((event, emit) {
      emit(event);
    });
  }
}

