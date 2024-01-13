import { LightningElement,track } from 'lwc';
export default class GrandParentAllDetails extends LightningElement {
     @track receivedMessage = '';
     handleDataFromChild(event) {
        console.log("rcv data raw grprnt", event.detail);
        this.receivedMessage = event.detail;
        console.log('Received data in grandparent:',this.receivedMessage);
    }
}