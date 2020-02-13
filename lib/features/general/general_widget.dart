import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';

import '../router/router.gr.dart';
import '../widget_res_export.dart';
import 'appbar/appbar_drawer_widget.dart';
import 'appbar/appbar_widget.dart';

class GeneralWidget extends StatefulWidget {
  GeneralWidget({Key key}) : super(key: key);

  @override
  _GeneralWidgetState createState() => _GeneralWidgetState();
}

class _GeneralWidgetState extends State<GeneralWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final routerStreams = getRouterStreams;
  List<BottomNavigationBarItem> _barItems;
  Widget _appBar;
  Widget _drawer;
  int _currentIndex = 0;

  final List<String> _tabTitle = [
    RouterPage.HomeRoute.info.title,
    '充值',
    '優惠',
    '客服',
    '我的',
    '更多'
  ];

  final List<RouterPage> _tabRoute = [
    RouterPage.HomeRoute,
  ];

  void onTabTapped(int index) {
    RouterNavigate.navigateToPage(_tabRoute[index]);
  }

  @override
  void initState() {
    _appBar = AppBarWidget(routerStreams: routerStreams, barKey: _scaffoldKey);
    _drawer = AppBarDrawerWidget(barKey: _scaffoldKey);
    _barItems = createBarItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    return WillPopScope(
        child: Scaffold(
          key: _scaffoldKey,

          /* Toolbar (title will change with placeholder) */
          appBar: PreferredSize(
            preferredSize: const Size(double.infinity, Global.APP_BAR_HEIGHT),
            child: _appBar,
          ),
          drawer: _drawer,

          /* Bottom Navigation */
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 2.0, color: Themes.defaultAccentColor),
              ),
            ),
            child: BottomNavigationBar(
              onTap: onTabTapped,
              currentIndex:
                  _currentIndex, // this will change when a tab is tapped
              type: BottomNavigationBarType.fixed,
              selectedFontSize: FontSize.NORMAL.value - 2,
              unselectedFontSize: FontSize.NORMAL.value - 2,
              unselectedItemColor: Themes.defaultTextColor,
              fixedColor: Themes.defaultAccentColor,
              backgroundColor: Themes.defaultAppbarColor,
              items: _barItems,
            ),
          ),

          /* Main Content (switch placeholder with Router) */
          body: Navigator(
            key: Router.navigatorKey,
            onGenerateRoute: Router.onGenerateRoute,
          ),
        ),

        /// listen to Back Button and prevent from being popped
        onWillPop: () async {
          RouterNavigate.navigateClean();
          return false;
        });
  }

  List<BottomNavigationBarItem> createBarItem() {
    final List<Icon> _tabIcon = [
      Icon(IconData(0xf015, fontFamily: 'FontAwesome')),
      Icon(IconData(0xf1c0, fontFamily: 'FontAwesome')),
      Icon(IconData(0xf06b, fontFamily: 'FontAwesome')),
      Icon(IconData(0xf27a, fontFamily: 'FontAwesome')),
      Icon(IconData(0xf2bd, fontFamily: 'FontAwesome')),
      Icon(Icons.more_horiz)
    ];

    return List.generate(
      _tabTitle.length,
      (index) => BottomNavigationBarItem(
        icon: _tabIcon[index],
        title: Padding(
          padding: EdgeInsets.only(top: 2.0),
          child: Text(_tabTitle[index]),
        ),
      ),
    );
  }
}
