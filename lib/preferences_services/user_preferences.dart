

import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesServices{

  static getUser()async{
    SharedPreferences instance=await SharedPreferences.getInstance();

    String userId=instance.getString("userID")??"";
    return userId;
  }


}