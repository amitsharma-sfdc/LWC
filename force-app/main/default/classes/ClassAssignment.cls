public class ClassAssignment {
    
    public static void createacc(String LName, String accname)
    {
        Account acc = new Account(Name = accname);
        Contact cnt = new Contact(LastName = LName);
        cnt.AccountId = acc.Id;
        insert acc;
        insert cnt;
        system.debug('success. account created was: '+acc);
        system.debug('success, contact created was : '+cnt);
        
    }

}