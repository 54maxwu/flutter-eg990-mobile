// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_route_form.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

abstract class _$MovieRouteForm {
  const _$MovieRouteForm();

  dynamic get tid;
  int get mid;
  dynamic get highlight;
  bool operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! MovieRouteForm) return false;

    return true &&
        this.tid == other.tid &&
        this.mid == other.mid &&
        this.highlight == other.highlight;
  }

  int get hashCode {
    return mapPropsToHashCode([tid, mid, highlight]);
  }

  String toString() {
    return 'MovieRouteForm <\'tid\': ${this.tid},\'mid\': ${this.mid},\'highlight\': ${this.highlight},>';
  }

  MovieRouteForm copyWith({dynamic tid, int mid, dynamic highlight}) {
    return MovieRouteForm(
      tid: tid ?? this.tid,
      mid: mid ?? this.mid,
      highlight: highlight ?? this.highlight,
    );
  }
}
