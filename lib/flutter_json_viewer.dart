library flutter_json_widget;

import 'package:flutter/material.dart';

part 'flutter_json_viewer_theme.dart';

class JsonViewer extends StatefulWidget {
  final dynamic jsonObj;

  JsonViewer(this.jsonObj);

  @override
  _JsonViewerState createState() => _JsonViewerState();
}

class _JsonViewerState extends State<JsonViewer> {
  @override
  Widget build(BuildContext context) {
    final defaultTheme = JsonViewerThemeData(
      levelOffset: 14,
      iconColor: Colors.grey[700]!,
      iconSize: 14,
      keyTextStyle: TextStyle(color: Colors.purple[900]),
      nullValueKeyTextStyle: TextStyle(color: Colors.grey),
      nullValueTextStyle: TextStyle(color: Colors.grey),
      intValueTextStyle: TextStyle(color: Colors.teal),
      stringValueTextStyle: TextStyle(color: Colors.redAccent),
      boolValueTextStyle: TextStyle(color: Colors.purple),
      doubleValueTextStyle: TextStyle(color: Colors.teal),
      arrayValueTextStyle: TextStyle(color: Colors.grey),
      objectValueTextStyle: TextStyle(color: Colors.grey),
    );

    final theme = JsonViewerTheme.of(context) ?? defaultTheme;

    if (widget.jsonObj == null)
      return Text('{}');
    else if (widget.jsonObj is List) {
      return JsonArrayViewer(
        widget.jsonObj,
        notRoot: false,
        theme: theme,
      );
    } else {
      return JsonObjectViewer(
        widget.jsonObj,
        notRoot: false,
        theme: theme,
      );
    }
  }
}

class JsonObjectViewer extends StatefulWidget {
  final Map<String, dynamic> jsonObj;
  final bool notRoot;
  final JsonViewerThemeData theme;

  JsonObjectViewer(
    this.jsonObj, {
    required this.theme,
    this.notRoot: false,
  });

  @override
  JsonObjectViewerState createState() => JsonObjectViewerState();
}

class JsonObjectViewerState extends State<JsonObjectViewer> {
  Map<String, bool> openFlag = Map();

  @override
  Widget build(BuildContext context) {
    if (widget.notRoot) {
      return Padding(
        padding: EdgeInsets.only(left: widget.theme.levelOffset),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _getList(),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _getList(),
    );
  }

  _getList() {
    List<Widget> list = [];
    for (MapEntry entry in widget.jsonObj.entries) {
      bool ex = isExtensible(entry.value);
      bool ink = isInkWell(entry.value);
      list.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (ex)
            if (openFlag[entry.key] ?? false)
              Icon(
                Icons.arrow_drop_down,
                size: widget.theme.iconSize,
                color: widget.theme.iconColor,
              )
            else
              Icon(
                Icons.arrow_right,
                size: widget.theme.iconSize,
                color: widget.theme.iconColor,
              )
          else
            Icon(
              Icons.arrow_right,
              color: Colors.transparent,
              size: widget.theme.iconSize,
            ),
          if (ex && ink)
            InkWell(
                child: Text(
                  entry.key,
                  style: widget.theme.keyTextStyle,
                ),
                onTap: () {
                  setState(() {
                    openFlag[entry.key] = !(openFlag[entry.key] ?? false);
                  });
                })
          else
            Text(
              entry.key,
              style: entry.value == null
                  ? widget.theme.nullValueKeyTextStyle
                  : widget.theme.keyTextStyle,
            ),
          Text(
            ':',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(width: 3),
          getValueWidget(entry)
        ],
      ));
      list.add(const SizedBox(height: 4));
      if (openFlag[entry.key] ?? false) {
        list.add(getContentWidget(entry.value, widget.theme));
      }
    }
    return list;
  }

  static getContentWidget(dynamic content, JsonViewerThemeData theme) {
    if (content is List) {
      return JsonArrayViewer(
        content,
        notRoot: true,
        theme: theme,
      );
    } else {
      return JsonObjectViewer(
        content,
        notRoot: true,
        theme: theme,
      );
    }
  }

  static isInkWell(dynamic content) {
    if (content == null) {
      return false;
    } else if (content is int) {
      return false;
    } else if (content is String) {
      return false;
    } else if (content is bool) {
      return false;
    } else if (content is double) {
      return false;
    } else if (content is List) {
      if (content.isEmpty) {
        return false;
      } else {
        return true;
      }
    }
    return true;
  }

  getValueWidget(MapEntry entry) {
    if (entry.value == null) {
      return Expanded(
        child: Text(
          'undefined',
          style: widget.theme.nullValueTextStyle,
        ),
      );
    } else if (entry.value is int) {
      return Expanded(
        child: Text(
          entry.value.toString(),
          style: widget.theme.intValueTextStyle,
        ),
      );
    } else if (entry.value is String) {
      return Expanded(
        child: Text(
          '\"' + entry.value + '\"',
          style: widget.theme.stringValueTextStyle,
        ),
      );
    } else if (entry.value is bool) {
      return Expanded(
        child: Text(
          entry.value.toString(),
          style: widget.theme.boolValueTextStyle,
        ),
      );
    } else if (entry.value is double) {
      return Expanded(
        child: Text(
          entry.value.toString(),
          style: widget.theme.doubleValueTextStyle,
        ),
      );
    } else if (entry.value is List) {
      if (entry.value.isEmpty) {
        return Text(
          'Array[0]',
          style: widget.theme.arrayValueTextStyle,
        );
      } else {
        return InkWell(
          child: Text(
            'Array<${getTypeName(entry.value[0])}>[${entry.value.length}]',
            style: widget.theme.arrayValueTextStyle,
          ),
          onTap: () {
            setState(() {
              openFlag[entry.key] = !(openFlag[entry.key] ?? false);
            });
          },
        );
      }
    }
    return InkWell(
      child: Text(
        'Object',
        style: widget.theme.objectValueTextStyle,
      ),
      onTap: () {
        setState(() {
          openFlag[entry.key] = !(openFlag[entry.key] ?? false);
        });
      },
    );
  }

  static isExtensible(dynamic content) {
    if (content == null) {
      return false;
    } else if (content is int) {
      return false;
    } else if (content is String) {
      return false;
    } else if (content is bool) {
      return false;
    } else if (content is double) {
      return false;
    }
    return true;
  }

  static getTypeName(dynamic content) {
    if (content is int) {
      return 'int';
    } else if (content is String) {
      return 'String';
    } else if (content is bool) {
      return 'bool';
    } else if (content is double) {
      return 'double';
    } else if (content is List) {
      return 'List';
    }
    return 'Object';
  }
}

