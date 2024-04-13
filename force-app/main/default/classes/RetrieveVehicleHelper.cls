public with sharing class RetrieveVehicleHelper {
    @AuraEnabled
    public static List<Vehicle__c> retrieveVehicleDetails() {
        List<Vehicle__c> vlist = [
            SELECT Id, Name, Model__c, Power__c, VIN_Number__c
            FROM Vehicle__c
            WITH SECURITY_ENFORCED
        ];
        return vlist;
    }
}