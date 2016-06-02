# Watson-Salesforce
Lightning Component using IBM Watson Personality Insights service

A couple of months ago I started working on integrating IBM Watson with Salesforce. My [original post](http://mahathussein.com/cognitive-computing-salesforce-com/) described the overall design. 

##Demo and Other Links
- [YouTube Demo](https://www.youtube.com/embed/aX2hHcQsvGg)
- [Blog Post](http://mahathussein.com/cognitive-computing-on-salesforce-com-part-2/)

## Pre-requisites
- Knowledge of Apex and the force.com platform
- IBM Watson Developer Account - You need valid IBM Watson developer account [see here on how to get started](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/doc/getting_started/)
- Twitter App - The Personality Insights service uses this as input.[Guide creating a Twitter App](http://iag.me/socialmedia/how-to-create-a-twitter-app-in-8-easy-steps/)

##Getting Started
This section highlights all the necessary config required in your Dev Org to get and running with the component. 

Deploy the components to a Dev org. 

<a href="https://githubsfdeploy.herokuapp.com">
  <img alt="Deploy to Salesforce" src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

###Update Custom Settings

####IBM Watson Service Credentials
- Setup a IBM Watson Developer Account and create a Personality Insights Service
- Grab the credentials and store in the `IBM_Watson_PersonalityInsights` Custom Setting. The URL for the service is actually `https://gateway.watsonplatform.net/personality-insights/api/v2/profile`. The API docs can be found [here](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/personality-insights/api/v2/#profile)

####Twitter API
- Create a App on https://apps.twitter.com/ and grab the key and access token
- Store the credentials in `Twitter_API` Custom Setting

###Enable My Domain
- Find the option in Setup and select a domain, make sure its enabled before progressing to the next step.

###Add Component to Contact Page
- The Personality Insights Component should be placed on the Contact Record Home page. In order to do this you need to enable App Builder for Lightning Pages if you haven't done so already.
- Once you have done this, navigate to a Contact Record Detail page and click `Edit Page` option from the setup menu.

###Remote Site Settings
- API callouts to the Twitter API and IBM Watson need to be setup as remote sites. See below for what this should look like.
