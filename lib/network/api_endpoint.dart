class ApiEndPoint {
  // WEB
  static const String baseUrl = "http://123.2.156.148:5245/api/";
  static const String login = "v1/Login/W/Login";
  static const String siteLocations = "v1/Login/W/sign/MySiteList";
  static const String addUserLocationPermission = "v1/Login/W/sign/Permission";

  // Mobile
  // static const String baseUrl = "http://123.2.156.148:5246/api/";

  /// Login
  // static const String login = "v1/Login/M/Login";

  /// 월별 캘린더 데이터 조회
  static const String monthCalendar = "v1/Calendar/M/sign/GetMonthCalendar";

  /// 오늘 날짜의 TODO List 조회
  static const String todoList = "v1/Calendar/M/sign/GetTodoList";

  /// 일정 추가
  static const String addCalendar = "v1/Calendar/M/sign/AddCalendar";

  /// 사업장 목록 조회
  // static const String siteLocations = "v1/Login/M/sign/MySiteList";

  /// 사업장 추가
  // static const String addUserLocationPermission = "v1/Login/M/sign/Permission";
}
