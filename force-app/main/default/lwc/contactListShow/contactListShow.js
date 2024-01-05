// loginForm.js
import { LightningElement, track, wire } from 'lwc';
import getAccountContacts from '@salesforce/apex/ContactController.getAccountContacts';


export default class ContactListShow extends LightningElement {
    @track accountName = '';
    @track contacts = [];
    @track showContacts = false;
    @track showContactDetails = false;
    @track selectedContactDetails;
    @track selectedContact = {};

    handleInputChange(event) {
        this.accountName = event.target.value;
        console.log(this.accountName);
    }

    handleLogin() {
        console.log(this.accountName);
        getAccountContacts({ accountname : this.accountName })
        .then(result => {
          
            this.contacts = result;
            console.log(this.contacts);
            this.showContacts = true;
            this.showContactDetails=false;
        })
        .catch(error => {
            
        });
    }
    handleContactClick(event) {
        const selectedContactId = event.target.dataset.key;
        console.log(selectedContactId);
        this.selectedContact = this.contacts.find(contact => contact.Id === selectedContactId);
        this.showContacts = false;
        this.showContactDetails = true;
    }
}