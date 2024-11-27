import 'dart:math' as math;

import 'package:flutter/physics.dart';
import 'package:flutter/widgets.dart';

class FlatWheelScrollView extends StatefulWidget {
  /// `Based on [ListWheelScrollView] but with a flat perspective.`
  ///
  /// Custom physics and controller based on the [FixedExtentScrollPhysics] and [FixedExtentScrollController].
  ///
  /// [controller] Scroll controller for [FlatScrollPhysics].
  ///
  /// [physics] Makes sure we always land on a particular countdown_detail after scrolling.
  ///
  /// [scrollBehavior] Scroll behavior for [FlatWheelScrollView].
  ///
  /// [itemExtent] Maximum size of an countdown_detail in the main axis.
  ///
  /// [itemCount] Total items to render for the [FlatWheelScrollView].
  ///
  /// [looping] Whether to create an infinite scroll loop of the items in the [FlatWheelScrollView].
  ///
  /// [onSelectedItemChanged] Callback fired when an countdown_detail is changed.
  ///
  /// [itemBuilder] To lazily build items on the viewport.
  const FlatWheelScrollView({
    super.key,
    this.controller,
    this.physics,
    this.scrollBehavior,
    required this.itemExtent,
    required this.itemCount,
    required this.looping,
    this.onSelectedItemChanged,
    required this.itemBuilder,
  });

  /// Scroll controller for [FlatScrollPhysics].
  final ScrollController? controller;

  /// [FlatScrollPhysics], which makes sure we always land on a particular countdown_detail after scrolling.
  /// This is the `default` physics for [FlatWheelScrollView].
  final ScrollPhysics? physics;

  /// Scroll behavior for [FlatWheelScrollView].
  final ScrollBehavior? scrollBehavior;

  /// Maximum size of an countdown_detail in the main axis.
  final double itemExtent;

  /// Total items to render for the [FlatWheelScrollView].
  final int itemCount;

  /// Whether to create an infinite scroll loop of the items in the [FlatWheelScrollView].
  final bool looping;

  /// Callback fired when an countdown_detail is changed.
  final ValueChanged<int>? onSelectedItemChanged;

  /// To lazily build items on the viewport.
  ///
  /// If [looping] is true, two indexes are rendered by the countdown_detail builder; `forward` and `reverse` items.
  ///
  /// Otherwise, only the `forward` index is rendered.
  final Widget Function(BuildContext context, int itemIndex) itemBuilder;

  @override
  State<StatefulWidget> createState() => _FlatWheelScrollViewState();
}

class _FlatWheelScrollViewState extends State<FlatWheelScrollView> {
  final Key _forwardListKey = const ValueKey<String>('flat_wheel_scroll_view');
  FlatScrollController? _controller;
  int _lastReportedItemIndex = 0;

  ScrollController get _effectiveController => widget.controller ?? (_controller ??= FlatScrollController());

  @override
  void initState() {
    super.initState();
    if (widget.controller is FlatScrollController) {
      final FlatScrollController controller = widget.controller! as FlatScrollController;
      _lastReportedItemIndex = controller.initialItem;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();

    super.dispose();
  }

  int _getTrueIndex(int currentIndex, int totalCount) {
    if (currentIndex >= 0) {
      return currentIndex % totalCount;
    }

    return (totalCount + (currentIndex % totalCount)) % totalCount;
  }

  bool _handleNotification(ScrollNotification notification) {
    if (notification.depth == 0 &&
        widget.onSelectedItemChanged != null &&
        notification is ScrollUpdateNotification &&
        notification.metrics is FlatMetrics) {
      final FlatMetrics metrics = notification.metrics as FlatMetrics;
      final int currentItemIndex = metrics.itemIndex;
      if (currentItemIndex != _lastReportedItemIndex) {
        _lastReportedItemIndex = currentItemIndex;
        final int trueIndex = _getTrueIndex(_lastReportedItemIndex, widget.itemCount);
        widget.onSelectedItemChanged?.call(trueIndex);
      }
    }

    return false;
  }

  List<Widget> _renderSlivers() {
    Widget forward = SliverFixedExtentList(
      key: _forwardListKey,
      delegate: SliverChildBuilderDelegate(
        (context, index) => widget.itemBuilder(context, index.abs() % widget.itemCount),
        childCount: widget.looping ? null : widget.itemCount,
      ),
      itemExtent: widget.itemExtent,
    );

    if (!widget.looping) return [forward];

    Widget reversed = SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => widget.itemBuilder(context, widget.itemCount - (index.abs() % widget.itemCount) - 1),
      ),
      itemExtent: widget.itemExtent,
    );

