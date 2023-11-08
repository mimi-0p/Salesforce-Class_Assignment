public class dmlAssignmentQ3 {
    public static void method1(){
       Account acc = new Account();
       acc.Name ='test1';
       system.debug(acc);
       insert acc;
       Contact con = new Contact();
       con.FirstName='Manish';
       con.LastName='Sahu';
       con.AccountId=acc.id;
       system.debug(con);
       insert con;
       delete con;
       delete acc;
       
       list<Account> acc2 =[Select Id, name from Account where IsDeleted = true ALL ROWS];
       system.debug(acc2);
	   undelete acc2;        
    }
}