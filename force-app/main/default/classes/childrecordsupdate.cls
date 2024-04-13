global class childrecordsupdate implements Database.Batchable<sObject>, Database.Stateful{

    global Integer recordsupdated = 0;
    global Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator('SELECT ID, BillingStreet, BillingCity, BillingState, BillingPostalCode, FROM Account Where BillingCountry = '+
            '\'India\'');

    }
    global void execute(Database.BatchableContext bc, List<Account> acclist){
        
        List<Contact> cntcts = new List<Contact>();
        for (Account acc : acclist) 
            {
                Contact ct = new Contact();
                ct.MailingStreet = acc.BillingStreet;
                ct.MailingCity = acc.BillingCity;
                ct.MailingState = acc.BillingState;
                ct.MailingPostalCode = acc.BillingPostalCode;
                ct.Description = 'All the Child records has been updated with the new address. Total no. of child records updated =' +recordsupdated;
                cntcts.add(ct); // add contact to list to be updated
                recordsupdated++; 
            }
        update cntcts;
        }
       
      
    
    global void finish(Database.BatchableContext bc)
			{
//AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,  JobItemsProcessed,TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id = :bc.getJobId()];
//Account.Description = 'All the Child records has been updated with the new address. Total no. of child records updated =' + recordsupdated);
			}
}