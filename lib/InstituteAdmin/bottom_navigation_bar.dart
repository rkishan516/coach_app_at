import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/foundation.dart';
import 'dart:math' as math;

class AnimatedBottomNavigationBar extends StatefulWidget {
  /// Icon data to render in the tab bar.
  final List<IconData> icons;

  /// Handler which is passed every updated active index.
  final Function(int) onTap;

  /// Current index of selected tab bar item.
  final int activeIndex;

  /// Optional custom size for each tab bar icon.
  final double iconSize;

  /// Optional custom tab bar height.
  final double height;

  /// Optional custom tab bar elevation.
  final double elevation;

  /// Optional custom notch margin for Floating
  final double notchMargin;

  /// Optional custom maximum spread radius for splash selection animation.
  final double splashRadius;

  /// Optional custom splash selection animation speed.
  final int splashSpeedInMilliseconds;

  /// Optional custom tab bar top-left corner radius.
  final double leftCornerRadius;

  /// Optional custom tab bar top-right corner radius. Useless with [GapLocation.end].
  final double rightCornerRadius;

  /// Optional custom tab bar background color.
  final Color backgroundColor;

  /// Optional custom splash selection animation color.
  final Color splashColor;

  /// Optional custom currently selected tab bar [IconData] color.
  final Color activeColor;

  /// Optional custom currently unselected tab bar [IconData] color.
  final Color inactiveColor;

  /// Optional custom [Animation] to animate corners and notch appearing.
  final Animation<double> notchAndCornersAnimation;

  /// Optional custom type of notch.
  final NotchSmoothness notchSmoothness;

  /// Location of the free space between tab bar items for notch.
  /// Must have the same location if [FloatingActionButtonLocation.centerDocked] or [FloatingActionButtonLocation.endDocked].
  final GapLocation gapLocation;

  /// Free space width between tab bar items. The preferred width is equal to total width of [FloatingActionButton] and double [notchMargin].
  final double gapWidth;

  AnimatedBottomNavigationBar({
    Key key,
    @required this.icons,
    @required this.activeIndex,
    @required this.onTap,
    this.height = 56,
    this.elevation = 8,
    this.splashRadius = 24,
    this.splashSpeedInMilliseconds = 300,
    this.notchMargin = 8,
    this.backgroundColor = Colors.white,
    this.splashColor = Colors.purple,
    this.activeColor = Colors.deepPurpleAccent,
    this.inactiveColor = Colors.black,
    this.notchAndCornersAnimation,
    this.leftCornerRadius = 0,
    this.rightCornerRadius = 0,
    this.iconSize = 24,
    this.notchSmoothness = NotchSmoothness.softEdge,
    this.gapLocation = GapLocation.none,
    this.gapWidth = 72,
  })  : assert(icons != null),
        assert(icons.length >= 2 && icons.length <= 5),
        assert(activeIndex != null),
        assert(onTap != null),
        super(key: key) {
    if (gapLocation == GapLocation.end) {
      if (rightCornerRadius != 0)
        throw NonAppropriatePathException(
            'RightCornerRadius along with ${GapLocation.end} or/and ${FloatingActionButtonLocation.endDocked} causes render issue => '
            'consider set rightCornerRadius to 0.');
    }
    if (gapLocation == GapLocation.center) {
      if (icons.length % 2 != 0)
        throw NonAppropriatePathException(
            'Odd count of icons along with $gapLocation causes render issue => '
            'consider set gapLocation to ${GapLocation.end}');
    }
  }

  @override
  _AnimatedBottomNavigationBarState createState() =>
      _AnimatedBottomNavigationBarState();
}

