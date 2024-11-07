import { LightningElement, api, track } from 'lwc';

export default class OpportunityList extends LightningElement {
    @api accountId;
    @track opportunities;

    // Fetch opportunities when the component is connected to the DOM
    connectedCallback() {
        this.loadOpportunities();
    }

    loadOpportunities() {
        // Implement a method to fetch opportunities based on the account Id
        // and update the 'opportunities' property
    }

    handleDelete(event) {
        const opportunityId = event.currentTarget.dataset.id;
        // Implement delete logic for the selected opportunity
        // and update the 'opportunities' property
    }
}