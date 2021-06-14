class Member{
  Member({this.myQRCode, this.name, this.club, this.email, this.phone,this.status});
  final String name;
  final String club;
  final String email;
  final String phone;
  final String myQRCode;
  bool status = false;
  void arrived(){
    status = true;
  }
  bool getStatus() {
    return status;
  }


}