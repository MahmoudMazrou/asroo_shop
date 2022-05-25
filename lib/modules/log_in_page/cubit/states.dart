abstract class AppLoginStates {}

class AppLoginInitialState extends AppLoginStates {}

class AppLoginLoadingState extends AppLoginStates {}

class AppLoginSuccessState extends AppLoginStates
{
  final String uId;//لمن تنجح ببعت اي دي اليوزر الي نجح عشان قصة الشيرد ريفرنسس

  AppLoginSuccessState(this.uId);
}

class AppLoginErrorState extends AppLoginStates
{
  final String error;

  AppLoginErrorState(this.error);
}

class AppChangePasswordVisibilityState extends AppLoginStates {}
class AppRegisterChangeChicPoxImageState extends AppLoginStates {}
