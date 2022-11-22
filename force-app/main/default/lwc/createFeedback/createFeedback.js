import { api, LightningElement } from 'lwc';
import createFeedback from '@salesforce/apex/FeedbackController.createFeedback';
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class CreateFeedback extends LightningElement {
    @api recordId;

    handleChange(event) {
        if (event.target.name == 'Name') {
          this.Name = event.target.value;
        }
    
        if (event.target.name == 'Description') {
          this.Description = event.target.value;
        }

      }

    submitAction() {
        createFeedback({
            Name:this.Name,
            Description:this.Description,
            Campaign:this.recordId})
          .then((result) => {
            const toastEvent = new ShowToastEvent({
              title: "Success!",
              message: "Feedback created successfully",
              variant: "success"
            });
            this.dispatchEvent(toastEvent);
    
          })
          .catch((error) => {
            this.dispatchEvent(
              new ShowToastEvent({
                title: 'Error creating record: record might exist or given data is not right',
                message: error.body.message,
                  variant: 'error'
              })
              );
          });
      }
}