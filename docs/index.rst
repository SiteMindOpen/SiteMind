=============
SiteMind Open
=============

Domain research tool targeting media planners and reseaerchers, specifically built for countering ad fraud and reducing its impact on media investment. Returns a result with up to 40 signals for any site typically in 1-3 seconds.

--------------------
OVERVIEW OF FUNCTION
--------------------

SiteMind allows two different kinds of searches to be performed by the user: 

- type-1: where a single domain name is the input 
- type-2: where a comma separated list of domain names is the input 

In both cases the system performs a series of operations resulting in up to 40 signals, which are then stored in a .csv file. Depending on the type of search, the result will then be returned either as a simple user interface, or a table with results for multiple sites. 

---------------
PROCESS FLOW 
---------------

1) User provides input 
2) System detects if there is single or multiple domains in the input
3) System checks if recent cache already has a result and if yes moves to step NNN
4) If there is no result in the cache the primary cycle starts 
5)


run.sh
    sitemind.sh 
        api-fetch.sh
            alexa_data.sh
            whois_data.sh
            wot_data.sh
                wo_data.py
            env-cleanup.sh
            api-build.sh
            env-cleanup.sh
            score-compute.sh
            data-export.sh
            data-cms.sh
            
            cms-scorecard.sh
            cms-overview.sh
            cms-traffic.sh
        
                
            
       
-------------
DATA TAXONOMY
-------------

The below table shows all the signals that are currently available through SiteMind. All variables are available through the scan function in the resulting .csv file, or in the user interface resulting from a single site search. 

NOTE: Different naming may be used in the user interfaces, and this is easily changed. 

**VARIABLE NAME** is the name of the variable as it is found in the output file resulting from a search of scan. 

**SOURCE** is the reference to where the data is originating from. In the case the filed says 'sitemind' it means that the signal is inferred from other data. 

**COLUMN NUMBER** is only for development purpose and is used in the UI codes to to present a certain signal in a given place in the user interface. 


+------------------------+-------------+---------+
|                        |             | COLUMN  |
| VARIABLE NAME          | SOURCE      | NUMBER  |
+========================+=============+=========+
| SCORE_CHECKS           | sitemind    | 2       |
+------------------------+-------------+---------+
| SCORE_UPSTREAM         | sitemind    | 3       |
+------------------------+-------------+---------+
| SCORE_UPSTREAMCHECK    | sitemind    | 4       |
+------------------------+-------------+---------+
| SCORE_TRUST            | sitemind    | 5       |
+------------------------+-------------+---------+
| SCORE_TOPKEYWORDS      | sitemind    | 6       |
+------------------------+-------------+---------+
| SCORE_SEARCH           | sitemind    | 7       |
+------------------------+-------------+---------+
| SCORE_PAGEVIEWS        | sitemind    | 8       |
+------------------------+-------------+---------+
| SCORE_YEARS            | sitemind    | 9       |
+------------------------+-------------+---------+
| SCORE_PRIVACY          | sitemind    | 10      |
+------------------------+-------------+---------+
| SCORE_BOUNCERATE       | sitemind    | 11      |
+------------------------+-------------+---------+
| ADMIN_CITY             | whois       | 12      |
+------------------------+-------------+---------+
| ADMIN_COUNTRY          | whois       | 13      |
+------------------------+-------------+---------+
| ALEXA_BOUNCERATE       | alexa       | 14      |
+------------------------+-------------+---------+
| ALEXA_INLINKS          | alexa       | 15      |
+------------------------+-------------+---------+
| ALEXA_LOADSPEED        | alexa       | 16      |
+------------------------+-------------+---------+
| ALEXA_PAGEVIEWS        | alexa       | 17      |
+------------------------+-------------+---------+
| ALEXA_RANK             | alexa       | 18      |
+------------------------+-------------+---------+
| ALEXA_SEARCHVISITS     | alexa       | 19      |
+------------------------+-------------+---------+
| ALEXA_TIMEONSITE       | alexa       | 20      |
+------------------------+-------------+---------+
| ALEXA_TOPCOUNTRIES     | alexa       | 21      |
+------------------------+-------------+---------+
| ALEXA_TOPKEYWORDS      | alexa       | 22      |
+------------------------+-------------+---------+
| ALEXA_UPSTREAM1        | alexa       | 23      |
+------------------------+-------------+---------+
| ALEXA_UPSTREAM1N       | alexa       | 24      |
+------------------------+-------------+---------+
| ALEXA_UPSTREAM2        | alexa       | 25      |
+------------------------+-------------+---------+
| ALEXA_UPSTREAM2N       | alexa       | 26      |
+------------------------+-------------+---------+
| ALEXA_UPSTREAM3        | alexa       | 27      |
+------------------------+-------------+---------+
| ALEXA_UPSTREAM3N       | alexa       | 28      |
+------------------------+-------------+---------+
| ALEXA_UPSTREAM4        | alexa       | 29      |
+------------------------+-------------+---------+
| ALEXA_UPSTREAM4N       | alexa       | 30      |
+------------------------+-------------+---------+
| ALEXA_UPSTREAM5        | alexa       | 31      |
+------------------------+-------------+---------+
| ALEXA_UPSTREAM5N       | alexa       | 32      |
+------------------------+-------------+---------+
| CHECKS_TOTAL           | alexa       | 33      |
+------------------------+-------------+---------+
| CHECK_FALSE            | alexa       | 34      |
+------------------------+-------------+---------+
| CHECK_TRUE             | alexa       | 35      |
+------------------------+-------------+---------+
| TOP5_UPSTREAM          | alexa       | 36      |
+------------------------+-------------+---------+
| WHOIS_PRIVACY          | whois       | 37      |
+------------------------+-------------+---------+
| WHOIS_YEARS            | whois       | 38      |
+------------------------+-------------+---------+
| WOT_CHILDSAFETY        | weboftrust  | 39      |
+------------------------+-------------+---------+
| WOT_TRUST              | weboftrust  | 40      |
+------------------------+-------------+---------+


------------
DATA SOURCES
------------

While adding virtually any additional data soruce, SiteMind relies on three different data source by default. 

- Alexa
- Web of Trust
- WHOIS 

**ALEXA***

It is recommended to use the paid Alexa API. SiteMind uses web scraping method by default for demo and prototyping purpose. 

**Web of Trust**

Web of Trust data is fetched using the WOT API, which provides a rich data taxonomy and is free to use to a substantial level of daily usage. 

More information on the WOT API can be found here: https://www.mywot.com/wiki/API

You can apply for your own API key here: https://www.mywot.com/en/reputation-api

**WHOIS**

SiteMind provides a fully automated method for the "gold standard" way of fetching WHOIS records. 

1) Gets to main record from the tld level registar including the registar that holds the sub-record 
2) Gets the sub-record from the holding registar 

------------------
CODING CONVENTIONS
------------------

The code is almost 100% bash and certain principles have been followed where possible: 

- code starts one tab intend deep
- each script (.sh file) represents a step in the process flow
- no more than 50 lines of code per script 
- no more than 50 characters long lines of code
- functions first, program second, cleanup last 
- mininal comments - instead self-explaining code 

It should be very easy for anyone with beginner+ level in bash to modify the code that is already there, to add new code to improve current functionality, or add completely new functionality. 
