import { LightningElement, api } from 'lwc';

export default class OrderDetailsModal extends LightningElement {
    @api orderId;
    @api ordername;
    @api enddate;
    @api startdate;

    handleClose() {
      
        const closeModalEvent = new CustomEvent('closemodal');
        this.dispatchEvent(closeModalEvent);
    }
}