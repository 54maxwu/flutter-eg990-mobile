import 'package:meta/meta.dart' show immutable;

@immutable
class AboutData {
  final String title;
  final List<String> subtitles;
  final List<String> contents;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const AboutData({
    this.title = '',
    this.subtitles,
    this.contents,
  });

  AboutData copyWith({
    String title,
    List<String> subtitles,
    List<String> contents,
  }) {
    if ((title == null || identical(title, this.title)) &&
        (subtitles == null || identical(subtitles, this.subtitles)) &&
        (contents == null || identical(contents, this.contents))) {
      return this;
    }

    return new AboutData(
      title: title ?? this.title,
      subtitles: subtitles ?? this.subtitles,
      contents: contents ?? this.contents,
    );
  }

  @override
  String toString() {
    return 'AboutData{title: $title, subtitles: $subtitles, contents: $contents}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AboutData &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          subtitles == other.subtitles &&
          contents == other.contents);

  @override
  int get hashCode => title.hashCode ^ subtitles.hashCode ^ contents.hashCode;

//</editor-fold>

}
