@isTest
public class TestOpportunityChangeTriggerrrr {
    @isTest static void testCreateAndUpdateOpportunity(){
        Opportunity testOpportunity = new Opportunity(
            StageName = 'Prospecting',
            CloseDate = Date.today().addMonths(3),
            Name = 'Sell 100 Widgets');
        insert testOpportunity;
        Test.getEventBus().deliver();
        Opportunity opp = new  Opportunity();
        opp = [Select Id, StageName From Opportunity Where Name = 'Sell 100 Widgets' Limit 1];
        opp.StageName = 'Closed Won';
        update opp;
        Test.getEventBus().deliver();
    }
}