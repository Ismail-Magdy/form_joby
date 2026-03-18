import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/seeker_model.dart';

class FormRepository {
  final SupabaseClient _supabaseClient;

  FormRepository(this._supabaseClient);

  Future<String> signUp({required String email, required String password}) async {
    final response = await _supabaseClient.auth.signUp(
      email: email,
      password: password,
    );
    
    if (response.user == null) {
      throw Exception('Sign up failed. User is null.');
    }
    
    return response.user!.id;
  }

  Future<String> uploadAvatar({
    required Uint8List fileBytes,
    required String fileName,
  }) async {
    final path = fileName;
    await _supabaseClient.storage.from('avatars').uploadBinary(
      path,
      fileBytes,
      fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
    );
    return _supabaseClient.storage.from('avatars').getPublicUrl(path);
  }

  Future<String> uploadCV({
    required Uint8List fileBytes,
    required String fileName,
  }) async {
    final path = fileName;
    await _supabaseClient.storage.from('cvs').uploadBinary(
      path,
      fileBytes,
      fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
    );
    return _supabaseClient.storage.from('cvs').getPublicUrl(path);
  }

  Future<void> insertProfile({
    required String userId,
    required String email,
    required String name,
  }) async {
    await _supabaseClient.from('profiles').insert({
      'id': userId,
      'email': email,
      'name': name,
      'role': 'seeker',
    });
  }

  Future<void> insertSeekerData(SeekerModel seekerData) async {
    await _supabaseClient.from('seekers_data').insert(seekerData.toJson());
  }
}
