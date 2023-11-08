public class soqlAssignmentQ7 {
    public static void method1(){
        list<Opportunity> opp =[ SELECT Account.Name, Account.BillingStreet, Account.BillingCity, Account.BillingState,
                                Account.BillingPostalCode, Account.BillingCountry,Account.AnnualRevenue
                                FROM Opportunity WHERE StageName = 'Closed Won'];
        list<Account> acc =new list<Account>();
        for(Opportunity opp2: opp){
            Account acc2 = new Account(
                Name = opp2.Account.Name,
                BillingStreet = opp2.Account.BillingStreet,
                BillingCity = opp2.Account.BillingCity,
                BillingState = opp2.Account.BillingState,
                BillingPostalCode = opp2.Account.BillingPostalCode,
                BillingCountry = opp2.Account.BillingCountry,
                AnnualRevenue = opp2.Account.AnnualRevenue
            );
            acc.add(acc2);
            }
        for(Account acc3 : acc){
            system.debug(acc3);
        }
    }
}