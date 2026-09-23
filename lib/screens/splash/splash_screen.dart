import 'package:flutter/material.dart';
import '../../animations/animated_logo.dart';
import '../../animations/app_animations.dart';
import '../../animations/page_transition.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/initialization_service.dart';
import '../../components/loaders/app_loader.dart';
import '../home/home_screen.dart';

/// The application's splash screen.
///
/// RESPONSIBILITY
/// This screen has two jobs: (1) present the branded entrance animation,
/// and (2) drive the simulated startup sequence from
/// [InitializationService] and react to its progress. It deliberately
/// does *not* know what "initialization" involves internally — see that
/// service's own documentation for why that separation matters.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final InitializationService _initService = InitializationService();

  // The current step label is held in a plain `late` field and pushed
  // into UI via `setState`, rather than via a ValueNotifier, because only
  // this single screen ever reads it — a broadcastable notifier would be
  // unnecessary machinery for state with exactly one listener.
  String _statusLabel = InitializationService.steps.first.label;
  double _progress = 0;

  // A separate AnimationController drives the app-name text's fade/slide
  // entrance, timed to start slightly after the logo so the two elements
  // don't compete for attention simultaneously.
  late final AnimationController _textController;
  late final Animation<double> _textFade;
  late final Animation<Offset> _textSlide;

  @override
  void initState() {
    super.initState();

    _textController = AnimationController(
      vsync: this,
      duration: AppAnimations.effectiveDuration(context, AppAnimations.normal),
    );
    final curved = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutCubic,
    );
    _textFade = Tween<double>(begin: 0, end: 1).animate(curved);
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(curved);

    // Starting the text animation after a short delay lets the logo
    // animation (which starts immediately inside AnimatedLogo) lead,
    // creating a simple, readable animation sequence rather than
    // everything appearing at once.
    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) _textController.forward();
    });

    _runStartupSequence();
  }

  Future<void> _runStartupSequence() async {
    await _initService.run(
      onStepStart: (index, step) {
        if (!mounted) return;
        setState(() {
          _statusLabel = step.label;
          _progress = (index + 1) / InitializationService.steps.length;
        });
      },
    );

    if (!mounted) return;

    // Using a custom fade transition (rather than the platform default)
    // for this one navigation keeps the splash-to-home hand-off visually
    // seamless instead of using a directional slide that would imply
    // Home is spatially "next to" the splash screen.
    Navigator.of(context).pushReplacement(
      AppPageTransition.fade(const HomeScreen(), context: context),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            children: [
              const Spacer(flex: 3),
              // AnimatedLogo manages its own fade/scale/rotation
              // animation internally — this screen only needs to place
              // it, not choreograph it.
              const AnimatedLogo(size: 108),
              const SizedBox(height: AppSpacing.lg),
              FadeTransition(
                opacity: _textFade,
                child: SlideTransition(
                  position: _textSlide,
                  child: Column(
                    children: [
                      Text(
                        AppConstants.appName,
                        style: AppTextStyles.headline.copyWith(
                          color: Theme.of(
                            context,
                          ).textTheme.headlineMedium?.color,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        AppConstants.appTagline,
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 3),
              // The linear loader gives concrete visual progress feedback
              // (rather than only a spinner), which makes a short,
              // deterministic startup sequence like this one feel more
              // informative.
              SizedBox(width: 180, child: AppLinearLoader(value: _progress)),
              const SizedBox(height: AppSpacing.md),
              // A `liveRegion` Semantics wrapper means a screen-reader
              // user hears each status update as it changes, instead of
              // silence followed by an unexplained screen change.
              Semantics(
                liveRegion: true,
                child: Text(_statusLabel, style: AppTextStyles.caption),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
