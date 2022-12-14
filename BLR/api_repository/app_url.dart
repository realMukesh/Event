class AppUrl {
  static const String online_redemption_number =
      "1111111111"; //its used for online reddemption
  static const String zapping_number =
      "1111111112"; //its used for online reddemption
  static const String zapping = "parexel_blr";

  static const String live_baseUrl = 'https://live.dreamcast.in/eventbot'; //

  static const String login = '$live_baseUrl/$zapping/app_login';

  static const String search_user = '$live_baseUrl/$zapping/search_user';

  //static const String login = live_baseUrl + '/akamai/app_login';
  static const String entryZapping = '$live_baseUrl/$zapping/entryzapping';


  static const String save_onsite_user = '$live_baseUrl/$zapping/save_onsite_user';

  static const String update_status = '$live_baseUrl/$zapping/update';
}

/*
UST 2022 API List::
Login - https://live.dreamcast.in/eventbot/ust2022/app_login/1111111112/ABC //
Login - https://live.dreamcast.in/eventbot/ust2022/app_login/1111111113/ABC

Entry Zapping - https://live.dreamcast.in/eventbot/ust2022/entryzapping/UST22476Z5/Training room, UST Sai Radhe Complex/ABC
Search API: https://live.dreamcast.in/eventbot/ust2022/search_user/username(thomas)/ABC
Update API: https://live.dreamcast.in/eventbot/ust2022/update/118/ABC*/
