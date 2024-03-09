import { LightningElement, track, wire } from 'lwc';
import {updateRecord,deleteRecord } from 'lightning/uiRecordApi';
import getOrders from '@salesforce/apex/OrderController.getOrders';
import updtName from '@salesforce/apex/OrderController.updtName';

export default class OrderListingLWC extends LightningElement {
    @track orders;
    @track isModalOpen = false;
    @track selectedOrderId;
    @track orderName;
    @track startDate;
    @track endDate;
    @track sortOrder;
    @track filteredOrders;

    columns = [
        { label: 'Order ID', fieldName: 'Id', type: 'text', sortable: true },
        { label: 'Order Name', fieldName: 'Name', type: 'text',editable:true },
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
            this.startDate = event.detail.row.Start_Date__c;
            this.isModalOpen = true;
        }
    }

    handleModalClose() {
        this.isModalOpen = false;
    }

    handleStartDateChange(event) {
        this.startDate = event.target.value;
    }

    handleEndDateChange(event) {
        this.endDate = event.target.value;
    }

    handleSortOrderChange(event) {
        this.sortOrder = event.detail.value;
    }

    handleClick() {
    var bckup = [];
    this.filteredOrders = this.orders;
    var strtdt = new Date(this.template.querySelector('[data-id="strtdate"]').value);
    var enddate = new Date(this.template.querySelector('[data-id="enddate"]').value);

    this.filteredOrders.forEach(res => {
        var orderStartDate = new Date(res.Start_Date__c);
        var orderEndDate = new Date(res.End_Date__c);

        
        if (orderStartDate >= strtdt && orderEndDate <= enddate) {
            bckup.push(res);
        }
    });
    console.log(JSON.stringify(bckup));
    
    this.orders = bckup;
}
handlesave(event){
    console.log('Draft Values : ' + JSON.stringify(event.detail.draftValues));
    let jsonstrng = JSON.stringify(event.detail.draftValues);

    updtName({
                   
                   jsonstrng:jsonstrng
                    
                })
                .then(result => {
                    
                    console.log('Object inserted successfully:', result);
                })
                .catch(error => {
                    
                    console.error('Error inserting object:', error);
                });

                this.showSuccessToast();
    }
    

}