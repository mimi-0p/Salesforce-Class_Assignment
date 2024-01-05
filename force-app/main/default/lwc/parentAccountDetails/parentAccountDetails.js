import { LightningElement,track } from 'lwc';
export default class ParentAccountDetails extends LightningElement {
  @track receivedData = '';

    handleDataFromChild(event) {
        this.receivedData = event.detail;
        console.log("rcv data",this.receivedData);
    }
}