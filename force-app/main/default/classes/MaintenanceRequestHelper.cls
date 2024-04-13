public with sharing class MaintenanceRequestHelper {
    
    public static void updateWorkOrders(List<case> ClosedCaseList){
        // update workorders
        
        List<Case> insertCaseList = New List<Case>();
        
        for(Case c : ClosedCaseList)
            
        {
            Case newCase = new Case();
            newCase.Type = 'Routine Maintenance';
            newCase.Status = 'New';
            newCase.Vehicle__c = c.Vehicle__c;
            newCase.Subject =  c.Subject;
            newCase.Date_Reported__c = Date.today();
            newCase.Date_Due__c = Date.today();
            //newCase.Origin = c.Origin;
            //newCase.Equipment__c = c.Equipment__c;
            insertCaseList.add(newCase);
        }
        
        if(insertCaseList.size() > 0){
            insert insertCaseList;
        }
    }  
}