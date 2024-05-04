import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shiksha_dhra/app/common/model/course.dart';
import 'package:shiksha_dhra/app/common/notifiers/current_user_state_notifier.dart';
import 'package:shiksha_dhra/app/home/notifiers/page_notifier.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homePageState = ref.watch(homePageNotifierProvider);
    final notifier = ref.watch(homePageNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shiksha Dhra',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: notifier.logout,
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      floatingActionButton: homePageState.maybeWhen(
        orElse: () => null,
        headOfInstitute: () => const _AddCourseFloatingButton(),
        headOfDepartment: (course) => const _AddCourseFloatingButton(),
      ),
      body: SafeArea(
        child: Center(
          child: homePageState.when(
            loading: () => Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).indicatorColor,
              ),
            ),
            student: (courses) => ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      course.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    subtitle: Text(
                      course.description,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onTap: () {},
                  ),
                );
              },
            ),
            teacher: (courses) => ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      course.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    subtitle: Text(
                      course.description,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onTap: () {},
                  ),
                );
              },
            ),
            headOfDepartment: (courses) => ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      course.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    subtitle: Text(
                      course.description,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onTap: () {},
                  ),
                );
              },
            ),
            headOfInstitute: () => Container(),
          ),
        ),
      ),
    );
  }
}

class _AddCourseFloatingButton extends ConsumerWidget {
  const _AddCourseFloatingButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(homePageNotifierProvider.notifier);
    final instituteId = ref.watch(
        sikhshaDhraUserNotifierProvider.select((value) => value!.instituteId!));

    return FloatingActionButton.extended(
      onPressed: () {
        final course = Course(
          instituteId: instituteId,
          name: 'Class 4',
          description: 'World class material available for class 4',
        );
        notifier.addCourse(course);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      label: Text(
        'Add Course',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      icon: Icon(
        Icons.add,
        color: Theme.of(context).iconTheme.color,
      ),
    );
  }
}
