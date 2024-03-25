class TAPiString {
  TAPiString._();

  static const String baseApiUrl = "https://sports-fr3q.onrender.com";
  // * Cricket Player

  // ! register
  static const cricketRegister = "$baseApiUrl/createcricketplayer";

  // ! registerallData
  static const cricketRegisterAllData = "$baseApiUrl/cricket-nic/pdf";

  // ! login api
  static const cricketLogin = "$baseApiUrl/cricketlogin";

  // * Swimming Player
  // ! register
  static const swimmingRegister = "$baseApiUrl/createswimmingplayer";

  // ! registerallData
  static const swimmingRegisterAllData = "$baseApiUrl/swimming-nic/pdf";

  // ! login api
  static const swimmingLogin = "$baseApiUrl/swimminglogin";

  // * Cricket Organization
  // ! register
  static const cricketOrganizationRegister =
      "$baseApiUrl/createcricketorganization";
  // ! login api
  static const cricketOrganizationLogin =
      "$baseApiUrl/logincricketorganization";
  // * Swimming Organization
  // ! register
  static const swimmingOrganizationRegister =
      "$baseApiUrl/createswimingorganization";
  // ! login api
  static const swimmingOrganizationLogin =
      "$baseApiUrl/loginswimingorganization";
}
