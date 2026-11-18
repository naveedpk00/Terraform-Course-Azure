# Day 01 - Terraform basics

## What is Infra as a Code

Infrastructure as Code (IaC) is the practice of defining and managing infrastructure, such as servers, networks, databases, and storage accounts, through code files rather than manual steps in a cloud portal or ad hoc commands.


 <img width="1293" height="816" alt="Gemini_Generated_Image_d5pyj0d5pyj0d5py" src="https://github.com/user-attachments/assets/1991d5a9-d7f6-4a77-8dca-5f0e209f0b60" />

## Why do we use Infra as a code?
When you can do that from the Azure console, login to the portal and create, drag, and drop.
Why take the pain of writing code for drag and drop?

Problems with manual setup:

- Clicking through a portal is slow, especially with many resources or environments.
- Human error is common. A missed setting or wrong option can cause outages or security gaps.
- Two environments that were meant to be identical often drift apart over time.
- No record exists of what was changed, when, or by whom.
- Rebuilding after a failure or disaster is difficult when the setup lives in someone’s memory.

<img width="1376" height="768" alt="Gemini_Generated_Image_z26t6zz26t6zz26t" src="https://github.com/user-attachments/assets/9152fceb-c8f6-451c-b936-422c0dd8da81" />


Say you need to provision the infrastructure for a three-tier application. Time taken: 2 hours. 
<img width="1376" height="768" alt="Gemini_Generated_Image_t2y4slt2y4slt2y4" src="https://github.com/user-attachments/assets/c807cdab-3c6a-424b-98a1-ef3d71dae79f" />

That’s fine for a personal project or while you’re learning.

Now imagine you’re working at a company with 4 environments. Time taken: 8 hours. No big deal, right?
Now multiply that by every change, every new project, and every team. That’s where manual provisioning stops scaling.
<img width="1376" height="768" alt="Gemini_Generated_Image_t9hacyt9hacyt9ha" src="https://github.com/user-attachments/assets/341a2110-e19b-4d27-b952-df5ac01a95e7" />

- Now imagine deploying 100s of servers. Tricky? And that’s not even the real problem.
- Costs keep piling up because resources stay running. Tearing everything down every day isn’t practical.
- Environments that should be identical but aren’t: “But it works on my machine!”
- The fix: automate how you provision, manage, and destroy infrastructure.
- The payoff: reliability, efficiency, and security.
<img width="1376" height="768" alt="Gemini_Generated_Image_err637err637err6" src="https://github.com/user-attachments/assets/56fdddf7-fe40-4aba-af09-fff78d8b1570" />

## Benefits of IaC:
- Consistent environment
- Easy to track cost
- Write once, deploy many (single code base)
- Time saving
- Reduced human error
- Cost saving
- Version control, changes are tracked in git
- Automated cleanup/scheduled destruction
- Easy to set up and destroy
- The developer can focus on app development
- Easy to create an identical production environment for troubleshooting

## What is Terraform
IaaC tool that helps do all these tasks

<img width="1376" height="768" alt="Gemini_Generated_Image_a2twnoa2twnoa2tw" src="https://github.com/user-attachments/assets/407f06f5-4930-4779-a8ee-e7a29e48dd47" />

## How it works
Write your terraform files --> Run terraform commands --> Call the target cloud provider API to provision the infra using Terraform Provider

<img width="1376" height="768" alt="Gemini_Generated_Image_4u97oa4u97oa4u97" src="https://github.com/user-attachments/assets/4f922233-7c2c-4fd4-9b02-ae5552764dad" />

Phases: init --> validate --> plan --> apply --> destroy


## Task for Day02
### Install Terraform
```
https://developer.hashicorp.com/terraform/install
```
### Common Error

```
brew install hashicorp/tap/terraform
Error: No developer tools installed.
Install the Command Line Tools:
  xcode-select --install
```

- Install the code tool for mac --> popup will appear, install using that
### Use below commands
```
terraform -install-autocomplete
alias tf=terraform
terraform -version
```
