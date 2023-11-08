public class dmlAssignmentQ1 {
    public static void method1(){
        integer no1 = 1;
		list<Student__c> studold=[select id,name from Student__c where Name like 's%' ];
        list<Student__c> studnew = new list<Student__c>();
        for(Student__c stud : studold){
            string updatename =stud.Name +' Test' +no1 ;
            stud.Name = updatename;
            no1++;
            studnew.add(stud);
        }
        update studnew;
        system.debug(studnew);
    }
}