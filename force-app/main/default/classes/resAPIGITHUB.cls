public class resAPIGITHUB {
    public restAPIIntegration__mdt ghI {set;get;}
    public String ClientID {set;get;}
    public String ClientSecret {set;get;}
    public String code {set;get;}
    
    public resAPIGITHUB(){
        ghI = [Select Id,MasterLabel,callback_URL__c,Client_ID__c,Client_Secret__c,code__c from restAPIIntegration__mdt where MasterLabel = 'gitHubIntegration']; 
        ClientID = ghI.Client_ID__c;
        ClientSecret = ghI.Client_Secret__c;
    }
    
    public Static String getResult(){
        String callbackurl = 'https://ap46.salesforce.com/apex/getCode';
        String url = 'https://developer.api.autodesk.com/authentication/v2/authorize?response_type=id_token&client_id=4BFUNaXkJVGclj3fwzR5Fc5A1ZzTnAZV&redirect_uri='+callbackurl+'&state=Amit';
        /*PageReference p = new PageReference(url);
        p.setRedirect(true);
        return p;*/
        
        HTTP http = new HTTP();
        HTTPRequest req = new HTTPRequest(); 
        req.setEndpoint(url);
        req.setMethod('GET');
        HTTPResponse res = http.send(req);
        return res.getBody();
    }
    
    public void getToken(){
        code = ApexPages.currentPage().getParameters().get('code');
    }
    
    
}