import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';
import '../core/utils/responsive.dart';
import '../widgets/buttons/shadcn_button.dart';
import '../widgets/cards/shadcn_card.dart';
import '../widgets/input/shadcn_input.dart';
import '../widgets/toast/shadcn_toast.dart';

/// Contact section with form
class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Responsive.sectionPadding(context),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Responsive.contentMaxWidth(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section header
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Get In Touch',
                    style: AppTypography.headingLarge(
                      AppColors.foreground(context),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    "Let's discuss your project or just say hello",
                    style: AppTypography.bodyMedium(
                      AppColors.mutedForeground(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              // Contact content
              ResponsiveBuilder(
                mobile: _MobileLayout(
                  formKey: _formKey,
                  nameController: _nameController,
                  emailController: _emailController,
                  messageController: _messageController,
                  isLoading: _isLoading,
                  onSubmit: _handleSubmit,
                ),
                desktop: _DesktopLayout(
                  formKey: _formKey,
                  nameController: _nameController,
                  emailController: _emailController,
                  messageController: _messageController,
                  isLoading: _isLoading,
                  onSubmit: _handleSubmit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    if (mounted) {
      ShadcnToast.show(
        context,
        message: 'Message sent successfully!',
        description: "I'll get back to you as soon as possible.",
        variant: ShadcnToastVariant.success,
      );

      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }
}

class _MobileLayout extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController messageController;
  final bool isLoading;
  final VoidCallback onSubmit;

  const _MobileLayout({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.messageController,
    required this.isLoading,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ContactInfo(),
        const SizedBox(height: AppSpacing.xl),
        _ContactForm(
          formKey: formKey,
          nameController: nameController,
          emailController: emailController,
          messageController: messageController,
          isLoading: isLoading,
          onSubmit: onSubmit,
        ),
      ],
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController messageController;
  final bool isLoading;
  final VoidCallback onSubmit;

  const _DesktopLayout({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.messageController,
    required this.isLoading,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _ContactInfo()),
        const SizedBox(width: AppSpacing.xxl),
        Expanded(
          flex: 2,
          child: _ContactForm(
            formKey: formKey,
            nameController: nameController,
            emailController: emailController,
            messageController: messageController,
            isLoading: isLoading,
            onSubmit: onSubmit,
          ),
        ),
      ],
    );
  }
}

class _ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's work together",
          style: AppTypography.headingMedium(AppColors.foreground(context)),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          "I'm always interested in hearing about new projects and opportunities. Whether you have a question or just want to say hi, feel free to reach out!",
          style: AppTypography.bodyMedium(AppColors.mutedForeground(context)),
        ),
        const SizedBox(height: AppSpacing.xl),

        // Contact methods
        _ContactMethod(
          icon: Icons.email_rounded,
          label: 'Email',
          value: 'mohamedeladnani0@gmail.com',
          onTap: () => _launchUrl('mailto:mohamedeladnani0@gmail.com'),
        ),
        const SizedBox(height: AppSpacing.md),
        _ContactMethod(
          icon: Icons.location_on_rounded,
          label: 'Location',
          value: 'Morocco',
        ),
        const SizedBox(height: AppSpacing.md),
        _ContactMethod(
          icon: Icons.schedule_rounded,
          label: 'Availability',
          value: 'Open to new opportunities',
        ),
        const SizedBox(height: AppSpacing.xl),

        // Social links
        Row(
          children: [
            _SocialButton(
              icon: Icons.code_rounded,
              label: 'GitHub',
              onTap: () => _launchUrl('https://github.com/mel-adna'),
            ),
            const SizedBox(width: AppSpacing.sm),
            _SocialButton(
              icon: Icons.work_rounded,
              label: 'LinkedIn',
              onTap: () => _launchUrl('https://www.linkedin.com/in/mel-adna/'),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _ContactMethod extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _ContactMethod({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: onTap != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.accent(context).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Icon(icon, size: 20, color: AppColors.accent(context)),
            ),
            const SizedBox(width: AppSpacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.caption(
                    AppColors.mutedForeground(context),
                  ),
                ),
                Text(
                  value,
                  style: AppTypography.bodyMedium(
                    AppColors.foreground(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _SocialButton({required this.icon, required this.label, this.onTap});

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.muted(context) : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(color: AppColors.border(context)),
          ),
          child: Icon(
            widget.icon,
            size: 20,
            color: _isHovered
                ? AppColors.foreground(context)
                : AppColors.mutedForeground(context),
          ),
        ),
      ),
    );
  }
}

class _ContactForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController messageController;
  final bool isLoading;
  final VoidCallback onSubmit;

  const _ContactForm({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.messageController,
    required this.isLoading,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return ShadcnCard(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Send a message',
              style: AppTypography.headingSmall(AppColors.foreground(context)),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Name field
            ShadcnInput(
              controller: nameController,
              label: 'Name',
              placeholder: 'Your name',
              prefixIcon: Icons.person_outline_rounded,
            ),
            const SizedBox(height: AppSpacing.md),

            // Email field
            ShadcnInput(
              controller: emailController,
              label: 'Email',
              placeholder: 'your@email.com',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: AppSpacing.md),

            // Message field
            ShadcnTextarea(
              controller: messageController,
              label: 'Message',
              placeholder: 'Tell me about your project...',
              minLines: 4,
              maxLines: 8,
            ),
            const SizedBox(height: AppSpacing.lg),

            // Submit button
            ShadcnButton(
              text: isLoading ? 'Sending...' : 'Send Message',
              icon: isLoading ? null : Icons.send_rounded,
              variant: ShadcnButtonVariant.primary,
              size: ShadcnButtonSize.lg,
              isLoading: isLoading,
              onPressed: isLoading ? null : onSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
