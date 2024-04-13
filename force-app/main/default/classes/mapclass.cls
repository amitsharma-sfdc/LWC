public class mapclass {
    
    public static void twoobj()
    {
        List<Account> acclist =  new List<Account>();
        List<Contact> cntlist =  new List<Contact>();
        
        Map<String, sObject> mapobj =  new Map<String, sObject>();
        
        Account myAcct = new Account();                       
        Map<Integer, Account> mA = new Map<Integer, Account>(); 
        Map<Integer, Contact> mC = new Map<Integer, Contact>();
        Integer i = 0;
        for(Account acc : acclist)
        {
            mA.put(i, acc);
            acclist.add(acc);
            i++;
        }insert acclist;i = 0;
        for(Contact cntct : cntlist)
        {
            mC.put(i, cntct);
            cntlist.add(cntct);
            i++;
        }insert cntlist;
        
        System.debug('Mapping Account is---------------------------'+mA);
        System.debug('Mapping Contact is---------------------------'+mC);
        //Set<Integer> s = m.keySet();        
    }
}