// dynamicFeedbackForm.js
import { LightningElement, track, wire } from 'lwc';
import getQuestions from '@salesforce/apex/FeedbackFormController.getQuestions';
import insertData from '@salesforce/apex/FeedbackFormInsert.insertData';
export default class DynamicFeedbackForm extends LightningElement {
    @track questions;
    @track picklistOptions = [];
    @track selectedPicklistOption;
    @track textAreaAnswer;
    @track checkboxOption = [];
    @track checkboxAnswer = false;
    @track checkboxAnswerName;
    @track radioOptions = [];
    @track selectedRadioOption = false;
    @track selectedRadioOptionName;

    @wire(getQuestions)
    wiredQuestions({ error, data }) {
        if (data) {
            this.questions = data;
            this.populateOptions();
        } else if (error) {
            console.error('Error fetching questions: ', error);
        }
    }

     populateOptions() {
        this.questions.forEach(question => {
            if (question.Picklist__c|| question.Checkbox__c || question.Radio_button__c) {
                question.Available_Options__c.split(',').forEach(option => {
                    if (option.trim() !== '') {
                        console.log("opts",option);
                        if (question.Radio_button__c) {
                            this.radioOptions.push({ label: option, value: option });
                        } else if (question.Picklist__c) {
                            this.picklistOptions.push({ label: option, value: option });
                            console.log("the",this.picklistOptions);
                        }
                        else if(question.Checkbox__c){
                            this.checkboxOption.push({ label: option, value: option});
                            console.log("new", this.checkboxOption);
                        }
                    }
                });
            }
        });
    }

    handlePicklistChange(event) {
        this.selectedPicklistOption = event.detail.value;
        console.log( this.selectedPicklistOption);
    }

    handleTextAreaChange(event) {
        this.textAreaAnswer = event.detail.value;
        console.log( this.textAreaAnswer);
    }

    handleCheckboxChange() {
    
    
}


    handleRadioChange() {
        this.selectedRadioOption = event.target.value;
        this.selectedRadioOptionName =event.target.label
        console.log( this.selectedRadioOption);
    }

    handleSubmit() {
       var arr ="";
       this.checkboxOption.forEach(res=>{
           var temp = this.template.querySelector('[data-id="'+res.label+'"]') ;
           console.log('temp',temp.checked);
           if(temp.checked){
               if(arr=="")
                 arr=res.label;
                else
                 arr = arr+','+res.label;  
           }
       });
      let myMap = new Map();
      this.questions.forEach(que => {
            if(que.Picklist__c){
                myMap.set(que.Question_Text__c, this.selectedPicklistOption);
            }
            else if(que.Radio_button__c){
                 myMap.set(que.Question_Text__c,this.selectedRadioOption);
            }
            else if(que.Checkbox__c){
                 myMap.set(que.Question_Text__c,arr);
            }
            else{
                 myMap.set(que.Question_Text__c,this.textAreaAnswer);
            }
      });
      myMap.forEach((value, key) => {
    console.log(`${key} = ${value}`);
    });
    let jsonArray = JSON.stringify(Array.from(myMap.entries()).map(([key, value]) => ({ key, value })));
    insertData({
                   
                   jsonString:jsonArray
                    
                })
                .then(result => {
                    
                    console.log('Object inserted successfully:', result);
                })
                .catch(error => {
                    
                    console.error('Error inserting object:', error);
                });

                this.showSuccessToast();
    }
     showSuccessToast() {
        const toastEvent = new ShowToastEvent({
            title: 'Success!',
            message: 'Record saved successfully.',
            variant: 'success',
        });
        this.dispatchEvent(toastEvent);
    }
}