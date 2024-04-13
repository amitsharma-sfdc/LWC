public Interface TriggerInterface {
    void beforeInsert(List<sObject> newRecordList);
    void beforeUpdate(Map<Id,sObject> newRecordMap, Map<Id,sObject> oldRecordMap);
    void afterInsert(List<sObject> newRecordList, Map<Id,sObject> newRecordMap);
    void afterUpdate(Map<Id,sObject> newRecordMap, Map<Id,sObject> oldRecordMap);
    void beforeDelete(List<sObject> oldRecordList, Map<Id,sObject> oldRecordMap);
    void afterDelete(Map<Id,sObject> oldRecordMap);
    void afterUndelete(List<sObject> newRecordList, Map<Id,sObject> newRecordMap);
}