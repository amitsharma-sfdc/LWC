public class TestMAPClass {
    
    public static void assignMAP(){
        List<MAP<ID,String>> maplist = new List<MAP<ID,String>>();
        MAP<ID,String> m1;
        
        List<Account> acclist  = new List<Account>();
        acclist = [Select Id, Name, ShippingState, BillingState from Account Limit 20];
        if(acclist!=null){
            for(Account acc: acclist){
                m1.keySet().add(acc.Id);
                maplist.add(m1);
            }
        }
        //return maplist;
    }
}