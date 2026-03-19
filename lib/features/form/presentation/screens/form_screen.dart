import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/helpers/validators.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_dropdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/widgets/custom_autocomplete.dart';
import '../../manager/form_cubit.dart';
import '../../manager/form_state.dart' as manager_state;
import '../widgets/file_upload_button.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FormCubit>(),
      child: const FormView(),
    );
  }
}

class FormView extends StatefulWidget {
  const FormView({super.key});

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _jobCategoryController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _linkedinController = TextEditingController();
  final _githubController = TextEditingController();

  bool _obscurePassword = true;

  String? _selectedLevel;
  String? _selectedWorkType;

  Uint8List? _cvBytes;
  String? _cvFileName;

  Uint8List? _avatarBytes;
  String? _avatarFileName;

  final List<String> _levels = ['Junior', 'Mid-Level', 'Senior', 'Tech Lead'];
  final List<String> _workTypes = ['Onsite', 'Remote'];

  final List<String> _jobCategories = [
    'Software Engineering',
    'UI/UX Design',
    'Marketing',
    'Data Science',
    'Quality Assurance',
    'Product Management'
  ];

  final List<String> _jobTitles = [
    'Flutter Developer',
    'Backend Developer',
    'Frontend Developer',
    'Full Stack Developer',
    'Android Developer',
    'iOS Developer',
    'UI/UX Designer'
  ];

  Future<void> _pickCV() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true,
    );

    if (result != null) {
      setState(() {
        _cvBytes = result.files.first.bytes;
        _cvFileName = result.files.first.name;
      });
    }
  }

  Future<void> _pickAvatar() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result != null) {
      setState(() {
        _avatarBytes = result.files.first.bytes;
        _avatarFileName = result.files.first.name;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (_cvBytes == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please upload your CV (PDF)')),
        );
        return;
      }

      context.read<FormCubit>().submitForm(
            fullName: _nameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            jobCategory: _jobCategoryController.text.trim(),
            jobTitle: _jobTitleController.text.trim(),
            level: _selectedLevel ?? '',
            workType: _selectedWorkType ?? '',
            whatsapp: _whatsappController.text.trim(),
            linkedin: _linkedinController.text.trim(),
            github: _githubController.text.trim(),
            cvBytes: _cvBytes,
            cvFileName: _cvFileName,
            avatarBytes: _avatarBytes,
            avatarFileName: _avatarFileName,
          );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _jobCategoryController.dispose();
    _jobTitleController.dispose();
    _whatsappController.dispose();
    _linkedinController.dispose();
    _githubController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joby Early Access'),
        centerTitle: true,
      ),
      body: BlocConsumer<FormCubit, manager_state.FormState>(
        listener: (context, state) {
          if (state is manager_state.FormSuccess) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: const Text('Success!'),
                content: const Text('Your profile has been created successfully.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Typically clear form or navigate here
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          } else if (state is manager_state.FormFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: AppTheme.errorRed,
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Card(
                    elevation: 8,
                    shadowColor: Colors.black.withValues(alpha: 0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: AppTheme.white,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 600),
                      padding: const EdgeInsets.all(40),
                      child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Join Joby',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textDark,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Fill in your details below to get early access.',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppTheme.textLight,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          CustomTextField(
                            label: 'Full Name',
                            hint: 'Enter your full name',
                            controller: _nameController,
                            prefixIcon: const FaIcon(FontAwesomeIcons.solidUser, size: 18, color: AppTheme.textLight),
                            validator: (val) => Validators.requiredField(val, 'Full Name'),
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'Email',
                            hint: 'Enter your email address',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: const FaIcon(FontAwesomeIcons.solidEnvelope, size: 18, color: AppTheme.textLight),
                            validator: Validators.email,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'Password',
                            hint: 'Create a password (min 6 chars)',
                            controller: _passwordController,
                            isPassword: _obscurePassword,
                            prefixIcon: const FaIcon(FontAwesomeIcons.lock, size: 18, color: AppTheme.textLight),
                            validator: Validators.password,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                color: AppTheme.textLight,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: CustomAutocomplete(
                                  label: 'Job Category',
                                  hint: 'e.g. Engineering',
                                  options: _jobCategories,
                                  controller: _jobCategoryController,
                                  prefixIcon: const FaIcon(FontAwesomeIcons.briefcase, size: 18, color: AppTheme.textLight),
                                  validator: (val) => Validators.requiredField(val, 'Job Category'),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: CustomAutocomplete(
                                  label: 'Job Title',
                                  hint: 'e.g. Flutter Dev',
                                  options: _jobTitles,
                                  controller: _jobTitleController,
                                  prefixIcon: const FaIcon(FontAwesomeIcons.userTie, size: 18, color: AppTheme.textLight),
                                  validator: (val) => Validators.requiredField(val, 'Job Title'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: CustomDropdown(
                                  label: 'Level',
                                  hint: 'Select Level',
                                  items: _levels,
                                  value: _selectedLevel,
                                  prefixIcon: const FaIcon(FontAwesomeIcons.layerGroup, size: 18, color: AppTheme.textLight),
                                  onChanged: (val) => setState(() => _selectedLevel = val),
                                  validator: (val) => Validators.requiredField(val, 'Level'),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: CustomDropdown(
                                  label: 'Work Type',
                                  hint: 'Select Type',
                                  items: _workTypes,
                                  value: _selectedWorkType,
                                  prefixIcon: const FaIcon(FontAwesomeIcons.buildingUser, size: 18, color: AppTheme.textLight),
                                  onChanged: (val) => setState(() => _selectedWorkType = val),
                                  validator: (val) => Validators.requiredField(val, 'Work Type'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'WhatsApp Number',
                            hint: 'e.g. +1234567890',
                            controller: _whatsappController,
                            keyboardType: TextInputType.phone,
                            prefixIcon: const FaIcon(FontAwesomeIcons.whatsapp, size: 18, color: AppTheme.textLight),
                            validator: Validators.phone,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'LinkedIn Profile',
                            hint: 'https://linkedin.com/in/...',
                            controller: _linkedinController,
                            keyboardType: TextInputType.url,
                            prefixIcon: const FaIcon(FontAwesomeIcons.linkedin, size: 18, color: AppTheme.textLight),
                            validator: (val) => Validators.url(val, 'LinkedIn'),
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'GitHub Profile',
                            hint: 'https://github.com/...',
                            controller: _githubController,
                            keyboardType: TextInputType.url,
                            prefixIcon: const FaIcon(FontAwesomeIcons.github, size: 18, color: AppTheme.textLight),
                            validator: (val) => Validators.url(val, 'GitHub'),
                          ),
                          const SizedBox(height: 24),
                          FileUploadButton(
                            title: 'Upload Profile Picture (Optional)',
                            fileName: _avatarFileName,
                            icon: Icons.image,
                            onTap: _pickAvatar,
                          ),
                          const SizedBox(height: 16),
                          FileUploadButton(
                            title: 'Upload CV (PDF) *',
                            fileName: _cvFileName,
                            icon: Icons.picture_as_pdf,
                            onTap: _pickCV,
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: state is manager_state.FormLoading ? null : _submit,
                            child: const Text('Submit & Register', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (state is manager_state.FormLoading)
                Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
