part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class HomeInitial extends AppState {}

final class GetDataLoadingState extends AppState {}

final class GetDataSuccessState extends AppState {}

final class GetDataErrorState extends AppState {
  final String error;

  GetDataErrorState(this.error);
}

final class GetStudentsLoadingState extends AppState {}

final class GetStudentsSuccessState extends AppState {}

final class GetStudentsErrorState extends AppState {
  final String error;

  GetStudentsErrorState(this.error);
}

final class GetTopsLoadingState extends AppState {}

final class GetTopsSuccessState extends AppState {}

final class GetTopsErrorState extends AppState {
  final String error;

  GetTopsErrorState(this.error);
}

final class GetHomeDataLoadingState extends AppState {}

final class GetHomeDataSuccessState extends AppState {}

final class GetData extends AppState {}

final class GetDataSuccess extends AppState {}

final class GetProfileDataLoadingState extends AppState {}

final class GetProfileDataSuccessState extends AppState {}

final class GetProfileDataErrorState extends AppState {
  final String error;

  GetProfileDataErrorState(this.error);
}

final class UpdateProfileImageLoadingState extends AppState {}

final class UpdateProfileImageSuccessState extends AppState {}

final class UpdateProfileImageErrorState extends AppState {
  final String error;

  UpdateProfileImageErrorState(this.error);
}

final class UpdateProfileDataSuccessState extends AppState {}

final class UpdateProfileDataLoadingState extends AppState {}

final class UpdateProfileDataErrorState extends AppState {
  final String error;

  UpdateProfileDataErrorState(this.error);
}

final class GetQuizzesLoadingState extends AppState {}

final class GetQuizzesSuccessState extends AppState {}

final class GetQuizzesErrorState extends AppState {}

final class ChooseAnswerState extends AppState {}

final class ChangeNameIDLoading extends AppState {}

final class ChangeNameIDSuccess extends AppState {}

final class ChangeNameIDError extends AppState {
  final String error;

  ChangeNameIDError(this.error);
}

final class HidePointsLoadingState extends AppState {}

final class HidePointsSuccessState extends AppState {}

final class HidePointsErrorState extends AppState {
  final String error;

  HidePointsErrorState(this.error);
}

final class GetPostsListItemsLoadingState extends AppState {}

final class GetPostsListItemsSuccessState extends AppState {}

final class ExportToExcelSuccessState extends AppState {}

final class ExportToExcelErrorState extends AppState {
  final String error;

  ExportToExcelErrorState(this.error);
}

final class SearchSuccessState extends AppState {}

final class SearchErrorState extends AppState {
  final String error;

  SearchErrorState(this.error);
}

final class SearchLoadingState extends AppState {}

final class SetStudentSuccessState extends AppState {}

final class SetStudentErrorState extends AppState {
  final String error;

  SetStudentErrorState(this.error);
}

final class SetStudentLoadingState extends AppState {}

final class SolveState extends AppState {}

final class AddImageSuccessState extends AppState {}

final class ChangeMode extends AppState {}

class SetOfflineStudentLoadingState extends AppState {}

class SetOfflineStudentSuccessState extends AppState {}

class SetOfflineStudentErrorState extends AppState {
  final String error;

  SetOfflineStudentErrorState(this.error);
}

class ExportCachedStudentsLoadingState extends AppState {}

class ExportCachedStudentsSuccessState extends AppState {}

class GetPersonalDataLoadingState extends AppState {}

class GetPersonalDataSuccessState extends AppState {}

class GetPersonalDataErrorState extends AppState {
  final String error;

  GetPersonalDataErrorState(this.error);
}

class OpenSubjectsLoadingState extends AppState {}

class OpenSubjectsSuccessState extends AppState {}

class GetStudentsAttendanceLoadingState extends AppState {}

class GetStudentsAttendanceSuccessState extends AppState {}

class GetStudentsAttendanceErrorState extends AppState {
  final String error;

  GetStudentsAttendanceErrorState(this.error);
}

class NoInternetConnection extends AppState {
  final String error;

  NoInternetConnection(this.error);
}

final class AddPostContentSuccessState extends AppState {}

final class AddPostContentErrorState extends AppState {
  final String error;

  AddPostContentErrorState(this.error);
}

final class AddPostContentLoadingState extends AppState {}

final class RequestLoadingState extends AppState {}

final class RequestSuccessState extends AppState {}

final class RequestErrorState extends AppState {
  final String error;

  RequestErrorState(this.error);
}

final class AddAttendanceLengthSuccessState extends AppState {}

final class Logout extends AppState {}

final class GetCashedQuizzesLoadingState extends AppState {}

final class GetCashedQuizzesSuccessState extends AppState {}

final class PickPostImageSuccessState extends AppState {}

final class PickPostImageErrorState extends AppState {
  final String error;

  PickPostImageErrorState(this.error);
}

final class PickPostImageLoadingState extends AppState {}

final class AddToSessionLoadingState extends AppState {}

final class UploadSessionLoadingState extends AppState {}

final class UploadSessionSuccessState extends AppState {}

final class GetVersionErrorState extends AppState {
  final String error;

  GetVersionErrorState(this.error);
}

final class GetVersionLoadingState extends AppState {}

final class GetVersionSuccessState extends AppState {
  final String version;

  GetVersionSuccessState(this.version);
}

final class CreateCodeState extends AppState {}

final class SelectLevelState extends AppState {}

final class AddSubjectLoadingState extends AppState {}

final class AddSubjectErrorState extends AppState {
  final String error;

  AddSubjectErrorState(this.error);
}

final class AddSubjectSuccessState extends AppState {}

final class DeleteAccountLoadingState extends AppState {}

final class DeleteAccountErrorState extends AppState {
  final String error;

  DeleteAccountErrorState(this.error);
}

final class DeleteAccountSuccessState extends AppState {}
