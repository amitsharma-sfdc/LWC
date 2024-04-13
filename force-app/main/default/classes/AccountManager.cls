@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String accountId = request.requestURI.substringBetween('Accounts/','/contacts');
        Account acc =  [SELECT Id, Name,(Select Id, Name From Contacts) FROM Account  WHERE Id = :accountId Limit 1];
        return acc;
    }
}