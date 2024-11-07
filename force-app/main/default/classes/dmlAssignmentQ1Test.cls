@isTest
public class dmlAssignmentQ1Test {

    @isTest
    static void testMethod1() {
        // Step 1: Create test data
        List<Student__c> testStudents = new List<Student__c>();
        
        // Create 3 students with names starting with 's'
        for (Integer i = 1; i <= 3; i++) {
            Student__c stud = new Student__c(
                Name = 'Student ' + i
            );
            testStudents.add(stud);
        }
        
        // Insert test students
        insert testStudents;

        // Step 2: Execute the method1 in dmlAssignmentQ1 class
        Test.startTest();
        dmlAssignmentQ1.method1();
        Test.stopTest();
        
        // Step 3: Verify that the student names were updated as expected
        List<Student__c> updatedStudents = [SELECT Id, Name FROM Student__c WHERE Name LIKE 'Student%Test%' ORDER BY Name];

        // Verify that 3 students were updated
        System.assertEquals(3, updatedStudents.size(), 'Expected 3 students to be updated');
        
        // Verify the names were updated correctly
        for (Integer i = 1; i <= updatedStudents.size(); i++) {
            System.assert(updatedStudents[i-1].Name.contains('Test'), 'Name should contain "Test"');
            System.assertEquals('Student ' + i + ' Test' + i, updatedStudents[i-1].Name, 'Student name is incorrect');
        }
    }
}