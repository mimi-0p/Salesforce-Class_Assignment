public class dmlAssignmentQ10 {
	public static void insertStudents() {
        List<Student__c> students = new List<Student__c>();
        for(Integer i = 0; i < 100; i++) {
            Student__c student = new Student__c();
            student.Name = 'Student ' + i;
            student.Fees__c = Math.round(Math.random() * 1000); 
            students.add(student);
        }
        Savepoint sp = Database.setSavepoint();
        Database.SaveResult[] results = Database.insert(students, false);
        
        Integer successfulInsertions = 0;
        for(Database.SaveResult result : results) {
            if(result.isSuccess()) {
                successfulInsertions++;
            }
        }
        if(successfulInsertions < 80) {
            Database.rollback(sp);
            System.debug(successfulInsertions + ' records inserted. Rolling back...');
        } else {
            System.debug(successfulInsertions + ' records inserted successfully.');
        }
    }
}