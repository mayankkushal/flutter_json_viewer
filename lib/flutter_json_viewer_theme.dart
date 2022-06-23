part of flutter_json_widget;

class JsonViewerTheme extends InheritedWidget {
  JsonViewerTheme({
    Key? key,
    required this.child,
    required this.data,
  }) : super(key: key, child: child);

  final Widget child;
  final JsonViewerThemeData data;

  static JsonViewerThemeData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<JsonViewerTheme>()?.data;
  }

  @override
  bool updateShouldNotify(JsonViewerTheme oldWidget) {
    return true;
  }
}

class JsonViewerThemeData {
  JsonViewerThemeData({
    required this.levelOffset,
    required this.iconColor,
    required this.iconSize,
    required this.keyTextStyle,
    required this.nullValueKeyTextStyle,
    required this.nullValueTextStyle,
    required this.intValueTextStyle,
    required this.stringValueTextStyle,
    required this.boolValueTextStyle,
    required this.doubleValueTextStyle,
    required this.arrayValueTextStyle,
    required this.objectValueTextStyle,
  });

  final double levelOffset;
  final Color iconColor;
  final double iconSize;
  final TextStyle keyTextStyle;
  final TextStyle nullValueKeyTextStyle;
  final TextStyle nullValueTextStyle;
  final TextStyle intValueTextStyle;
  final TextStyle stringValueTextStyle;
  final TextStyle boolValueTextStyle;
  final TextStyle doubleValueTextStyle;
  final TextStyle arrayValueTextStyle;
  final TextStyle objectValueTextStyle;

  @override
  bool operator ==(Object? other) {
    if (other is! JsonViewerThemeData) {
      return false;
    }

    return hashCode == other.hashCode;
  }

  @override
  int get hashCode =>
      levelOffset.hashCode ^
      iconColor.hashCode ^
      iconSize.hashCode ^
      keyTextStyle.hashCode ^
      nullValueKeyTextStyle.hashCode ^
      nullValueTextStyle.hashCode ^
      intValueTextStyle.hashCode ^
      stringValueTextStyle.hashCode ^
      boolValueTextStyle.hashCode ^
      doubleValueTextStyle.hashCode ^
      arrayValueTextStyle.hashCode ^
      objectValueTextStyle.hashCode;
}
