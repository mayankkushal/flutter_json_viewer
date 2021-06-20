# flutter_json_viewer

A Json viewer widget for flutter. Updated with null safety and added support for Array in the root level.

Forked from [flutter_json_widget](https://github.com/demdog/flutter_json_widget)

## Using the library

The `/example/` folder in the [GitHub repo](https://github.com/mayankkushal/flutter_json_viewer)

contains a full Flutter app with demo examples.

## Use this package as a library on [Dart dev](https://pub.dev/packages/flutter_json_viewer)

### 1. Depend on it

Add this to your package's pubspec.yaml file:

```

dependencies:

flutter_json_viewer: ^1.0.0

```

### 2. Install it

You can install packages from the command line:

with Flutter:

```

$ flutter pub get

```

Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more.

### 3. Import it

Now in your Dart code, you can use:

```

import 'package:flutter_json_viewer/flutter_json_viewer.dart';

```

### 4. Show it

```

@override

Widget build(BuildContext context) {

var testString = '''{

"I": "How are you?",

"You": "Excellent!"}

''';

Map<String, dynamic> jsonObj = jsonDecode(testString);

return SafeArea(

child: SingleChildScrollView(

child: JsonViewer(jsonObj)

),

);

}

```

## Demo

![Demo](https://github.com/mayankkushal/flutter_json_viewer/blob/master/example.gif)
