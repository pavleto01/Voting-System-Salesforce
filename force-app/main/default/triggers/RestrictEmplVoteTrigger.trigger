trigger RestrictEmplVoteTrigger on Votes_for_employee__c (before insert) {
    Map<String, List<Votes_for_employee__c>> votes = new Map<String, List<Votes_for_employee__c>>();

    for(Votes_for_employee__c n :Trigger.new){    
        if(!votes.containsKey(n.Unique__c)){
            votes.put(n.Unique__c, new List<Votes_for_employee__c>());
        }
        votes.get(n.Unique__c).add(n);
    }

    for(Votes_for_employee__c n :[SELECT Id, Unique__c FROM Votes_for_employee__c WHERE Unique__c IN :votes.keySet()]){

        for(Votes_for_employee__c newVote :votes.get(n.Unique__c)){
            newVote.addError('Duplicate vote detected!');
        }

        for(List<Votes_for_employee__c> vote : votes.values()){

            if(vote.size() > 1){
                for(Votes_for_employee__c dupName :vote){
                    dupName.addError('User already voted');
                }
            }
        }
    }
}