public class ParkLocator {
    
    public static List<String> country(String cntry)
    {
        ParkService.ParksImplPort park = new  ParkService.ParksImplPort();
        List<String> parklist = park.byCountry(cntry);
        return parklist;
    }
}