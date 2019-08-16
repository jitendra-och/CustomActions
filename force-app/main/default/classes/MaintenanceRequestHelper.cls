public class MaintenanceRequestHelper {
    
    public static void updateWorkOrders(List<Case> caseList){
        List<Case> newCaseList = new List<Case>();
        
        for (Case c : caseList){
            Integer nextServiceDays = ShortestMaintenance(c); 
            
            c.ParentId = c.id;
            c.id = null;
            c.Subject = 'Routine Maintenance Request';
            c.Status = 'New';
            c.Type ='Routine Maintenance';
            c.Date_Reported__c = Date.today();
            c.Date_Due__c = Date.today().addDays(nextServiceDays);
            
            newCaseList.add(c);
        }
        
        if (newCaseList.size() > 0){            
            insert newCaseList;
        }
    }
            
	private static Integer ShortestMaintenance(Case c){
        Integer nextServiceDays = 365;
                
        return nextServiceDays;
    }           
}