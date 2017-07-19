# Project-Mathcraft-API [![Build Status](https://travis-ci.org/thisisDom/project-mathcraft-api.svg?branch=master)](https://travis-ci.org/thisisDom/project-mathcraft-api)

The Project-Mathcraft API manages all game data traffic(level management, user activity, etc.) across all platforms

# Resources

Documentation for various API resources can be found in the following sections:

* [Players](#players)
* [Levels](#levels)
* [Buildings](#buildings)
* [Questions](#questions)

## Players

### Fetch A Player
```
GET https://mathcraft-api.herokuapp.com/players/<player_id>
```

Example Response:
```json
// 20170718100500
// https://mathcraft-api.herokuapp.com/players/<player_id>

{
  "player": {
               "id": 1,
               "username": "this_is_Dom",
               "email_address": "this_is_Dom@this_is_Dom.com",
               "avatar_asset_link": "/path/to/avatar.png",
               "experience": 100,
               "created_at": "2017-07-17 10:00:00",
               "updated_at": "2017-07-17 10:00:00",
               "level": 4,
               "buildings": [{
                              "player_id": 1,
                              "building_id": 1,
                              "name": "magic-house-1",
                              "location": 12,
                              "offsetX": -105,
                              "offsetY": -40,
                              "asset_link": "/path/to/building.png",
                              "building_class": "Magic House",
                              "building_level": 1,
                              "created_at": "2017-07-08 08:00:00",
                              "updated_at": "2017-07-08 08:00:00"
                             }],
               "resources": [{
                              "player_id": 1,
                              "resource_id": 1, 
                              "name": "wood",
                              "quantity": 20,
                              "asset_link": "/path/to/resource.png",
                              "created_at": "2017-07-08 08:00:00",
                              "updated_at": "2017-07-08 08:00:00"
                             }]
             }
}
```

## Levels

## Get all levels(ordered by position)
```
GET https://mathcraft-api.herokuapp.com/levels
```

Example Response:
```json
// 20170718100500
// https://mathcraft-api.herokuapp.com/levels

{ 
  "levels": [{
             "position": 1,
             "experience": 10,
             "time_limit": 60,
             "assets": {
                          "boss": "",
                          "minion": ["minion_1.png", "minion_2.png"],
                          "phaser-background": "phaser-background.png",
                          "calculator-background": "calculator-background.png",
                        },
              "title": "Forest",
              "level_type": "time attack",
              "level_requirement": 0
             }]
}
```

## Buildings

### Get available Buildings
```
GET https://mathcraft-api.herokuapp.com/buildings
```

Example Response:
```json
// 20170718100500
// https://mathcraft-api.herokuapp.com/buildings

{
   "buildings": [{
                  "building_id": 1,
                  "name": "magic-house-1",
                  "asset_link": "/path/to/building.png",
                  "building_class": "Magic House",
                  "building_level": 1,
                  "created_at": "2017-07-08 08:00:00",
                  "updated_at": "2017-07-08 08:00:00",
                  "resources": [{
                              "building_id": 1,
                              "resource_id": 1, 
                              "name": "wood",
                              "quantity": 20,
                              "asset_link": "/path/to/resource.png",
                              "created_at": "2017-07-08 08:00:00",
                              "updated_at": "2017-07-08 08:00:00"
                             }]
                 }]
}
```


### Get a Player's Buildings
```
GET https://mathcraft-api.herokuapp.com/playersbuildings/<player_id>
```

Example Response:
```json
// 20170718100500
// https://mathcraft-api.herokuapp.com/playersbuildings/<player_id>

{
  "player": {
               "buildings": [{
                              "player_id": 1,
                              "building_id": 1,
                              "name": "magic-house-1",
                              "location": 12,
                              "offsetX": -105,
                              "offsetY": -40,
                              "asset_link": "/path/to/building.png",
                              "building_class": "Magic House",
                              "building_level": 1,
                              "created_at": "2017-07-08 08:00:00",
                              "updated_at": "2017-07-08 08:00:00"
                             }]
              }
}
```

### Creating a Building

```
POST https://mathcraft-api.herokuapp.com/playersbuildings/<player_id>
```
Parameters:

|  Attributes   |  Type   | Description                                                                    |
|---------------|---------|--------------------------------------------------------------------------------|
| location      | integer | The tile location of the buildings(0-25)                                       |
| building_name | string  | The name of the building being built(ex. "magic-house-1")                      |

Example Response:
```json
// 20170718100500
// https://mathcraft-api.herokuapp.com/playersbuildings/<player_id>

{
  "player": {
               "buildings": [{
                              "player_id": 1,
                              "building_id": 1,
                              "name": "magic-house-1",
                              "location": 12,
                              "offsetX": -105,
                              "offsetY": -40,
                              "asset_link": "/path/to/building.png",
                              "building_class": "Magic House",
                              "building_level": 1,
                              "created_at": "2017-07-08 08:00:00",
                              "updated_at": "2017-07-08 08:00:00"
                             }]
              }
}
```


### Upgrading a Building
```
POST https://mathcraft-api.herokuapp.com/playersbuildings/<player_id>/upgrade
```
Parameters:

|  Attributes   |  Type   | Description                                                                    |
|---------------|---------|--------------------------------------------------------------------------------|
| location      | integer | The tile location of the buildings(0-25)                                       |
| building_name | string  | The name of the building being built(ex. "magic-house-1")                      |

Example Response:
```json
// 20170718100500
// https://mathcraft-api.herokuapp.com/playersbuildings/<player_id>/upgrade

{
  "player": {
               "buildings": [{
                              "player_id": 1,
                              "building_id": 1,
                              "name": "magic-house-1",
                              "location": 12,
                              "offsetX": -105,
                              "offsetY": -40,
                              "asset_link": "/path/to/building.png",
                              "building_class": "Magic House",
                              "building_level": 1,
                              "created_at": "2017-07-08 08:00:00",
                              "updated_at": "2017-07-08 08:00:00"
                             }]
              }
}
```
