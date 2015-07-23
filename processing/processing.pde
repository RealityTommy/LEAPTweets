// initializes global variables
ArrayList<Tweet> tweets;
String tweetString;
JSONArray tweetList;
PImage bg;
PImage hand;

void setup()
{
  /* Sets up canvas and prepare array of tweets */
  
  // removes cursor
  noCursor();
  // loads hand image
  hand = loadImage("hand.png");
    
  // allows window to be resized
  frame.setResizable(true);
  
  bg = loadImage("TweetBackground02.jpg");
  
  // draws canvas
  size(displayWidth, displayHeight);
  
  // sets up array of tweets
  tweets = new ArrayList();
  
  // loads JSON file containing tweets
  tweetList = loadJSONArray("../data.json");
  
  // iterates through JSON file and add tweets to tweets array
  for (int i = 0; i < 50; i++)
  {
    JSONObject t = tweetList.getJSONObject(i);
    String text = t.getString("text");
    String name = t.getString("name");
    String handle = t.getString("handle");
    
    Tweet tweet = new Tweet(text, name, handle);
    tweets.add(tweet);
  }
  
}

void draw() {  
  /* Displays tweets and boxes on canvas */
  
  tint(255, 255);
    
  // background image setup
  for (int i = 0; i < displayWidth * 6; i = i + displayWidth)
  {
    image(bg, i, 0, displayWidth, displayHeight);  
  }
  
  // iterates through array of tweets and displays them on canvas
  for (Tweet tweet : tweets)
  {
    tweet.displayTweet();
    tweet.resetTweet();
  }
  
  // displays image of hand
  tint(255, 100);
  image(hand, mouseX-32, mouseY-32, 64, 64);
}

class Tweet
{
  /* Sets up class to display tweets and boxes */
  
  // variables to set size of text boxes and boxes
  String text;
  String name;
  String handle;
  float xpos = random(displayWidth);
  float ypos = random(45, displayHeight - 175);
  float xspeed = random(3.1, 6.1);
  int fontSize = 12;

  // constructors for Tweet object
  Tweet(String tempText, String tempName, String tempHandle)
  { 
    text = tempText;
    name = tempName;
    handle = tempHandle;
   }

  void displayTweet() 
  { 
    /* Displays box behind tweet text */
    stroke(41, 150, 60);
    
    if (mouseX > xpos && mouseX < xpos+425 && 
        mouseY > ypos && mouseY < ypos+150) 
    {
            
      if(true) 
      { 
        fill(41, 118, 60, 225);
        rect(xpos-10, ypos-10, 700, 175, 7); 
        
        fill(255);
        
        textSize(fontSize * 2);
        text(name, xpos + 10 , ypos, 600, 150);
        
        textSize(fontSize * 1.25);
        text(handle, xpos + 10 , ypos+30, 600, 150);
        
        textSize(fontSize * 1.5);
        text(text, xpos + 10 , ypos+60, 600, 150);
        
        xpos += 0;
      }
    }
    else
    {
      fill(41, 118, 60, 225);
      rect(xpos-10, ypos-10, 450, 125, 7);
      
      fill(255);
      
      textSize(fontSize * 1.5);
      text(name, xpos + 10 , ypos, 425, 75);
      
      textSize(fontSize);
      text(handle, xpos + 10 , ypos+25, 425, 75);
      
      textSize(fontSize * 1);
      text(text, xpos + 10 , ypos+50, 425, 75);
      
      xpos += xspeed;
    }
  }

  void resetTweet()
  {
    /* Move tweet back to beginning once it runs off display */
    
    if (xpos > (width + 515)) {
      xpos = -515;
    }
  }
}
