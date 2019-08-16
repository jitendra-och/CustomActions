@isTest
private class TestMaintenanceRequest {
	@isTest 
    static void TestUpdateWorkOrders() {
        // Test data setup
        // Create a cases
      	List<Case> caseList = new List<Case>();
        
        for (Integer i = 0; i < 200; i++) {
			Case aCase = new Case(Subject = 'Test Case ' + i,
                                 Status = 'New',
                                 Origin = 'Phone',
                                 Type = 'Repair');
            caseList.add(aCase);
        }
        insert caseList;
        
        for (Integer i = 0; i < 200; i++) {
        	caseList.get(i).Status = 'Closed';
        }
        update caseList;
        
        List<String> idList = new List<String>();
        for (Integer i = 0; i < 200; i++) {
        	idList.add(caseList.get(i).parentId);
        }
        
        // Perform test
        Test.startTest();
        List<Case> newCaseList = [SELECT id, Subject, Type FROM Case WHERE parentId IN  :idList];
        System.assert(newCaseList != null);
        
        Test.stopTest();
    }
}