class PatientHistory{
   String? image;
   String? diseaseName;
   String? subDiseaseName;
   String? checkRecordDate;
   String? pdfUrl;

  PatientHistory(this.image, this.diseaseName, this.subDiseaseName, this.checkRecordDate, this.pdfUrl);

    PatientHistory.fromJson(Map<String, dynamic> json) {
      diseaseName = json['disease_name'];
      subDiseaseName = json['sub_disease_name'];
      checkRecordDate = json['check_date'];
      image = json['image'];
      pdfUrl = json['PDF_URL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['disease_name'] = this.diseaseName;
    data['sub_disease_name'] = this.subDiseaseName;
    data['check_date'] = this.checkRecordDate;
    data['image'] = this.image;
    data['PDF_URL'] = this.pdfUrl;
    return data;
  }
}
