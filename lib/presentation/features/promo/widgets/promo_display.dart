import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/domain/sector/promo/promo_entity.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';
import 'package:flutter_eg990_mobile/presentation/features/promo/data/promo_category.dart';
import 'package:flutter_eg990_mobile/presentation/features/promo/widgets/promo_list.dart';
import 'package:flutter_eg990_mobile/res.dart';

class PromoDisplay extends StatefulWidget {
  final List<PromoEntity> promos;

  PromoDisplay({Key key, @required this.promos}) : super(key: key);

  @override
  _PromoDisplayState createState() => _PromoDisplayState();
}

class _PromoDisplayState extends State<PromoDisplay>
    with SingleTickerProviderStateMixin {
  final GlobalKey _barKey = GlobalKey(debugLabel: 'promotabs');
  final GlobalKey _viewKey = GlobalKey(debugLabel: 'promoview');

  List<PromoCategoryEnum> _categories;
  TabController _tabController;

  @override
  void initState() {
    _categories = PromoCategoryEnum.filteredList(
        widget.promos.map((e) => e.categoryStr).toList());
    debugPrint('Promo categories: ${_categories.map((e) => e.value).toList()}');
    super.initState();
    // Create TabController for getting the index of current tab
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    try {
      if (_tabController != null) _tabController.dispose();
    } catch (e) {
      MyLogger.debug(
        msg: 'dispose promo tab controller has exception: $e',
        tag: "PromoDisplay",
      );
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor.defaultLayeredBackgroundColor,
      appBar: AppBar(
        leadingWidth: 0.0,
        elevation: 0.0,
        title: TabBar(
          key: _barKey,
          controller: _tabController,
          unselectedLabelColor: themeColor.defaultHintColor,
          labelColor: themeColor.defaultTextColor,
          labelStyle: TextStyle(fontSize: FontSize.SUBTITLE.value),
          indicatorColor: themeColor.defaultAccentColor,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: List.generate(_categories.length,
              (index) => Tab(text: _categories[index].label)),
        ),
      ),
      body: TabBarView(
        key: _viewKey,
        controller: _tabController,
        children: (_categories.length == 1 && widget.promos.isEmpty)
            ? [
                Container(
                    alignment: Alignment.center,
                    child: Image.asset(Res.img_no_data))
              ]
            : List.generate(
                _categories.length,
                (index) => PromoList(
                  promos: (index == 0)
                      ? widget.promos
                      : _getPromoByCategory(_categories[index].value.category),
                ),
              ),
      ),
    );
  }

  List<PromoEntity> _getPromoByCategory(String category) {
    // debugPrint('all promos ids: ${widget.promos.map((e) => e.id)}');
    // debugPrint('looking for: $category');
    final list =
        widget.promos.where((promo) => promo.categoryStr == category).toList();
    debugPrint('$category promo ids: ${list.map((e) => e.id)}');
    return list;
  }
}
