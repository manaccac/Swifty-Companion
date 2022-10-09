import 'dart:developer';

import 'package:swifty_companion/data/model/project.dart';
import 'package:swifty_companion/data/model/skill.dart';
import 'package:swifty_companion/data/model/user.dart';
import 'package:swifty_companion/data/oauth_service.dart';

class Repository {
  final OauthService oauthService;

  Repository({required this.oauthService});

  Future<User?> fetchUser_Profile(String username) async {
    final user = await oauthService.fetchUser(username);
    final List<Project> projects = [];
    final List<Skill> skills = [];
    dynamic cursus;

    // print("USER");
    // print(user);
    // http://jsonviewer.stack.hu/ remove + format
    if (user != null) {
      cursus = user["cursus_users"][0];
      if (cursus == null) return null;
      for (final elem in user["cursus_users"]) {
        if (elem["cursus"]["name"] == "42cursus") cursus = elem;
      }

      for (final project in user["projects_users"]) {
        if (project["project"]["parent_id"] == null &&
            (project["cursus_ids"][0] == 21)) {
          final bool inProgress;
          if (project["status"] == "finished") {
            inProgress = false;
          } else {
            inProgress = true;
          }
          projects.add(Project(
              name: project["project"]["name"] as String,
              note: (project["final_mark"] ?? 0) as int,
              inProgress: inProgress,
              validated: (project["validated?"] ?? false) as bool));
        }
      }
      for (final skill in cursus["skills"]) {
        skills.add(Skill(
            name: skill["name"] as String, score: skill["level"] as double));
      }
      return User(
          image: (user["image_url"] ?? 0) as String,
          username: (user["login"] ?? 0) as String,
          firstname: (user["first_name"] ?? 0) as String,
          lastname: (user["last_name"] ?? "-") as String,
          evaluationPoint: (user["correction_point"] ?? 0) as int,
          wallet: (user["wallet"] ?? 0) as int,
          level: (cursus["level"] ?? 0.0) as double,
          email: user["email"] as String,
          grade: (cursus["grade"] ?? "-") as String,
          projects: projects,
          skills: skills);
    }
    return null;
  }
}
