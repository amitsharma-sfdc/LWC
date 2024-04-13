public class WeatherForecast {
//This is Apex Callout which calls an external system from Salesforce org//
//From SFDC	-->>	To	-->>  External System (Apex Callout)  
    @AuraEnabled
    public static List<String> getweatherreport(String city_name)
    {
        List<String> weatherReport = new List<String>();
        String city, temp, hummidity, pressure, temp_min, temp_max;
        HTTP http = new HTTP();
        HTTPRequest req = new HTTPRequest(); // All the information that you want to pass out to an external system is gonna save in this method
        //req.setEndpoint('https://api.openweathermap.org/data/2.5/find?q=London&units=metric&appid=4bce304d8b00161a0b741a5a9b6f94bf');
        req.setEndpoint('https://api.openweathermap.org/data/2.5/weather?q='+city_name+'&units=metric&appid=4bce304d8b00161a0b741a5a9b6f94bf');
        req.setMethod('GET');
        HTTPResponse res = http.send(req);
        Map<String,object> jsonbody = (Map<String,object>)Json.deserializeUntyped(res.getBody());
        city = String.valueof(jsonbody.get('name'));
        Map<String,object> mainjsonbody = (Map<String,object>)(jsonbody.get('main'));
        weatherReport.add(String.valueof(jsonbody.get('name')));
        weatherReport.add(String.valueof(mainjsonbody.get('temp')));
        weatherReport.add(String.valueof(mainjsonbody.get('humidity')));
        weatherReport.add(String.valueof(mainjsonbody.get('pressure')));
        weatherReport.add(String.valueof(mainjsonbody.get('temp_min')));
        weatherReport.add(String.valueof(mainjsonbody.get('temp_max')));
        System.debug(mainjsonbody);
        return weatherReport;
}
}