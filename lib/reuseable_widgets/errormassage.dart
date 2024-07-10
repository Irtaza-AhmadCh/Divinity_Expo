import '../Paths/imports.dart';





class ErrorMassage {

  static  void errormassage( context, error){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
     duration: Duration(seconds: 5),
      content: Text('$error', style: TextStyle(
        color: MyColors.white,
        fontSize: 15
      ),),
      backgroundColor: MyColors.bgBlue,
    ));
  }

}