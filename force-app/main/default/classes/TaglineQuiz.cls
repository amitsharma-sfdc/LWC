public class TaglineQuiz {
    
    @AuraEnabled
    public static List<Quiz__c> getListSettings(){
        List<Quiz__c> qList = new List<Quiz__c>();
        qList = Quiz__c.getall().values();
        return qList;
    }
   
    @AuraEnabled
    public static Integer saveAnswer(String ans, Integer qno, String qustn){
        Quiz_Answers__c QuizAn = new Quiz_Answers__c();
        //QuizAn = [Select Id, Name FROM Quiz_Answers__c WHERE Name = :'Quiz No.'+ qno];
        QuizAn.Name = 'Question No.'+ qno;
        QuizAn.Answer__c = ans;
        QuizAn.Question__c = qustn;
        insert QuizAn;
		return (qno*100/11);
    }

    @AuraEnabled
    public static Integer score(List<String>an_list, List<String>crctans){
        Integer score = 0;
        Integer i;
        for(i = 1 ; i < crctans.size() ; i++)
        {
            if(an_list.get(i) == crctans.get(i))
            {
                score++;
            }
        }
        
        return (score*100/12);
    }
    
    @AuraEnabled    
    public static String cancel(String cncl){
        
        return cncl;
    }
    
    @AuraEnabled
    public static String showresult(List<String>an_list, Integer num){
        
        
        return 'result';
    }
}