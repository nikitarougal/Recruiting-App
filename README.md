# Salesforce Recruiting App

## Overview

The Salesforce Recruiting App is a custom application designed to streamline the recruitment process by managing job openings and candidate applications. It leverages custom objects, an Experience site for candidates, and automated workflows to enhance the hiring process. Link to the Experience site: https://saas-customization-5419-dev-ed.scratch.my.site.com/RecruitingApp

## Features

- **Job Management:** Create and manage job openings with detailed descriptions.
  
- **Candidate Portal:** A public Experience site for candidates to explore job listings, apply for positions, and interact with the recruiting process.
  
  ![image](https://github.com/nikitarougal/Recruiting-App/assets/77426901/92c35f67-d446-4ba3-865f-e351b0464e6b)

- **Application Workflow:** Candidates can apply for jobs by filling out a form, including basic information and uploading their resume.
  
![image](https://github.com/nikitarougal/Recruiting-App/assets/77426901/817d7acb-edb2-4d97-a269-718795d24b5a)

- **Personality Assessment:** Qualified candidates are prompted to provide additional information through a Personality Assessment form.

- **Email Automation:** Automated emails are sent to candidates upon application and to hiring managers when a new qualified candidate is identified.

## Custom Objects

1. **Jobs:**
   - Fields: Title, Job Description, Job Comments, Hiring Manager, Job Status, etc.

2. **Candidates:**
   - Fields: Last Name, First Name, Candidate Email, Test Responses, etc.

## Technologies Used

- **Lightning Web Components:** For building the user interface and Experience site.
  
- **Apex:** For creating custom business logic and triggers.
  
- **Flows:** For designing and automating multi-step processes.

## Setup Instructions

1. Clone the repository.

   ```bash
   git clone https://github.com/nikitarougal/Recruiting-App.git

1. Deploy the Salesforce metadata using Salesforce CLI or any other deployment tool.

2. Set up Experience site and configure necessary permissions.

3. Customize as needed for your specific organization.


## License

This project is licensed under the [MIT License](LICENSE).