    return [reversed, forward];
  }

  double _getCenteredAnchor(BoxConstraints constraints) {
    return ((constraints.maxHeight / 2) - (widget.itemExtent / 2)) / constraints.maxHeight;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleNotification,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return _FlatScrollable(
            controller: _effectiveController,
            physics: widget.physics,
            itemExtent: widget.itemExtent,
            itemCount: widget.itemCount,
            looping: widget.looping,
            scrollBehavior: widget.scrollBehavior ?? ScrollConfiguration.of(context).copyWith(scrollbars: false),
            viewportBuilder: (context, position) {
              return Viewport(
                center: _forwardListKey,
                offset: position,
                anchor: _getCenteredAnchor(constraints),
                slivers: _renderSlivers(),
              );
            },
          );
        },
      ),
    );
  }
}

class FlatMetrics extends FixedScrollMetrics {
  FlatMetrics({
    required super.minScrollExtent,
    required super.maxScrollExtent,
    required super.pixels,
    required super.viewportDimension,
    required super.axisDirection,
    required super.devicePixelRatio,
    required this.itemIndex,
  });

  @override
  FlatMetrics copyWith({
    double? minScrollExtent,
    double? maxScrollExtent,
    double? pixels,
    double? viewportDimension,
    AxisDirection? axisDirection,
    double? devicePixelRatio,
    int? itemIndex,
  }) {
    return FlatMetrics(
      minScrollExtent: minScrollExtent ?? (hasContentDimensions ? this.minScrollExtent : null),
      maxScrollExtent: maxScrollExtent ?? (hasContentDimensions ? this.maxScrollExtent : null),
      pixels: pixels ?? this.pixels,
      viewportDimension: viewportDimension ?? this.viewportDimension,
      axisDirection: axisDirection ?? this.axisDirection,
      devicePixelRatio: devicePixelRatio ?? this.devicePixelRatio,
      itemIndex: itemIndex ?? this.itemIndex,
    );
  }

  // The scroll view's currently selected countdown_detail index
  final int itemIndex;
}

class _FlatScrollable extends Scrollable {
  const _FlatScrollable({
    super.controller,
    super.physics,
    super.scrollBehavior,
    required super.viewportBuilder,
    required this.itemExtent,
    required this.looping,
    required this.itemCount,
  });

  final double itemExtent;
  final bool looping;
  final int itemCount;

  @override
  _FlatScrollableState createState() => _FlatScrollableState();
}

class _FlatScrollableState extends ScrollableState {
  double get itemExtent => (widget as _FlatScrollable).itemExtent;
  bool get looping => (widget as _FlatScrollable).looping;
  int get itemCount => (widget as _FlatScrollable).itemCount;
}

class _FlatScrollPosition extends ScrollPositionWithSingleContext implements FlatMetrics {
  _FlatScrollPosition({
    required super.physics,
    required super.context,
    required int initialItem,
    super.oldPosition,
  })  : assert(context is _FlatScrollableState),
        super(
          initialPixels: _getItemExtentFromScrollContext(context) * initialItem,
        );

  double get itemExtent => _getItemExtentFromScrollContext(context);
  static double _getItemExtentFromScrollContext(ScrollContext context) {
    return (context as _FlatScrollableState).itemExtent;
  }

  bool get looping => _getLoopingFromScrollExtent(context);
  static bool _getLoopingFromScrollExtent(ScrollContext context) {
    return (context as _FlatScrollableState).looping;
  }

  int get itemCount => _getItemCountFromScrollExtent(context);
  static int _getItemCountFromScrollExtent(ScrollContext context) {
    return (context as _FlatScrollableState).itemCount;
  }

  @override
  int get itemIndex => _getItemFromOffset(
        offset: pixels,
        itemExtent: itemExtent,
        minScrollExtent: minScrollExtent,
        maxScrollExtent: maxScrollExtent,
      );

  @override
  double get maxScrollExtent => looping ? (super.hasContentDimensions ? super.maxScrollExtent : 0.0) : itemExtent * (itemCount - 1);

  @override
  FlatMetrics copyWith({
    double? minScrollExtent,
    double? maxScrollExtent,
    double? pixels,
    double? viewportDimension,
    AxisDirection? axisDirection,
    double? devicePixelRatio,
    int? itemIndex,
  }) {
    return FlatMetrics(
      minScrollExtent: minScrollExtent ?? (hasContentDimensions ? this.minScrollExtent : null),
      maxScrollExtent: maxScrollExtent ?? (hasContentDimensions ? this.maxScrollExtent : null),
      pixels: pixels ?? (hasPixels ? this.pixels : null),
      viewportDimension: viewportDimension ?? (hasViewportDimension ? this.viewportDimension : null),
      axisDirection: axisDirection ?? this.axisDirection,
      itemIndex: itemIndex ?? this.itemIndex,
      devicePixelRatio: devicePixelRatio ?? this.devicePixelRatio,
    );
  }
}

