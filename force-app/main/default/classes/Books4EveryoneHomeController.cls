public with sharing class Books4EveryoneHomeController 
{
@AuraEnabled
public static List<Recommendation__c> getBookRecommendations(){
return [SELECT Name, Review__c, Rating__c, Book__r.Name, Book__r.Author__r.Name FROM Recommendation__c WHERE Book__c != null];
}     
}