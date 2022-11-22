public with sharing class VoteEmplController {
    @AuraEnabled(cacheable=true)
    public static List<AggregateResult> getEmplVotes(string record) {
        List<AggregateResult> VoteList = [
            SELECT count(Id) Counter, Name
            FROM Votes_for_employee__c
            WHERE Voting_campaign__c = :record  
            GROUP BY Name
            HAVING count(Name) > 0
        ];
        return VoteList;
    }
}
