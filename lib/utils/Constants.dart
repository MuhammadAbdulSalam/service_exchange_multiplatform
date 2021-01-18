import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_exchange_multiplatform/models/UserDataModel.dart';

enum listType { NEAR_ME, MY_POSTS, REFRESH, FILER }
enum OffersListType { RECEIVED, SENT }

class Constants {
  static const DEFAULT_BLUE = Color(0xFF6dc1c3);
  static const BLUE_SHADE_1 = Color(0xFF81E4E6);
  static const BLUE_SHADE_2 = Color(0xFF88F0F2);
  static const DEFAULT_ORANGE = Color(0xFFd25643);
  static const ORANGE_SHADE_1 = Color(0xFFE65E49);
  static const ORANGE_SHADE_2 = Color(0xFF2634E);
  static const DARK_GREY = Color(0xFF2b2b2b);

  static bool IS_THEME_DARK = false;
  static Color THEME_DEFAULT_BLACK = Colors.black87;
  static Color THEME_DEFAULT_WHITE = Colors.white60;
  static Color THEME_DEFAULT_FULL_WHITE = Colors.white;
  static Color THEME_LIGHT_BLACK = Colors.black54;
  static Color THEME_ORCHARD = Color(0xffDA70D6);
  static Color THEME_DARK_TEXT = Colors.white;

  static Color THEME_DEFAULT_BACKGROUND = THEME_DEFAULT_BLACK;
  static Color THEME_DEFAULT_BORDER = THEME_DEFAULT_WHITE;
  static Color THEME_DEFAULT_TEXT = THEME_DARK_TEXT;
  static Color THEME_TEXT_BOX_COLOR = Colors.black54;
  static Color THEME_TEXT_HINT_COLOR = THEME_DARK_TEXT;
  static Color THEME_LABEL_COLOR = THEME_DARK_TEXT;
  static Color THEME_POST_ADD_CONTAINER = THEME_DEFAULT_BLACK;
  static Color THEME_WHITE_BACKGROUND_TEXT = THEME_DEFAULT_BLACK;
  static Color THEME_SHADOW_COLOR = Colors.white;
  static Color THEME_RECYCLER_BACKGROUND = THEME_DEFAULT_BLACK;
  static Color THEME_CARD_COLOR = THEME_DEFAULT_BLACK;
  static Color THEME_COMMENT_BACKGROUND = Color(0x73D3D3D3);
  static Color THEME_PROFILE_BACKGROUND = Colors.white;
  static Color THEME_PROFILE_INFO_LABEL = Colors.black38;
  static Color THEME_PROFILE_CONTAINERS_GRADIENT1 = Colors.orangeAccent;
  static Color THEME_PROFILE_CONTAINERS_GRADIENT2 = DEFAULT_BLUE;
  static Color THEME_OFFER_TOOLBAR_COLOR = THEME_DEFAULT_BLACK;
  static Color POST_ITEM_GRADIENT1 = Colors.white;
  static Color POST_ITEM_GRADIENT2 = Colors.white;
  static Color POST_ITEM_GRADIENT3 = Colors.white;
  static Color POST_ITEM_GRADIENT4 = Colors.white;
  static Color OFFER_STATUS_TEXT = Colors.black54;

  static void homeThemeLight() {
    THEME_DEFAULT_BACKGROUND = THEME_DEFAULT_WHITE;
    THEME_DEFAULT_BORDER = THEME_DEFAULT_BLACK;
    THEME_DEFAULT_TEXT = Colors.black;
    THEME_TEXT_BOX_COLOR = THEME_DEFAULT_WHITE;
    THEME_TEXT_HINT_COLOR = THEME_DEFAULT_BLACK;
    THEME_LABEL_COLOR = THEME_DEFAULT_BLACK;
    THEME_SHADOW_COLOR = THEME_DEFAULT_BLACK;
    THEME_RECYCLER_BACKGROUND = Color(0xE6FFFFFF);
    THEME_CARD_COLOR = Colors.white;
    THEME_COMMENT_BACKGROUND = Color(0x73D3D3D3);
    THEME_PROFILE_BACKGROUND = Colors.white;
    THEME_PROFILE_INFO_LABEL = Colors.black38;
    THEME_PROFILE_CONTAINERS_GRADIENT1 = Colors.orangeAccent;
    THEME_PROFILE_CONTAINERS_GRADIENT2 = DEFAULT_BLUE;
    THEME_OFFER_TOOLBAR_COLOR = THEME_DEFAULT_BLACK;
    POST_ITEM_GRADIENT1 = Colors.white;
    POST_ITEM_GRADIENT2 = Colors.white;
    POST_ITEM_GRADIENT3 = Colors.orangeAccent;
    POST_ITEM_GRADIENT4 = DEFAULT_BLUE;
    OFFER_STATUS_TEXT = Colors.black54;
  }

