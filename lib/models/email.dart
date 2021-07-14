class Email{
  late String correo;

  Email(
      {required this.correo});

  Email.fromJson(Map<String, dynamic> json) {
    this.correo = json['correo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['correo'] = this.correo.toString();
    return data;
  }
}