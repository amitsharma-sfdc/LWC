public class accessAmitSharmaOrgJWT {
    
    public static String getAccessToken(){
        credentials__c cr = credentials__c.getValues('accessAmitSharmaOrgJWT');
        Auth.JWT jwt = new Auth.JWT();
        jwt.setSub(cr.userName__c);
        jwt.setAud(cr.url__c); 
        jwt.setIss(cr.consumerKey__c);
        
        //Create the object that signs the JWT bearer token
        Auth.JWS jws = new Auth.JWS(jwt,'salesforcetest');
        //String token = jws.getCompactSerialization();
        String tokenEndpoint ='https://login.salesforce.com/services/oauth2/token';
        
        Auth.JWTBearerTokenExchange bearer = new Auth.JWTBearerTokenExchange(tokenEndpoint, jws);
        String accessToken = bearer.getAccessToken();
        return accessToken;
    }
    
    public static String updateCase(){
        Map<String,String> payload = new Map<String,String>();
        String jsonMap;
        payload.put('CaseNumber','00001026');
        payload.put('Status','New');
        payload.put('Description','REST API');
        payload.put('Type','Structural');
        payload.put('Origin','Web');
        jsonMap = JSON.serialize(payload);
        Http http = new Http();
        HttpRequest httpReq = new  HttpRequest();
        httpReq.setEndpoint( 'https://amitsharma-dev-ed.develop.my.salesforce.com/services/apexrest/getAccount/');
        httpReq.setMethod( 'POST' );
        httpReq.setHeader( 'Content-Type', 'application/json' );
        httpReq.setHeader( 'Accept', 'application/json' );
        httpReq.setHeader( 'Authorization', 'Bearer ' + getAccessToken());
        httpReq.setBody(jsonMap);
        HttpResponse httpRes = http.send( httpReq );
        System.debug('Account ******'+httpRes.getBody());
        return httpRes.getBody();
    }
}