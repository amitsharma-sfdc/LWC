@RestResource(urlMapping='/apexSecurityRest')
global with sharing class ApexSecurityRest {
    @HttpGet
    global static Contact doGet() {
        Contact result;
         Id recordId = RestContext.request.params.get('id');
    
          List<Contact> results = [SELECT id, Name, Title, Top_Secret__c, Account.Name FROM Contact WHERE Id = :recordId];
          SObjectAccessDecision securityDecision = Security.stripInaccessible(AccessType.READABLE, results);
          
           SObjectAccessDecision securityDecision2 =
       Security.stripInaccessible(AccessType.UPDATABLE,
             [SELECT Description FROM Contact]
             );
             result.Description = result.Account?.Name;

           return result;
      }
      public class FunctionalException extends Exception{}
      public class SecurityException extends Exception{}
}