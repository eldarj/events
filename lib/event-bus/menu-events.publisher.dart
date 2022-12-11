import 'dart:async';
import 'package:rxdart/rxdart.dart';

enum MenuItemType {
  SEARCH, SETTINGS
}

class MenuEventsPublisher {
  static final MenuEventsPublisher _instance = MenuEventsPublisher._internal();

  final Map<String, StreamSubscription> _subs = {};

  final PublishSubject<MenuItemType> _menuEventsSubject = PublishSubject<MenuItemType>();

  factory MenuEventsPublisher() {
    return _instance;
  }

  MenuEventsPublisher._internal();

  // Consume
  onMenuItemPressed(String key, Function callback) {
    _addListener(_subs, _menuEventsSubject, key, callback);
  }

  // Produce
  emitMenuItemPressed(MenuItemType type) {
    _menuEventsSubject.add(type);
  }

  // Listener methods
  removeListener(String key) {
    _subs[key]?.cancel();
    _subs.remove(key);
  }

  _addListener(Map<String, StreamSubscription> subs, PublishSubject<MenuItemType> subject, String key, dynamic callback) {
    if (subs.containsKey(key)) {
      subs[key]?.cancel();
      subs.remove(key);
      subs[key] = subject.listen(callback);
    } else {
      subs[key] = subject.listen(callback);
    }
  }
}

final menuEventsPublisher = MenuEventsPublisher._internal();
