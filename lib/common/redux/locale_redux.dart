
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

/**
 * 语言Redux
 * Created by mai
 * Date: 2018-07-16
 */

final LocaleReducer = combineReducers<Locale>([
  TypedReducer<Locale, RefreshLocaleAction>(_refresh),
]);

Locale _refresh(Locale locale, RefreshLocaleAction action) {
  locale = action.locale;
  return locale;
}

class RefreshLocaleAction {
  final Locale locale;

  RefreshLocaleAction(this.locale);
}


