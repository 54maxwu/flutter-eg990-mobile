import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/network/handler/request_code_model.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/res.dart';

import 'state/mission_store.dart';
import 'widgets/mission_display.dart';

class MissionRoute extends StatefulWidget {
  @override
  _MissionRouteState createState() => _MissionRouteState();
}

class _MissionRouteState extends State<MissionRoute> {
  MissionStore _store;
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    _store ??= sl.get<MissionStore>();
    super.initState();
    // execute action on init
    _store.initialize();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction(
        // Observe store's observable in page
        (_) => _store.errorMessage,
        // Do something when the value has changed
        (String message) {
          if (message != null && message.isNotEmpty) {
            callToastError(message, delayedMilli: 200);
          }
        },
      ),
      /* Reaction on prize result changed */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.prizeResult,
        // Run some logic with the content of the observed field
        (RequestCodeModel result) {
          debugPrint('claim prize result: $result');
          if (result == null) return;
          if (result.isSuccess) {
            callToastInfo(
                MessageMap.getSuccessMessage(result.msg, RouteEnum.MISSION),
                icon: Icons.check_circle_outline);
          } else {
            callToastError(
                MessageMap.getErrorMessage(result.msg, RouteEnum.MISSION));
          }
        },
      ),
    ];
  }

  @override
  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        debugPrint('pop mission route');
        Future.delayed(Duration(milliseconds: 100), () => AppNavigator.back());
        return Future(() => true);
      },
      child: Scaffold(
        body: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Res.mission_bg),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Image.asset(Res.mission_title),
                    ),
                    Image.asset(Res.mission_title_light),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 72, 16, 24),
                child: Observer(
                  // Observe using specific widget
                  builder: (_) {
                    switch (_store.state) {
                      case MissionStoreState.loading:
                        return LoadingWidget();
                      case MissionStoreState.loaded:
                        return MissionDisplay(store: _store);
                      default:
                        return SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
