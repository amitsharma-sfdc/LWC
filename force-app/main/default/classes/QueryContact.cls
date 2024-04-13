public class QueryContact {
    public static Id getContactId(String lastName, String title){ 
        try {
            Contact cn  = [Select Id, LastName, Title from Contact where LastName =: lastName and Title =: title Limit 1];
            return cn.Id;
        } catch (Exception ex) {
            System.debug('Error>>>>::'+ex.getLineNumber());
            return null;
        }
    }
    public static Id getContactIDWithBinds(Map<String, Object> bindVars) {
        try{
            String query = 'SELECT ID FROM CONTACT WHERE LastName =: lastName AND Title =: title LIMIT l';
            List<Contact> contacts = Database.queryWithBinds(query, bindVars, AccessLevel.USER_MODE); //[SELECT ID FROM CONTACT WHERE LastName =: lastname AND Title =: title];
            System.debug(contacts);
            if (contacts.size() > 0){
                return contacts[0].Id;
            }else{
                return null;
            }
        }catch(Exception ex){
            System.debug('Error>>>>::'+ex.getLineNumber());
            String lastname =  bindVars.get('lastName').toString();
            String title =  bindVars.get('title').toString();
            List<Contact> contacts = [SELECT ID FROM CONTACT WHERE LastName =: lastname AND Title =: title];
            return contacts[0].Id;
        }
    }
}