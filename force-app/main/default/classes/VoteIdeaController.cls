public with sharing class VoteIdeaController {
    @AuraEnabled(cacheable=true)
    public static List<Votes_for_idea__c> getIdeaVotes(string record) {
        List<Votes_for_idea__c> IdeaVoteList = [
            SELECT Id, Idea__r.Name,Idea__r.Idea_description__c,Vote__c,CreatedBy.Name
            FROM Votes_for_idea__c
            WHERE Voting_campaign__c = :record
            ORDER BY Id
        ];
        return IdeaVoteList;
    }
}
