public class accountTriggerHelper {
    
    public static void updateSLASerialNumber(List<Account> newAccountList){
        for(Account acc:newAccountList){
            acc.SLASerialNumber__c = String.isBlank(acc.SLASerialNumber__c) ? 'ABCDEFGHIJ': acc.SLASerialNumber__c;
        }
    }
}