import { LightningElement, track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

export default class AccountComponent extends LightningElement {
    @track accounts;

    connectedCallback() {
        this.loadAccounts();
    }

    loadAccounts() {
        getAccounts()
            .then(result => {
                this.accounts = result;
            })
            .catch(error => {
                this.showToast('Error', error.body.message, 'error');
            });
    }

    handleDelete(event) {
        this.loadAccounts();
    }

    handleEdit(event) {
        this.loadAccounts();
    }

    handleAccordion(event) {
        const accountId = event.detail;
        this.accounts = this.accounts.map(account => {
            if (account.Id === accountId) {
                account.showDetails = !account.showDetails;
            }
            return account;
        });
    }

    showToast(title, message, variant) {
        const toastEvent = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(toastEvent);
    }
}