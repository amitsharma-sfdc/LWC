@IsTest
private class AccountManagerTest {
    @isTest static void testGetCaseById() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri = 'https://shoppingwb-dev-ed.my.salesforce.com/services/apexrest/Accounts/'+ recordId +'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        // Verify results
        System.assert(thisAccount != null);
        System.assertEquals('Test record', thisAccount.Name);
    }
    static Id createTestRecord() {
        // Create test record
        Account AccountTest = new Account(Name='Test record');
        insert AccountTest;
        Contact ContactTest = new Contact(LastName = 'TestContact', AccountId = AccountTest.Id);
            insert ContactTest;
        return AccountTest.Id;
    }   
}