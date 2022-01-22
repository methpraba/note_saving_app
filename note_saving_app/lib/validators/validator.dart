class Validator{
  static String? validateField({required String value}){
    if (value.isEmpty){
      return 'This textField cannot be empty';
  }
    return null;
  }
  static String? validateUserId({required String uid}){
    if(uid.isEmpty){
      return 'User ID cannot be empty';
    }
    else if(uid.length <= 6){
      return 'User ID should be greater than six characters';
    }
    return null;
  }
}