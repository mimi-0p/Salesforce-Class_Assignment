// dynamicFeedbackForm.js
import { LightningElement, track, wire } from 'lwc';
import getQuestions from '@salesforce/apex/FeedbackFormController.getQuestions';

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

    handleCheckboxChange(event) {
        this.checkboxAnswer = event.target.checked;
        this.checkboxAnswerName = event.target.label;
        console.log( this.checkboxAnswerName);
    }

    handleRadioChange(event) {
        this.selectedRadioOption = event.target.value;
        this.selectedRadioOptionName =event.target.label
         console.log( this.selectedRadioOption);
    }

    handleSubmit() {
       
    }
}