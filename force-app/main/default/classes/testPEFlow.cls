public class testPEFlow {

    @InvocableMethod(label='Test PE Flow')
    public Static List<String> updateCase(List<String> caseId){
        List<String> retresult = new List<String>();
        Case c = [Select Id, CaseNumber, Description from Case where Id =: caseId[0]];
        c.Description = caseId[0];
        Database.SaveResult sr = Database.update(c, false);
                    if (sr.isSuccess()) {
                        System.debug('**Success**'+c);
                        retresult.add('Success');
                    } else {
                        System.debug('**Error**');
                        List<Database.Error> err = sr.getErrors();
                        retresult.add('ERROR!-' + err[0].getMessage());
                    }
        return retresult;
    }
}