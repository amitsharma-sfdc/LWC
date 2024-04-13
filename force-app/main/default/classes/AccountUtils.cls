public class AccountUtils {
    
    public static List<Account> accountsByState(string state)
    {
        List<Account> acclist = new List<Account>();
        acclist = [SELECT Id,Name FROM Account where BillingState=: state];
        return acclist;
    }
}