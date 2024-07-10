import '../Paths/imports.dart';



Widget ProfileField({title, text, width}){
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(
          color: MyColors.white,
          fontSize: 16,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.normal ,
        ),),
        SizedBox(
          height: 13,
        ),
        Container(
          height: 45,
          width: width,
          decoration: BoxDecoration(
              color: MyColors.bgBlue,
              border: Border.all(color: Colors.white,
                  width: 1),
              borderRadius: BorderRadius.circular(25)
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(21, 13, 0,13),
            child: Text(text, style: TextStyle(
              color: MyColors.white.withOpacity(.49),
              fontSize: 14,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.normal ,
            ),),
          ),

        )
      ],
    ),
  );
}