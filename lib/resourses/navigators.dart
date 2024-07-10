import 'package:flutter/material.dart';

NavigateTo(context, screen){

  Navigator.push(context,
  MaterialPageRoute(builder: (context)=> screen));
}

NavigateToReplace(context, screen){

  Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context)=> screen));
}

NavigatePop(context, ){

  Navigator.pop(context);
}
