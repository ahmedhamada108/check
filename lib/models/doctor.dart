import 'package:untitled1/widgets/doctor_card.dart';

class Doctor {
  final String doctorName;
  final String doctorDescription;
  final String address;
  final String doctorFee;
  final String doctorImage;
  final String doctorProfile;

  Doctor(this.doctorName, this.doctorDescription, this.address, this.doctorFee,
      this.doctorImage, this.doctorProfile);

  static getDoctorsInfo(String name, String address, String description,
      String fees, String image) {
    return DoctorCard(
      doctorName: name,
      doctorAddress: address,
      doctorCost: fees,
      doctorProfession: description,
      doctorImagePath: image,
    );
  }

  factory Doctor.fromJson(Map<String, dynamic> json){
  return Doctor(
     json['Doctor_name'],
    json['Doctor_description'],
    json['Address'],
    json['Doctor_fee'],
    json['Doctor_image'],
    json['Doctor_profile'],
  );
  }
}


class Result {
  ResultCheck? resultCheck;
  List<VezzetaDoctors>? vezzetaDoctors;

  Result({this.resultCheck, this.vezzetaDoctors});

  Result.fromJson(Map<String, dynamic> json) {
    resultCheck = json['Result Check'] != null
        ? new ResultCheck.fromJson(json['Result Check'])
        : null;
    if (json['Vezzeta Doctors'] != null) {
      vezzetaDoctors = <VezzetaDoctors>[];
      json['Vezzeta Doctors'].forEach((v) {
        vezzetaDoctors!.add(new VezzetaDoctors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resultCheck != null) {
      data['Result Check'] = this.resultCheck!.toJson();
    }
    if (this.vezzetaDoctors != null) {
      data['Vezzeta Doctors'] =
          this.vezzetaDoctors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultCheck {
  int? id;
  String? subDisease;
  String? description;
  int? totalVezzetaDoctors;

  ResultCheck(
      {this.id, this.subDisease, this.description, this.totalVezzetaDoctors});

  ResultCheck.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subDisease = json['sub_disease'];
    description = json['description'];
    totalVezzetaDoctors = json['Total_Vezzeta_Doctors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_disease'] = this.subDisease;
    data['description'] = this.description;
    data['Total_Vezzeta_Doctors'] = this.totalVezzetaDoctors;
    return data;
  }
}

class VezzetaDoctors {
  String? doctorName;
  String? doctorDescription;
  String? address;
  String? doctorFee;
  String? doctorImage;
  String? doctorProfile;

  VezzetaDoctors(
      {this.doctorName,
      this.doctorDescription,
      this.address,
      this.doctorFee,
      this.doctorImage,
      this.doctorProfile});

  VezzetaDoctors.fromJson(Map<String, dynamic> json) {
    doctorName = json['Doctor_name'];
    doctorDescription = json['Doctor_description'];
    address = json['Address'];
    doctorFee = json['Doctor_fee'];
    doctorImage = json['Doctor_image'];
    doctorProfile = json['Doctor_profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Doctor_name'] = this.doctorName;
    data['Doctor_description'] = this.doctorDescription;
    data['Address'] = this.address;
    data['Doctor_fee'] = this.doctorFee;
    data['Doctor_image'] = this.doctorImage;
    data['Doctor_profile'] = this.doctorProfile;
    return data;
  }
}