public class dmlAssignmentQ2 {
    public static void method1(){
        list<Account> empacc = [SELECT Id,Name FROM Account WHERE Id NOT IN (SELECT AccountId FROM Opportunity)];
        list<Opportunity> Opp = new list<Opportunity>();
        for(Account acc : empacc){
            Opportunity newopp =new Opportunity();
            newopp.Name =acc.name;
            newopp.StageName ='Prospecting';
            newopp.CloseDate=date.today();
            newopp.AccountId=acc.id;
            Opp.add(newopp);
            system.debug(newopp);
            
        }
        system.debug(Opp);
        insert Opp;
        
    }

}