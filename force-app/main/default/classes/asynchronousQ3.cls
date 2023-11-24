/*Write a Batch Class to Update the Status of the Campaign to Completed if it
is not Completed.*/
public class asynchronousQ3 implements Database.Batchable<sObject>{
    public Database.QueryLocator Start(Database.BatchableContext bc){
        return Database.getQueryLocator([Select id,Status from Campaign where Status != 'Completed']);
    }
    public void execute(Database.BatchableContext BC, List<Campaign> scope){
       System.debug(scope);
       List<Campaign> camp =new List<Campaign>();
        for(Campaign mp : scope){
            mp.Status = 'Completed' ;
            camp.add(mp);
        }
        System.debug(camp);
        update camp;
    }
    public void finish(Database.BatchableContext BC){
        /*asynchronousQ3 bt = new asynchronousQ3();
        Database.executeBatch(bt);*/
    }
}