public with sharing class TestScript {
    @RemoteAction
    public static String takeCare(){
        String retr;
        List<Account> accList = new List<Account>();
        accList = [Select Id, Name, BillingState from Account where BillingState != Null];
        List<Contact> cntctList = new List<Contact>();
        cntctList = [Select Id, Name, AccountId, Phone,Employee_Name__c from Contact where AccountId In: accList];
        for(Contact cnt: cntctList)
        {
            cnt.AccountWithBS__c = 'Yes';
        }
        Database.SaveResult[] srList = Database.update(cntctList, false);
        for (Database.SaveResult sr : srList) {
            if (sr.isSuccess()) {
                return sr.getId();
            }
            else {
                // Operation failed, so get all errors                
                for(Database.Error err : sr.getErrors()) {
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Account fields that affected this error: ' + err.getFields());
                    retr = err.getMessage();
                }
            }
        }return retr;
    }   
}