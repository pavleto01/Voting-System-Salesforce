public with sharing class FeedbackController {

    @AuraEnabled
    public static Feedback__c createFeedback(string Name, string Description, string Campaign){
        Feedback__c Feedback = new Feedback__c();
        Feedback.Name=Name;
        Feedback.Feedback_description__c=Description;
        Feedback.Voting_campaign__c=Campaign;
        insert Feedback;
        return Feedback;
    }
    
    
    @AuraEnabled(cacheable=true)
    public static List<Feedback__c> getFeedbacks(string record) {
        List<Feedback__c> FeedbackList = [
            SELECT Id, Name,Feedback_description__c
            FROM Feedback__c
            WHERE Voting_campaign__c = :record
            ORDER BY Id
        ];
        return FeedbackList;
    }
  }