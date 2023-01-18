
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient{
    final Uri currencyURL = Uri.https("prepaid.currconv.com", "/api/v7/currencies", {"apiKey":"pr_01ed97b00041411ba288a521f2a3270a"});

    //function to return currency from api
    Future<List<String>> getCurrencies() async {
      http.Response res = await http.get(currencyURL);
      if(res.statusCode == 200){
        var body = jsonDecode(res.body);
        var list = body["results"];
        //add keys to list 'currencies'
        List<String> currencies = (list.keys).toList();

        return currencies;
      }
      else{
        throw Exception("Failed to connect to API");
    }
    }

    Future<double> getRate(String from, String to) async{
      final Uri rateUrl = Uri.https('prepaid.currconv.com','/api/v7/convert', {"apiKey":"pr_01ed97b00041411ba288a521f2a3270a",
      "q": "${from}_${to}",
      "compact":"ultra"
      });
      http.Response res = await http.get(rateUrl);
      if(res.statusCode == 200) {
        var body = jsonDecode(res.body);
        return body["${from}_${to}"];
      }
      else{
        throw Exception("Failed to connect to API");
      }

    }

  }


