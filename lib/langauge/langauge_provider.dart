
import 'package:class_9th_ncert_all/Modals/listdata.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:hive/hive.dart';


class LangaugeProvider with ChangeNotifier
{
 

bool isHindi;


LangaugeProvider(this.isHindi);


bool get getselectedLangauge => isHindi;


Future<DataSet> loadJsonDataSet()
async {

     if(isHindi)

      {
     String jsonstring =  await rootBundle.loadString('assets/data_image/HindiModal.json');
    final jsonresponse = json.decode(jsonstring);
     return DataSet.fromJson(jsonresponse);
     }
     else
     {
    String jsonstring =  await rootBundle.loadString('assets/data_image/Modal.json');
    final jsonresponse = json.decode(jsonstring);
     return DataSet.fromJson(jsonresponse);
     }
 
    

}

  // use to toggle the langauge
  toggleLangauge() async {
    final languagebox = await Hive.openBox('languagebox');
    languagebox.put('isHindi', !isHindi);
    isHindi = !isHindi;
    notifyListeners();
  }







}