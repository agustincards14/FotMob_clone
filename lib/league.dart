// Flutter code sample for SingleChildScrollView

// In this example, the children are spaced out equally, unless there's no more
// room, in which case they stack vertically and scroll.
//
// When using this technique, [Expanded] and [Flexible] are not useful, because
// in both cases the "available space" is infinite (since this is in a viewport).
// The next section describes a technique for providing a maximum height constraint.

import 'package:flutter/widgets.dart';

class League {
  String name;
  List<String> confs;
  int tabs;
  Icon icon;
  int importance;

  League(this.name, this.confs, this.tabs, {this.icon, this.importance});
}
