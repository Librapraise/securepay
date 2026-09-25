import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../widgets/hero_branding_panel.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String _selectedCountryCode = '+234';

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthProvider>();
    final fullPhone = '$_selectedCountryCode${_phoneController.text.trim().replaceAll(' ', '')}';
    final ok = await auth.signUp(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      phoneNumber: fullPhone,
      password: _passwordController.text,
    );

    if (ok && mounted) {
      context.go('/dashboard');
    } else if (mounted && auth.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(auth.errorMessage!),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textHeading,
          letterSpacing: -0.1,
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    final isLoading = context.watch<AuthProvider>().status == AuthStatus.loading;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 40.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                const Text(
                  'Create an account',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textHeading,
                    letterSpacing: -0.8,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),

                // Subtitle description with inline link
                Text.rich(
                  TextSpan(
                    text:
                        'Sign up for Myafrimall and gain unlimited access to shipping to over 300 countries from Nigeria. Do you already have an account? ',
                    style: const TextStyle(
                      color: AppColors.textSubheading,
                      fontSize: 13.5,
                      height: 1.45,
                    ),
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.baseline,
                        baseline: TextBaseline.alphabetic,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => context.go('/login'),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: AppColors.textLink,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),

                // First name & Last name side-by-side
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel('First name'),
                          TextFormField(
                            controller: _firstNameController,
                            style: const TextStyle(fontSize: 14.5, color: AppColors.textHeading),
                            decoration: const InputDecoration(
                              hintText: 'John',
                            ),
                            validator: (v) =>
                                (v == null || v.trim().isEmpty) ? 'First name is required' : null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel('Last name'),
                          TextFormField(
                            controller: _lastNameController,
                            style: const TextStyle(fontSize: 14.5, color: AppColors.textHeading),
                            decoration: const InputDecoration(
                              hintText: 'Doe',
                            ),
                            validator: (v) =>
                                (v == null || v.trim().isEmpty) ? 'Last name is required' : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),

                // Email
                _buildFieldLabel('Email'),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(fontSize: 14.5, color: AppColors.textHeading),
                  decoration: const InputDecoration(
                    hintText: 'user@example.com',
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Email is required';
                    if (!v.contains('@') || !v.contains('.')) return 'Enter a valid email address';
                    return null;
                  },
                ),
                const SizedBox(height: 22),

                // Phone Number with Country Code Dropdown prefix
                _buildFieldLabel('Phone Number'),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(fontSize: 14.5, color: AppColors.textHeading),
                  decoration: InputDecoration(
                    hintText: '8012345678',
                    prefixIcon: Container(
                      padding: const EdgeInsets.only(left: 12, right: 6),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedCountryCode,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 18,
                                color: Color(0xFF6B7280),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: '+234',
                                  child: Text(
                                    '+234',
                                    style: TextStyle(
                                      fontSize: 14.5,
                                      color: Color(0xFF6B7280),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: '+1',
                                  child: Text(
                                    '+1',
                                    style: TextStyle(
                                      fontSize: 14.5,
                                      color: Color(0xFF6B7280),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: '+44',
                                  child: Text(
                                    '+44',
                                    style: TextStyle(
                                      fontSize: 14.5,
                                      color: Color(0xFF6B7280),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() => _selectedCountryCode = val);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 4),
                        ],
                      ),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Phone number is required';
                    if (v.trim().length < 7) return 'Enter a valid phone number';
                    return null;
                  },
                ),
                const SizedBox(height: 22),

                // Password
                _buildFieldLabel('Password'),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: const TextStyle(fontSize: 14.5, color: AppColors.textHeading),
                  decoration: InputDecoration(
                    hintText: 'Enter Passwoord',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        size: 20,
                        color: const Color(0xFF9CA3AF),
                      ),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (v) =>
                      (v == null || v.length < 6) ? 'Password must be at least 6 characters' : null,
                ),
                const SizedBox(height: 32),

                // Submit Button
                SizedBox(
                  width: 155,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    onPressed: isLoading ? null : _submit,
                    child: isLoading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Create account',
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 32),

                // Terms and policy footnote
                Text.rich(
                  TextSpan(
                    text: 'By clicking on create account you agree to our ',
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: AppColors.textSubheading,
                      height: 1.45,
                    ),
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.baseline,
                        baseline: TextBaseline.alphabetic,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'privacy policy',
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textLink,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const TextSpan(text: ' and '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.baseline,
                        baseline: TextBaseline.alphabetic,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'terms of use',
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textLink,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 960) {
            return Row(
              children: [
                Expanded(flex: 6, child: _buildForm(context)),
                const Expanded(
                  flex: 6,
                  child: HeroBrandingPanel(
                    title: 'Seamlessly Delivering to Over 300 Countries from Nigeria!',
                    subtitle:
                        'Access global markets with our quick shipping from Nigeria! Fast delivery and easy customs to 300+ countries.',
                  ),
                ),
              ],
            );
          } else {
            return SafeArea(child: _buildForm(context));
          }
        },
      ),
    );
  }
}
