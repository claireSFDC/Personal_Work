@isTest
public with sharing class dateTimeConverterTest {
    @IsTest
    static void testDateTimeConverter(){

        Profile systemadminprofile = [Select id, name from profile where name = 'System Administrator'];

        User newUser = new User(
            LastName = 'dateTimeConverterTest',
            username = 'dateTimeConverterTest@sf.com',
            email = 'dateTimeConverterTest@sf.com.invalid',
            alias = 'dxtxc',
            CommunityNickname = 'dateTimeConverterTest',
            LocaleSidKey = 'en_US',
            TimeZoneSidKey = 'America/New_York',
            LanguageLocaleKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            profileid = systemadminprofile.id
        );
        insert newUser;

        Test.startTest();
        System.runAs(newUser){
            dateTimeConverterController.dateTimeConverter dtToTest = new dateTimeConverterController.dateTimeConverter();
            List<dateTimeConverterController.dateTimeConverter> dtToTestList = new List<dateTimeConverterController.dateTimeConverter>();
            List<String> results = new List<String>();

            Datetime myDateTime = Datetime.newInstance(2023, 2, 27, 5, 30, 0);

            dtToTest.dateTimeVar = myDateTime;
            dtToTest.formatString = 'yyyy-MM-dd h:mm a';
            dtToTest.timeZoneName = 'America/Los_Angeles';
            
            dtToTestList.add(dtToTest);
            
            //Test positive
            results = dateTimeConverterController.dateTimeConverterMethod(dtToTestList);
            System.assertEquals('2023-02-27 2:30 AM', results[0]);
         

            Test.stopTest();
            }
        
    }
}