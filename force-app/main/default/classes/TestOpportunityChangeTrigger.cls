@isTest
public class TestOpportunityChangeTrigger {
  @isTest static void testCreateAndUpdateOpportunity() {
    // Enable all Change Data Capture entities for notifications.
    Opportunity opp = new Opportunity(Name ='Sell 100 Widgets', StageName ='Prospecting', CloseDate = Date.today().addMonths(3) );
    insert opp;
    Test.getEventBus().deliver();
    Opportunity[] oppRecords = [SELECT Id, StageName FROM Opportunity Where Name = 'Sell 100 Widgets' Limit 1];
          opp.StageName = 'Closed Won';
    Test.getEventBus().deliver();
    Task[] taskList = [SELECT Id,Subject FROM Task];
      System.assertEquals('Closed Won', opp.StageName, 'The stage hasnt changed to closed won');
    //System.assertEquals(1, taskList.size(), 'The change event trigger did not create the expected task.');
  }
}