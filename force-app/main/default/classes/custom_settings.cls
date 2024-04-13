public class custom_settings {
    @AuraEnabled
    public static String customlist(){
        CustomSettings_1__c mc = CustomSettings_1__c.getOrgDefaults();
        String fone = mc.Phone__c;
        String nam = mc.Name__c;
        String mail = mc.Email__c;
        return nam;
        
        //List<CustomSettings_1__c> custList = [select id, Name__c, Phone__c from CustomSettings_1__c];  
        //return custList;

    }
    
}