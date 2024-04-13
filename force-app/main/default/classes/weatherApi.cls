public with sharing class weatherApi {
  @AuraEnabled
  public static string getweather(String city) {
    try {
      //String endpointURL = 'http://api.weatherapi.com/v1/current.json?key=68bc2af07fd04f4988772306230511&q=Durgapur';
      city = city.replaceAll('[^a-zA-Z0-9\\s+]', '');
      Http http = new Http();
      HttpRequest req = new HttpRequest();
      req.setEndpoint('callout:Weather_Api/current.json?q=' + city);
      //req.setEndpoint(endpointURL);
      req.setMethod('GET');
      System.debug('Request : ' + req);
      HttpResponse res = http.send(req);
      return res.getBody();
    } catch (Exception ex) {
      String err = 'Exception Occurred !!\n';
      err += 'Error :' + ex.getMessage() + ' at line : ' + ex.getLineNumber();
      return err;
    }
  }

  @AuraEnabled
  public static string getCityName(String lat, String longi) {
    try {
      String name;
      Http http = new Http();
      HttpRequest req = new HttpRequest();
      req.setEndpoint(
        'https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=' +
          lat +
          '&longitude=' +
          longi +
          '&localityLanguage=en'
      );
      req.setMethod('GET');
      HttpResponse res = http.send(req);
      JSON2Apex obj = JSON2Apex.parse(res.getBody());
      name = obj.city;
      name = name.replaceAll('[^a-zA-Z0-9\\s+]', '');
      System.debug('obj ::' + obj);
      return getweather(name);
      //return res.getBody();
    } catch (Exception ex) {
      String err = 'Exception Occurred !!\n';
      err += 'Error :' + ex.getMessage() + ' at line : ' + ex.getLineNumber();
      return err;
    }
  }

  @AuraEnabled
  public static string getTime(String lat, String longi) {
    try {
      Http http = new Http();
      HttpRequest req = new HttpRequest();
      req.setEndpoint(
        'https://timeapi.io/api/Time/current/coordinate?latitude=' +
          lat +
          '&longitude=' +
          longi
      );
      req.setMethod('GET');
      HttpResponse res = http.send(req);
      TimeJSON2Apex obj = TimeJSON2Apex.parse(res.getBody());
      //System.debug(res.getBody());
      //System.debug(obj.time_Z + ' ' + getMeridian(obj.time_Z + ':' + obj.seconds));
      return res.getBody()
        .replaceAll(obj.time_Z, getMeridian(obj.time_Z + ':' + obj.seconds));
    } catch (Exception ex) {
      String err = 'Exception Occurred !!\n';
      err += 'Error :' + ex.getMessage() + ' at line : ' + ex.getLineNumber();
      return err;
    }
  }

  public static string getMeridian(String timestr) {
    Integer hour;
    Integer min;
    String sec;
    hour = integer.valueof(timestr.substring(0, 2));
    System.debug(hour);
    min = integer.valueof(timestr.substring(3, 5));
    System.debug(min);
    sec = timestr.substring(6);
    String meridian = hour >= 12 ? '  PM' : '  AM';
    hour = hour > 12 ? hour - 12 : hour;
    timestr = hour < 10 ? '0' + String.valueOf(hour) : String.valueOf(hour);
    timestr = min < 10
      ? timestr + ':0' + String.valueOf(min) + ':' + sec + meridian
      : timestr + ':' + String.valueOf(min) + ':' + sec + meridian;
    return timestr;
  }

  @AuraEnabled
  public static string login2Weather(String username, String password) {
    try {
      String res;
      List<Password__c> pw = [
        SELECT Id, Name, Password__c, UserId__c
        FROM Password__c
        WHERE Name = :username
      ];
      if (pw.size() > 0) {
        for (Password__c p : pw) {
          res = p.Password__c == password ? 'success' : 'error';
        }
        return res;
      } else {
        return 'error';
      }
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
}