import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/seeker_model.dart';
import '../data/repositories/form_repository.dart';
import 'form_state.dart';

class FormCubit extends Cubit<FormState> {
  final FormRepository _formRepository;

  FormCubit(this._formRepository) : super(FormInitial());

  Future<void> submitForm({
    required String fullName,
    required String email,
    required String password,
    required String jobCategory,
    required String jobTitle,
    required String level,
    required String workType,
    required String whatsapp,
    required String linkedin,
    required String github,
    required Uint8List? cvBytes,
    required String? cvFileName,
    required Uint8List? avatarBytes,
    required String? avatarFileName,
  }) async {
    emit(FormLoading());

    try {
      // 1. Auth: Sign Up
      final userId = await _formRepository.signUp(
        email: email,
        password: password,
      );

      // 2. Storage: Upload Avatar (if exists)
      if (avatarBytes != null && avatarFileName != null) {
        // Ensure unique filename
        final uniqueFileName = '${DateTime.now().millisecondsSinceEpoch}_$avatarFileName';
        await _formRepository.uploadAvatar(
          fileBytes: avatarBytes,
          fileName: uniqueFileName,
        );
      }

      // 3. Storage: Upload CV
      if (cvBytes == null || cvFileName == null) {
        throw Exception('CV is required.');
      }
      final uniqueCvFileName = '${DateTime.now().millisecondsSinceEpoch}_$cvFileName';
      final cvUrl = await _formRepository.uploadCV(
        fileBytes: cvBytes,
        fileName: uniqueCvFileName,
      );

      // 4. Database: Insert Profile
      // Using avatarUrl could be an enhancement for the profiles table later,
      // but sticking strictly to the requirements for now: id, email, name, role='seeker'
      await _formRepository.insertProfile(
        userId: userId,
        email: email,
        name: fullName,
      );

      // 5. Database: Insert Seekers Data
      final seekerModel = SeekerModel(
        userId: userId,
        jobCategory: jobCategory,
        jobTitle: jobTitle,
        level: level,
        workType: workType,
        whatsapp: whatsapp,
        linkedin: linkedin,
        github: github,
        cvUrl: cvUrl,
      );

      await _formRepository.insertSeekerData(seekerModel);

      emit(FormSuccess());
    } catch (e) {
      emit(FormFailure(errorMessage: e.toString()));
    }
  }
}
