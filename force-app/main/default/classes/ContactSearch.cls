/*
* Trailhead: Apex Basics & Database Write SOQL Queries
*/


public class ContactSearch {
    	public Static List<Contact> searchForContacts(String lastname, String postalcode){
        List<Contact> cntlist = new List<Contact>();
        cntlist = [Select Id, LastName, MailingPostalCode From Contact where LastName =: lastname and MailingPostalCode =: postalcode];
        return cntlist;
    }
}