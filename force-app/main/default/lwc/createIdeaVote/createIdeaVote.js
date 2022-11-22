import { api, LightningElement, track } from 'lwc';
import getIdeaOptions from '@salesforce/apex/IdeaVoteController.getIdeaOptions';
import createIdeaVote from '@salesforce/apex/IdeaVoteController.createIdeaVote';
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class CreateIdeaVote extends LightningElement {
    @track ioptions = [];
    @api recordId;

    get voteOptions() {
      return [
          { label: 'YES', value: 'YES' },
          { label: 'NO', value: 'NO' },
      ];
  }

    connectedCallback(){
        getIdeaOptions({record: this.recordId}).then(iresult => {
            let iarr = [];
            for (let i = 0; i < iresult.length; i++) {
                iarr.push({label: iresult[i].Name, value: iresult[i].Id});
            }
            this.ioptions = iarr;
        });
    }

    get ideaOptions(){
        return this.ioptions;
    }

    handleChange(event) {
        if (event.target.name == 'Idea') {
          this.Idea = event.target.value; 
        }
        if (event.target.name == 'Vote') {
          this.Vote = event.target.value; 
        }
      }

      submitAction() {
        createIdeaVote({
            Idea:this.Idea,
            Vote:this.Vote,
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