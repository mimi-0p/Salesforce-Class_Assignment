/*Write a Batch apex class to automatically delete the Leads whose Lead
Status is 'Closed- Not Converted&quot'*/
public class asynchronousQ4 implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([select id,Status from Lead where Status ='Closed - Not Converted']);
    }
    public void execute(Database.BatchableContext BC, List<Lead> scope){
        List<Lead> lst =new List<Lead>();
        for(Lead lsts : scope){
            lst.add(lsts);
        }
        if (!lst.isEmpty()) {
           delete lst;
        }
    }
    public void finish(Database.BatchableContext BC){
        
    }

}