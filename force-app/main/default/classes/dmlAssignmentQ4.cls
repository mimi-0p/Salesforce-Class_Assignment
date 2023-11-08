public class dmlAssignmentQ4 {
    public static void method1(){
        Account acc =[select id,Name,AnnualRevenue from account limit 1];
        system.debug(acc);
        acc.Name='changed';
        acc.AnnualRevenue =200000;
        database.update(acc);
        system.debug(acc);
    }
}