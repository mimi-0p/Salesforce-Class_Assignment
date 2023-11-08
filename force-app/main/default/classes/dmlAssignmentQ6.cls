public class dmlAssignmentQ6 {
    public static void method1(){
        Contact con=new Contact();
        con.FirstName = 'test';
        con.LastName ='Contact updated1';
        Account accref = new Account(
            MyExtID_c__c='SAP111112');                
        con.Account = accref;
        Account mainAccount = new Account(
            Name='TEst',
            MyExtID_c__c='SAP111112');
        list<sObject> rcdins = new list<sObject>{mainAccount,con};
        System.debug(rcdins);
        insert rcdins;
    }
}