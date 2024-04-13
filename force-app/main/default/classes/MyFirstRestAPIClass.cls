@RestResource(urlMapping='/getAccount/*')
global with sharing class MyFirstRestAPIClass
{
    @HttpGet
    global static Account doGet() 
    {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        //String AccNumber = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        res.addHeader('Content-Type', 'application/json');
        String accountid = req.params.get('account_id');
        Account result = [SELECT Id, Name, Phone, Website FROM Account WHERE Id = :accountid ];
        return result;
    }

    @HttpDelete
    global static void doDelete() 
    {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String AccNumber = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Id, Name, Phone, Website FROM Account WHERE AccountNumber = :AccNumber ];
        delete result;
    }

    /*@HttpPost
    global static String doPost(String Id,String Name,String Description,String Site) 
    {
        Account acc = new Account();//[Select Id,Name,Description,Site from Account where Id =:Id];
        acc.Name = Name;
        acc.Description = Description;
        acc.Site = Site;
        insert acc;
        return acc.Id;
    }*/
    @HttpPost
    global static String doPost(String CaseNumber,String Status,String Description,String Type,String Origin) 
    {
        Case c = [Select CaseNumber,Status,Description,Type,Origin from Case where CaseNumber =:CaseNumber];
        c.Status = Status;
        c.Description = Description;
        c.Type = Type;
        c.Origin = Origin;
        update c;
        return 'update successful';
    }

}