public class Calloutcontroller {

public List<consolewrap> ConsoleWrapperList{get;set;}

public Static String getperformcallout(){

//ConsoleWrapperList = new List<consolewrap>();
    
String retResult;

HttpRequest req = new HttpRequest();

HttpResponse res = new HttpResponse();

Http http = new Http();

req.setEndpoint('http://universities.hipolabs.com/search?country=United+States');

req.setMethod('GET');

res = http.send(req);

if(res.getstatusCode() == 200 && res.getbody() != null){

//ConsoleWrapperList=(List<consolewrap>)json.deserialize(res.getbody(),List<consolewrap>.class);

retResult = (String)json.deserialize(res.getbody(),String.class);
    
}

return retResult;

}

}