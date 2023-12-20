import { LightningElement } from 'lwc';

export default class RegForm extends LightningElement {
    studentlist=[];
    registration=false;
    isstudent = false;
    constructor(){
        super();
        console.log("Constructor");
    }
    connectedCallback(){

    }
    renderedCallback(){

    }
    studentReg(){
        this.registration=true;
        this.isstudent=false;
    }
    submitclick(){
        var nameInput = this.template.querySelector('[data-id="stdname"]').value;
        var phoneInput = this.template.querySelector('[data-id="phnno"]').value;
        var emailInput = this.template.querySelector('[data-id="emailid"]').value;
        var dobInput = this.template.querySelector('[data-id="dob"]').value;
        var tempvar = {
            "Name": nameInput,
            "Phone": phoneInput,
            "Emailid": emailInput,
            "DOB": dobInput
        };
        console.log("test",tempvar);
        this.studentlist.push(tempvar);
        console.log(JSON.stringify(this.studentlist));
        
        
    }
    studentData(){
        this.isstudent=true;
        this.registration=false;
        

    }
    disconnectedCallback(){

    }
    errorCallback(){

    }
}