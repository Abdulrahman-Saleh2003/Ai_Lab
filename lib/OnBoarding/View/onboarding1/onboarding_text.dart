
import 'package:flutter/material.dart';

Widget   onboardingText(
    {
      required String label,
      required TextStyle? style,
      int maxLines=2,


    }


    ){
  return

    Text(
      label,style:style ,                  overflow: TextOverflow.ellipsis,
maxLines: maxLines,

    );


}
