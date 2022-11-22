import { LightningElement, api, track, wire } from 'lwc';
import getEmplVotes from '@salesforce/apex/VoteEmplController.getEmplVotes';

const COLUMNS = [
    { label: 'Employee', fieldName: 'Candidate', type: 'String'},
    { label: 'Number of votes', fieldName: 'Votes', type: 'Integer' }
]

export default class EmplVoteResult extends LightningElement {
    @api recordId;
    @track columns = COLUMNS;    
    @track data = [];
    voteResponse;

    
    @wire(getEmplVotes, {record: '$recordId'}) votes(value){
        this.voteResponse = value;
        const {data} = value;
        if(data){
            this.data = data.map(item => {
                let element = {
                    Candidate: item.Name,
                    Votes: item.Counter
                };
                return element;
            });
        }
    }
}