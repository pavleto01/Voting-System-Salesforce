public with sharing class CandidateController {

    @AuraEnabled
    public static Candidate__c createCandidate(string Candidates, string Nomination, string Reason, string Campaign){
        Candidate__c Candidate = new Candidate__c();
        Candidate.Candidate__c=Candidates;
        Candidate.Nomination__c=Nomination;
        Candidate.Reason__c=Reason;
        Candidate.Voting_campaign__c=Campaign;
        insert Candidate;
        return Candidate;
    }
    
    
    @AuraEnabled(cacheable=true)
    public static List<Candidate__c> getCandidates() {
        List<Candidate__c> canList = [
            SELECT Id, Candidate__r.Name,Nomination__r.Name
            FROM Candidate__c
            ORDER BY Id
        ];
        return canList;
    }

    
  }