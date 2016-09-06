# SiteMind - Open Source Website Intelligence

### WHAT IS IT

Domain research tool targeting media planners and reseaerchers, specifically built for countering ad fraud in media investment. 

### FEATURE  HIGHLIGHTS

- intuitive 'buy score' system for website rating
- search any domain
- returns result usually in 1 to 2 seconds
- up to 150 data points per site from 5 different sources  
- easy to use API with ready end-points for all common languages


### GETTING STARTED 

At the moment the only dependency is HTML::Strip. You can install it from terminal with: 

    sudo cpan install "HTML::Strip"

To make sure that all the scripts have correct permissions, in the program root folder run: 

    chmod +x ./bin/*.sh s33r.sh

Before using s33r, you also have to have a PHP server running. In the program root folder run: 

    sudo php -S 127.0.0.1:80 && ./s33r.sh viralands.com && /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --app="http://127.0.0.1/scorecard.html" --window-size="1000x800"

This should result in a browser window opening with a result for 'viralands.com'. 

### THE APPLICATION

Once you've followed the above steps, you should see a screen like the one below. From there you can search and get a result for any domain. 

<img src="https://s4.postimg.org/6qtx7e57x/screen1.jpg" alt="Drawing" width="700"/>
