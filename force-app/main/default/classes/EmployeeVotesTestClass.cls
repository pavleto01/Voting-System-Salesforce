@isTest
public class EmployeeVotesTestClass {
    @isTest 
    static void EmployeeVotesTest(){
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
         
        User user = new User(LastName = 'LIVESTON',
                           FirstName='JASON',
                           Alias = 'jliv',
                           Email = 'jason.liveston@asdf.com',
                           Username = 'jason.liveston@asdf.com',
                           ProfileId = profileId.id,
                           TimeZoneSidKey = 'GMT',
                           LanguageLocaleKey = 'en_US',
                           EmailEncodingKey = 'UTF-8',
                          LocaleSidKey = 'en_US'
                           );

        Voting_campaign__c VCampaign = new Voting_campaign__c();
        VCampaign.Name='TestCampaignName';
        VCampaign.Campaign_status__c='Close Campaign';
        VCampaign.Start_date__c=date.parse('12/08/2022');
        VCampaign.Closing_date__c=date.parse('12/09/2022');
        insert VCampaign;

        Nomination__c Nomination = new Nomination__c();
        Nomination.Name='TestName';
        Nomination.Nomination_Description__c='TestDescription';
        Nomination.Voting_campaign__c=VCampaign.Id;
        insert Nomination;

        Candidate__c Candidate = new Candidate__c();
        Candidate.Candidate__c=user.Id;
        Candidate.Nomination__c=Nomination.Id;
        Candidate.Voting_campaign__c=VCampaign.Id;
        Candidate.Reason__c='Test reason';
        insert Candidate;

        Votes_for_employee__c EmplVote = new Votes_for_employee__c();
        EmplVote.Candidate__c=Candidate.Id;
        EmplVote.Voting_campaign__c=VCampaign.Id;
        
        EmployeeVotesController.createEmplVote(EmplVote.Candidate__c,EmplVote.Voting_campaign__c);
        EmployeeVotesController.getEmplCandidates(VCampaign.Id);
        VoteEmplController.getEmplVotes(VCampaign.Id);
    }
}
