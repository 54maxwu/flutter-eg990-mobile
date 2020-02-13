import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ty_mobile/features/home/presentation/bloc/bloc_route.dart';
import 'package:flutter_ty_mobile/features/home/presentation/widgets/member_widget.dart';
import 'package:flutter_ty_mobile/features/home/presentation/widgets/widgets.dart';
import 'package:flutter_ty_mobile/features/users/presentation/user_data.dart';

import '../../widget_res_export.dart'
    show FontSize, Global, RouterNavigate, Themes, localeStr, sl;

///@author H.C.CHIANG
///@version 2020/2/12
class HomeRoute extends StatefulWidget {
  HomeRoute({Key key}) : super(key: key);

  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  final ScrollController _scrollViewController = ScrollController();
  final GlobalKey<MemberWidgetState> _memberWidgetKey =
      new GlobalKey<MemberWidgetState>();
  MemberWidget _memberWidget;

  @override
  void initState() {
    print('home init');
    super.initState();
  }

  @override
  void didUpdateWidget(HomeRoute oldWidget) {
    print('home update');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    print('home changed');
    super.didChangeDependencies();
  }

  void testUpdate() {
    print('test update');
  }

  @override
  Widget build(BuildContext context) {
    print('home user data: ${sl.get<UserData>().toString()}');
    return Scaffold(
      backgroundColor: Themes.defaultBackgroundColor,
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (context, boxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Row(
                children: <Widget>[
                  _buildBannerBody(context),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: <Widget>[
                  _buildMarqueeDecorLeft(),
                  _buildMarqueeBody(context),
                  _buildMarqueeDecorRight(),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: StreamBuilder<bool>(
                stream: RouterNavigate.routerStreams.userStream,
                initialData: false,
                builder: (context, snapshot) {
                  print('checking member widget...');
                  if (_memberWidget == null) {
                    _memberWidget = MemberWidget(key: _memberWidgetKey);
                  } else if (snapshot.data) {
                    _memberWidgetKey.currentState.updateUser();
                    RouterNavigate.resetCheckUser();
                  }
                  return _memberWidget;
                },
              ),
            ),
          ];
        },
        body: Row(
          children: <Widget>[
            _buildGameContainer(context),
          ],
        ),
      ),
    );
  }

  BlocProvider<HomeBannerBloc> _buildBannerBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeBannerBloc>(),
      child: Expanded(
        child: Container(
          child: AspectRatio(
            aspectRatio: 16 / 6.15,
            child: ClipRect(
              child: BlocBuilder<HomeBannerBloc, HomeBannerState>(
                builder: (context, state) {
                  return state.when(
                    bInitial: (_) => BannerControl(),
                    bLoading: (_) => LoadingWidget(),
                    bCaching: (_) {
                      print('banner state props: ${state.props.first}');
                      return BannerCached(banners: state.props.first);
                    },
                    bLoaded: (_) => BannerDisplay(images: state.props.first),
                    bError: (_) => Icon(Icons.broken_image,
                        color: Themes.defaultTextColor),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildMarqueeDecorLeft() {
    return Expanded(
      child: new Padding(
        padding: EdgeInsets.only(left: 3.0),
        child: Icon(IconData(0xf027, fontFamily: 'FontAwesome'),
            color: Themes.accentLightColor),
      ),
    );
  }

  Expanded _buildMarqueeDecorRight() {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
        child: ButtonTheme(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(8.0),
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: RaisedButton(
            color: Themes.defaultAccentColor,
            child: new Text(
              localeStr.pageTitleMarquee,
              style: TextStyle(
                  fontSize: FontSize.NORMAL.value - 2,
                  color: Themes.defaultTextColorBlack),
            ),
            visualDensity: VisualDensity(horizontal: -4.0, vertical: -3.0),
            onPressed: () => {},
          ),
        ),
      ),
    );
  }

  BlocProvider<HomeMarqueeBloc> _buildMarqueeBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeMarqueeBloc>(),
      child: Expanded(
        flex: 12,
        child: BlocBuilder<HomeMarqueeBloc, HomeMarqueeState>(
          builder: (context, state) {
            return state.when(
              mInitial: (_) => MarqueeControl(),
              mLoading: (_) => Container(),
              mLoaded: (_) => MarqueeDisplay(marquees: state.props.first),
              mError: (_) => MessageDisplay(
                message: state.props.first,
              ),
            );
          },
        ),
      ),
    );
  }

  BlocProvider<HomeGameTabsBloc> _buildGameContainer(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeGameTabsBloc>(),
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          width: Global.device.width,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6.0, 8.0, 2.0, 4.0),
          child: BlocBuilder<HomeGameTabsBloc, HomeGameTabsState>(
            builder: (context, state) {
              return state.when(
                tInitial: (_) => GameControl(),
                tLoading: (_) => LoadingWidget(),
                tLoaded: (_) => GameDisplayTab(tabsData: state.props.first),
                tError: (_) => MessageDisplay(
                  message: state.props.first,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
