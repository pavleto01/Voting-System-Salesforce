@isTest
public class NominationTestClass {
    @isTest 
    static void NominationTest(){
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
        
        NominationController.createNomination(Nomination.Name,Nomination.Nomination_Description__c,Nomination.Voting_campaign__c);
        NominationController.getNominations(VCampaign.Id);
    }
}
