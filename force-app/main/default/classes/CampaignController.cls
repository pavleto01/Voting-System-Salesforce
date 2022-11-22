public with sharing class CampaignController {
    @AuraEnabled(cacheable=true)
    public static List<Voting_campaign__c> getCampaigns() {
        List<Voting_campaign__c> CamList = [
            SELECT Id, Name
            FROM Voting_campaign__c
            WITH SECURITY_ENFORCED
            ORDER BY Name
        ];
        return CamList;
    }
}
