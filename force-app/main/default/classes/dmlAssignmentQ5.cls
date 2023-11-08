public class dmlAssignmentQ5 {
    public static void method1(){
        list<Student__c> dlts =[select id,Name from Student__c where Name like '_r%' ];
        system.debug(dlts);
        delete dlts;
        method2();
    }
    public static void method2(){
        List<Student__c> delStud = [SELECT Id FROM Student__c WHERE IsDeleted = true 
                                    AND LastModifiedDate >= 2023-09-01T18:31:42.000+0000 
                                    AND LastModifiedDate <= 2023-09-30T18:31:42.000+0000 
                                    AND LastModifiedBy.Name = 'Salesforce Demo' ALL ROWS];
        system.debug(delStud);
        undelete delstud;
        }
}