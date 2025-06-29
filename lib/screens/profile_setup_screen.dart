import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../home_screen.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ProfileSetupScreenState createState() => ProfileSetupScreenState();
}

class ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _emergencyPhoneController = TextEditingController();
  final _medicationsController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _notesController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _emergencyContactController.dispose();
    _emergencyPhoneController.dispose();
    _medicationsController.dispose();
    _allergiesController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Setup'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Let\'s set up your profile',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'This information helps us provide better assistance.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 32),

              // Basic Information Section
              _buildSectionHeader('Basic Information'),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _nameController,
                label: 'Full Name',
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _ageController,
                label: 'Age',
                icon: Icons.cake,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid age';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _phoneController,
                label: 'Phone Number',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 32),

              // Emergency Contact Section
              _buildSectionHeader('Emergency Contact'),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _emergencyContactController,
                label: 'Emergency Contact Name',
                icon: Icons.person_add,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an emergency contact';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _emergencyPhoneController,
                label: 'Emergency Contact Phone',
                icon: Icons.phone_in_talk,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an emergency contact phone';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Medical Information Section
              _buildSectionHeader('Medical Information (Optional)'),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _medicationsController,
                label: 'Current Medications',
                icon: Icons.medication,
                maxLines: 3,
                hint: 'List your current medications, separated by commas',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _allergiesController,
                label: 'Allergies',
                icon: Icons.warning,
                maxLines: 2,
                hint: 'List any allergies you have',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _notesController,
                label: 'Additional Notes',
                icon: Icons.note,
                maxLines: 3,
                hint: 'Any other important information',
              ),
              const SizedBox(height: 32),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child:
                      _isLoading
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                          : const Text(
                            'Complete Setup',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
      ),
    );
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final profile = {
        'name': _nameController.text.trim(),
        'age': int.parse(_ageController.text.trim()),
        'phone': _phoneController.text.trim(),
        'emergencyContact': _emergencyContactController.text.trim(),
        'emergencyPhone': _emergencyPhoneController.text.trim(),
        'medications': _medicationsController.text.trim(),
        'allergies': _allergiesController.text.trim(),
        'notes': _notesController.text.trim(),
        'createdAt': DateTime.now().toIso8601String(),
      };

      await StorageService.saveUserProfile(profile);

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving profile: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
