public with sharing class IdeaVoteController {

    @AuraEnabled
    public static Votes_for_idea__c createIdeaVote(string Idea, string Vote, string Campaign){
        Votes_for_idea__c IdeaVote = new Votes_for_idea__c();
        IdeaVote.Idea__c=Idea;
        IdeaVote.Vote__c=Vote;
        IdeaVote.Voting_campaign__c=Campaign;
        insert IdeaVote;
        return IdeaVote;
    }
    
    
    @AuraEnabled(cacheable=true)
    public static List<Idea__c> getIdeaOptions(string record) {
        List<Idea__c> IdeaVoteList = [
            SELECT Id, Name,Idea_description__c
            FROM Idea__c
            WHERE Voting_campaign__c = :record
            ORDER BY Id
        ];
        return IdeaVoteList;
    }
  }