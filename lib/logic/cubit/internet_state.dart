part of 'internet_cubit.dart';


enum ConnectionType{
  wifi,
  mobile,
  none,
}

@immutable
abstract class InternetState {}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState{
  final ConnectionType connectionType;

  InternetConnected({required this.connectionType});

}

class InternetDisconnected extends InternetState{
  InternetDisconnected();
}

