@IsTest
public class asynchronousQ1Test {
    @IsTest
    static void testBatchClass(){
        // Create test data
        List<User> users = new List<User>();
        for (Integer i = 0; i < 50; i++) {
            User u = new User(
                FirstName = 'Test',
                LastName = 'User' + i,
                Email = 'test.user' + i + '@example.com',
                Username = 'test.truser' + i + '@example.com',
                Alias = 'tuser' + i,
                TimeZoneSidKey = 'America/Los_Angeles',
                LocaleSidKey = 'en_US',
                EmailEncodingKey = 'UTF-8',
                ProfileId = UserInfo.getProfileId(),
                LanguageLocaleKey = 'en_US',
                IsActive = false
            );
            users.add(u);
        }
        insert users;
        // Start the batch job
        Test.startTest();
        asynchronousQ1 batchClass = new asynchronousQ1();
        Database.executeBatch(batchClass);
        Test.stopTest();
        
        // Verify the results
        List<User> updatedUsers = [SELECT Id, IsActive FROM User WHERE Id IN :users];
        for (User u : updatedUsers) {
            System.assertEquals(false, u.IsActive, 'User should be deactivated');
        }
    }
}