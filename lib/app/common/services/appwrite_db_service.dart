import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shiksha_dhra/app/auth/services/appwrite_auth_service.dart';
import 'package:shiksha_dhra/app/common/model/content.dart';
import 'package:shiksha_dhra/app/common/model/course.dart';
import 'package:shiksha_dhra/app/common/model/institute.dart';
import 'package:shiksha_dhra/app/common/model/shikhsha_dhra_user.dart';
import 'package:shiksha_dhra/app/common/model/subject.dart';
import 'package:shiksha_dhra/app/common/model/user_course.dart';

part 'appwrite_db_service.g.dart';

@riverpod
AppwriteDbService appwriteDbService(AppwriteDbServiceRef ref) {
  return AppwriteDbService(ref);
}

class AppwriteDbService {
  final Ref ref;
  final Databases databases;
  AppwriteDbService(this.ref) : databases = Databases(ref.read(clientProvider));

  Future<ShikshaDhraUser> getUser(String id) async {
    final docs = await databases.getDocument(
      databaseId: 'integration',
      collectionId: 'users',
      documentId: id,
    );
    return ShikshaDhraUser.fromJson(docs.data);
  }

  Future<List<UserCourse>> getUserCourse(String userId) async {
    final docs = await databases.listDocuments(
        databaseId: 'integration',
        collectionId: 'userCourses',
        queries: [
          Query.equal('userId', userId),
        ]);
    return docs.documents.map((e) => UserCourse.fromJson(e.data)).toList();
  }

  Future<List<Course>> getInstituteCourses(String instituteId) async {
    final docs = await databases.listDocuments(
      databaseId: 'integration',
      collectionId: 'courses',
      queries: [
        Query.equal('instituteId', instituteId),
      ],
    );
    return docs.documents.map((e) => Course.fromJson(e.data)).toList();
  }

  Future<Course> getCourse(String id) async {
    final docs = await databases.getDocument(
      databaseId: 'integration',
      collectionId: 'courses',
      documentId: id,
    );
    return Course.fromJson(docs.data);
  }

  Future<Subject> getSubject(String id) async {
    final docs = await databases.getDocument(
      databaseId: 'integration',
      collectionId: 'subjects',
      documentId: id,
    );
    return Subject.fromJson(docs.data);
  }

  Future<List<Subject>> getSubjectsByCourseId(String courseId) async {
    final docs = await databases.listDocuments(
      databaseId: 'integration',
      collectionId: 'subjects',
      queries: [
        Query.equal('courseId', courseId),
      ],
    );
    return docs.documents.map((e) => Subject.fromJson(e.data)).toList();
  }

  Future<List<Content>> getContentsBySubjectId(String subjectId) async {
    final docs = await databases.listDocuments(
      databaseId: 'integration',
      collectionId: 'contents',
      queries: [
        Query.equal('subjectId', subjectId),
      ],
    );
    return docs.documents.map((e) => Content.fromJson(e.data)).toList();
  }

  Future<Institute> getInstitute(String id) async {
    final docs = await databases.getDocument(
      databaseId: 'integration',
      collectionId: 'institutes',
      documentId: id,
    );
    return Institute.fromJson(docs.data);
  }

  Future<void> createCourse(Course course) async {
    await databases.createDocument(
      databaseId: 'integration',
      collectionId: 'courses',
      documentId: ID.unique(),
      data: course.toJson(),
    );
  }

  Future<void> createSubject(Subject subject) async {
    await databases.createDocument(
      databaseId: 'integration',
      collectionId: 'subjects',
      documentId: ID.unique(),
      data: subject.toJson(),
    );
  }
}
