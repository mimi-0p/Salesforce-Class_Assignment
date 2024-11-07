import { LightningElement, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAccounts from '@salesforce/apex/accountConOptController.getAccounts';
import deleteOpportunity from '@salesforce/apex/accountConOptController.deleteOpportunity';
import deleteContact from '@salesforce/apex/accountConOptController.deleteContact';
import deleteAccount from '@salesforce/apex/accountConOptController.deleteAccount';

export default class AccConOpt extends NavigationMixin(LightningElement) {
    @track accounts;

    contactColumns = [{ label: 'Contact Name', fieldName: 'Name', type: 'text' }];
    opportunityColumns = [{ label: 'Opportunity Name', fieldName: 'Name', type: 'text' }];

    @wire(getAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
        } else if (error) {
            this.showToast('Error retrieving accounts', error.body.message, 'error');
        }
    }

    handleToggleSection(event) {
        const openSections = event.detail.openSections;
    }

    handleEditAccount(event) {
        const recordId = event.target.dataset.id;
        const editRecordEvent = new CustomEvent('editrecord', {
            detail: { recordId: recordId }
        });
        this.dispatchEvent(editRecordEvent);
    }

    async handleDeleteAccount(event) {
        const accountId = event.target.dataset.id;

        try {
            await deleteAccount({ accountId });
            this.accounts = this.accounts.filter(acc => acc.Id !== accountId);
            this.showToast('Success', 'Account deleted successfully', 'success');
        } catch (error) {
            this.showToast('Error deleting account', error.body.message, 'error');
        }
    }

    async handleDeleteOpportunity(event) {
        const opportunityId = event.target.dataset.id;

        try {
            await deleteOpportunity({ opportunityId });
            this.refreshAccounts();
            this.showToast('Success', 'Opportunity deleted successfully', 'success');
        } catch (error) {
            this.showToast('Error deleting opportunity', error.body.message, 'error');
        }
    }

    async handleDeleteContact(event) {
        const contactId = event.target.dataset.id;

        try {
            await deleteContact({ contactId });
            this.refreshAccounts();
            this.showToast('Success', 'Contact deleted successfully', 'success');
        } catch (error) {
            this.showToast('Error deleting contact', error.body.message, 'error');
        }
    }

    refreshAccounts() {
        getAccounts()
            .then((result) => {
                this.accounts = result;
            })
            .catch((error) => {
                this.showToast('Error retrieving accounts', error.body.message, 'error');
            });
    }

    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: title,
                message: message,
                variant: variant,
            })
        );
    }
}