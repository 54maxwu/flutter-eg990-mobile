import 'dart:async' show StreamSubscription;

import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/router/app_global_streams.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/mission/data/entity/mission_claim_form.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/mission/data/models/mission_list_model.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/mission/data/models/mission_model.dart';

import '../data/mission_type.dart';
import '../state/mission_store.dart';
import 'mission_item_widget.dart';

/// Contains a List builder to show [MissionItemWidget]
/// [missionType] = mission tab that the view belongs
/// [list] = mission data that are under [listName]
class MissionListView extends StatefulWidget {
  final MissionStore store;
  final MissionTypeEnum missionType;

  MissionListView({@required this.store, @required this.missionType});

  @override
  _MissionListViewState createState() => _MissionListViewState();
}

class _MissionListViewState extends State<MissionListView>
    with AutomaticKeepAliveClientMixin {
  StreamSubscription _langSubscript;
  String _lang;

  List<ReactionDisposer> _disposers;
  StreamSubscription<MapEntry<int, MissionStatus>> _updateSubscript;
  List<MissionModel> _missions;

  Map<int, GlobalKey<MissionItemWidgetState>> _itemKeyMap;

  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.initData,
        // Run some logic with the content of the observed field
        (model) {
          if (mounted) {
            Future.delayed(Duration(milliseconds: 200), () {
              final list = widget.store.initData[widget.missionType.value.id];
              if (_missions != list) {
                setState(() {
                  _itemKeyMap = new Map();
                  _missions = list;
                });
              }
            });
          }
        },
      ),
    ];
  }

  @override
  void initState() {
    _itemKeyMap ??= new Map();
    _lang = Global.lang.code;
    if (widget.store.initData != null) {
      _missions = widget.store.initData[widget.missionType.value.id];
    }
    super.initState();
    _langSubscript ??= getAppGlobalStreams.languageStream.listen((event) {
      if (event != _lang) {
        _lang = event;
        setState(() {});
      }
    });
    _updateSubscript ??= widget.store.updateStream.listen((event) {
      if (_missions.any((element) => element.id == event.key)) {
        debugPrint('prize update stream: $event');
        int index = _missions.indexWhere(
          (element) => element.id == event.key,
        );
        if (index >= 0) {
          MissionModel model = _missions[index];
          switch (event.value) {
            case MissionStatus.RECEIVED:
              model = model.copyWith(complete: '3');
              _missions.replaceRange(index, index + 1, [model]);
              break;
            default:
              break;
          }
          _itemKeyMap[model.id]?.currentState?.updateStatus = event.value;
        }
      }
    });
  }

  @override
  void dispose() {
    try {
      _disposers.forEach((d) => d());
      _langSubscript?.cancel();
      _langSubscript = null;
      _updateSubscript?.cancel();
      _updateSubscript = null;
    } catch (e) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_missions == null || _missions.isEmpty) return SizedBox.shrink();
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      itemCount: _missions.length,
      itemBuilder: (_, index) {
        int id = _missions[index].id;
        final GlobalKey<MissionItemWidgetState> key =
            new GlobalKey(debugLabel: 'mid$id');
        _itemKeyMap[id] = key;
        return MissionItemWidget(
          key: key,
          mission: _missions[index],
          onPrizeTap: (m) {
            final MissionClaimForm form = MissionClaimForm(
              missionType: widget.missionType,
              prizeId: m.id,
            );
            widget.store.claimPrize(form);
          },
        );
      },
    );
  }
}
