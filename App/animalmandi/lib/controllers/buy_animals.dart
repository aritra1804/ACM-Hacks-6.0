import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/cow_model.dart';



 class  BuyAnimal{
   static  Future<List<Animaldetails>> getAnimalData()async{
       final  url='https://acm-hacks.herokuapp.com/api/animals/cow';
       final response=await http.get(Uri.parse(url));
       final body =json.decode(response.body);
       return body.map<Animaldetails>((e)=>Animaldetails.fromJson(e)).toList();

     }

     static Future<List<Animaldetails>> getBuffaloData()async{
        final  url='https://acm-hacks.herokuapp.com/api/animals/buffalo';
        final response=await http.get(Uri.parse(url));
        final body =json.decode(response.body);
        return body.map<Animaldetails>((e)=>Animaldetails.fromJson(e)).toList();
  
     }

 }