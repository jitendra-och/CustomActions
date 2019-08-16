@isTest
private class WarehouseCalloutServiceTest {
  	// implement your mock callout test here
  	@isTest static void testGetCallout() {
    
        // Set mock callout class 
    	Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock()); 
        
        // This causes a fake response to be sent
    	// from the class that implements HttpCalloutMock. 
    	HttpResponse response = WarehouseCalloutService.runWarehouseEquipmentSync();
    	
        String actualValue = response.getBody();
    	System.debug(response.getBody());
        
        String expectedValue = '[{"_id":"55d66226726b611100aaf741","replacement":false,"quantity":5,"name":"Generator 1000 kW","maintenanceperiod":365,"lifespan":120,"cost":5000,"sku":"100003"}]';
		System.assertEquals(actualValue, expectedValue);
    	System.assertEquals(200, response.getStatusCode());
    }
}