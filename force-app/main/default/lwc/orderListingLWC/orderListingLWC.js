import { LightningElement, track, wire } from 'lwc';
import getOrders from '@salesforce/apex/OrderController.getOrders';

export default class OrderListingLWC extends LightningElement {
    @track orders;
    @track isModalOpen = false;
    @track selectedOrderId;
    @track orderName;
    @track startDate;
    @track endDate;



    columns = [
        { label: 'Order ID', fieldName: 'Id', type: 'text', sortable: true },
        { label: 'Order Name', fieldName: 'Name', type: 'text' },
        
        {
            label: 'View Details',
            type: 'button',
            typeAttributes: {
                label: 'View Details',
                name: 'view_details',
                title: 'Click to View Details',
                variant: 'base',
            },
        },
    ];
        sortOptions = [
        { label: 'New to Old', value: 'desc' },
        { label: 'Old to New', value: 'asc' },
    ];


   
    @wire(getOrders)
    wiredOrders({ error, data }) {
        if (data) {
            this.orders = data;
        } else if (error) {
            
            console.error(error);
        }
    }

    handleRowAction(event) {
        if (event.detail.action.name === 'view_details') {
           
            this.selectedOrderId = event.detail.row.Id;
            this.orderName = event.detail.row.Name;
            this.endDate = event.detail.row.End_Date__c;
            this.startDate =event.detail.row.Start_Date__c;
            this.isModalOpen = true;
        }
    }

    handleModalClose() {
        
        this.isModalOpen = false;
    }
}