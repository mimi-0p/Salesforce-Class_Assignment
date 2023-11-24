/*Write a Batch apex class to automatically deactivate users when the user&#39;s
Last Login Date is greater than 30 days.*/
public class asynchronousQ1 implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext BC){
        Date thirtyDaysAgo = Date.today().addDays(-30);
        return Database.getQueryLocator([Select id,LastLoginDate,IsActive from User where LastLoginDate 
                                         <:thirtyDaysAgo and IsActive =true]);
    }
    public void execute(Database.BatchableContext BC, List<User> scope){
        list<User> Us =new list<User>();
        for(User user1 : scope){
            user1.isActive = false;
            us.add(user1);
        }
        update us;
    }
    public void finish(Database.BatchableContext BC){
        
    }

}