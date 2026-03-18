import 'package:equatable/equatable.dart';

class SeekerModel extends Equatable {
  final String userId;
  final String jobCategory;
  final String jobTitle;
  final String level;
  final String workType;
  final String whatsapp;
  final String linkedin;
  final String github;
  final String cvUrl;

  const SeekerModel({
    required this.userId,
    required this.jobCategory,
    required this.jobTitle,
    required this.level,
    required this.workType,
    required this.whatsapp,
    required this.linkedin,
    required this.github,
    required this.cvUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'job_category': jobCategory,
      'job_title': jobTitle,
      'level': level,
      'work_type': workType,
      'whatsapp': whatsapp,
      'linkedin': linkedin,
      'github': github,
      'cv_url': cvUrl,
    };
  }

  @override
  List<Object?> get props => [
        userId,
        jobCategory,
        jobTitle,
        level,
        workType,
        whatsapp,
        linkedin,
        github,
        cvUrl,
      ];
}
