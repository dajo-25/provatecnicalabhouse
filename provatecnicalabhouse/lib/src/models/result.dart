import 'dart:convert';
import 'dart:ui';

class Result {

  Result({
    this.title,
    this.description,
    this.atribute,
  });


  Result.fromJson(dynamic json) {

    try{

    title = utf8.decode(Latin1Codec().encode(json['title'])).toString();
    description = utf8.decode(Latin1Codec().encode(json['description'])).toString();
    }catch(_){

      title = json['title'];
      description = json['description'];
    }

    atribute =
        json['atribute'] != null ? Atribute.fromJson(json['atribute']) : null;
  }

  String? title;
  String? description;
  String? _imageUrl;
  Atribute? atribute;
  Color? _accentColor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    if (atribute != null) {
      map['atribute'] = atribute?.toJson();
    }
    return map;
  }

  Color? get accentColor => _accentColor;

  set accentColor(Color? value) {
    _accentColor = value;
  }

  String? get imageUrl => _imageUrl;

  set imageUrl(String? value) {
    _imageUrl = value;
  }
}

class Atribute {
  Atribute({
    this.name,
    this.value,
  });

  Atribute.fromJson(dynamic json) {
    try{

    name = utf8.decode(Latin1Codec().encode(json['name'])).toString();
    }catch(_){
      name = json['name'];
    }

    value = (double.tryParse(json['value'].toString()) ?? int.tryParse(json['value'].toString())) as double?;
  }

  String? name;
  double? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['value'] = value;
    return map;
  }
}
