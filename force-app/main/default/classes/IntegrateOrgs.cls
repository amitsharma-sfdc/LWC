@RestResource(urlMapping='/conectOrg/')
global class IntegrateOrgs {
    @HttpPost
    global static String doPost(String name, String email) {
		Savepoint sp = Database.setSavepoint();
        
        try {
			Account acc = new Account();
            acc.Name = name;
            insert acc;
            return 'Account Created Successfully. Account Id : '+acc.Id;
        } catch (Exception e) {
            Database.rollback(sp);
            System.debug(e.getMessage());
            return null;
        }
    }
}