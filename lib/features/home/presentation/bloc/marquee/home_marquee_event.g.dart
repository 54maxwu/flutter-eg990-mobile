// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_marquee_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class HomeMarqueeEvent extends Equatable {
  const HomeMarqueeEvent(this._type);

  factory HomeMarqueeEvent.getMarqueeEvent() = GetMarqueeEvent;

  final _HomeMarqueeEvent _type;

//ignore: missing_return
  FutureOr<R> when<R>(
      {@required FutureOr<R> Function(GetMarqueeEvent) getMarqueeEvent}) {
    assert(() {
      if (getMarqueeEvent == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _HomeMarqueeEvent.GetMarqueeEvent:
        return getMarqueeEvent(this as GetMarqueeEvent);
    }
  }

  FutureOr<R> whenOrElse<R>(
      {FutureOr<R> Function(GetMarqueeEvent) getMarqueeEvent,
      @required FutureOr<R> Function(HomeMarqueeEvent) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _HomeMarqueeEvent.GetMarqueeEvent:
        if (getMarqueeEvent == null) break;
        return getMarqueeEvent(this as GetMarqueeEvent);
    }
    return orElse(this);
  }

  FutureOr<void> whenPartial(
      {FutureOr<void> Function(GetMarqueeEvent) getMarqueeEvent}) {
    assert(() {
      if (getMarqueeEvent == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _HomeMarqueeEvent.GetMarqueeEvent:
        if (getMarqueeEvent == null) break;
        return getMarqueeEvent(this as GetMarqueeEvent);
    }
  }

  @override
  List get props => const [];
}

@immutable
class GetMarqueeEvent extends HomeMarqueeEvent {
  const GetMarqueeEvent._() : super(_HomeMarqueeEvent.GetMarqueeEvent);

  factory GetMarqueeEvent() {
    _instance ??= GetMarqueeEvent._();
    return _instance;
  }

  static GetMarqueeEvent _instance;
}
