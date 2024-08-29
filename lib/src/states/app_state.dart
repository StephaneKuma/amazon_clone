// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/src/enums/app_status.dart';
import 'package:amazon_clone/src/models/user/user.dart';

class AppState {
  final AppStatus status;
  final User? user;

  AppState({
    this.status = AppStatus.initial,
    this.user,
  });

  AppState copyWith({
    AppStatus? status,
    User? user,
  }) {
    return AppState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  bool operator ==(covariant AppState other) {
    if (identical(this, other)) return true;

    return other.status == status && other.user == user;
  }

  @override
  int get hashCode => status.hashCode ^ user.hashCode;
}
