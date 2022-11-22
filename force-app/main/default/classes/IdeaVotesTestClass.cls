@isTest
public class IdeaVotesTestClass {
    @isTest
    static void IdeaVotesTest() {
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

        Idea__c Idea = new Idea__c();
        Idea.Name='TestIdea';
        Idea.Idea_Description__c='TestDescription';
        Idea.Voting_campaign__c=VCampaign.Id;
        insert Idea;

        Votes_for_idea__c IdeaVote = new Votes_for_idea__c();
        IdeaVote.Idea__c=Idea.Id;
        IdeaVote.Vote__c='YES';
        IdeaVote.Voting_campaign__c=VCampaign.Id;
        
        IdeaVoteController.createIdeaVote(IdeaVote.Idea__c,IdeaVote.Vote__c,IdeaVote.Voting_campaign__c);
        IdeaVoteController.getIdeaOptions(VCampaign.Id);
        VoteIdeaController.getIdeaVotes(VCampaign.Id);
    }
}
