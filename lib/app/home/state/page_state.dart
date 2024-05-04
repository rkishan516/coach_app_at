import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shiksha_dhra/app/common/model/course.dart';

part 'page_state.freezed.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState.loading() = _HomePageStateLoading;
  const factory HomePageState.student({
    @Default([]) List<Course> course,
  }) = _HomePageStateStudent;
  const factory HomePageState.teacher({
    @Default([]) List<Course> course,
  }) = _HomePageStateTeacher;
  const factory HomePageState.headOfDepartment({
    @Default([]) List<Course> course,
  }) = _HomePageStateHeadOfDepartment;
  const factory HomePageState.headOfInstitute() = _HomePageStateHeadOfInstitute;
}