  static void homeThemeDark() {
    THEME_DEFAULT_BACKGROUND = THEME_DEFAULT_BLACK;
    THEME_DEFAULT_BORDER = THEME_DEFAULT_WHITE;
    THEME_DEFAULT_TEXT = THEME_DARK_TEXT;
    THEME_TEXT_BOX_COLOR = Colors.black54;
    THEME_TEXT_HINT_COLOR = THEME_DARK_TEXT;
    THEME_LABEL_COLOR = THEME_DARK_TEXT;
    THEME_SHADOW_COLOR = Colors.black54;
    THEME_RECYCLER_BACKGROUND = Color(0x40FFFFFF);
    THEME_CARD_COLOR = Colors.black54;
    THEME_COMMENT_BACKGROUND = Colors.black54;
    THEME_PROFILE_BACKGROUND = THEME_LIGHT_BLACK;
    THEME_PROFILE_INFO_LABEL = Colors.grey;
    THEME_PROFILE_CONTAINERS_GRADIENT1 = Colors.black54;
    THEME_PROFILE_CONTAINERS_GRADIENT2 = Colors.black54;
    THEME_OFFER_TOOLBAR_COLOR = Colors.black54;
    POST_ITEM_GRADIENT1 = Colors.transparent;
    POST_ITEM_GRADIENT2 = Colors.transparent;
    POST_ITEM_GRADIENT3 = Colors.orangeAccent;
    POST_ITEM_GRADIENT4 = DEFAULT_BLUE;
    OFFER_STATUS_TEXT = THEME_DEFAULT_WHITE;
  }

  static Color getContainerColor() {
    if (IS_THEME_DARK) {
      return Colors.transparent;
    } else {
      return Colors.white;
    }
  }

  static const USER_NAME = "user_name";
  static const USER_JOB = "user_job";
  static const USER_PHONE = "user_phone";
  static const USER_ADDRESS = "user_address";
  static const USER_DP = "user_dp";
  static const TEMPLATE_SERVICE = "template_service";
  static const TEMPLATE_DESCRIPTION = "template_description";
  static const COLOR_THEME = "color_theme";

  // ignore: non_constant_identifier_names
  static var registration_Address = "";

  static const DEFAULT_BUTTON = Color(0xFF6dc1c3);

  static int CURRENT_INDEX = 0;
  static int HOME_INDEX = 0;
  static int POSTS_INDEX = 1;
  static int NEWADD_INDEX = 3;

  static int NEAR_ME = 0;
  static int MY_POSTS = 0;
  static int REFRESH = 1;
  static int FILTER = 3;

  static bool FIRST_START_POSTPAGE = true;

  static List<UserDataModel> userList = [];

  static String getImageUrl() {
    if (userList[0].dpUrl == "default") {
      return "https://www.woolha.com/media/2019/06/buneary.jpg";
    } else {
      return userList[0].dpUrl;
    }
  }

// iPhone 6S
// |_ [portrait]
//    |_ size: 375.0x667.0, pixelRatio: 2.0, pixels: 750.0x1334.0
//       |_ diagonal: 765.1888655750291
// |_ [horizontal]
//    |_ size: 667.0x375.0, pixelRatio: 2.0, pixels: 1334.0x750.0
//       |_ diagonal: 765.1888655750291

// iPhone X
// |_ [portrait]
//    |_ size: 375.0x812.0, pixelRatio: 3.0, pixels: 1125.0x2436.0
//       |_ diagonal: 894.4098613052072
// |_ [horizontal]
//    |_ size: 812.0x375.0, pixelRatio: 3.0, pixels: 2436.0x1125.0
//       |_ diagonal: 894.4098613052072

// iPhone XS Max
// |_ [portrait]
//    |_ size: 414.0x896.0, pixelRatio: 3.0, pixels: 1242.0x2688.0
//       |_ diagonal: 987.0217829409845
// |_ [horizontal]
//    |_ size: 896.0x414.0, pixelRatio: 3.0, pixels: 2688.0x1242.0
//       |_ diagonal: 987.0217829409845

// iPad Pro (9.7-inch)
// |_ [portrait]
//    |_ size: 768.0x1024.0, pixelRatio: 2.0, pixels: 1536.0x2048.0
//       |_ diagonal: 1280.0
// |_ [horizontal]
//    |_ size: 1024.0x768.0, pixelRatio: 2.0, pixels: 2048.0x1536.0
//       |_ diagonal: 1280.0

// iPad Pro (10.5-inch)
// |_ [portrait]
//    |_ size: 834.0x1112.0, pixelRatio: 2.0, pixels: 1668.0x2224.0
//       |_ diagonal: 1390.0
// |_ [horizontal]
//    |_ size: 1112.0x834.0, pixelRatio: 2.0, pixels: 2224.0x1668.0
//       |_ diagonal: 1390.0

// iPad Pro (12.9-inch)
// |_ [portrait]
//    |_ size: 1024.0x1366.0, pixelRatio: 2.0, pixels: 2048.0x2732.0
//       |_ diagonal: 1707.2000468603555
// |_ [horizontal]
//    |_ size: 1366.0x1024.0, pixelRatio: 2.0, pixels: 2732.0x2048.0
//       |_ diagonal: 1707.2000468603555

}
