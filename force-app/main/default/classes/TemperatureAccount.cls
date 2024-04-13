public class TemperatureAccount {
    
    // Takes a Fahrenheit temperature and returns the Celsius equivalent.
    public static Decimal FahrenheitToCelsius(Decimal fh) {
        Decimal cs = (fh - 32) * 5/9;
        cs = cs*checkAccount('West Bengal');
        System.debug(cs);
        return cs.setScale(2);
    }
    
    public static integer checkAccount(String BState)
    {
        Integer accno;
        accno = [Select Count() from Account where BillingState =: BState];
        return accno;
    }
}