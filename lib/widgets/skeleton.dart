import 'package:flutter/material.dart';

class Skeleton extends StatefulWidget {
  final bool isLoading;
  final Duration duration;
  final Curve curve;

  const Skeleton({
    Key? key,
    this.isLoading = true,
    this.duration = const Duration(milliseconds: 1200),
    this.curve = Curves.easeInOut,
  }) : super(key: key);

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final child = Container(
    width: double.infinity,
    height: 80,
    margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(10),
    ),
  );

  @override
  void initState() {
    super.initState();

    if (widget.isLoading) {
      _controller = AnimationController(
        vsync: this,
        duration: widget.duration,
      );
      _animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: widget.curve,
        ),
      );
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant Skeleton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isLoading) {
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  Widget _skeleton() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: _animation.value,
          child: child,
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoading ? _skeleton() : child;
  }
}
