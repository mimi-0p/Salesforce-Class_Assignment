public class dmlAssignmentQ8 {
    public static void method1(){
        List<AggregateResult> aggregateResults = [SELECT COUNT(Id) oppCount, AccountId 
                                                  FROM Opportunity 
                                                  GROUP BY AccountId 
                                                  HAVING COUNT(Id) > 2];

        List<Id> accountIdsToDelete = new List<Id>();
		for(AggregateResult result : aggregateResults) {
            accountIdsToDelete.add((Id)result.get('AccountId'));
        }

        List<Account> accountsToDelete = [SELECT Id FROM Account WHERE Id IN :accountIdsToDelete];

        if (!accountsToDelete.isEmpty()) {
            delete accountsToDelete;
            System.debug(accountsToDelete.size() + ' accounts deleted successfully.');
        } else {
            System.debug('No accounts meet the criteria for deletion.');
        }
    }
}