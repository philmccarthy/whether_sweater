## Instructions

Create a branch off of your Sweater Weather project called final_assessment.

As you work, please should commit to this branch every 15 minutes.

DO NOT push your code to your GitHub repo until the end of the 3 hour assessment

Complete the assignment below. You should:

TDD all of your work

Prioritize getting your code functional before attempting any refactors

Write/refactor your code to achieve good code quality

## Assignment

You will build an endpoint that will retrieve a restaurant recommendation and forecast information for a destination city.
Your endpoint should follow this format:

`GET /api/v1/munchies?start=denver,co&destination=pueblo,co&food=hamburger`

(everything will be passed with query parameters)

Your API will return:

- the destination city
- estimated travel time from start city to destination city
- the name and address of a restaurant serving THE SPECIFIED TYPE of cuisine that WILL BE OPEN at your estimated time of arrival.
- the current forecast of the destination city (not when you arrive)
- Your response should be in the format below:

```
{
  "data": {
    "id": "null",
    "type": "munchie",
    "attributes": {
      "destination_city": "Pueblo, CO",
      "travel_time": "1 hours 48 min",
      "forecast": {
        "summary": "Cloudy with a chance of meatballs",
        "temperature": "83"
      },
      "restaurant": {
        "name": "Burgers-R-Us",
        "address": "4602 N. Elizabeth St, Ste 120, Pueblo, CO 81008"
      }
    }
  }
}
```

APIs to Use

MapQuest Directions API
to find out how long it will take to travel from your start location to your end location.
https://developer.mapquest.com/documentation/directions-api/route/get/

Yelp Fusion API
to find the name and address of a restaurant in your end location
Restaurants should be open at the time of arrival
Restaurants should serve the type of food specified in the request
https://www.yelp.com/developers/documentation/v3/business_search

Open Weather Map API
to find the current forecast at the end location.
https://openweathermap.org/api