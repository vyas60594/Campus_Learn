 import 'package:flutter/material.dart';
 import 'complete_profile_screen.dart';

 class SignupScreen extends StatefulWidget {
   const SignupScreen({super.key});

   @override
   State<SignupScreen> createState() => _SignupScreenState();
 }

 class _SignupScreenState extends State<SignupScreen> {
   final _formKey = GlobalKey<FormState>();
   final _nameController = TextEditingController();
   final _emailController = TextEditingController();
   final _passwordController = TextEditingController();
   final _confirmPasswordController = TextEditingController();

   bool _obscurePassword = true;
   bool _obscureConfirmPassword = true;

   @override
   void dispose() {
     _nameController.dispose();
     _emailController.dispose();
     _passwordController.dispose();
     _confirmPasswordController.dispose();
     super.dispose();
   }

   @override
   Widget build(BuildContext context) {
     const Color darkCard = Color(0xFF273645);
     const Color accentYellow = Color(0xFFFFD54F);

     return Scaffold(
       backgroundColor: Colors.white,
       body: SafeArea(
         child: SingleChildScrollView(
           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               // Brand header
               Row(
                 children: [
                   Stack(
                     children: [
                       Container(
                         width: 44,
                         height: 44,
                         decoration: BoxDecoration(
                           color: darkCard,
                           borderRadius: BorderRadius.circular(12),
                           boxShadow: const [
                             BoxShadow(
                               color: Color(0x14000000),
                               blurRadius: 14,
                               offset: Offset(0, 8),
                             ),
                           ],
                         ),
                         child: const Icon(Icons.school_rounded,
                             color: Colors.white, size: 24),
                       ),
                       Positioned(
                         right: 4,
                         top: 4,
                         child: Container(
                           width: 8,
                           height: 16,
                           decoration: BoxDecoration(
                             color: accentYellow,
                             borderRadius: BorderRadius.circular(6),
                           ),
                         ),
                       ),
                     ],
                   ),
                   const SizedBox(width: 12),
                   const Text(
                     'CampusLearn',
                     style: TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.w700,
                       color: Color(0xFF273645),
                     ),
                   ),
                 ],
               ),

               const SizedBox(height: 28),
               const Text(
                 'Create your account',
                 style: TextStyle(
                   fontSize: 28,
                   fontWeight: FontWeight.w700,
                   color: Color(0xFF273645),
                 ),
               ),
               const SizedBox(height: 6),
               Text(
                 'Join the community and start learning together.',
                 style: TextStyle(
                   fontSize: 15,
                   color: Colors.grey.shade600,
                 ),
               ),

               const SizedBox(height: 24),
               Form(
                 key: _formKey,
                 child: Column(
                   children: [
                     // Name
                     TextFormField(
                       controller: _nameController,
                       textCapitalization: TextCapitalization.words,
                       decoration: InputDecoration(
                         labelText: 'Full name',
                         prefixIcon: const Icon(Icons.person_outline),
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(12),
                         ),
                       ),
                       validator: (value) {
                         if (value == null || value.trim().isEmpty) {
                           return 'Please enter your name';
                         }
                         if (value.trim().length < 2) {
                           return 'Name is too short';
                         }
                         return null;
                       },
                     ),

                     const SizedBox(height: 16),

                     // Email
                     TextFormField(
                       controller: _emailController,
                       keyboardType: TextInputType.emailAddress,
                       decoration: InputDecoration(
                         labelText: 'Email',
                         hintText: 'you@example.com',
                         prefixIcon: const Icon(Icons.email_outlined),
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(12),
                         ),
                       ),
                       validator: (value) {
                         if (value == null || value.trim().isEmpty) {
                           return 'Please enter your email';
                         }
                         if (!value.contains('@')) {
                           return 'Please enter a valid email';
                         }
                         return null;
                       },
                     ),

                     const SizedBox(height: 16),

                     // Password
                     TextFormField(
                       controller: _passwordController,
                       obscureText: _obscurePassword,
                       decoration: InputDecoration(
                         labelText: 'Password',
                         prefixIcon: const Icon(Icons.lock_outline),
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(12),
                         ),
                         suffixIcon: IconButton(
                           icon: Icon(
                             _obscurePassword
                                 ? Icons.visibility_off
                                 : Icons.visibility,
                           ),
                           onPressed: () {
                             setState(() {
                               _obscurePassword = !_obscurePassword;
                             });
                           },
                         ),
                       ),
                       validator: (value) {
                         if (value == null || value.isEmpty) {
                           return 'Please enter your password';
                         }
                         if (value.length < 6) {
                           return 'Password must be at least 6 characters';
                         }
                         return null;
                       },
                     ),

                     const SizedBox(height: 16),

                     // Confirm Password
                     TextFormField(
                       controller: _confirmPasswordController,
                       obscureText: _obscureConfirmPassword,
                       decoration: InputDecoration(
                         labelText: 'Confirm password',
                         prefixIcon: const Icon(Icons.lock_reset_outlined),
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(12),
                         ),
                         suffixIcon: IconButton(
                           icon: Icon(
                             _obscureConfirmPassword
                                 ? Icons.visibility_off
                                 : Icons.visibility,
                           ),
                           onPressed: () {
                             setState(() {
                               _obscureConfirmPassword = !_obscureConfirmPassword;
                             });
                           },
                         ),
                       ),
                       validator: (value) {
                         if (value == null || value.isEmpty) {
                           return 'Please confirm your password';
                         }
                         if (value != _passwordController.text) {
                           return 'Passwords do not match';
                         }
                         return null;
                       },
                     ),

                     const SizedBox(height: 24),

                     // Sign up button
                     SizedBox(
                       width: double.infinity,
                       height: 52,
                       child: ElevatedButton(
                         style: ElevatedButton.styleFrom(
                           backgroundColor: darkCard,
                           foregroundColor: Colors.white,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(12),
                           ),
                           elevation: 0,
                         ),
                         onPressed: () {
                           if (_formKey.currentState!.validate()) {
                             // TODO: Replace with real signup logic
                             ScaffoldMessenger.of(context).showSnackBar(
                               const SnackBar(content: Text('Creating account...')),
                             );
                             // Navigate to complete profile screen
                             Navigator.of(context).push(
                               MaterialPageRoute(
                                 builder: (_) => const CompleteProfileScreen(),
                               ),
                             );
                           }
                         },
                         child: const Text(
                           'Create account',
                           style: TextStyle(
                             fontSize: 16,
                             fontWeight: FontWeight.w600,
                           ),
                         ),
                       ),
                     ),

                     const SizedBox(height: 16),

                     // Already have account
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text(
                           'Already have an account?',
                           style: TextStyle(color: Colors.grey.shade700),
                         ),
                         TextButton(
                           onPressed: () {
                             // If we came from login, this will return there.
                             // If this was the first screen, it will simply try to pop and do nothing if not possible.
                             Navigator.of(context).maybePop();
                           },
                           child: const Text('Sign in'),
                         ),
                       ],
                     ),
                   ],
                 ),
               ),
             ],
           ),
         ),
       ),
     );
   }
 }


