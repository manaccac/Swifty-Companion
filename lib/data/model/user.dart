import 'package:swifty_companion/data/model/project.dart';
import 'package:swifty_companion/data/model/skill.dart';

class User {
  String image;
  String username;
  String firstname;
  String lastname;
  int evaluationPoint;
  int wallet;
  double level;
  String grade;
  String email;
  List<Project> projects;
  List<Skill> skills;

  User({
    required this.image,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.evaluationPoint,
    required this.wallet,
    required this.email,
    required this.level,
    required this.grade,
    required this.projects,
    required this.skills,
  });
}
