import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/application/themes/theme_interface.dart';

enum IndicatorSide { start, end }

/// A vertical tab widget for flutter
class VerticalTabs extends StatefulWidget {
  final Key key;
  final double tabsWidth;
  final EdgeInsets tabsPadding;
  final List<Tab> tabs;
  final List<Widget> contents;
  final int initialIndex;
  final TextDirection direction;
  final IndicatorSide indicatorSide;
  final double indicatorWidth;
  final Color indicatorColor;
  final bool disabledChangePageFromContentView;
  final Axis contentScrollAxis;
  final Color backgroundColor;
  final Color selectedTabBackgroundColor;
  final Color tabBackgroundColor;
  final TextStyle selectedTabTextStyle;
  final TextStyle tabTextStyle;
  final Curve changePageCurve;
  final Duration changePageDuration;
  final Color tabsShadowColor;
  final double tabsElevation;
  final Function(int tabIndex) onSelect;

  VerticalTabs({
    this.key,
    @required this.tabs,
    @required this.contents,
    @required this.tabsWidth,
    this.tabsPadding,
    this.initialIndex = 0,
    this.indicatorWidth = 0,
    this.indicatorSide,
    this.indicatorColor,
    this.disabledChangePageFromContentView = false,
    this.contentScrollAxis = Axis.vertical,
    this.selectedTabBackgroundColor,
    this.tabBackgroundColor,
    this.direction = TextDirection.ltr,
    this.selectedTabTextStyle,
    this.tabTextStyle,
    this.changePageCurve = Curves.easeInOut,
    this.changePageDuration = const Duration(milliseconds: 300),
    this.tabsShadowColor,
    this.tabsElevation = 2.0,
    this.onSelect,
    this.backgroundColor,
  })  : assert(
            tabs != null && contents != null && tabs.length == contents.length),
        super(key: key);

  @override
  _VerticalTabsState createState() => _VerticalTabsState();
}

class _VerticalTabsState extends State<VerticalTabs>
    with TickerProviderStateMixin {
  int _selectedIndex;
  bool _changePageByTapView;

  AnimationController animationController;
  Animation<double> animation;
  Animation<RelativeRect> rectAnimation;

  PageController pageController = PageController();

  List<AnimationController> animationControllers = [];

  ScrollPhysics pageScrollPhysics = AlwaysScrollableScrollPhysics();

  @override
  void initState() {
    _selectedIndex = widget.initialIndex;
    for (int i = 0; i < widget.tabs.length; i++) {
      animationControllers.add(AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      ));
    }
    _selectTab(widget.initialIndex);

    if (widget.disabledChangePageFromContentView == true)
      pageScrollPhysics = NeverScrollableScrollPhysics();

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController.jumpToPage(widget.initialIndex);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.direction,
      child: Container(
        color: widget.backgroundColor ?? Colors.transparent,
        padding: widget.tabsPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    width: widget.tabsWidth,
                    child: ListView.builder(
                      primary: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: widget.tabs.length,
                      itemBuilder: (context, index) {
                        Widget child = widget.tabs[index].child;

                        Color itemBGColor =
                            widget.tabBackgroundColor ?? Colors.transparent;
                        if (_selectedIndex == index)
                          itemBGColor = widget.selectedTabBackgroundColor ??
                              Colors.transparent;

                        double left, right;
                        if (widget.direction == TextDirection.rtl) {
                          left = (widget.indicatorSide == IndicatorSide.end)
                              ? 0
                              : null;
                          right = (widget.indicatorSide == IndicatorSide.start)
                              ? 0
                              : null;
                        } else {
                          left = (widget.indicatorSide == IndicatorSide.start)
                              ? 0
                              : null;
                          right = (widget.indicatorSide == IndicatorSide.end)
                              ? 0
                              : null;
                        }

                        return Stack(
                          children: <Widget>[
                            if (widget.indicatorWidth > 0)
                              Positioned(
                                top: 2,
                                bottom: 2,
                                width: widget.indicatorWidth,
                                left: left,
                                right: right,
                                child: ScaleTransition(
                                  child: Container(
                                    color: widget.indicatorColor ??
                                        themeColor.defaultAccentColor,
                                  ),
                                  scale: Tween(begin: 0.0, end: 1.0).animate(
                                    new CurvedAnimation(
                                      parent: animationControllers[index],
                                      curve: Curves.elasticOut,
                                    ),
                                  ),
                                ),
                              ),
                            GestureDetector(
                              onTap: () {
                                _changePageByTapView = true;
                                setState(() {
                                  _selectTab(index);
                                });

                                pageController.animateToPage(index,
                                    duration: widget.changePageDuration,
                                    curve: widget.changePageCurve);
                              },
                              child: Container(
                                color: itemBGColor,
                                alignment:
                                    (widget.direction == TextDirection.rtl)
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.0, vertical: 5.0),
                                child: child,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                      scrollDirection: widget.contentScrollAxis,
                      physics: pageScrollPhysics,
                      onPageChanged: (index) {
                        if (_changePageByTapView == false ||
                            _changePageByTapView == null) {
                          _selectTab(index);
                        }
                        if (_selectedIndex == index) {
                          _changePageByTapView = null;
                        }
                        setState(() {});
                      },
                      controller: pageController,

                      // the number of pages
                      itemCount: widget.contents.length,

                      // building pages
                      itemBuilder: (BuildContext context, int index) {
                        return widget.contents[index];
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectTab(index) {
    _selectedIndex = index;
    for (AnimationController animationController in animationControllers) {
      animationController.reset();
    }
    animationControllers[index].forward();

    if (widget.onSelect != null) {
      widget.onSelect(_selectedIndex);
    }
  }
}
