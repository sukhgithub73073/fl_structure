import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_structure/utils/helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'network_event.dart';

part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  StreamSubscription<ConnectivityResult> ? streamSubscription;

  NetworkBloc() : super(NetworkInitial()) {
    on<ListenConnection>(_listenConnection);
    on<AddNetworkLoaded>(_addNetworkLoaded);
    add(ListenConnection());
  }

  @override
  Future<void> close() async {
    await streamSubscription?.cancel();
    return super.close();
  }

  Future<FutureOr<void>> _listenConnection(
    ListenConnection event,
    Emitter<NetworkState> emit,
  ) async {
    try {
      emit(NetworkLoading());
      streamSubscription = Connectivity()
          .onConnectivityChanged
          .listen((event) {
            printLog("NetworkBloc()=> ${event.toString()}");
        add(AddNetworkLoaded(event));
      });
    } catch (e, s) {
      blocLog(msg: e.toString(), bloc: "ListenConnection");
      blocLog(msg: s.toString(), bloc: "ListenConnection");
      emit(NetworkError());
    }
  }

  FutureOr<void> _addNetworkLoaded(
    AddNetworkLoaded event,
    Emitter<NetworkState> emit,
  ) {
    if (event.event == ConnectivityResult.none) {
      emit(NetworkError());
    } else {
      emit(NetworkLoaded());
    }
  }
}
