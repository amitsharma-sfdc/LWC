public class userClass {
    @RemoteAction
    public static JSON2Apex save(String input){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        //req.setEndpoint('https://gorest.co.in/public/v2/users/'+input);
        req.setEndpoint('https://api.cricapi.com/v1/matches?apikey=2d1fede3-c70f-4e5e-9554-68ce2b65546e&offset=0');
        req.setMethod('GET');
        HttpResponse res = h.send(req);
        System.debug(res.getStatusCode()+' :: '+res.getBody());
        JSON2Apex obj = JSON2Apex.parse(res.getBody());
        System.debug('obj '+obj);
        return obj;
    }
}