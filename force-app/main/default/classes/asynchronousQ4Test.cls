@IsTest
public class asynchronousQ4Test {
    @IsTest
    static void testBatchClass(){
        // Create test data
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 50; i++) {
            Lead l = new Lead(
                FirstName = 'Test' + i,
                LastName = 'Lead' + i,
                Company = 'Test Company' + i,
                Status = 'Closed - Not Converted'
            );
            leads.add(l);
        }
        insert leads;
        
        // Start the batch job
        Test.startTest();
        asynchronousQ4 batchClass = new asynchronousQ4();
        Database.executeBatch(batchClass);
        Test.stopTest();
        
        // Verify the results
        List<Lead> deletedLeads = [SELECT Id FROM Lead WHERE Id IN :leads];
        System.assertEquals(0, deletedLeads.size(), 'All leads should be deleted');
    }
}