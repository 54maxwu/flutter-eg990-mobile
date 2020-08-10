import 'package:dataclass/dataclass.dart';

part 'movie_route_form.g.dart';

@dataClass
class MovieRouteForm extends _$MovieRouteForm {
  final dynamic tid;
  final int mid;
  final dynamic highlight;

  const MovieRouteForm({this.tid, this.mid, this.highlight});
}
