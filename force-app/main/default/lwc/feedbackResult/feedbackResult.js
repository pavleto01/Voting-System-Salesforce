import getFeedbacks from '@salesforce/apex/FeedbackController.getFeedbacks';
import {api,wire, track, LightningElement } from 'lwc';


export default class FeedbackResult extends LightningElement {
    @api recordId;
    @track feedData;
    @track errorData;
     @wire(getFeedbacks, {record: '$recordId'})
     dataRecord({data, error}){
       if(data){
           this.feedData = data;
       }
       else if(error){
           this.errorData = error;
       }
     }

}