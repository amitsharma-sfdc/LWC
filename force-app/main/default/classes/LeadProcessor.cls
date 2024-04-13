/*This is an Apex class that implements the Database.
 * Batchable interface to update all Lead records 
 * in the org with a specific LeadSource.*/


global class LeadProcessor implements Database.Batchable<sObject>
{
/*************************************************** Start*********************************************/
    global Database.QueryLocator start(Database.BatchableContext bc) 
    {
        return Database.getQueryLocator([Select LeadSource From Lead ]);
    }
      
/*************************************************** Execute *****************************************/        

    global void execute(Database.BatchableContext bc, List<Lead> scope)
    {
        List<Account> acc = new List<Account>();
        List<Lead> leadd = new List<Lead>();
    
        for (Lead ld : leadd){
                    ld.LeadSource = 'Dreamforce';
        Leadd.add(ld);
                    }


update leadd;
    	}
/************************************************** Finish *******************************************/ 
    
    global void finish(Database.BatchableContext bc)
    {
        Integer i;
        i = i+1;
    } 
    

}