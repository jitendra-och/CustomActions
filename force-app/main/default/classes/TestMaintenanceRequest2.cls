@isTest
private class TestMaintenanceRequest2 {
	@isTest 
    static void TestUpdateWorkOrders() {
        // Test data setup
        // Create a case
        // Positive test case: trigger is fired.
		Case aCase = new Case(Subject = 'Test Case a',
                             Status = 'New',
                             Origin = 'Phone',
                             Type = 'Repair');
        insert aCase;
        
        aCase.Status = 'Closed';
        update aCase;
        
        // Positive test case: trigger is fired.
		Case bCase = new Case(Subject = 'Test Case b',
                             Status = 'New',
                             Origin = 'Phone',
                             Type = 'Repair');
        insert bCase;
        
        bCase.Status = 'Working';
        update bCase;
        // Perform test
        Test.startTest();
        List<Case> newCaseList = [SELECT id, Subject, Type FROM Case WHERE parentId = :aCase.id];
        System.assert(newCaseList != null);
        System.assert(newCaseList.get(0).Status == 'New');
        
		newCaseList = [SELECT id, Subject, Type FROM Case WHERE parentId = :bCase.id];
        System.assert(newCaseList == null);
        Test.stopTest();

        // Verify 
        // In this case the deletion should have been stopped by the trigger,
        // so verify that we got back an error.
        
    }
    
    private static Integer ShortestMaintenance(Case c){
        Integer nextServiceDays;
        
        if (c.Work_Parts__r.size()>0){
            nextServiceDays = Integer.valueOf(c.Work_Parts__r.get(0).Maintenance_Request__c);
            
            for (Work_Part__c wPart : c.Work_Parts__r){
                if (Integer.valueOf(wPart.Maintenance_Request__c) < nextServiceDays){
                    nextServiceDays = Integer.valueOf(wPart.Maintenance_Request__c);
                }                    
            }            
        } else {
            nextServiceDays = 365;
        }       
        
        System.debug('nextServiceDays:' + nextServiceDays);
        
        return nextServiceDays;
    }           
}