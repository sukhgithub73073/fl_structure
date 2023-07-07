part of 'network_bloc.dart';

abstract class NetworkState extends Equatable {
  const NetworkState();
}

class NetworkInitial extends NetworkState {
  @override
  List<Object> get props => [];
}

class NetworkLoading extends NetworkState {
  @override
  List<Object> get props => [];
}

class NetworkLoaded extends NetworkState {
  @override
  List<Object> get props => [];
}

class NetworkError extends NetworkState {
  @override
  List<Object> get props => [];
}
