global class sObjectUpdateBatch_2 implements Database.Batchable<sObject>,Database.Stateful,Schedulable
{   
    global Static String DefaultAccount = '0012v00003ap1JKAAY';
    global Static String DefaultContact = '0032v00003whQagAAE';
    global List<Account> accList = new List<Account>();
    global List<Contact> cntList = new List<Contact>();
    global List<Case> csList = new List<Case>();
    global String errorMessage = '';
    global Integer accListSize = 0;
    global Integer cntListSize = 0;
    global Integer csListSize = 0;
    global List<sObject> start(Database.BatchableContext BC)
    {
        List<sObject> sObjList = new List<sObject>(); 
        List<String> strList = new List<String>();
        strList.add('SELECT Id,CaseNumber,Description,AccountId,ContactId FROM Case where AccountId =: DefaultAccount Or ContactId =: DefaultContact');
        strList.add('SELECT Id,FirstName,LastName,Phone,Email,AccountId FROM Contact where Email = \'batchupdate@sfdc.com\' OR Phone =\'0123456789\' OR AccountId =: DefaultAccount');
        strList.add('Select Id,Name,Type,AnnualRevenue,Phone,AccountNumber,NumberofLocations__c,Number_of_Contacts__c,Industry,Rating,Sic,(Select Id from Contacts) from Account');
        
        for(String str:strList){
            for(sObject sOb:Database.Query(str)){
                sObjList.add(sOb); 
            }
        }
        return sObjList;
    }
    global void execute(Database.BatchableContext BC, List<sObject> sObjList)
    {
        try{
            String DefaultAccount = '0012v00003ap1JKAAY';
            String DefaultContact = '0032v00003whQagAAE';
            
            Schema.SObjectType accExpected = Schema.Account.getSObjectType();
            Schema.SObjectType cntExpected = Schema.Contact.getSObjectType();
            Schema.SObjectType csExpected = Schema.Case.getSObjectType();
            for(SObject sob : sObjList){
                Object filter = sob.getSObjectType() == accExpected ? accList.add((Account)sob):sob.getSObjectType() == cntExpected ? cntList.add((Contact)sob) : csList.add((Case)sob);
            }
            if(accList.size()>0){
                for(Account a:accList){
                    a.Type = a.Type != null || a.Type != ''?'': a.Type;
                    a.AnnualRevenue = a.AnnualRevenue != null ? null :a.AnnualRevenue;
                    a.Phone = a.Phone != null || a.Phone != ''?'':a.Phone;
                    a.NumberofLocations__c = a.NumberofLocations__c != null ? null:a.NumberofLocations__c;
                    a.Number_of_Contacts__c = a.Number_of_Contacts__c != null ? null: a.Number_of_Contacts__c;
                    a.Industry = a.Industry != null || a.Industry != '' ? '' : a.Industry;
                    a.Rating = a.Rating != null || a.Rating != '' ? '' : a.Rating;
                    a.SIC = a.SIC != null || a.Rating != '' ? '' : a.SIC;
                }
                Database.SaveResult[] sr = Database.update(accList, false);
                for(Database.SaveResult s: sr){
                    if (s.isSuccess()) {
                        System.debug(LoggingLevel.INFO,'isSuccess-Account');
                        accListSize++;
                    }
                    else {
                        System.debug(LoggingLevel.INFO,'isError-Account');
                        List<Database.Error> err = s.getErrors();
                        errorMessage = errorMessage + 'ERROR while Updating Account!-' + err[0].getMessage()+'\n';
                    }
                }
            }
            if(csList.size()>0){
                for(Case c:csList){
                    c.AccountId = c.AccountId == DefaultAccount ? null : c.AccountId;
                    c.ContactId = c.ContactId == DefaultContact ? null : c.ContactId;
                }
                Database.SaveResult[] sr = Database.update(csList, false);
                for(Database.SaveResult s: sr){
                    if (s.isSuccess()) {
                        csListSize++;
                        System.debug(LoggingLevel.INFO,csListSize);
                    }
                    else {
                        List<Database.Error> err = s.getErrors();
                        errorMessage = errorMessage + 'ERROR while Updating Case!-' + err[0].getMessage()+'\n';
                    }
                }
            }
            if(cntList.size() > 0){
                for(Contact c:cntList){
                    c.Email = c.Email == 'batchupdate@sfdc.com'? '' : c.Email;
                    c.Phone = c.Phone == '0123456789'? '' : c.Phone;
                    c.AccountId = c.AccountId == DefaultAccount ? null : c.AccountId;
                }
                Database.SaveResult[] sr = Database.update(cntList, false);
                for(Database.SaveResult s: sr){
                    if (s.isSuccess()) {
                        cntListSize++;
                        System.debug(LoggingLevel.INFO,cntListSize);
                    }
                    else {
                        List<Database.Error> err = s.getErrors();
                        errorMessage = errorMessage + 'ERROR while Updating Contact!-' + err[0].getMessage()+'\n';
                    }
                }
            }
        }catch(Exception e){
            errorMessage = errorMessage + 'Error :'+e.getMessage()+' At :>'+e.getLineNumber()+'\n';
            System.debug(LoggingLevel.INFO,'Error At :>'+e.getLineNumber());
        }
    }
    global void finish(Database.BatchableContext BC) {
        String msg = 'Batch Process Completed.\n'+
            'Accounts Updated = '+accListsize+'\n'+
            'Contacts Updated = '+cntListsize+'\n'+
            'Case Updated = '+csListsize;
        System.debug(LoggingLevel.INFO,'***cntListsize***'+cntListsize);
        System.debug(LoggingLevel.INFO,'***csListsize***'+csListsize);
        sendEmail(String.isNotBlank(errorMessage) ? errorMessage : msg);
    }
    global void sendEmail(String mssg){
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] {'amit.sharma49@ibm.com'};
            message.optOutPolicy = 'FILTER';
        message.subject = 'Batch Run';
        message.plainTextBody = mssg;
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);        
    }
    global void execute(SchedulableContext sc){
        sObjectUpdateBatch_2 b = new sObjectUpdateBatch_2();
        Database.executeBatch(b);
    }
}