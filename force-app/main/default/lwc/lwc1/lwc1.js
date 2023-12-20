import { LightningElement } from 'lwc';

export default class Lwc1 extends LightningElement {
    handleClick(){
        var nameInput = this.template.querySelector('[data-id="stdname"]').value;
        var phoneInput = this.template.querySelector('[data-id="phnno"]').value;
        var emailInput = this.template.querySelector('[data-id="emailid"]').value;
        var dobInput = this.template.querySelector('[data-id="dob"]').value;
        console.log(nameInput);
        console.log(phoneInput);
        console.log(emailInput);
        console.log(dobInput);


    }
}