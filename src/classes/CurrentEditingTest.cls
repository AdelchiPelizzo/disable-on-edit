/**
 * Created by Adelchi on 22/09/2019.
 */


@IsTest
private class CurrentEditingTest {
    private static User u1;
    private static User u2;
    private static Case cas;

    static void generateTestUsers() {
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        u1 = new User(
                Alias = 'standt1',
                Email='standarduser1@testorg.com',
                EmailEncodingKey='UTF-8',
                LastName='Testing1',
                LanguageLocaleKey='en_US',
                LocaleSidKey='en_US',
                ProfileId = p.Id,
                TimeZoneSidKey='America/Los_Angeles',
                UserName='standarduser1@disoned.com'
        );
        insert u1;
        u2 = new User(
                Alias = 'standt2',
                Email='standarduser2@testorg.com',
                EmailEncodingKey='UTF-8',
                LastName='Testing2',
                LanguageLocaleKey='en_US',
                LocaleSidKey='en_US',
                ProfileId = p.Id,
                TimeZoneSidKey='America/Los_Angeles',
                UserName='standarduser2@disoned.com'
        );
        insert u2;
    }

    static void createCaseTest(Boolean bool, User u) {
        cas = new Case(
                Status ='New',
                Priority = 'Medium',
                Origin = 'Email',
                isEdited__c = bool,
                currentUser__c = u.Id
        );
        insert cas;
    }

    static void createCaseTest(User u) {
        cas = new Case(
                Status ='New',
                Priority = 'Medium',
                Origin = 'Email',
                currentUser__c = u.Id
        );
        insert cas;
    }

    @IsTest
    static void runTest () {
        generateTestUsers();
        System.runAs(u1){
            createCaseTest(true, u1);
            System.assertEquals(false, currentEditing.run(cas.Id));
            createCaseTest(true, u2);
            System.assertEquals(true, currentEditing.run(cas.Id));
            createCaseTest(u1);
            System.assertEquals(false, currentEditing.run(cas.Id));
            currentEditing.destroy(cas.Id);
            System.assertEquals(cas.isEdited__c, false);
            createCaseTest(u2);
            currentEditing.destroy(cas.Id);
            System.assertEquals(cas.isEdited__c, false);
            createCaseTest(true, u1);
            currentEditing.saveEditingStatus(cas.Id);
            System.assertEquals(cas.isEdited__c, true);
            createCaseTest(u2);
            currentEditing.saveEditingStatus(cas.Id);
            System.assertEquals(cas.isEdited__c, false);
        }
    }
}