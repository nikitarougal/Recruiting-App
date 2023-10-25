public with sharing class JobEmailSender {
  public class CustomEmailException extends Exception {
  }

  @AuraEnabled(cacheable=true)
  public static String sendJobEmail(Id jobId, String userEmail) {
    // Retrieve the job details (e.g., job title and description) based on the jobId
    List<Job__c> jobs = [
      SELECT Name, Job_Description__c
      FROM Job__c
      WHERE Id = :jobId
    ];
    // Compose an email with the job details and a link to the job description page
    if (jobs.isEmpty()) {
      return 'Job not found';
    }
    // You can use Salesforce's Email Services or third-party email services here

    // Send the email
    Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();

    message.toAddresses = new List<String>{ userEmail };
    message.subject = jobs[0].Name + ' job posting';
    message.plainTextBody =
      jobs[0].Job_Description__c +
      '. Find more on https://customer-computing-5490.scratch.my.site.com/RecruitingApp';

    List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>{
      message
    };

    Messaging.SendEmailResult[] emailResults = Messaging.sendEmail(messages);

    if (!emailResults[0].success) {
      throw new CustomEmailException(emailResults[0].errors[0].message);
    }

    return 'Email sent successfully';
  }
}