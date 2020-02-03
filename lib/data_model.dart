

class DataModel{
  String nomor,nama,type,keterangan;


  DataModel({this.nomor, this.nama, this.type,this.keterangan});

  factory DataModel.fromJson(Map<String, dynamic>json) => DataModel(
    nomor: json["nomor"],
    nama: json["nama"],
    type: json["type"],
    keterangan: json["keterangan"]
  );
}