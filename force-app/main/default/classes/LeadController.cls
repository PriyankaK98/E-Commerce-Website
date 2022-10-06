/********************************************************************************
ClassName: LeadController
Author : Priyanka K
CreatedDate : 02-07-2021
Purpose: Controller on Lead Object
********************************************************************************/
public with sharing class LeadController {

/*******************************************************************************
*MethodName: getLeads
*Parameters Accepted: None
*Purpose: get the top 10 Lead records (Sort by Created date)
********************************************************************************/
    @AuraEnabled(cacheable=true)
    public static List<Lead> getLeads() {
        return [SELECT Name, Email, Phone, Company, Status 
                          FROM Lead order by CreatedDate desc LIMIT 10];
    }

/*******************************************************************************
*MethodName: saveTask
*Parameters Accepted: Subject, Comments, And Lead to log a call
*Purpose: Creating a task on the lead
********************************************************************************/


    @AuraEnabled
    public static void saveTask(String subject, String description, Id lead){
        List<Lead> leads= [SELECT OwnerId FROM Lead WHERE id = :lead];
        Task t=new Task();
        t.Subject = subject;
        t.Description = description;
        t.WhoId = lead;
        t.OwnerId = leads[0].OwnerId;
        t.ActivityDate = Date.today();
        try {
            insert t;
        } catch (Exception e) {
            System.debug(e);
        }

    }
}