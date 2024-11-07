@IsTest
public class asynchronousQ3Test {
    @IsTest
    static void testBatchClass(){
        // Create test data
        List<Campaign> campaigns = new List<Campaign>();
        for (Integer i = 0; i < 50; i++) {
            Campaign c = new Campaign(
                Name = 'Test Campaign '+ i,
                Status = 'In Progress',
                Type = 'Email',
                StartDate = Date.today(),
                EndDate = Date.today().addDays(10)
            );
            campaigns.add(c);
        }
        insert campaigns;
        
        // Start the batch job
        Test.startTest();
        asynchronousQ3 batchClass = new asynchronousQ3();
        Database.executeBatch(batchClass);
        Test.stopTest();
        
        // Verify the results
        List<Campaign> updatedCampaigns = [SELECT Id, Status FROM Campaign];
        for (Campaign c : updatedCampaigns) {
            System.assertEquals('Completed', c.Status, 'Campaign status should be updated to Completed');
        }
    }
}