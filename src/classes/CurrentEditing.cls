/**
 * Created by Adelchi on 15/09/2019.
 */


public with sharing class CurrentEditing {
    /**
 * Purpose : (Flag Case record which is potentially being edited. It updates isEdited__c)
 * @param (parameter recId) (Id of the Case being edited)
 * @return (Boolean value of isEdited__c, true if case is being edited, false if it is not.)
 */

    @AuraEnabled
    public static Boolean run(String recId){
        String currentUserId = UserInfo.getUserId();
        Case c = [SELECT disoned__isEdited__c, disoned__currentUser__c FROM Case WHERE Id =: recId];
        if(c.disoned__isEdited__c == false){
            c.disoned__isEdited__c = true;
            c.disoned__currentUser__c = currentUserId;
            update c;
            return false;
        }else if(c.disoned__isEdited__c == true && c.disoned__currentUser__c != currentUserId){
            return true;
        }else{return false;}
    }

    @AuraEnabled
    public static void destroy(String recId){
        String currentUserId = UserInfo.getUserId();
        Case c = [SELECT disoned__isEdited__c, disoned__currentUser__c FROM Case WHERE Id =: recId];
        if(c.disoned__isEdited__c == true && c.disoned__currentUser__c == currentUserId){
            c.disoned__currentUser__c = '';
            c.disoned__isEdited__c = false;
            update c;
        }
    }

    @AuraEnabled
    public static void saveEditingStatus(String recId){
        String currentUserId = UserInfo.getUserId();
        Case c = [SELECT disoned__isEdited__c, disoned__currentUser__c FROM Case WHERE Id =: recId];
        if(c.disoned__isEdited__c == true && c.disoned__currentUser__c == currentUserId){
            c.disoned__isEdited__c = false;
            update c;
        }else if(c.disoned__isEdited__c == true && c.disoned__currentUser__c != currentUserId){

        }
    }
}