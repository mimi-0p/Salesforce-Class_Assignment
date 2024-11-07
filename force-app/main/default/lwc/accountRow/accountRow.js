import { LightningElement, api } from 'lwc';

export default class AccountRow extends LightningElement {
    @api account;
    isAccordionOpen = false;

    handleDelete() {
        const deleteEvent = new CustomEvent('delete', {
            detail: this.account.Id
        });
        this.dispatchEvent(deleteEvent);
    }

    handleEdit() {
        const editEvent = new CustomEvent('edit', {
            detail: this.account.Id
        });
        this.dispatchEvent(editEvent);
    }

    handleAccordion() {
        this.isAccordionOpen = !this.isAccordionOpen;
        const accordionEvent = new CustomEvent('accordion', {
            detail: this.account.Id
        });
        this.dispatchEvent(accordionEvent);
    }
}