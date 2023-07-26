import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:palette_generator/palette_generator.dart';
import 'package:provatecnicalabhouse/src/config/globals.dart';

import '../models/Result.dart';

class RequestProvider {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://api.openai.com/v1/chat/",
    connectTimeout: const Duration(milliseconds: 13000),
    receiveTimeout: const Duration(milliseconds: 8000),
    receiveDataWhenStatusError: true,
  ));

  static Future<List<Result>> getResults({required String prompt, required String model, List<Result>? pastResults}) async {
    // print("A");
    //
    // Response _response = await _dio.post("completions", data: "{\r\n     \"model\": \"gpt-4-0613\",\r\n     \"messages\": [{\"role\": \"user\", \"content\": \"Dame un JSON correspondiente a \\\"LOS 5 MINERALES M\\u00C1S INFLUYENTES DE EUROPA Y AFRICA\\\". El JSON debe tener la siguiente estructura:\\r\\nArray con el numero de objetos especificado. Que cada objeto tenga solamente estos campos:\\r\\ntitle (String)\\r\\ndescription (String)\\r\\natribute (Float) ( [numerical_value] debe corresponder a un atributo. Este valor debe describir alg\\u00FAn atributo num\\u00E9rico del objeto. Por ejemplo, en caso de que los objetos sean deportes, este valor num\\u00E9rico puede corresponder a la dificultad o al porcentaje de personas que lo practican, en caso de que los objetos sean platos de comida, este valor podr\\u00EDa corresponder tambi\\u00E9n a la dificultad, al tiempo de preparaci\\u00F3n o por ejemplo, a una escala de frescura. El atributo debe ser el mismo para todos los objetos del array. No puede ser que el atributo de uno sea dificultad y de otro dureza)\\r\\n\\r\\nEl objeto seria algo as\\u00ED:\\r\\n[{\\\"title\\\":\\\"Tomate\\\", \\\"description\\\": \\\"El tomate es el mejor cultivo\\\", \\\"atribute\\\": {\\\"name\\\":\\\"Dulzura (escala del 1 al 10)\\\", \\\"value\\\": 6},\\r\\n{\\\"title\\\":\\\"Patata\\\", \\\"description\\\": \\\"Patatas para todo el mundo\\\", \\\"atribute\\\": {\\\"name\\\":\\\"Dulzura (escala del 1 al 10)\\\", \\\"value\\\": 4},\\r\\n(...)]\\r\\n\\r\\nMUY IMPORTANTE! NO DEBEN TODOS LOS OBJETOS DEBEN TENER EL MISMO ATRIBUTO. NO DEBE HABER ATRIBUTOS DIFERENTES ENTRE LOS DIFERENTES OBJETOS DEL ARRAY!\"}],\r\n     \"temperature\": 0.7\r\n   }", options: Options(headers: {
    //   HttpHeaders.authorizationHeader: "Bearer ${Globals.apiKey}"
    // },
    //     contentType: Headers.textPlainContentType,
    // responseType: ResponseType.json));
    //
    // print(_response.toString());
    //
    // if(_response.data != null){
    //   print(_response.data.toString());
    // }
    //
    // return _response.data.toString();

    print("A");

    List<Result> resultList = [];

    if(prompt != ""){

      if(pastResults != null){

        await Future.forEach(pastResults, (element) async {
          Result tmpResult = element;

          // print(utf8.tmpResult.description);

          tmpResult.imageUrl = await RequestProvider.getImageUrl(tmpResult.title ?? "apple");

          tmpResult.accentColor = (await PaletteGenerator.fromImageProvider(NetworkImage(tmpResult.imageUrl.toString()))).vibrantColor?.color;
          print("tmpResult.accentColor");
          print(tmpResult.accentColor?.value.toString());

          resultList.add(tmpResult);
        });
      }else{
        http.Response response = await http.post(
            Uri.https("api.openai.com", 'v1/chat/completions'),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${Globals.apiKey}"
            },
            body: "${Globals.promptBefore}$model${Globals.promptMid}$prompt${Globals.promptAfter}");

        await Future.forEach((jsonDecode((((jsonDecode(response.body) as Map)["choices"] as List<dynamic>).first["message"]["content"]).toString().substring((((jsonDecode(response.body) as Map)["choices"] as List<dynamic>).first["message"]["content"]).toString().indexOf('['), (((jsonDecode(response.body) as Map)["choices"] as List<dynamic>).first["message"]["content"]).toString().lastIndexOf(']')+1)) as List<dynamic>), (element) async {
          Result tmpResult = Result.fromJson(element);

          // print(utf8.tmpResult.description);

          tmpResult.imageUrl = await RequestProvider.getImageUrl(tmpResult.title ?? "apple");

          tmpResult.accentColor = (await PaletteGenerator.fromImageProvider(NetworkImage(tmpResult.imageUrl.toString()))).vibrantColor?.color;
          print("tmpResult.accentColor");
          print(tmpResult.accentColor?.value.toString());

          resultList.add(tmpResult);
        });
      }



    }else{

      await Future.forEach((jsonDecode(((jsonDecode(Globals.testingResponse) as Map)["choices"] as List<dynamic>).first["message"]["content"]) as List<dynamic>), (element) async {
        Result tmpResult = Result.fromJson(element);

        tmpResult.imageUrl = await RequestProvider.getImageUrl(tmpResult.title ?? "apple");

        tmpResult.accentColor = (await PaletteGenerator.fromImageProvider(NetworkImage(tmpResult.imageUrl.toString()))).vibrantColor?.color;
        print("tmpResult.accentColor");
        print(tmpResult.accentColor?.value.toString());

        resultList.add(tmpResult);
      });

    }

    // await (jsonDecode(((jsonDecode(Globals.testingResponse) as Map)["choices"] as List<dynamic>).first["message"]["content"]) as List<dynamic>).forEach((element) {
    //   Result tmpResult = Result.fromJson(element);
    //
    //   // tmpResult.imageUrl = await RequestProvider.getImageUrl(tmpResult.title ?? "apple");
    //   tmpResult.imageUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyPY4TFZRof2yVhaVGevXagrrds0w1seRyOy0I9yhOs5vF_-06Pmt3BGDTQm0&amp;s";
    //
    //   resultList.add(tmpResult);
    // });

    return resultList;
  }

  static Future<String> getImageUrl(String title) async {

    // String response = (await http.get(
    //     Uri.https("serpapi.com", 'search.json?q=$title&engine=google_images&ijn=0'))).body;
    //
    // print(response);
    //
    // return jsonDecode((jsonDecode(response)["images_results"] as List<dynamic>).first)["original"];

    http.Response response = await http.get(
        Uri.parse("https://www.google.com/search?sxsrf=AB5stBj6qR4to_Y-GpUJ5RKo9FVhpUQNRQ:1690244322853&q=$title&tbm=isch&source=lnms&sa=X&ved=2ahUKEwiAyMnjyqiAAxXs_rsIHagZCewQ0pQJegQIDRAB&cshid=1690244342610269&biw=1920&bih=937&dpr=1")
    );

    String tmpUrl = response.body.substring(response.body.indexOf('https://encr'));

    return tmpUrl.substring(0, tmpUrl.indexOf('\"'));

    // print(tmpUrl.substring(0, tmpUrl.indexOf('\"')));


  }
}
