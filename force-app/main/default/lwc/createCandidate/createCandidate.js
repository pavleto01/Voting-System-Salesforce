import { api, LightningElement, track} from 'lwc';
import getNominations from "@salesforce/apex/NominationController.getNominations";
import createCandidate from '@salesforce/apex/CandidateController.createCandidate';
import getUsers from '@salesforce/apex/UserController.getUsers';
import { ShowToastEvent } from "lightning/platformShowToastEvent";


export default class CreateCandidate extends LightningElement {

    @track noptions = [];
    @track uoptions = [];
    @api recordId;

    
    connectedCallback(){
        getUsers().then(userresult => {
            let userarr = [];
            for (let i = 0; i < userresult.length; i++) {
                userarr.push({label: userresult[i].Name, value: userresult[i].Id});
            }
            this.uoptions = userarr;
        });

        getNominations({record: this.recordId}).then(nomresult => {
            let nomarr = [];
            for (let j = 0; j < nomresult.length; j++) {
                nomarr.push({label: nomresult[j].Name, value: nomresult[j].Id});
            }
            this.noptions = nomarr;
        });

    }

    get userOptions(){
        return this.uoptions;
    }
    
    
    get nominationOptions(){
        return this.noptions;
    }

    
    handleChange(event) {
        if (event.target.name == 'Candidates') {
          this.Candidates = event.target.value;
        }
    
        if (event.target.name == 'Nomination') {
          this.Nomination = event.target.value;
        }

        if (event.target.name == 'Reason') {
            this.Reason = event.target.value;
          }
      }

    submitAction() {
        createCandidate({
            Candidates:this.Candidates,
            Nomination:this.Nomination,
            Reason:this.Reason,
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