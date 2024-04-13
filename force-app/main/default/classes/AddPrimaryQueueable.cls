public class AddPrimaryQueueable implements Queueable {
    Private Contact c;
    Private String s;
    public AddPrimaryQueueable(Contact con, String state){
        System.debug('In constructor1'+c);
        System.debug('In constructor1'+s);
        c = con;
        s = state;
        System.debug('In constructor'+c);
        System.debug('In constructor'+s);
    }
    public void execute(QueueableContext context) {
        
        System.debug('Inside execute, Contact'+c);
        System.debug('Inside execute, State'+s);
    }
}