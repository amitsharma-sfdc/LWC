@IsTest
public class AccountProcessorTest {
    public static testmethod void TestAccountProcessorTest() 
    {
Account a = new Account();
        //Account ac = [Select Id, Name from Account where Id = : AccountId];
a.Name = 'Test Account';
Insert a;
Contact cont = New Contact();
cont.FirstName ='Bob';
cont.LastName ='Masters';
cont.AccountId = a.Id;
Insert cont;
                                               
List<Id> AccId = new list<ID>();
AccId.add(a.id);

 
        Test.startTest();
            AccountProcessor.countContacts(AccId);
        Test.stopTest();
        
        //Account ACC = [select Number_of_Contacts__c from Account where id = :a.id LIMIT 1];
        //System.assertEquals ( Integer.valueOf(ACC.Number_of_Contacts__c) ,1);
  }
  
}