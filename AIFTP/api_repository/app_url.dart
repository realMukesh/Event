class AppUrl {
  static const String online_redemption_number =
      "1111111111"; //its used for online reddemption
  static const String zapping_number =
      "1111111112"; //its used for online reddemption
  static const String zapping = "aiftp";

  static const String live_baseUrl = 'https://live.dreamcast.in/eventbot'; //

  static const String login = '$live_baseUrl/$zapping/app_login';

  static const String save_onsite_user = '$live_baseUrl/$zapping/save_onsite_user';

  static const String search_user = '$live_baseUrl/$zapping/search_user';

  static const String update_status = '$live_baseUrl/$zapping/update';

  //static const String login = live_baseUrl + '/akamai/app_login';
  static const String entryZapping = '$live_baseUrl/$zapping/entryzapping';
}
