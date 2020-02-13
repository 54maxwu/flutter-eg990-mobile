// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_game_tabs_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class HomeGameTabsEvent extends Equatable {
  const HomeGameTabsEvent(this._type);

  factory HomeGameTabsEvent.getGameTypesEvent() = GetGameTypesEvent;

  final _HomeGameTabsEvent _type;

//ignore: missing_return
  FutureOr<R> when<R>(
      {@required FutureOr<R> Function(GetGameTypesEvent) getGameTypesEvent}) {
    assert(() {
      if (getGameTypesEvent == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _HomeGameTabsEvent.GetGameTypesEvent:
        return getGameTypesEvent(this as GetGameTypesEvent);
    }
  }

  FutureOr<R> whenOrElse<R>(
      {FutureOr<R> Function(GetGameTypesEvent) getGameTypesEvent,
      @required FutureOr<R> Function(HomeGameTabsEvent) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _HomeGameTabsEvent.GetGameTypesEvent:
        if (getGameTypesEvent == null) break;
        return getGameTypesEvent(this as GetGameTypesEvent);
    }
    return orElse(this);
  }

  FutureOr<void> whenPartial(
      {FutureOr<void> Function(GetGameTypesEvent) getGameTypesEvent}) {
    assert(() {
      if (getGameTypesEvent == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _HomeGameTabsEvent.GetGameTypesEvent:
        if (getGameTypesEvent == null) break;
        return getGameTypesEvent(this as GetGameTypesEvent);
    }
  }

  @override
  List get props => const [];
}

@immutable
class GetGameTypesEvent extends HomeGameTabsEvent {
  const GetGameTypesEvent._() : super(_HomeGameTabsEvent.GetGameTypesEvent);

  factory GetGameTypesEvent() {
    _instance ??= GetGameTypesEvent._();
    return _instance;
  }

  static GetGameTypesEvent _instance;
}
