import { LightningElement,api } from 'lwc';
import uploadFile from '@salesforce/apex/FileUploader.uploadFile'

export default class UploadAttachment extends LightningElement {
    @api candidateId;
    fileData
    openfileUpload(event) {
        const file = event.target.files[0]
        var reader = new FileReader()
        reader.onload = () => {
            var base64 = reader.result.split(',')[1]
            this.fileData = {
                'filename': file.name,
                'base64': base64,
                'candidateId': this.candidateId
            }
            console.log(this.fileData)
            console.log(this.candidateId)
        }
        reader.readAsDataURL(file)
    }
    
    handleClick(){
        const {base64, filename, candidateId} = this.fileData
        uploadFile({ base64, filename, candidateId }).then(result=>{
            this.fileData = null;
            if (result) {
                // If the result is not null, show a success message
                let title = `${filename} uploaded successfully!`;
                alert(title);
            } else {
                // Handle the case where the result is null (or an error occurred)
                alert('File upload failed. Please try again.');
            }
        })
        .catch(error => {
            // Handle any potential error from the Apex call
            alert('An error occurred: ' + error.body.message);
        });
    }

}