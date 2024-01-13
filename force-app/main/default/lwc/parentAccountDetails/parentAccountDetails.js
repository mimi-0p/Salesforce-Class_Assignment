import { LightningElement,track } from 'lwc';
export default class ParentAccountDetails extends LightningElement {
  @track receivedData = '';
  

    handleDataFromChild(event) {
        console.log("rcv data raw", event.detail);
        this.receivedData = event.detail;
        console.log("rcv data",this.receivedData);
    }
}