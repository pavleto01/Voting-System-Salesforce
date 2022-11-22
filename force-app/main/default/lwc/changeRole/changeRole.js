import { api, track, LightningElement, wire } from 'lwc';
import getUsers from '@salesforce/apex/UserController.getUsers';
import getRoles from '@salesforce/apex/UserController.getRoles';
import { ShowToastEvent } from "lightning/platformShowToastEvent";


import USER_OBJECT from "@salesforce/schema/User";
import USERID_FIELD from "@salesforce/schema/User.Id";
import USERROLEID_FIELD from "@salesforce/schema/User.UserRoleId";



import { updateRecord } from "lightning/uiRecordApi";

export default class ChangeRole extends LightningElement {
    @api
    recordId;

    @track roptions = [];
    @track uoptions = [];
   

    connectedCallback(){
        getUsers().then(userresult => {
            let userarr = [];
            for (let i = 0; i < userresult.length; i++) {
                userarr.push({label: userresult[i].Name + ' - ' + userresult[i].UserRole.Name, value: userresult[i].Id});
            }
            this.uoptions = userarr;
        });

        getRoles().then(roleresult => {
            let rolearr = [];
            for (let j = 0; j < roleresult.length; j++) {
                rolearr.push({label: roleresult[j].Name, value: roleresult[j].Id});
            }
            this.roptions = rolearr;
        });

    }

    get userOptions(){
        return this.uoptions;
    }
    
    
    get roleOptions(){
        return this.roptions;
    }


    handleChange(event) {
        if (event.target.name == 'User') {
          this.User = event.target.value;  
        } 

        if (event.target.name == 'Role') {
            this.Role = event.target.value;  
          } 
      }

      

      submitAction() {
        const fields = {};

            fields[USERID_FIELD.fieldApiName] = this.User;
            fields[USERROLEID_FIELD.fieldApiName] = this.Role;
        
        const recordInput = {
            fields: fields
        };


        updateRecord(recordInput)
        .then((record) => {
            const toastEvent = new ShowToastEvent({
                title: "Success!",
                message: "Role changed successfully",
                variant: "success"
              });
              this.dispatchEvent(toastEvent);
              location.reload();
        })
        .catch((error) => {
            this.dispatchEvent(
              new ShowToastEvent({
                  title: 'Error changing role',
                  message: error.body.message,
                  variant: 'error'
              })
             );
        });
    }
}