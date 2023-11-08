public class soqlAssignmentQ6 {
    public static void method1(Decimal fee1, Decimal fee2) {
        List<Student__c> students = [SELECT Name, Course__c,Fees__c  FROM Student__c WHERE Fees__c >=: fee1 AND Fees__c <=: fee2 ];
        for(Student__c stud:students){
        System.debug(stud);
        }
    }
}