import { api, LightningElement } from 'lwc';
import createIdea from '@salesforce/apex/IdeaController.createIdea';
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class CreateIdea extends LightningElement {
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
        createIdea({
            Name:this.Name,
            Description:this.Description,
            Campaign:this.recordId})
          .then((result) => {
            const toastEvent = new ShowToastEvent({
              title: "Success!",
              message: "Record created successfully",
              variant: "success"
            });
            this.dispatchEvent(toastEvent);
            location.reload();
    
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