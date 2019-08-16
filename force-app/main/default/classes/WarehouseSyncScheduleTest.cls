@isTest
private class WarehouseSyncScheduleTest {
	// Dummy CRON expression: midnight on March 15.
    // Because this is a test, job executes
    // immediately after Test.stopTest().
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    
    @isTest
    static void testSyncSchedule() {
        String jobID = System.schedule('Daily warehouse sync', CRON_EXP, new WarehouseSyncSchedule());
        System.debug('jobID: ' + jobID);
        System.assert(jobID != null);
    }
}