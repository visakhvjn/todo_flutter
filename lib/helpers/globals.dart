import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/models/user.dart';

User gUser;
int selectedCategoryIndex = 0;
ScrollController taskScrollController;
ValueNotifier<GraphQLClient> graphQLClient;
SharedPreferences sharedPreferences;
bool initialDataPresent = false;