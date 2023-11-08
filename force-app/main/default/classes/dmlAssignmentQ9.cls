public class dmlAssignmentQ9 {
    public static void method1(String objname){
        string d1 ='Select id,Name from '+ objname;
        list<sObject> tst = database.query(d1);
        for(sObject tst1 : tst){
            System.debug(tst1);
        }
    }
}