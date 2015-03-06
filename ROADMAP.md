# MTA Service Alerts Roadmap

## Overview
Every New Yorker can tell you about the time their train was stuck between stations for an hour due to a “sick passenger” or when they had to unexpectedly change their route after the conductor announced “signal problems” on their line. These phrases: “sick passenger”, “signal problems”, “police activity” are part of the straphangers lexicon. Each announcement means missed meetings and grumpy commuters. 

In a world saturated with subway navigation apps, there is an untapped data set: Unplanned Subway service interruptions.

The MTA does broadcast real-time alerts through a .txt file that is refreshed every minute but is not publicly archived.

## Use Cases
1. I am walking out the door and want to know if there are delays on my line and how quickly I can expect them to clear up so I can change my route if necessary.
2. I am on my couch and want to explore historical delays and what types of alerts happen at each station so I can compare service on different lines.

## Goals
1. Scrape data into a public API
2. Create a user interface including a map with historical alerts plotted on stations and lines
3. Allow users to request and receive alerts when their line is experiencing delays

## Challenges
1. Some data is easier to parse than others. For example, the .txt files has a class for alert type, but other data like length of delay and station of delay need additional steps to extract.

## Needs
1. Someone with advanced data parsing experience especially natural language processing

## Phase 1 | API
1. Create public API with the easily parsable fields
2. Determine how to convert human readable text to machine readable fields including station where alert occured and alert type
3. Incorporate additional fields that may require some calculations or cross referencing with other sources such as how long alert lasted and other stations affected by alert

## Phase 2 | Design
1. Integrate API into designs
2. Ability to overlay data (such as circles) on stations in map
3. Additional charts and text describing data set
4. Filtering by time, alert type and line

## Phase 3 | Alerts
1. Allow user to sign up for real time alerts via Twilio
2. Update map to show affected lines. Ex. If trains service unavailable on part of line, gray out that line in the map.
