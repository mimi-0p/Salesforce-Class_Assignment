public class soqlAssignmentQ4 {
    public static void method1(){
        list<string> studentname = new list<string>();
        studentname.add('John');
        studentname.add('Jack');
        studentname.add('Will');
        studentname.add('David');
        Date startDate = Date.today();
        Date endDate = startDate.addMonths(3).addDays(-1);
        List<Student__c> students = [
            SELECT Id, Name, Registered_Date__c
            FROM Student__c
            WHERE Name IN :studentname
            AND Registered_Date__c >= :startDate
            AND Registered_Date__c <= :endDate
        ];
        for(Student__c sud :students ){
        system.debug(sud);
        }
    }

}