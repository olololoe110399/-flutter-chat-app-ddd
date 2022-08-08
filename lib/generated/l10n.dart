// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Messages`
  String get messages {
    return Intl.message(
      'Messages',
      name: 'messages',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get contacts {
    return Intl.message(
      'Contacts',
      name: 'contacts',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Calls`
  String get calls {
    return Intl.message(
      'Calls',
      name: 'calls',
      desc: '',
      args: [],
    );
  }

  /// `Stories`
  String get stories {
    return Intl.message(
      'Stories',
      name: 'stories',
      desc: '',
      args: [],
    );
  }

  /// `Type something...`
  String get typeSomething {
    return Intl.message(
      'Type something...',
      name: 'typeSomething',
      desc: '',
      args: [],
    );
  }

  /// `Online now`
  String get onlineNow {
    return Intl.message(
      'Online now',
      name: 'onlineNow',
      desc: '',
      args: [],
    );
  }

  /// `No name`
  String get noName {
    return Intl.message(
      'No name',
      name: 'noName',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get signOut {
    return Intl.message(
      'Sign out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `There are not users`
  String get thereAreNotUsers {
    return Intl.message(
      'There are not users',
      name: 'thereAreNotUsers',
      desc: '',
      args: [],
    );
  }

  /// `Oh no, something went wrong. `
  String get ohNoSomethingWentWrong {
    return Intl.message(
      'Oh no, something went wrong. ',
      name: 'ohNoSomethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Please check your config:\n {error}`
  String pleaseCheckYourConfigError(Object error) {
    return Intl.message(
      'Please check your config:\n $error',
      name: 'pleaseCheckYourConfigError',
      desc: '',
      args: [error],
    );
  }

  /// `So empty.\nGo and message someone.`
  String get soEmptyngoAndMessageSomeone {
    return Intl.message(
      'So empty.\nGo and message someone.',
      name: 'soEmptyngoAndMessageSomeone',
      desc: '',
      args: [],
    );
  }

  /// `Connecting`
  String get connecting {
    return Intl.message(
      'Connecting',
      name: 'connecting',
      desc: '',
      args: [],
    );
  }

  /// `Offline`
  String get offline {
    return Intl.message(
      'Offline',
      name: 'offline',
      desc: '',
      args: [],
    );
  }

  /// `Members:`
  String get members {
    return Intl.message(
      'Members:',
      name: 'members',
      desc: '',
      args: [],
    );
  }

  /// `watchers`
  String get watchers {
    return Intl.message(
      'watchers',
      name: 'watchers',
      desc: '',
      args: [],
    );
  }

  /// `Online`
  String get online {
    return Intl.message(
      'Online',
      name: 'online',
      desc: '',
      args: [],
    );
  }

  /// `Last online:`
  String get lastOnline {
    return Intl.message(
      'Last online:',
      name: 'lastOnline',
      desc: '',
      args: [],
    );
  }

  /// `Typing message`
  String get typingMessage {
    return Intl.message(
      'Typing message',
      name: 'typingMessage',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `name`
  String get name {
    return Intl.message(
      'name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `picture URL`
  String get pictureUrl {
    return Intl.message(
      'picture URL',
      name: 'pictureUrl',
      desc: '',
      args: [],
    );
  }

  /// `Do not Empty`
  String get doNotEmpty {
    return Intl.message(
      'Do not Empty',
      name: 'doNotEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Email`
  String get invalidEmail {
    return Intl.message(
      'Invalid Email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `email`
  String get email {
    return Intl.message(
      'email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `short Password`
  String get shortPassword {
    return Intl.message(
      'short Password',
      name: 'shortPassword',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get password {
    return Intl.message(
      'password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signIn {
    return Intl.message(
      'Sign in',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Cannot be empty`
  String get cannotBeEmpty {
    return Intl.message(
      'Cannot be empty',
      name: 'cannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back`
  String get welcomeBack {
    return Intl.message(
      'Welcome back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Create account`
  String get createAccount {
    return Intl.message(
      'Create account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `CHATTER`
  String get chatter {
    return Intl.message(
      'CHATTER',
      name: 'chatter',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
