@IsTest
public class asynchronousQ2Test {
    @IsTest
    static void testBatchClass(){
        // Create test data
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            Account tp = new Account(
                Name = 'Test Account '+ i,
                Description = 'Original Description',
                NumberOfEmployees = 10
            );
            accounts.add(tp);
        }
        insert accounts;
        
        // Start the batch job
        Test.startTest();
        asynchronousQ2 batchClass = new asynchronousQ2();
        Database.executeBatch(batchClass);
        Test.stopTest();
        
        // Verify the results
        List<Account> updatedAccounts = [SELECT Id, Description, NumberOfEmployees FROM Account];
        for (Account acc : updatedAccounts) {
            System.assertEquals('Updated Description', acc.Description, 'Account description should be updated');
            System.assertEquals(100, acc.NumberOfEmployees, 'Account number of employees should be updated');
        }
    }
}