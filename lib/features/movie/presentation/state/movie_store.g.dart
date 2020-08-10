// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MovieStore on _MovieStore, Store {
  Computed<MovieStoreState> _$tabStateComputed;

  @override
  MovieStoreState get tabState =>
      (_$tabStateComputed ??= Computed<MovieStoreState>(() => super.tabState,
              name: '_MovieStore.tabState'))
          .value;
  Computed<MovieStoreState> _$egRouteStateComputed;

  @override
  MovieStoreState get egRouteState => (_$egRouteStateComputed ??=
          Computed<MovieStoreState>(() => super.egRouteState,
              name: '_MovieStore.egRouteState'))
      .value;

  final _$errorMessageAtom = Atom(name: '_MovieStore.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$_tabInitFutureAtom = Atom(name: '_MovieStore._tabInitFuture');

  @override
  ObservableFuture<dynamic> get _tabInitFuture {
    _$_tabInitFutureAtom.reportRead();
    return super._tabInitFuture;
  }

  @override
  set _tabInitFuture(ObservableFuture<dynamic> value) {
    _$_tabInitFutureAtom.reportWrite(value, super._tabInitFuture, () {
      super._tabInitFuture = value;
    });
  }

  final _$_routeInitFutureAtom = Atom(name: '_MovieStore._routeInitFuture');

  @override
  ObservableFuture<dynamic> get _routeInitFuture {
    _$_routeInitFutureAtom.reportRead();
    return super._routeInitFuture;
  }

  @override
  set _routeInitFuture(ObservableFuture<dynamic> value) {
    _$_routeInitFutureAtom.reportWrite(value, super._routeInitFuture, () {
      super._routeInitFuture = value;
    });
  }

  final _$waitForTabInitializeDataAtom =
      Atom(name: '_MovieStore.waitForTabInitializeData');

  @override
  bool get waitForTabInitializeData {
    _$waitForTabInitializeDataAtom.reportRead();
    return super.waitForTabInitializeData;
  }

  @override
  set waitForTabInitializeData(bool value) {
    _$waitForTabInitializeDataAtom
        .reportWrite(value, super.waitForTabInitializeData, () {
      super.waitForTabInitializeData = value;
    });
  }

  final _$waitForRouteInitializeDataAtom =
      Atom(name: '_MovieStore.waitForRouteInitializeData');

  @override
  bool get waitForRouteInitializeData {
    _$waitForRouteInitializeDataAtom.reportRead();
    return super.waitForRouteInitializeData;
  }

  @override
  set waitForRouteInitializeData(bool value) {
    _$waitForRouteInitializeDataAtom
        .reportWrite(value, super.waitForRouteInitializeData, () {
      super.waitForRouteInitializeData = value;
    });
  }

  final _$waitForMovieDataAtom = Atom(name: '_MovieStore.waitForMovieData');

  @override
  bool get waitForMovieData {
    _$waitForMovieDataAtom.reportRead();
    return super.waitForMovieData;
  }

  @override
  set waitForMovieData(bool value) {
    _$waitForMovieDataAtom.reportWrite(value, super.waitForMovieData, () {
      super.waitForMovieData = value;
    });
  }

  final _$changeCategoryAtom = Atom(name: '_MovieStore.changeCategory');

  @override
  bool get changeCategory {
    _$changeCategoryAtom.reportRead();
    return super.changeCategory;
  }

  @override
  set changeCategory(bool value) {
    _$changeCategoryAtom.reportWrite(value, super.changeCategory, () {
      super.changeCategory = value;
    });
  }

  final _$waitForMoviePostAtom = Atom(name: '_MovieStore.waitForMoviePost');

  @override
  bool get waitForMoviePost {
    _$waitForMoviePostAtom.reportRead();
    return super.waitForMoviePost;
  }

  @override
  set waitForMoviePost(bool value) {
    _$waitForMoviePostAtom.reportWrite(value, super.waitForMoviePost, () {
      super.waitForMoviePost = value;
    });
  }

  final _$waitForHotMoviesAtom = Atom(name: '_MovieStore.waitForHotMovies');

  @override
  bool get waitForHotMovies {
    _$waitForHotMoviesAtom.reportRead();
    return super.waitForHotMovies;
  }

  @override
  set waitForHotMovies(bool value) {
    _$waitForHotMoviesAtom.reportWrite(value, super.waitForHotMovies, () {
      super.waitForHotMovies = value;
    });
  }

  final _$getTabInitializeDataAsyncAction =
      AsyncAction('_MovieStore.getTabInitializeData');

  @override
  Future<void> getTabInitializeData() {
    return _$getTabInitializeDataAsyncAction
        .run(() => super.getTabInitializeData());
  }

  final _$getEgMoviesAsyncAction = AsyncAction('_MovieStore.getEgMovies');

  @override
  Future<int> getEgMovies({dynamic tid}) {
    return _$getEgMoviesAsyncAction.run(() => super.getEgMovies(tid: tid));
  }

  final _$getRouteInitializeDataAsyncAction =
      AsyncAction('_MovieStore.getRouteInitializeData');

  @override
  Future<void> getRouteInitializeData(MovieRouteForm form) {
    return _$getRouteInitializeDataAsyncAction
        .run(() => super.getRouteInitializeData(form));
  }

  final _$getEgMoviePostAsyncAction = AsyncAction('_MovieStore.getEgMoviePost');

  @override
  Future<void> getEgMoviePost(MovieRouteForm form) {
    return _$getEgMoviePostAsyncAction.run(() => super.getEgMoviePost(form));
  }

  final _$getEgHotMoviesAsyncAction = AsyncAction('_MovieStore.getEgHotMovies');

  @override
  Future<void> getEgHotMovies({dynamic tid}) {
    return _$getEgHotMoviesAsyncAction
        .run(() => super.getEgHotMovies(tid: tid));
  }

  final _$setFavoriteMovieAsyncAction =
      AsyncAction('_MovieStore.setFavoriteMovie');

  @override
  Future<bool> setFavoriteMovie(int mid, bool isFavorite) {
    return _$setFavoriteMovieAsyncAction
        .run(() => super.setFavoriteMovie(mid, isFavorite));
  }

  final _$setMovieRateAsyncAction = AsyncAction('_MovieStore.setMovieRate');

  @override
  Future<bool> setMovieRate(int mid, MovieRate rate) {
    return _$setMovieRateAsyncAction.run(() => super.setMovieRate(mid, rate));
  }

  final _$watchFreeMovieAsyncAction = AsyncAction('_MovieStore.watchFreeMovie');

  @override
  Future<bool> watchFreeMovie(int mid) {
    return _$watchFreeMovieAsyncAction.run(() => super.watchFreeMovie(mid));
  }

  final _$buyMovieAsyncAction = AsyncAction('_MovieStore.buyMovie');

  @override
  Future<bool> buyMovie(int mid) {
    return _$buyMovieAsyncAction.run(() => super.buyMovie(mid));
  }

  final _$requestVerifyPhoneAsyncAction =
      AsyncAction('_MovieStore.requestVerifyPhone');

  @override
  Future<String> requestVerifyPhone(String mobile) {
    return _$requestVerifyPhoneAsyncAction
        .run(() => super.requestVerifyPhone(mobile));
  }

  final _$postPhoneVerifyCodeAsyncAction =
      AsyncAction('_MovieStore.postPhoneVerifyCode');

  @override
  Future<bool> postPhoneVerifyCode(String mobile, String code) {
    return _$postPhoneVerifyCodeAsyncAction
        .run(() => super.postPhoneVerifyCode(mobile, code));
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
waitForTabInitializeData: ${waitForTabInitializeData},
waitForRouteInitializeData: ${waitForRouteInitializeData},
waitForMovieData: ${waitForMovieData},
changeCategory: ${changeCategory},
waitForMoviePost: ${waitForMoviePost},
waitForHotMovies: ${waitForHotMovies},
tabState: ${tabState},
egRouteState: ${egRouteState}
    ''';
  }
}
