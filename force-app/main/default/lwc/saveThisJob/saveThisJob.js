import { LightningElement, api, track } from "lwc";
import sendJobEmail from "@salesforce/apex/JobEmailSender.sendJobEmail";

export default class SaveThisJob extends LightningElement {
  @api jobId;
  @track email = "";
  @track errorMessage = "";
  @track successMessage = "";

  handleEmailChange(event) {
    this.email = event.target.value;
  }

  sendJobEmail() {
    sendJobEmail({ jobId: this.jobId, userEmail: this.email })
      .then((result) => {
        if (result === "Email sent successfully") {
          this.errorMessage = "";
          this.successMessage = "The job details have been sent to your email.";
        } else {
          this.errorMessage = "There was an issue sending the email.";
          this.successMessage = "";
        }
      })
      .catch((error) => {
        this.errorMessage = "An error occurred: " + error.body.message;
        this.successMessage = "";
      });
  }
}
