/*This is an Apex Test class for LeadProcessor Apex that implements the Database.
 * Batchable interface to update all Lead records 
 * in the org with a specific LeadSource.*/
/*****************************  This is a Test code for Testing a batch Apex **************/

@isTest
public class LeadProcessorTest {
    static testMethod void LeadtestMethod()
 {
        List<Lead> lld = new List<Lead>();
    
    for(Integer i=1;i<=200;i++)
    {
        Lead ld = new Lead();
        ld.FirstName ='FirstName';
        ld.LastName ='LastName'+i;
        ld.Company ='Code'+i;
        lld.add(ld);
    } insert lld;
      
        Test.startTest();
    LeadProcessor lp = new LeadProcessor();
   Database.executeBatch(lp);
    Test.stopTest();

}
}