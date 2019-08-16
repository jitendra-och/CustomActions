global class WarehouseSyncSchedule implements Schedulable {
  	
    global void execute(SchedulableContext ctx) {
        WarehouseCalloutService.runWarehouseEquipmentSync();
    }

    /*public static void scheduleJob() {
        // Seconds Minutes Hours Day_of_month Month Day_of_week optional_year  	
        String sch = '0 0 1 * * ?';
        String jobID = System.schedule('Daily warehouse sync', sch, new WarehouseSyncSchedule());
        //System.debug('jobID: ' + jobID);
        
    } */   
}