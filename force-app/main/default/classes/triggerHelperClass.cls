public class triggerHelperClass {
    public static void doupate(List<Special_Price_Quote__c> newSpList){
        for(Special_Price_Quote__c sp : newSpList)
        {
            if(sp.Total_Quote_Amount__c < 30000)
            {
                sp.Total_Quote_Amount__c = 150;
            }
            else
            {
                
                sp.Second_Approver__c = 'Amit';
                system.debug('second approver is------'+sp.Second_Approver__c);
                //spqLstToUpdate.add(sp);
            }
        }
    }
}