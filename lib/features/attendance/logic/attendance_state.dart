part of 'attendance_cubit.dart';

@immutable
sealed class AttendanceState {}

final class AttendanceInitial extends AttendanceState {}

final class GetStudentsLoadingState extends AttendanceState {}

final class GetStudentsSuccessState extends AttendanceState {}

final class GetStudentsErrorState extends AttendanceState {
  final String message;
  GetStudentsErrorState(this.message);
}

final class ExportToExcelSuccessState extends AttendanceState {}

final class ExportToExcelErrorState extends AttendanceState {
  final String message;
  ExportToExcelErrorState(this.message);
}

final class ExportToExcelLoadingState extends AttendanceState {}

final class SearchLoadingState extends AttendanceState {}

final class SearchErrorState extends AttendanceState {
  final String message;
  SearchErrorState(this.message);
}

final class SearchSuccessState extends AttendanceState {}

final class ExportCachedStudentsLoadingState extends AttendanceState {}

final class ExportCachedStudentsSuccessState extends AttendanceState {}

final class ExportCachedStudentsErrorState extends AttendanceState {
  final String message;
  ExportCachedStudentsErrorState(this.message);
}

final class GetCashedAttendancesLoadingState extends AttendanceState {}

final class GetCashedAttendancesSuccessState extends AttendanceState {}

final class GetCashedAttendancesErrorState extends AttendanceState {
  final String message;
  GetCashedAttendancesErrorState(this.message);
}

final class NoInternetConnection extends AttendanceState {
  final String message;
  NoInternetConnection(this.message);
}