class JsonArrayViewer extends StatefulWidget {
  final List<dynamic> jsonArray;
  final bool notRoot;
  final JsonViewerThemeData theme;

  JsonArrayViewer(
    this.jsonArray, {
    this.notRoot: false,
    required this.theme,
  });

  @override
  _JsonArrayViewerState createState() => _JsonArrayViewerState();
}

class _JsonArrayViewerState extends State<JsonArrayViewer> {
  late List<bool> openFlag;

  @override
  Widget build(BuildContext context) {
    if (widget.notRoot) {
      return Container(
        padding: EdgeInsets.only(left: widget.theme.levelOffset),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _getList(),
        ),
      );
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: _getList());
  }

  @override
  void initState() {
    super.initState();
    openFlag = List.filled(widget.jsonArray.length, false);
  }

  _getList() {
    List<Widget> list = [];
    int i = 0;
    for (dynamic content in widget.jsonArray) {
      bool ex = JsonObjectViewerState.isExtensible(content);
      bool ink = JsonObjectViewerState.isInkWell(content);
      list.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (ex)
            if (openFlag[i])
              Icon(
                Icons.arrow_drop_down,
                size: widget.theme.iconSize,
                color: widget.theme.iconColor,
              )
            else
              Icon(
                Icons.arrow_right,
                size: widget.theme.iconSize,
                color: widget.theme.iconColor,
              )
          else
            Icon(
              Icons.arrow_right,
              size: widget.theme.iconSize,
              color: Colors.transparent,
            ),
          if (ex && ink)
            getInkWell(i)
          else
            Text(
              '[$i]',
              style: content == null
                  ? widget.theme.nullValueKeyTextStyle
                  : widget.theme.keyTextStyle,
            ),
          Text(
            ':',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(width: 3),
          getValueWidget(content, i)
        ],
      ));
      list.add(const SizedBox(height: 4));
      if (openFlag[i]) {
        list.add(JsonObjectViewerState.getContentWidget(content, widget.theme));
      }
      i++;
    }
    return list;
  }

  getInkWell(int index) {
    return InkWell(
        child: Text('[$index]', style: widget.theme.keyTextStyle),
        onTap: () {
          setState(() {
            openFlag[index] = !(openFlag[index]);
          });
        });
  }

  getValueWidget(dynamic content, int index) {
    if (content == null) {
      return Expanded(
        child: Text(
          'undefined',
          style: widget.theme.nullValueKeyTextStyle,
        ),
      );
    } else if (content is int) {
      return Expanded(
        child: Text(
          content.toString(),
          style: widget.theme.intValueTextStyle,
        ),
      );
    } else if (content is String) {
      return Expanded(
        child: Text(
          '\"' + content + '\"',
          style: widget.theme.stringValueTextStyle,
        ),
      );
    } else if (content is bool) {
      return Expanded(
        child: Text(
          content.toString(),
          style: widget.theme.boolValueTextStyle,
        ),
      );
    } else if (content is double) {
      return Expanded(
        child: Text(
          content.toString(),
          style: widget.theme.doubleValueTextStyle,
        ),
      );
    } else if (content is List) {
      if (content.isEmpty) {
        return Text(
          'Array[0]',
          style: widget.theme.arrayValueTextStyle,
        );
      } else {
        return InkWell(
          child: Text(
            'Array<${JsonObjectViewerState.getTypeName(content)}>[${content.length}]',
            style: widget.theme.arrayValueTextStyle,
          ),
          onTap: () {
            setState(() {
              openFlag[index] = !(openFlag[index]);
            });
          },
        );
      }
    }
    return InkWell(
      child: Text(
        'Object',
        style: widget.theme.objectValueTextStyle,
      ),
      onTap: () {
        setState(() {
          openFlag[index] = !(openFlag[index]);
        });
      },
    );
  }
}
