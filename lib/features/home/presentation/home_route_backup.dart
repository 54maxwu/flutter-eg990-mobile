import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ty_mobile/features/home/presentation/bloc/bloc_route.dart';
import 'package:flutter_ty_mobile/features/home/presentation/widgets/widgets.dart';
import 'package:flutter_ty_mobile/features/users/presentation/user_data.dart';

import '../../widget_res_export.dart' show FontSize, Themes, localeStr, sl;

///
/// @author H.C.CHIANG
/// @version 2019/12/27
class HomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('home user data: ${sl.get<UserData>().toString()}');
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Themes.defaultBackgroundColor,
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                _buildBannerBody(context),
              ],
            ),
            Row(
              children: <Widget>[
                _buildMarqueeDecorLeft(),
                _buildMarqueeBody(context),
                _buildMarqueeDecorRight(),
              ],
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  _buildGameContainer(context),
                ],
              ),
            ),
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
      child: Row(
        children: <Widget>[
          Expanded(
            child: new Container(
              padding: EdgeInsets.only(left: 3.0),
              child: Icon(IconData(0xf027, fontFamily: 'FontAwesome'),
                  color: Themes.accentLightColor),
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildMarqueeDecorRight() {
    return Expanded(
      flex: 3,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
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
                  visualDensity:
                      VisualDensity(horizontal: -4.0, vertical: -3.0),
                  onPressed: () => {},
                ),
              ),
            ),
          ),
        ],
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
              mLoading: (_) => LoadingWidget(),
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
      child: Expanded(
        child: new Container(
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
