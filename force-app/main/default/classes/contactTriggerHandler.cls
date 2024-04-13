public class contactTriggerHandler implements TriggerInterface {
    public static void beforeInsert(List<sObject> newRecordList){
        contactTriggerHelper.updateDescription(newRecordList);
    }
    public static void beforeUpdate(Map<Id,sObject> newRecordMap, Map<Id,sObject> oldRecordMap){
    }
    public static void afterInsert(List<sObject> newRecordList, Map<Id,sObject> newRecordMap){
    }
    public static void afterUpdate(Map<Id,sObject> newRecordMap, Map<Id,sObject> oldRecordMap){
    }
    public static void beforeDelete(List<sObject> oldRecordList, Map<Id,sObject> oldRecordMap){
    }
    public static void afterDelete(Map<Id,sObject> oldRecordMap){
    }
    public static void afterUndelete(List<sObject> newRecordList, Map<Id,sObject> newRecordMap){
    }
}