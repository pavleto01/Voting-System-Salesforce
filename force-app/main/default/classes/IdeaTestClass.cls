@isTest
public class IdeaTestClass {
    @isTest
    static void IdeaTest(){
        Test.StartTest(); 
        Voting_campaign__c VCampaign = new Voting_campaign__c();
        VCampaign.Name='TestCampaignName';
        VCampaign.Campaign_status__c='Voting';
        VCampaign.Start_date__c=date.parse('12/08/2022');
        VCampaign.Closing_date__c=date.parse('12/09/2022');
        insert VCampaign;

        Idea__c Idea = new Idea__c();
        Idea.Name='TestIdea';
        Idea.Idea_Description__c='TestDescription';
        Idea.Voting_campaign__c=VCampaign.Id;
        

        IdeaController.createIdea(Idea.Name, Idea.Idea_Description__c, Idea.Voting_campaign__c);
        IdeaController.getIdeas();
        Test.StopTest(); 
    }
}

