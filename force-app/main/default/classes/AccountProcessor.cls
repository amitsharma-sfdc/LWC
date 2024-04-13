public class AccountProcessor {
    
@future
    public static void countContacts(List<Id> listid) {
List<Account> acc=[select Name , (Select LastName from contacts) from Account where id in: listid];
for(Account acct :acc){
acct.Number_of_Contacts__c = acct.contacts.size();
    system.debug(acct.Name + acct.contacts.size());
    acc.add(acct);
    update acc;
}
    }
}