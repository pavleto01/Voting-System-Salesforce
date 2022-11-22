import { api, LightningElement, track } from 'lwc';
import getEmplCandidates from '@salesforce/apex/EmployeeVotesController.getEmplCandidates';
import createEmplVote from '@salesforce/apex/EmployeeVotesController.createEmplVote';
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class CreateEmployeeVote extends LightningElement {
    @track coptions = [];
    @api recordId;

    connectedCallback(){
        getEmplCandidates({record: this.recordId}).then(candresult => {
            let candarr = [];
            for (let i = 0; i < candresult.length; i++) {
                candarr.push({label: candresult[i].Candidate__r.Name + " - " + candresult[i].Nomination__r.Name, value: candresult[i].Id});
            }
            this.coptions = candarr;
        });
    }

    get candOptions(){
        return this.coptions;
    }

    handleChange(event) {
        if (event.target.name == 'Candidates') {
          this.Candidates = event.target.value;
        }
      }

      submitAction() {
        createEmplVote({
            Candidate:this.Candidates,
            Campaign:this.recordId})
          .then((result) => {
            const toastEvent = new ShowToastEvent({
              title: "Success!",
              message: "Vote created successfully",
              variant: "success"
            });
            this.dispatchEvent(toastEvent);
          })
          .catch((error) => {
            this.dispatchEvent(
              new ShowToastEvent({
                title: 'Error creating record: you have already voted or given data is not right',
                message: error.body.message,
                  variant: 'error'
              })
              );
          });
      }
}