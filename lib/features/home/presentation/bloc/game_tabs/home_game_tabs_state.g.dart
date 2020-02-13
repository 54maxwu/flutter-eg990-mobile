// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_game_tabs_state.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class HomeGameTabsState<T> extends Equatable {
  const HomeGameTabsState(this._type);

  factory HomeGameTabsState.tInitial() = TInitial<T>;

  factory HomeGameTabsState.tLoading() = TLoading<T>;

  factory HomeGameTabsState.tLoaded({@required GameTypesEntity types}) =
      TLoaded<T>;

  factory HomeGameTabsState.tError({@required String message}) = TError<T>;

  final _HomeGameTabsState _type;

//ignore: missing_return
  FutureOr<R> when<R>(
      {@required FutureOr<R> Function(TInitial<T>) tInitial,
      @required FutureOr<R> Function(TLoading<T>) tLoading,
      @required FutureOr<R> Function(TLoaded<T>) tLoaded,
      @required FutureOr<R> Function(TError<T>) tError}) {
    assert(() {
      if (tInitial == null ||
          tLoading == null ||
          tLoaded == null ||
          tError == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _HomeGameTabsState.TInitial:
        return tInitial(this as TInitial);
      case _HomeGameTabsState.TLoading:
        return tLoading(this as TLoading);
      case _HomeGameTabsState.TLoaded:
        return tLoaded(this as TLoaded);
      case _HomeGameTabsState.TError:
        return tError(this as TError);
    }
  }

  FutureOr<R> whenOrElse<R>(
      {FutureOr<R> Function(TInitial<T>) tInitial,
      FutureOr<R> Function(TLoading<T>) tLoading,
      FutureOr<R> Function(TLoaded<T>) tLoaded,
      FutureOr<R> Function(TError<T>) tError,
      @required FutureOr<R> Function(HomeGameTabsState<T>) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _HomeGameTabsState.TInitial:
        if (tInitial == null) break;
        return tInitial(this as TInitial);
      case _HomeGameTabsState.TLoading:
        if (tLoading == null) break;
        return tLoading(this as TLoading);
      case _HomeGameTabsState.TLoaded:
        if (tLoaded == null) break;
        return tLoaded(this as TLoaded);
      case _HomeGameTabsState.TError:
        if (tError == null) break;
        return tError(this as TError);
    }
    return orElse(this);
  }

  FutureOr<void> whenPartial(
      {FutureOr<void> Function(TInitial<T>) tInitial,
      FutureOr<void> Function(TLoading<T>) tLoading,
      FutureOr<void> Function(TLoaded<T>) tLoaded,
      FutureOr<void> Function(TError<T>) tError}) {
    assert(() {
      if (tInitial == null &&
          tLoading == null &&
          tLoaded == null &&
          tError == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _HomeGameTabsState.TInitial:
        if (tInitial == null) break;
        return tInitial(this as TInitial);
      case _HomeGameTabsState.TLoading:
        if (tLoading == null) break;
        return tLoading(this as TLoading);
      case _HomeGameTabsState.TLoaded:
        if (tLoaded == null) break;
        return tLoaded(this as TLoaded);
      case _HomeGameTabsState.TError:
        if (tError == null) break;
        return tError(this as TError);
    }
  }

  @override
  List get props => const [];
}

@immutable
class TInitial<T> extends HomeGameTabsState<T> {
  const TInitial._() : super(_HomeGameTabsState.TInitial);

  factory TInitial() {
    _instance ??= TInitial._();
    return _instance;
  }

  static TInitial _instance;
}

@immutable
class TLoading<T> extends HomeGameTabsState<T> {
  const TLoading._() : super(_HomeGameTabsState.TLoading);

  factory TLoading() {
    _instance ??= TLoading._();
    return _instance;
  }

  static TLoading _instance;
}

@immutable
class TLoaded<T> extends HomeGameTabsState<T> {
  const TLoaded({@required this.types}) : super(_HomeGameTabsState.TLoaded);

  final GameTypesEntity types;

  @override
  String toString() => 'TLoaded(types:${this.types})';
  @override
  List get props => [types];
}

@immutable
class TError<T> extends HomeGameTabsState<T> {
  const TError({@required this.message}) : super(_HomeGameTabsState.TError);

  final String message;

  @override
  String toString() => 'TError(message:${this.message})';
  @override
  List get props => [message];
}
