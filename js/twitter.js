// integrate twit to pull tweets
// https://github.com/ttezel/twit
var Twit = require('twit');
// We need to include our configuration file
var T = new Twit(require('./config.js'));

// integrate jsonfile to save tweets to json file
// https://www.npmjs.com/package/jsonfile
var jf = require('jsonfile');
var util = require('util');

// get access to json file
var file = '../data.json'
jf.readFile(file, function(err, obj) {
    console.log(err)
});

// This function finds the latest tweets by the q parameter and in the US, and displays it in the console.
function getTweets()
{
    // This is the URL of a search for the latest tweets by the q parameter.
    // filter the public stream by the latitude/longitude/radius bounded box of US
    // searches
    var query1 = { q: 'hastac2015', count: 100 };
    var query2 = { q: 'hastac', count: 100 };

    var queryList = [query1, query2];

    // list that holds found tweets
    var tweetList = [];

    for (index = 0; index < queryList.length; index++)
    {
        T.get('search/tweets', queryList[index], function(error, data) 
        {

            // If our search request to the server had no errors...
            if (!error) {

                // iterates through each tweet metadata
                for (index = 0; index < data.statuses.length; index++)
                {
                    // takes text from tweet
                    var tweetText = data.statuses[index].text;

                    // takes user's name from tweet
                    var screenName = "@" + data.statuses[index].user.screen_name;

                    // takes screen name from tweet
                    var userName = data.statuses[index].user.name;

                    var fullTweet = {text:tweetText, name:userName, handle:screenName};

                    tweetList.push(fullTweet);

                    //console.log(fullTweet);

                }

                jf.writeFile(file, tweetList, function(err) {
                  console.log(err)
                })

            }

            // However, if our original search request had an error, we want to print it out here.
            else {
                console.log(error);
            }
        })
    }
}

getTweets();

// ...and then every hour after that. Time here is in milliseconds, so
// 1000 ms = 1 second, 1 sec * 60 = 1 min, 1 min * 60 = 1 hour --> 1000 * 60 * 60
// setInterval(getTweets, 1000 * 60 * 60);