public with sharing class EmployeeVotesController {

    @AuraEnabled
    public static Votes_for_employee__c createEmplVote(string Candidate, string Campaign){
        Votes_for_employee__c EmplVote = new Votes_for_employee__c();
        EmplVote.Candidate__c=Candidate;
        EmplVote.Voting_campaign__c=Campaign;
        insert EmplVote;
        return EmplVote;
    }
    
    
    @AuraEnabled(cacheable=true)
    public static List<Candidate__c> getEmplCandidates(string record) {
        List<Candidate__c> EmplVoteList = [
            SELECT Id, Candidate__r.Name,Nomination__r.Name
            FROM Candidate__c
            WHERE Voting_campaign__c = :record
            ORDER BY Id
        ];
        return EmplVoteList;
    }
  }