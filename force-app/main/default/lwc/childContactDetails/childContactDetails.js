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
            if (result) {
                this.contact = result;
                this.error = undefined;
            }
        } catch (error) {
            this.error = error;
            this.contact = {};
        }
    }
    sendData() {
        const eventData = this.contact;
        console.log("dispatch",eventData);
        const event = new CustomEvent('senddata', { detail: eventData });
        this.dispatchEvent(event);
    }
}