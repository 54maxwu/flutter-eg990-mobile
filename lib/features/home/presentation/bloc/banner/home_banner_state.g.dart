// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_banner_state.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class HomeBannerState extends Equatable {
  const HomeBannerState(this._type);

  factory HomeBannerState.bInitial() = BInitial;

  factory HomeBannerState.bLoading() = BLoading;

  factory HomeBannerState.bCaching({@required List banners}) = BCaching;

  factory HomeBannerState.bLoaded({@required List images}) = BLoaded;

  factory HomeBannerState.bError({@required String message}) = BError;

  final _HomeBannerState _type;

//ignore: missing_return
  FutureOr<R> when<R>(
      {@required FutureOr<R> Function(BInitial) bInitial,
      @required FutureOr<R> Function(BLoading) bLoading,
      @required FutureOr<R> Function(BCaching) bCaching,
      @required FutureOr<R> Function(BLoaded) bLoaded,
      @required FutureOr<R> Function(BError) bError}) {
    assert(() {
      if (bInitial == null ||
          bLoading == null ||
          bCaching == null ||
          bLoaded == null ||
          bError == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _HomeBannerState.BInitial:
        return bInitial(this as BInitial);
      case _HomeBannerState.BLoading:
        return bLoading(this as BLoading);
      case _HomeBannerState.BCaching:
        return bCaching(this as BCaching);
      case _HomeBannerState.BLoaded:
        return bLoaded(this as BLoaded);
      case _HomeBannerState.BError:
        return bError(this as BError);
    }
  }

  FutureOr<R> whenOrElse<R>(
      {FutureOr<R> Function(BInitial) bInitial,
      FutureOr<R> Function(BLoading) bLoading,
      FutureOr<R> Function(BCaching) bCaching,
      FutureOr<R> Function(BLoaded) bLoaded,
      FutureOr<R> Function(BError) bError,
      @required FutureOr<R> Function(HomeBannerState) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _HomeBannerState.BInitial:
        if (bInitial == null) break;
        return bInitial(this as BInitial);
      case _HomeBannerState.BLoading:
        if (bLoading == null) break;
        return bLoading(this as BLoading);
      case _HomeBannerState.BCaching:
        if (bCaching == null) break;
        return bCaching(this as BCaching);
      case _HomeBannerState.BLoaded:
        if (bLoaded == null) break;
        return bLoaded(this as BLoaded);
      case _HomeBannerState.BError:
        if (bError == null) break;
        return bError(this as BError);
    }
    return orElse(this);
  }

  FutureOr<void> whenPartial(
      {FutureOr<void> Function(BInitial) bInitial,
      FutureOr<void> Function(BLoading) bLoading,
      FutureOr<void> Function(BCaching) bCaching,
      FutureOr<void> Function(BLoaded) bLoaded,
      FutureOr<void> Function(BError) bError}) {
    assert(() {
      if (bInitial == null &&
          bLoading == null &&
          bCaching == null &&
          bLoaded == null &&
          bError == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _HomeBannerState.BInitial:
        if (bInitial == null) break;
        return bInitial(this as BInitial);
      case _HomeBannerState.BLoading:
        if (bLoading == null) break;
        return bLoading(this as BLoading);
      case _HomeBannerState.BCaching:
        if (bCaching == null) break;
        return bCaching(this as BCaching);
      case _HomeBannerState.BLoaded:
        if (bLoaded == null) break;
        return bLoaded(this as BLoaded);
      case _HomeBannerState.BError:
        if (bError == null) break;
        return bError(this as BError);
    }
  }

  @override
  List get props => const [];
}

@immutable
class BInitial extends HomeBannerState {
  const BInitial._() : super(_HomeBannerState.BInitial);

  factory BInitial() {
    _instance ??= BInitial._();
    return _instance;
  }

  static BInitial _instance;
}

@immutable
class BLoading extends HomeBannerState {
  const BLoading._() : super(_HomeBannerState.BLoading);

  factory BLoading() {
    _instance ??= BLoading._();
    return _instance;
  }

  static BLoading _instance;
}

@immutable
class BCaching extends HomeBannerState {
  const BCaching({@required this.banners}) : super(_HomeBannerState.BCaching);

  final List banners;

  @override
  String toString() => 'BCaching(banners:${this.banners})';
  @override
  List get props => [banners];
}

@immutable
class BLoaded extends HomeBannerState {
  const BLoaded({@required this.images}) : super(_HomeBannerState.BLoaded);

  final List images;

  @override
  String toString() => 'BLoaded(images:${this.images})';
  @override
  List get props => [images];
}

@immutable
class BError extends HomeBannerState {
  const BError({@required this.message}) : super(_HomeBannerState.BError);

  final String message;

  @override
  String toString() => 'BError(message:${this.message})';
  @override
  List get props => [message];
}
