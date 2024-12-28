# Datenanalyse-in-Unternehmen
Analyse von Verkehrsströmen in Bielefeld


## HERE Maps API
### Traffic-Data:
- **length** = Total length (in meters)
- **olr** = TPEG OpenLR encoded as Base 64 strings
- **shape** = series of geo-coordinate describing the shape of the roadway
- **speed** = The average speed (in meters per second), capped by the speed limit, that current traffic is travelling
- **speedUncapped** = The average speed (in meters per second), not capped by the speed limit, that current traffic is travelling
- **freeFlow** = The free flow speed (in meters per second) is a reference speed provided to indicate the speed on the segment at which vehicles should be considered to be able to travel without impediment
- **jamFactor** = The number between 0.0 and 10.0 indicating the expected quality of travel. When there is a road closure, the jamFactor will be 10.0. As the value approaches 10.0 the quality of travel is getting worse
- **confidence** = The number between 0.0 and 1.0 indicating the proportion of real time data included in the speed calculation.

|                              |                             |
|------------------------------|-----------------------------|
| 0.7 < **confidence** <= 1.0  | indicates real time speeds  |
| 0.5 < **confidence** <= 0.7  | indicates historical speeds |
| 0.0 < **confidence** <= 0.5  | indicates speed limit       |

- traversability = Indicates whether this roadway can be driven. The possible values are given in the following table

|                           |                                                            |
|---------------------------|------------------------------------------------------------|
| **open**                  | Roadway is open and can be driven                          |
| **closed**                | Roadway is closed (blocked) and cannot be driven           |
| **reversibleNotRoutable** | The roadway is reversible but it is currently not routable |

### Traffic-Incidents:
- **length** = Total length (in meters)
- **olr** = TPEG OpenLR encoded as Base 64 strings
- **shape** = series of geo-coordinate describing the shape of the roadway
- **id** = Unique identifier for traffic incident
- **originalId** = Identifier of the first traffic incident in a chain of updates
- **startTime** = Start time of the incident
- **endTime** = End time of the incident
- **entryTime** = The time the incident was entered into the system
- **roadCloased** = A flag to indicate whether this incident is a road closure
- **criticality** = The severity of the incident that has occured, with the following possible values: **low** (least severe), **minor**, **major**, and **critical** (most severe)
- **type** = An open list of possible incident types

|                 |                                                                              |
|-----------------|------------------------------------------------------------------------------|
| accident        | Indicates that there has been a collision                                    |
| construction    | Indicates that building or roadworks are taking place                        |
| congestion      | Indicates that there has been a build up of vehicles                         |
| disabledVehicle | Indicates that a vehicle is unable to move and is obstructing the road       |
| massTransit     | Indicates that an event is present related to public transit                 |
| plannedEvent    | Indicates that an organised event is taking place causing disruption         |
| roadHazard      | Indicates that there are dangerous objects on the surface of the road        |
| roadClosure     | Indicates that the road has been closed, e.g. police presence                |
| weather         | Indicates that weather conditions are causing disruptions                    |
| laneRestriction | Indicates that some of the lanes have access restrictions                    |
| other           | Indicates that an incident not explainable with the types above has occurred |

- **codes** = A prioritised list of codes which describe the cause of the incident. The codes are given in order of importance, so the first item in the list is considered the primary cause of the incident. 
- **description** = A full natural language description of the incident
- **summary** = A short natural language description of the incident
- **vehicleRestrictions** = A list of restrictions that apply to the vehicles passing through this area
- **junctionTraversability** = Indicates junction traversability. Used for road closures to indicate if the closure can be crossed.

|                            |                                                                                       |
|----------------------------|---------------------------------------------------------------------------------------|
| allOpen                    | All junctions are open                                                                |
| allClosed                  | All junctions are closed                                                              |
| intermediateClosedEdgeOpen | Junctions at beginning and end of roadway are open, intermediate junctions are closed |
| startOpenOthersClosed      | First edge junction open, all others closed                                           |
| endOpenOthersClosed        | Last edge junction open; all others closed                                            |

### Weather-Observations:
- **countryCode** = A three-letter country code
- **countryName** = The localised country name
- **state** = A code/abbreviation for the state division of a country
- **city** = The name of the primary locality of the place
- **location** = Location on the Earth
- **daylight** = Part of the day (D=day or N=night)
- **description** = Human-readable weather description
- **skyInfo** = Sky descriptor value. If the element is in the response and it contains a value, there is an Integer in the String. If the element is in the response and it does not contain a value, there is an asterisk (*) in the String.
- **skyDesc** = Description of sky conditions
- **temperature** = Temperature in Celsius/Fahrenheit
- **temperatureDesc** = Temperature description
- **comfort** = Comfort level in degrees. This value indicates what the temperature feels like, depending on a variety of environmental factors such as wind speed and humidity.
- **highTemperature** = The Highest temperature for the day in Celsius/Fahrenheit
- **lowTemperature** = The lowest temperature for the day in Celsius/Fahrenheit
- **humidity** = Humidity as a percentage (%)
- **dewPoint** = Dew point in Celsius/Fahrenheit.
- **precipitationProbability** = Precipitation probability percentage (%)
- **rainfall** = Amount of rain in cm/in
- **windSpeed** = Wind speed in km/h or mph
- **windDirection** = Wind direction in degrees
- **windDesc** = Human readable description of the direction of the wind
- **windDescShort** = Abbreviation of the direction the wind is coming from
- **uvIndex** = UV Index value
- **uvDesc** = UV conditions description
- **barometerPressure** = Barometric pressure in mbar/in
- **barometerTrend** = Description of the trend in the barometric pressure
- **iconId** = Icon number
- **iconName** = Icon name
- **iconLink** = Link to icon resource file
- **ageMinutes** = Data age in minutes
- **activeAlerts** = Number of active weather alerts

### Weather-Alerts:
- **countryCode** = A three-letter country code
- **countryName** = The localised country name
- **state** = A code/abbreviation for the state division of a country
- **city** = The name of the primary locality of the place
- **location** = Location on the Earth
- **timeSegments** = Array of object
- **type** = Type of alert