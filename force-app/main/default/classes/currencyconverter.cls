//This is Apex Callout which calls an external system from Salesforce org//
//From SFDC	-->>	To	-->>  External System (Apex Callout)
public class currencyconverter {
    
    @AuraEnabled
    public static Decimal convertcurrencytoINR(Decimal eur)
    {
        Decimal inr = 0.0;
        HTTP http = new HTTP();
        HTTPRequest req = new HTTPRequest(); // All the information that you want to pass out to an external system is gonna save in this method
        req.setEndpoint('https://api.exchangeratesapi.io/latest');
        req.setMethod('GET');
        HTTPResponse res = http.send(req);
        Map<String,object> jsonbody = (Map<String,object>)Json.deserializeUntyped(res.getBody());
        System.debug(jsonBody);
        Map<String,object> nMap = (Map<String,object>)jsonBody.get('rates');
        Decimal conversionRate = (Decimal) nMap.get('USD');
        inr = eur*conversionRate;
        return inr;
    }

}