class FlatScrollController extends ScrollController {
  FlatScrollController({this.initialItem = 0});

  final int initialItem;

  int get selectedItem => (position as _FlatScrollPosition).itemIndex;

  /// Animate to a specific countdown_detail index
  Future<void> animateToItem(
    int itemIndex, {
    required Duration duration,
    required Curve curve,
  }) async {
    if (!hasClients) {
      return;
    }

    await Future.wait<void>(<Future<void>>[
      for (final _FlatScrollPosition position in positions.cast<_FlatScrollPosition>())
        position.animateTo(
          itemIndex * position.itemExtent,
          duration: duration,
          curve: curve,
        ),
    ]);
  }

  /// Jumpt to a specific countdown_detail index
  void jumpToItem(int itemIndex) {
    for (final _FlatScrollPosition position in positions.cast<_FlatScrollPosition>()) {
      position.jumpTo(itemIndex * position.itemExtent);
    }
  }

  @override
  ScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition? oldPosition,
  ) {
    return _FlatScrollPosition(
      physics: physics,
      context: context,
      initialItem: initialItem,
      oldPosition: oldPosition,
    );
  }
}

class FlatScrollPhysics extends ScrollPhysics {
  const FlatScrollPhysics({super.parent});

  @override
  FlatScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return FlatScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    assert(position is _FlatScrollPosition);

    final _FlatScrollPosition metrics = position as _FlatScrollPosition;

    // Scenario 1:
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at the scrollable's boundary.
    if ((velocity <= 0.0 && metrics.pixels <= metrics.minScrollExtent) || (velocity >= 0.0 && metrics.pixels >= metrics.maxScrollExtent)) {
      return super.createBallisticSimulation(metrics, velocity);
    }

    // Create a test simulation to see where it would have ballistically fallen
    // naturally without settling onto items.
    final Simulation? testFrictionSimulation = super.createBallisticSimulation(metrics, velocity);

    // Scenario 2:
    // If it was going to end up past the scroll extent, defer back to the
    // parent physics' ballistics again which should put us on the scrollable's
    // boundary.
    if (testFrictionSimulation != null &&
        (testFrictionSimulation.x(double.infinity) == metrics.minScrollExtent ||
            testFrictionSimulation.x(double.infinity) == metrics.maxScrollExtent)) {
      return super.createBallisticSimulation(metrics, velocity);
    }

    // From the natural final position, find the nearest countdown_detail it should have
    // settled to.
    final int settlingItemIndex = _getItemFromOffset(
      offset: testFrictionSimulation?.x(double.infinity) ?? metrics.pixels,
      itemExtent: metrics.itemExtent,
      minScrollExtent: metrics.minScrollExtent,
      maxScrollExtent: metrics.maxScrollExtent,
    );

    final double settlingPixels = settlingItemIndex * metrics.itemExtent;

    // Scenario 3:
    // If there's no velocity and we're already at where we intend to land,
    // do nothing.
    if (velocity.abs() < toleranceFor(position).velocity && (settlingPixels - metrics.pixels).abs() < toleranceFor(position).distance) {
      return null;
    }

    // Scenario 4:
    // If we're going to end back at the same countdown_detail because initial velocity
    // is too low to break past it, use a spring simulation to get back.
    if (settlingItemIndex == metrics.itemIndex) {
      return SpringSimulation(
        spring,
        metrics.pixels,
        settlingPixels,
        velocity,
        tolerance: toleranceFor(position),
      );
    }

    // Scenario 5:
    // Create a new friction simulation except the drag will be tweaked to land
    // exactly on the countdown_detail closest to the natural stopping point.
    return FrictionSimulation.through(
      metrics.pixels,
      settlingPixels,
      velocity,
      toleranceFor(position).velocity * velocity.sign,
    );
  }
}

int _getItemFromOffset({
  required double offset,
  required double itemExtent,
  required double minScrollExtent,
  required double maxScrollExtent,
}) {
  return (_clipOffsetToScrollableRange(offset, minScrollExtent, maxScrollExtent) / itemExtent).round();
}

double _clipOffsetToScrollableRange(
  double offset,
  double minScrollExtent,
  double maxScrollExtent,
) {
  return math.min(math.max(offset, minScrollExtent), maxScrollExtent);
}
