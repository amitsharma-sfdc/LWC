public class notification 
{
    public static void createcon(List<Contact> conlist)  
    {
            Messaging.PushNotification msg = new Messaging.PushNotification();
            string msgs =  'One new contact has been created';
            String userId1 = '2F0052v00000cbJmb';  
            Set<String> users = new Set<String>();
            users.add(userId1);
            msg.send(msgs,users);
    }
}