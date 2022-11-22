trigger CandidateDuplicationTrigger on Candidate__c (before insert) {
    Map<String, List<Candidate__c>> cand = new Map<String, List<Candidate__c>>();

    for(Candidate__c i :Trigger.new){    
        if(!cand.containsKey(i.Candidate__c)){
            cand.put(i.Candidate__c, new List<Candidate__c>());
        }
        cand.get(i.Candidate__c).add(i);
    }

    for(Candidate__c i :[SELECT Id, Candidate__c FROM Candidate__c WHERE Candidate__c IN :cand.keySet()]){

        for(Candidate__c newCand :cand.get(i.Candidate__c)){
            newCand.addError('Duplicate candidate detected!');
        }

        for(List<Candidate__c> candidate : cand.values()){

            if(candidate.size() > 1){
                for(Candidate__c dupName :candidate){
                    dupName.addError('Duplicate candidate');
                }
            }
        }
    }
}