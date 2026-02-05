---
trigger: model_decision
description: When working with UI, UX, or animations.
---

# FLUTTER UI/UX EXPERT GUIDELINES

# 1. RESPONSIVE & ADAPTIVE DESIGN
- **No Hardcoded Dimensions:** Avoid fixed heights/widths (e.g., `height: 50`) for layout containers. Use `Flexible`, `Expanded`, or percentages of `MediaQuery`.
- **Adaptive Breakpoints:** Always consider Mobile vs. Desktop/Web.
  - Use `LayoutBuilder` for component-level responsiveness.
  - Use `shortestSide` checks for Tablet vs. Phone logic.
- **Touch Targets:** Ensure all tappable areas are at least 48x48 logical pixels (Mobile guidelines). Use `HitTestBehavior.opaque` if necessary.

# 2. THEMING & STYLING (STRICT)
- **Zero Hardcoded Colors:** NEVER use `Colors.blue` or Hex codes directly in widgets.
  - ALWAYS use `Theme.of(context).colorScheme.primary`, `surface`, `onBackground`, etc.
  - This ensures Dark Mode support works out-of-the-box.
- **Typography:** NEVER use `TextStyle(fontSize: 20, fontWeight: FontWeight.bold)`.
  - ALWAYS use `Theme.of(context).textTheme.titleLarge`.
  - Apply modifications using `.copyWith()` only when strictly necessary.
- **Padding/Spacing:** Use defined constants or variables for spacing (e.g., `Gap(16)` or `const EdgeInsets.all(AppSpacing.md)`), avoiding magic numbers like `13.0`.

# 3. WIDGET ARCHITECTURE (ATOMIC DESIGN)
- **Composition over Inheritance:** Build complex UIs by composing small, single-purpose widgets (Atoms/Molecules).
- **Separate View & Logic:**
  - `Page/Screen`: Scaffolds, global state connections.
  - `Organisms/Sections`: Large blocks of UI (e.g., `HomeHeader`, `ProductList`).
  - `Molecules/Atoms`: Reusable buttons, cards, tags.
- **Const Correctness:** The AI MUST prioritize `const` constructors for all stateless UI elements to prevent unnecessary rebuilds.

# 4. ACCESSIBILITY (A11Y)
- **Semantics:** Wrap interactive or informative widgets in `Semantics()` if they are custom-built.
- **Screen Readers:** Ensure `IconButton` has a `tooltip`.
- **Text Scaling:** Test that layouts do not break when `textScaleFactor` is > 1.0. Use `TextOverflow.ellipsis` or scrollable containers for safety.

# 5. ANIMATIONS & MICRO-INTERACTIONS
- **Declarative Motion:** Prefer `AnimatedContainer`, `AnimatedOpacity`, or `AnimatedCrossFade` for simple state changes over full `AnimationController` boilerplate.
- **Feedback:** All buttons/cards must have visual feedback on tap (InkWell/Ripple).

# FLUTTER ANIMATION MASTERY GUIDELINES

# 1. THE HIERARCHY OF ANIMATION (STRATEGY)
Before writing code, apply this decision tree to choose the lightest tool:
1. **Implicit Animations (First Choice):** For simple property changes (color, size, opacity, position), ALWAYS prefer `AnimatedContainer`, `AnimatedOpacity`, `AnimatedPositioned`, or `AnimatedAlign`. They handle internal state and cleanup automatically.
2. **Explicit Animations (Second Choice):** Use `AnimationController` + `AnimatedBuilder` only when you need:
   - Orchestration (staggered animations).
   - Repeat/Looping.
   - User control (pause, reverse, scrub).
3. **Pre-built Transitions:** Prefer standard widgets like `FadeTransition`, `ScaleTransition`, `SlideTransition` over building custom ones inside `AnimatedBuilder`.

# 2. PERFORMANCE & OPTIMIZATION (CRITICAL)
- **The `child` Parameter:** When using `AnimatedBuilder` or `TweenAnimationBuilder`, NEVER rebuild static sub-trees. Pass the static widget subtree into the `child` parameter and use it inside the builder closure.
  - *Bad:* `builder: (ctx, val, _) => Container(child: HugeStaticWidget())`
  - *Good:* `child: HugeStaticWidget(), builder: (ctx, val, child) => Container(child: child)`
- **RepaintBoundaries:** Suggest wrapping heavy animated areas in `RepaintBoundary()` to separate their painting layer from the rest of the screen.
- **Avoid Layout Thrashing:** Prefer animating `Transform` (Translate/Scale/Rotate) and `Opacity`. Avoid animating `width`, `height`, or `padding` in high-frequency loops (explicit animations) as they trigger expensive layout passes.

# 3. WEB & CANVAS SPECIFIC RULES
- **Shader Warm-up:** Be cautious with heavy shaders or `BackdropFilter` (Blur) on Web. They can cause severe jank on some renderers.
- **SVG vs. Code:** For complex vector animations (like icons morphing), suggest **Rive** or **Lottie** instead of coding pure `CustomPainter` paths manually, unless it's simple geometry.

# 4. NATURAL MOTION (UX)
- **Kill Linear:** NEVER use `Curves.linear` for UI movement (sliding, scaling). It looks robotic.
  - *Default:* Use `Curves.easeOutCubic` or `Curves.easeOutExpo` for entering elements.
  - *Exiting:* Use `Curves.easeInCubic`.
- **Spring Physics:** For interactive elements (drag releases), suggest `SpringSimulation` or physics-based curves over standard duration-based curves.

# 5. BOILERPLATE REDUCTION
- **Mixins:** Always use `SingleTickerProviderStateMixin` for a single controller.
- **Disposal:** STRICTLY enforce `controller.dispose()` in the `dispose` method to prevent memory leaks.