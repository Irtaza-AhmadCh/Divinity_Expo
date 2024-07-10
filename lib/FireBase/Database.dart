


class FireStore {
  static void userdata(firestoreRef, val, PhoneNo, emailController,
      nameController) {
    firestoreRef.doc(val.user!.uid.toString()).set({
      'Id': val.user!.uid.toString(),
      'Phone Number': PhoneNo,
      'Email': emailController.text,
      'Name': nameController.text,

    });
  }



}