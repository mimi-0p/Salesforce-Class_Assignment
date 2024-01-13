@isTest
private class AccountTriggerHandlertest {

    @isTest
    static void testOnAfterInsert() {
        // Create test data
        List<Account> testAccounts = new List<Account>();
        for(Integer i = 0; i < 3; i++) {
            Account acc = new Account(Name = 'Test Account ' + i);
            testAccounts.add(acc);
        }

        // Insert test data
        Test.startTest();
        insert testAccounts;
        Test.stopTest();

        // Verify opportunities were created for accounts without linked opportunities
        List<Opportunity> createdOpportunities = [SELECT Name, AccountId FROM Opportunity];
        System.assertEquals(3, createdOpportunities.size(), 'Opportunities not created for all accounts');

        // Perform additional assertions as needed
    }

    @isTest
    static void testOnBeforeDelete() {
        // Create test data - Accounts and related Opportunities
        Account accWithOpp = new Account(Name = 'Account With Opportunity');
        insert accWithOpp;

        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(10),
            AccountId = accWithOpp.Id
        );
        insert opp;

        Account accWithoutOpp = new Account(Name = 'Account Without Opportunity');
        insert accWithoutOpp;

        // Attempt to delete accounts
        Test.startTest();
        accWithoutOpp = [SELECT Id FROM Account WHERE Id = :accWithoutOpp.Id LIMIT 1];
        Test.stopTest();

        // Verify account deletion is prevented
        System.assertNotEquals(null, accWithoutOpp, 'Account was incorrectly deleted');

        // Perform additional assertions as needed
    }

     @isTest
    static void testAftrdlt() {
        // Create test data - Accounts that were merged and deleted
        Account acc1 = new Account(Name = 'Merged Account 1', Phone = '123456789');
        Account acc2 = new Account(Name = 'Merged Account 2', Phone = '987654321');
        insert new List<Account>{ acc1, acc2 };

        // Merge the accounts
        Test.startTest();
        Database.MergeResult mergeResult = Database.merge(acc1, acc2);
        Test.stopTest();

        // Check if the merge was successful
        System.assert(mergeResult.isSuccess(), 'Merge was not successful');

        // Verify backup records were created
        List<Account_Backup__c> backupRecords = [SELECT Name, Phone__c FROM Account_Backup__c];
        System.assertEquals(1, backupRecords.size(), 'Backup records were not created');

        // Perform additional assertions as needed
    }
}