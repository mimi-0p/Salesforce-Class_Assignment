@RestResource(urlMapping ='/createStudent/')
global class createStudentApi {
    @httppost
    global static list<Student__c> myMethod(){
        RestRequest req = RestContext.request;
        String str = req.requestBody.toString();
        studentWrappercls obj =studentWrappercls.parse(str);
        System.debug(obj.Student);
        list<Student__c> stu = new list<Student__c>();
        list<studentWrappercls.Student> std = obj.Student;
        for(studentWrappercls.Student stud : std ){
            System.debug(stud.Name);
            System.debug(stud.Email);
            Student__c inss =  new Student__c();
            inss.Name =stud.Name;
            inss.Email__c =stud.Email;
            stu.add(inss);
        }
        insert stu;
        /*Map<String,Object> regMap =(map<String,Object>)json.deserializeUntyped(str);
        Student__c std = new Student__c();
        std.Name =String.valueOf(regMap.get('Name'));
        std.Email__c = String.valueOf(regMap.get('Email'));
        insert std;*/
        return stu;
    }
}