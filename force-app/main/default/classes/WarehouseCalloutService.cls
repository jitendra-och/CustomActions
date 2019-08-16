public with sharing class WarehouseCalloutService {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    // complete this method to make the callout (using @future) to the
    // REST endpoint and update equipment on hand.
    @future(callout=true)
    public static void runWarehouseEquipmentSync() {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setEndpoint(WAREHOUSE_URL);
		request.setMethod('GET');
		HttpResponse response = http.send(request);
		
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            // Deserialize the JSON string into list of WarehouseEquipment class.
            List<WarehouseEquipment> equipmentList = (List<WarehouseEquipment>) JSON.deserialize(
                response.getBody(), List<WarehouseEquipment>.class);
            
            List<Product2> productList = new List<Product2>();
            for (WarehouseEquipment equipment: equipmentList) {
                Product2 p = new Product2();
                p.Name = equipment.name;
                p.Current_Inventory__c = equipment.quantity;
                p.Replacement_Part__c = equipment.replacement;
                p.Maintenance_Cycle__c = equipment.maintenanceperiod;
                p.Lifespan_Months__c = equipment.lifespan;
                p.Cost__c = equipment.cost;
                p.Warehouse_SKU__c = equipment.sku;
                
                productList.add(p);   
        	}
            upsert productList;
        }
        //return response;
	}
}