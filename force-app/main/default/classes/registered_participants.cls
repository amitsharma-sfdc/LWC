public with sharing class registered_participants{
    @AuraEnabled
    public static List<Contact> getContacts() {
        List <Contact> conList = [SELECT Employee_ID__c,LastName FROM Contact WHERE Employee_ID__c != NULL ];
        return conList;
    }
}