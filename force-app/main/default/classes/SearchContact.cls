public class SearchContact {
    
    public void search_contact()
    {
        List<Contact> cntctList = new List<Contact>();
        cntctList = [Select Id, Name, Email, Account.Name From Contact where Account.Name ='Technologies'];
        
        for(Contact con: cntctList)
        {
            con.Fax = '1234567890';
            cntctList.add(con);
        }
        update cntctList;
    }

}