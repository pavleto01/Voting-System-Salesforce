import { LightningElement, api, track, wire } from 'lwc';
import getIdeaVotes from '@salesforce/apex/VoteIdeaController.getIdeaVotes';

const COLUMNS = [
    { label: 'Idea', fieldName: 'Idea', type: 'text' },
    { label: 'Idea Description', fieldName: 'Description', type: 'text' },
    { label: 'Voter', fieldName: 'Voter', type: 'text' },
    { label: 'Vote', fieldName: 'Vote', type: 'text' }
]

export default class IdeaVoteResult extends LightningElement {
    @api recordId;
    @track columns = COLUMNS;    
    @track data = [];
    ideaResponse;

    


    @wire(getIdeaVotes, {record: '$recordId'}) idea(value){
        this.ideaResponse = value;
        const {data} = value;
        if(data){
            this.data = data.map(item => {
                let element = {
                    Idea: item.Idea__r.Name,
                    Description: item.Idea__r.Idea_description__c,
                    Voter: item.CreatedBy.Name,
                    Vote: item.Vote__c
                };
                return element;
            });
        }
    }
}