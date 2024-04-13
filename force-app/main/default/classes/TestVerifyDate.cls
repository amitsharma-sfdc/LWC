@isTest
private class TestVerifyDate {
	@isTest static void ThirtyDays() {
		Date thirtyDaysTrue = VerifyDate.CheckDates(Date.today(), Date.newInstance(2020,3,25));
		System.assertEquals(Date.newInstance(2020,3,25), thirtyDaysTrue);
	}

	@isTest static void ThirtyOneDays() {
		Date thirtyOneDaysTrue = VerifyDate.CheckDates(Date.today(), Date.newInstance(2020,3,31));
		System.assertEquals(Date.newInstance(2020,3,31), thirtyOneDaysTrue);
	}    

	@isTest static void EndOfMonth() {
		Date endOfMonth = VerifyDate.CheckDates(Date.today(), Date.newInstance(2020,6,25));
		System.assertEquals(Date.newInstance(2020,3,31), endOfMonth);
	}	
}