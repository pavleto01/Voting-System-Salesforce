import { LightningElement, track, api } from "lwc";

import createNomination from "@salesforce/apex/NominationController.createNomination";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class CreateNomination extends LightningElement {
  @track Name;
  @track Description;
  @track error;
  @api recordId;



  HandleChange(event) {
    if (event.target.name == 'Name') {
      this.Name = event.target.value;
    }

    if (event.target.name == 'Description') {
      this.Description = event.target.value;
    }
  }

  submitAction() {
    createNomination({
      Name:this.Name,
      Description:this.Description,
      Campaign:this.recordId
      })
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
