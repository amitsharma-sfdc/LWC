public class UpdateOpportunity {
    public static void checkOpportunityStage(List<Opportunity> opportunityList){
        if(opportunityList.size()>0){
            List<Task> taskList=new List<Task>();
            for(Opportunity op : opportunityList){
                if(op.StageName == 'Closed Won'){
                    Task task1=new Task();
                    task1.Subject='Follow Up Test Task';
                    task1.WhatId=op.Id;
                    taskList.add(task1);                      
                }
            }
            if(taskList.size()>0){
                insert taskList;
            }
        }
    }
}