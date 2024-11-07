/*Update account description, number of employees, contact last name using
batch apex. Get the failure record ids in the email. Also, schedule the job for
every Monday.*/
public class asynchronousQ2 implements Database.Batchable<sObject>,schedulable,Database.Stateful {
    public list<id> failedrecords = new list<id>();
    public list<id> successfulrecords = new list<id>();
	public Database.QueryLocator Start(Database.BatchableContext bc){
        return Database.getQueryLocator([Select id,Description,NumberOfEmployees,(Select id,LastName from Contacts) from Account ]);
    }
    public void execute(Database.BatchableContext BC, List<Account> scope){
        list<Account> acc =new list<Account>();
        list<Contact> Cont =new list<Contact>();
        for(Account ac : Scope){
            ac.Description ='Updated Description';
            ac.NumberOfEmployees=100;
            for(Contact cn : ac.Contacts){cn.LastName ='Updated Name Batch'; Cont.add(cn);
            }
            acc.add(ac);
        }
        try{
            update acc;
            System.debug('ids'+acc);
            update Cont;
            for(Account tc : acc){
               successfulrecords.add(tc.Id);
            }
            System.debug('1st'+successfulrecords);
            
        }
        catch(Exception e){
             for(Account failedAcc : acc){
                failedRecords.add(failedAcc.Id);
            }
            System.debug(failedRecords);
        }
    }
    public void finish(Database.BatchableContext BC){
        	system.debug(failedRecords);
        	system.debug(successfulrecords);
            if(failedRecords.isEmpty() || !successfulrecords.isEmpty() ){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                String sendTo = 'manishkanha2015@gmail.com';
                mail.setToAddresses(new String[]{sendTo});
                mail.setSubject('Failed Record Id');
                mail.setPlainTextBody('Your Failed record id are'+ String.join(successfulrecords, ', '));
                Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
            }
    }
    public void execute(SchedulableContext sc) {
        asynchronousQ2 bt = new asynchronousQ2();
        Database.executeBatch(bt);
    }
}