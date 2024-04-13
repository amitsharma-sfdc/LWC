global class sObjectUpdateBatch implements Database.Batchable<sObject>,Database.Stateful,Schedulable
{   
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
        strList.add('SELECT Id,CaseNumber,Description,AccountId,ContactId FROM Case where AccountId = \'\' Or ContactId = \'\'');
        strList.add('SELECT Id,FirstName,LastName,Phone,Email,AccountId FROM Contact where Email = \'\' OR Phone = \'\' OR AccountId = \'\'');
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
                    a.Type = a.Type == null || a.Type == ''?'Technology Partner':a.Type;
                    a.AnnualRevenue = a.AnnualRevenue == null ? 1000 :a.AnnualRevenue;
                    a.Phone = a.Phone == null || a.Phone == ''?'09921343385':a.Phone;
                    a.NumberofLocations__c = a.NumberofLocations__c == null ? 100:a.NumberofLocations__c;
                    a.Number_of_Contacts__c = a.Number_of_Contacts__c == null ? a.Contacts.size(): a.Number_of_Contacts__c;
                    a.Industry = a.Industry == null || a.Industry == '' ? 'Batch Update' : a.Industry;
                    a.Rating = a.Rating == null || a.Rating == '' ? 'Hot' : a.Rating;
                    a.SIC = a.SIC == null || a.Rating == '' ? 'SIC'+ a.AccountNumber : a.SIC;
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
                    c.AccountId = c.AccountId == null ? DefaultAccount : c.AccountId;
                    c.ContactId = c.ContactId == null ? DefaultContact : c.ContactId;
                }
                Database.SaveResult[] sr = Database.update(csList, false);
                for(Database.SaveResult s: sr){
                    if (s.isSuccess()) {
                        System.debug(LoggingLevel.INFO,'isSuccess-Case');
                        csListSize++;
                    }
                    else {
                        System.debug(LoggingLevel.INFO,'isError-Case');
                        List<Database.Error> err = s.getErrors();
                        errorMessage = errorMessage + 'ERROR while Updating Case!-' + err[0].getMessage()+'\n';
                    }
                }
            }
            if(cntList.size() > 0){
                for(Contact c:cntList){
                    c.Email = c.Email == null || c.Email == '' ? 'batchupdate@sfdc.com' : c.Email;
                    c.Phone = c.Phone == null || c.Phone == ''? '0123456789' : c.Phone;
                    c.AccountId = c.AccountId == null ? DefaultAccount : c.AccountId;
                }
                Database.SaveResult[] sr = Database.update(cntList, false);
                for(Database.SaveResult s: sr){
                    if (s.isSuccess()) {
                        System.debug(LoggingLevel.INFO,'isSuccess-Contact');
                        cntListSize++;
                    }
                    else {
                        System.debug(LoggingLevel.INFO,'isError-Contact');
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
        sObjectUpdateBatch b = new sObjectUpdateBatch();
        Database.executeBatch(b);
    }
}