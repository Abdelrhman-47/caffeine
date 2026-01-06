import 'package:caffeine/features/profile/data/user_data.dart';
import 'package:hive_ce/hive.dart';

class LocalServiceProfile {  
static const String userDataBoxName = 'userDataBox';

  Box<UserData> get _userDataBox =>
      Hive.box<UserData>(userDataBoxName);

  UserData? getUserData() {
    return _userDataBox.get('user_data');
  }

  Future<void> saveUserData(UserData userData) async {
    await _userDataBox.put('user_data', userData);
  }
}