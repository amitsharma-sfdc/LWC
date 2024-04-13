public inherited sharing class RetrieveVehicle {
    @AuraEnabled
    public static List<Vehicle__c> getDetails(){
        List<Vehicle__c> lv = RetrieveVehicleHelper.retrieveVehicleDetails();
        return lv;
    }
}