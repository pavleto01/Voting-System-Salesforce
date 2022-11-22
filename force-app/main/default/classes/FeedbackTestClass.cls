@isTest
public class FeedbackTestClass {
    @isTest 
    static void FeedbackTest(){

        Voting_campaign__c VCampaign = new Voting_campaign__c();
        VCampaign.Name='TestCampaignName';
        VCampaign.Campaign_status__c='Close Campaign';
        VCampaign.Start_date__c=date.parse('12/08/2022');
        VCampaign.Closing_date__c=date.parse('12/09/2022');
        insert VCampaign;

        Feedback__c Feedback = new Feedback__c();
        Feedback.Name='TestName';
        Feedback.Feedback_description__c='TestDescription';
        Feedback.Voting_campaign__c=VCampaign.Id;
        
        FeedbackController.createFeedback(Feedback.Name,Feedback.Feedback_description__c,Feedback.Voting_campaign__c);
        FeedbackController.getFeedbacks(VCampaign.Id);
    }
}

