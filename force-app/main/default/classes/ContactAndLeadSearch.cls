/*
 * Trailhead: Apex Basics & Database Write SOQL Queries
 */

public class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(String parameter)
    {
        List<List<SObject>> searchfild = [FIND :parameter IN ALL FIELDS RETURNING Contact(FirstName, LastName), Lead(FirstName, LastName)];
        return searchfild;
    }
}