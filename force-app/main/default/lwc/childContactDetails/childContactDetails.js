import { LightningElement, track } from 'lwc';
import getContactDetails from '@salesforce/apex/ContactController.getContactDetails';

export default class ChildContactDetails extends LightningElement {
    @track contact = {};
    @track error;

    handleInputChange(event) {
        const contactName = event.target.value;
        this.fetchContactDetails(contactName);
    }

    async fetchContactDetails(contactName) {
        try {
            const result = await getContactDetails({ contactName: contactName });
            console.log(result);
            if (result) {
                this.contact = result;
                this.error = undefined;
            }
        } catch (error) {
            this.error = error;
            this.contact = {};
        }
    }
    sendData(event) {

        //event.preventDefault();
        const eventData = this.contact;
        console.log("dispatch",eventData);
        const event1 = new CustomEvent('senddata', {bubbles: true,
            composed: true,detail: eventData});
        this.dispatchEvent(event1);
    }
}