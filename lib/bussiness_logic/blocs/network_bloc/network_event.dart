part of 'network_bloc.dart';

abstract class NetworkEvent extends Equatable {
  const NetworkEvent();
}

class ListenConnection extends NetworkEvent {
  @override
  List<Object?> get props => [];
}

class AddNetworkLoaded extends NetworkEvent {
  final ConnectivityResult event;
  AddNetworkLoaded(this.event);
  @override
  List<Object?> get props => [event];
}
