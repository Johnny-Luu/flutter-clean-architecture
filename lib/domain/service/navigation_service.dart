// import 'package:fimber/fimber.dart';
// import 'package:flutter/material.dart';

// /// Singleton navigation service used for navigation between the screens.
// /// This service allows navigation from viewmodel without requiring the context
// /// details from the widget.
// class NavigationService {
//   final AppRouter _router;

//   NavigationService(this._router);

//   Future push<T>(PageRouteInfo routeInfo) async {
//     try {
//       return _router.push(routeInfo);
//     } on Exception catch (e) {
//       Fimber.e('Exception occurred in navigateTo: $e');
//     }
//   }

//   Future popAndPush(PageRouteInfo routeInfo) async {
//     try {
//       return _router.popAndPush(routeInfo);
//     } on Exception catch (e) {
//       Fimber.e('Exception occurred in navigateTo: $e');
//     }
//   }

//   Future pushAndRemoveUntil(
//     PageRouteInfo routeInfo, {
//     required RoutePredicate predicate,
//   }) async {
//     try {
//       return _router.pushAndPopUntil(routeInfo, predicate: predicate);
//     } on Exception catch (e) {
//       Fimber.e('Exception occurred in navigateTo: $e');
//     }
//   }

//   Future<bool> pop() {
//     try {
//       return _router.pop();
//     } on Exception catch (e) {
//       Fimber.e('Exception occurred in pop: $e');
//       return Future.value(false);
//     }
//   }

//   void popToRoot() {
//     try {
//       return _router.popUntil((route) => route.isFirst);
//     } on Exception catch (e) {
//       Fimber.e('Exception occurred in pop: $e');
//     }
//   }

//   // Future push(String routeName, [Object? arguments]) async {
//   //   try {
//   //     return ExtendedNavigator?.root?.push(routeName, arguments: arguments);
//   //   } on Exception catch (e) {
//   //     print('Exception occurred in navigateTo: $e');
//   //   }
//   // }
//   //
//   // Future popAndPush(String routeName, [Object? arguments]) async {
//   //   try {
//   //     return ExtendedNavigator?.root?.popAndPush(routeName, arguments: arguments);
//   //   } on Exception catch (e) {
//   //     print('Exception occurred in navigateTo: $e');
//   //   }
//   // }
//   //
//   // Future pushAndRemoveUntil(String routeName, [Object? arguments]) async {
//   //   try {
//   //     return ExtendedNavigator?.root?.pushAndRemoveUntil(
//   //         routeName, (route) => route.isFirst, arguments: arguments);
//   //   } on Exception catch (e) {
//   //     print('Exception occurred in navigateTo: $e');
//   //   }
//   // }
//   //
//   // void pop([Object? arguments]) {
//   //   try {
//   //     return ExtendedNavigator?.root?.pop(arguments);
//   //   } on Exception catch (e) {
//   //     print('Exception occurred in pop: $e');
//   //   }
//   // }
//   //
//   // void popToRoot() {
//   //   try {
//   //     return ExtendedNavigator?.root?.popUntil((route) => route.isFirst);
//   //   } on Exception catch (e) {
//   //     print('Exception occurred in pop: $e');
//   //   }
//   // }
// }