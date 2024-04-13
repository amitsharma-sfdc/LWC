public class contactTriggerHelper {
    
    public static void updateDescription(List<Contact> newContactList){
        for(Contact c:newContactList){
            c.Description = String.isBlank(c.Description) ? 'Updated from TriggerHandler': c.Description;
        }
    }
}