// Derives a working L-System formula from the provided text string

// word count = generations
// word length = angle variance for the various characteristics
// some colour control?

// each tweet is at max 140 characters

int wordNum = 1; // generations
int wordLength = 1;

boolean ready = true;

IntList varians = new IntList();


void parseTweet(String tweetedText)
{
  if(ready)
  {
    twit = tweetedText;
    // clear the list
    varians.clear();
    
    // split the string into component words using " " delimeter 
    String[] words = split(tweetedText,' ');
    
    // set number of words => generations... may need to be scaled down as +16 is crazy massive
    wordNum = constrain(words.length, 2,MAXGENERATIONS);
    println("words found : " + words.length);
    

    for(int i= 0 ; i < words.length; i++)
    {
      varians.append(numMap(words[i].length()));
    }
    
    // fill list with 0 if there are less than 9 words
    if(varians.size() < 9)
    {
      int tmp = 9 - varians.size();
      for (int i = 0; i < tmp ; i++)
      {
        varians.append(0);  // can be any value... may need tweaking for effect
      }
    }
    // shuffle the values around
    rando();
    // assign a random colour
    randColour();
    ready = !ready;
  }
}


// allow for a new tweet to be called 
void keyPressed()
{
  if(key == 'C' || key == 'c')
  {
    randColour();
  }
  
  if(key == 'Z' || key == 'z')
  {
    nextTweet = !nextTweet;
  }  
  
  // increment generations
  if(key == '>' || key == '.')
  {
    wordNum++;
    if(wordNum > MAXGENERATIONS) { wordNum = MAXGENERATIONS; }
  } 
  
  if(key == '<' || key == ',')
  {
    wordNum--;
    if(wordNum < 1) { wordNum = 1; }
  }
}

int numMap(int number)
{
  // set a variance of -45 degrees to +45
  // assuming word length no longer than 12 letters
  // anything above 12 characters = 90 degrees
  // constrained to that it wont go above 90 degrees
  
  return constrain((int)map(number, 1, 12, -30, 30), -25, 60);
    
}

void randColour()
{
  r = random(1, 255);
  g = random(1, 255);
  b = random(1, 255);
}


void rando()
{ 
  for(int i = 0; i < wordNum; i++)
  {
    int temp = varians.get(i);
    int select = (int)random(1, wordNum + 1);
    
    // swap values around
    varians.set(i,varians.get(select)); 
    varians.set(select, temp);
  }
}
    