class _AnimatedBottomNavigationBarState
    extends State<AnimatedBottomNavigationBar> with TickerProviderStateMixin {
  ValueListenable<ScaffoldGeometry> geometryListenable;
  AnimationController _bubbleController;
  double _bubbleRadius = 0;
  double _iconScale = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    geometryListenable = Scaffold.geometryOf(context);
    if (widget.notchAndCornersAnimation != null) {
      widget.notchAndCornersAnimation..addListener(() => setState(() {}));
    }
  }

  @override
  void didUpdateWidget(AnimatedBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.activeIndex != widget.activeIndex) {
      _startBubbleAnimation();
    }
  }

  _startBubbleAnimation() {
    _bubbleController = AnimationController(
      duration: Duration(milliseconds: widget.splashSpeedInMilliseconds),
      vsync: this,
    );

    final bubbleCurve = CurvedAnimation(
      parent: _bubbleController,
      curve: Curves.linear,
    );

    Tween<double>(begin: 0, end: 1).animate(bubbleCurve)
      ..addListener(() {
        setState(() {
          _bubbleRadius = widget.splashRadius * bubbleCurve.value;
          if (_bubbleRadius == widget.splashRadius) {
            _bubbleRadius = 0;
          }

          if (bubbleCurve.value < 0.5) {
            _iconScale = 1 + bubbleCurve.value;
          } else {
            _iconScale = 2 - bubbleCurve.value;
          }
        });
      });

    if (_bubbleController.isAnimating) {
      _bubbleController.reset();
    }
    _bubbleController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalShape(
      elevation: widget.elevation,
      color: Colors.transparent,
      clipper: CircularNotchedAndCorneredRectangleClipper(
        shape: CircularNotchedAndCorneredRectangle(
          animation: widget.notchAndCornersAnimation,
          notchSmoothness: widget.notchSmoothness,
          gapLocation: widget.gapLocation,
          leftCornerRadius: widget.leftCornerRadius,
          rightCornerRadius: widget.rightCornerRadius,
        ),
        geometry: geometryListenable,
        notchMargin: widget.notchMargin,
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: widget.backgroundColor,
        child: SafeArea(
          child: Container(
            height: widget.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: _buildItems(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildItems() {
    List items = <Widget>[];
    for (var i = 0; i < widget.icons.length; i++) {
      if (widget.gapLocation == GapLocation.center &&
          i == widget.icons.length / 2) {
        items.add(
          GapItem(
            width: widget.gapWidth * widget.notchAndCornersAnimation.value,
          ),
        );
      }

      items.add(
        NavigationBarItem(
          isActive: i == widget.activeIndex,
          bubbleRadius: _bubbleRadius,
          maxBubbleRadius: widget.splashRadius,
          bubbleColor: widget.splashColor,
          activeColor: widget.activeColor,
          inactiveColor: widget.inactiveColor,
          iconData: widget.icons[i],
          iconScale: _iconScale,
          iconSize: widget.iconSize,
          onTap: () => widget.onTap(widget.icons.indexOf(widget.icons[i])),
        ),
      );

      if (widget.gapLocation == GapLocation.end &&
          i == widget.icons.length - 1) {
        items.add(
          GapItem(
            width: widget.gapWidth * widget.notchAndCornersAnimation.value,
          ),
        );
      }
    }
    return items;
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

enum NotchSmoothness { defaultEdge, softEdge, smoothEdge, verySmoothEdge }

enum GapLocation { none, center, end }

class BubblePainter extends CustomPainter {
  final double bubbleRadius;
  final double maxBubbleRadius;
  final Color bubbleColor;
  final Color endColor;

  BubblePainter({
    this.bubbleRadius,
    this.maxBubbleRadius,
    this.bubbleColor,
  })  : endColor = Color.lerp(bubbleColor, Colors.white, 0.8),
        super();

  @override
  void paint(Canvas canvas, Size size) {
    if (bubbleRadius == maxBubbleRadius) return;

    var animationProgress = bubbleRadius / maxBubbleRadius;

    double strokeWidth = bubbleRadius < maxBubbleRadius * 0.5
        ? bubbleRadius
        : maxBubbleRadius - bubbleRadius;

    final paint = Paint()
      ..color = Color.lerp(bubbleColor, endColor, animationProgress)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), bubbleRadius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class CircularNotchedAndCorneredRectangleClipper extends CustomClipper<Path> {
  CircularNotchedAndCorneredRectangleClipper({
    @required this.geometry,
    @required this.shape,
    @required this.notchMargin,
  })  : assert(geometry != null),
        assert(shape != null),
        assert(notchMargin != null),
        super(reclip: geometry);

  final ValueListenable<ScaffoldGeometry> geometry;
  final NotchedShape shape;
  final double notchMargin;

  @override
  Path getClip(Size size) {
    if (geometry.value.floatingActionButtonArea != null &&
        geometry.value.floatingActionButtonArea.width !=
            geometry.value.floatingActionButtonArea.height)
      throw IllegalFloatingActionButtonSizeException(
          'Floating action button must be a circle');

    final Rect button = geometry.value.floatingActionButtonArea?.translate(
      0.0,
      geometry.value.bottomNavigationBarTop * -1.0,
    );

    return shape.getOuterPath(Offset.zero & size, button?.inflate(notchMargin));
  }

  @override
  bool shouldReclip(CircularNotchedAndCorneredRectangleClipper oldClipper) {
    return oldClipper.geometry != geometry ||
        oldClipper.shape != shape ||
        oldClipper.notchMargin != notchMargin;
  }
}

class GapLocationException implements Exception {
  final String _cause;

  GapLocationException(this._cause) : super();

  @override
  String toString() => _cause;
}

class NonAppropriatePathException implements Exception {
  final String _cause;

  NonAppropriatePathException(this._cause) : super();

  @override
  String toString() => _cause;
}

class IllegalFloatingActionButtonSizeException implements Exception {
  String _cause;

  IllegalFloatingActionButtonSizeException(this._cause) : super();

  @override
  String toString() => _cause;
}

class NavigationBarItem extends StatelessWidget {
  final bool isActive;
  final double bubbleRadius;
  final double maxBubbleRadius;
  final Color bubbleColor;
  final Color activeColor;
  final Color inactiveColor;
  final IconData iconData;
  final double iconScale;
  final double iconSize;
  final VoidCallback onTap;

  NavigationBarItem({
    this.isActive,
    this.bubbleRadius,
    this.maxBubbleRadius,
    this.bubbleColor,
    this.activeColor,
    this.inactiveColor,
    this.iconData,
    this.iconScale,
    this.iconSize,
    this.onTap,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: CustomPaint(
          painter: BubblePainter(
            bubbleRadius: isActive ? bubbleRadius : 0,
            bubbleColor: bubbleColor,
            maxBubbleRadius: maxBubbleRadius,
          ),
          child: InkWell(
            child: Transform.scale(
              scale: isActive ? iconScale : 1,
              child: Icon(
                iconData,
                color: isActive ? activeColor : inactiveColor,
                size: iconSize,
              ),
            ),
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}

class GapItem extends StatelessWidget {
  final double width;

  GapItem({this.width});

  @override
  Widget build(BuildContext context) => Container(width: width);
}

class CircularNotchedAndCorneredRectangle extends NotchedShape {
  /// Creates a [CircularNotchedAndCorneredRectangle].
  ///
  /// The same object can be used to create multiple shapes.
  final Animation<double> animation;
  final NotchSmoothness notchSmoothness;
  final GapLocation gapLocation;
  final double leftCornerRadius;
  final double rightCornerRadius;

  CircularNotchedAndCorneredRectangle({
    this.animation,
    this.notchSmoothness,
    this.gapLocation,
    this.leftCornerRadius,
    this.rightCornerRadius,
  });

  /// Creates a [Path] that describes a rectangle with a smooth circular notch.
  ///
  /// `host` is the bounding box for the returned shape. Conceptually this is
  /// the rectangle to which the notch will be applied.
  ///
  /// `guest` is the bounding box of a circle that the notch accommodates. All
  /// points in the circle bounded by `guest` will be outside of the returned
  /// path.
  ///
  /// The notch is curve that smoothly connects the host's top edge and
  /// the guest circle.
  @override
  Path getOuterPath(Rect host, Rect guest) {
    if (guest == null || !host.overlaps(guest)) {
      if (this.rightCornerRadius > 0 || this.leftCornerRadius > 0) {
        double leftCornerRadius =
            this.leftCornerRadius * (animation?.value ?? 1);
        double rightCornerRadius =
            this.rightCornerRadius * (animation?.value ?? 1);
        return Path()
          ..moveTo(host.left, host.top)
          ..arcTo(
            Rect.fromLTWH(host.left, host.top, leftCornerRadius * 2,
                leftCornerRadius * 2),
            _degreeToRadians(180),
            _degreeToRadians(90),
            false,
          )
          ..lineTo(host.right - host.height, host.top)
          ..arcTo(
            Rect.fromLTWH(host.right - rightCornerRadius * 2, host.top,
                rightCornerRadius * 2, rightCornerRadius * 2),
            _degreeToRadians(270),
            _degreeToRadians(90),
            false,
          )
          ..lineTo(host.right, host.bottom)
          ..lineTo(host.left, host.bottom)
          ..close();
      }
      return Path()..addRect(host);
    }

    if (guest.center.dx == host.width / 2) {
      if (gapLocation != GapLocation.center)
        throw GapLocationException(
            'Wrong gap location in $AnimatedBottomNavigationBar towards FloatingActionButtonLocation => '
            'consider use ${GapLocation.center} instead of $gapLocation or change FloatingActionButtonLocation');
    }

    if (guest.center.dx != host.width / 2) {
      if (gapLocation != GapLocation.end)
        throw GapLocationException(
            'Wrong gap location in $AnimatedBottomNavigationBar towards FloatingActionButtonLocation => '
            'consider use ${GapLocation.end} instead of $gapLocation or change FloatingActionButtonLocation');
    }

    // The guest's shape is a circle bounded by the guest rectangle.
    // So the guest's radius is half the guest width.
    double notchRadius = guest.width / 2 * (animation?.value ?? 1);
    double leftCornerRadius = this.leftCornerRadius * (animation?.value ?? 1);
    double rightCornerRadius = this.rightCornerRadius * (animation?.value ?? 1);

    // We build a path for the notch from 3 segments:
    // Segment A - a Bezier curve from the host's top edge to segment B.
    // Segment B - an arc with radius notchRadius.
    // Segment C - a Bezier curve from segment B back to the host's top edge.
    //
    // A detailed explanation and the derivation of the formulas below is
    // available at: https://goo.gl/Ufzrqn

    final double s1 = notchSmoothness.s1;
    final double s2 = notchSmoothness.s2;

    double r = notchRadius;
    double a = -1.0 * r - s2;
    double b = host.top - guest.center.dy;

    double n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    double p2xA = ((a * r * r) - n2) / (a * a + b * b);
    double p2xB = ((a * r * r) + n2) / (a * a + b * b);
    double p2yA = math.sqrt(r * r - p2xA * p2xA);
    double p2yB = math.sqrt(r * r - p2xB * p2xB);

    List<Offset> p = List<Offset>(6);

    // p0, p1, and p2 are the control points for segment A.
    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    // p3, p4, and p5 are the control points for segment B, which is a mirror
    // of segment A around the y axis.
    p[3] = Offset(-1.0 * p[2].dx, p[2].dy);
    p[4] = Offset(-1.0 * p[1].dx, p[1].dy);
    p[5] = Offset(-1.0 * p[0].dx, p[0].dy);

    // translate all points back to the absolute coordinate system.
    for (int i = 0; i < p.length; i += 1) p[i] += guest.center;

    return Path()
      ..moveTo(host.left, host.top)
      ..arcTo(
        Rect.fromLTWH(
            host.left, host.top, leftCornerRadius * 2, leftCornerRadius * 2),
        _degreeToRadians(180),
        _degreeToRadians(90),
        false,
      )
      ..lineTo(p[0].dx, p[0].dy)
      ..quadraticBezierTo(p[1].dx, p[1].dy, p[2].dx, p[2].dy)
      ..arcToPoint(
        p[3],
        radius: Radius.circular(notchRadius),
        clockwise: false,
      )
      ..quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy)
      ..lineTo(host.right - host.height, host.top)
      ..arcTo(
        Rect.fromLTWH(host.right - rightCornerRadius * 2, host.top,
            rightCornerRadius * 2, rightCornerRadius * 2),
        _degreeToRadians(270),
        _degreeToRadians(90),
        false,
      )
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();
  }
}

double _degreeToRadians(double degree) {
  final double radian = (math.pi / 180) * degree;
  return radian;
}

extension on NotchSmoothness {
  static const curveS1 = {
    NotchSmoothness.defaultEdge: 15.0,
    NotchSmoothness.softEdge: 20.0,
    NotchSmoothness.smoothEdge: 30.0,
    NotchSmoothness.verySmoothEdge: 40.0,
  };

  static const curveS2 = {
    NotchSmoothness.defaultEdge: 1.0,
    NotchSmoothness.softEdge: 5.0,
    NotchSmoothness.smoothEdge: 15.0,
    NotchSmoothness.verySmoothEdge: 25.0,
  };

  double get s1 => curveS1[this];

  double get s2 => curveS2[this];
}
