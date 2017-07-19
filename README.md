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

### Get all levels (sorted by order position)

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

### Starting A level

```
POST https://mathcraft-api.herokuapp.com/playerslevels/start
```

Parameters:

|  Attributes |  Type   | Description                                                                    |
|-------------|---------|--------------------------------------------------------------------------------|
| level_id    | integer | The id of the level                                                            |
| player_id   | integer | The id of the player                                                           |

Example Response:
```json
// 20170718100500
// https://mathcraft-api.herokuapp.com/playerslevels/start

{
  "player_level": {
                     "player_id": 1,
                     "level_id": 10,
                     "time_started": "2017-07-18 10:05:00",
                     "time_complete": "",
                     "correct_answers": ,
                     "created_at": "2017-07-18 10:05:00",
                     "updated_at": "2017-07-18 10:05:00"
                   }
}
```

### Completing A level

```
POST https://mathcraft-api.herokuapp.com/playerslevels/complete
```

Parameters:

|  Attributes      |  Type   | Description                                 |
|------------------|---------|---------------------------------------------|
| players_level_id | integer | The id of the players_level played          |
| player_id        | integer | The id of the player                        |
| correct_answers  | integer | The number of questions answered correctly  |

Example Response:
```json
// 20170718100500
// https://mathcraft-api.herokuapp.com/playerslevels/start

{
  "player_level": {
                     "player_id": 1,
                     "level_id": 10,
                     "time_started": "2017-07-18 10:05:00",
                     "time_complete": "",
                     "correct_answers": ,
                     "created_at": "2017-07-18 10:05:00",
                     "updated_at": "2017-07-18 10:05:00"
                   }
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

|  Attributes   |  Type   | Description                                               |
|---------------|---------|-----------------------------------------------------------|
| location      | integer | The tile location of the buildings(0-25)                  |
| building_name | string  | The name of the building being built(ex. "magic-house-1") |

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

|  Attributes   |  Type   | Description                                               |
|---------------|---------|-----------------------------------------------------------|
| location      | integer | The tile location of the buildings(0-25)                  |
| building_name | string  | The name of the building being built(ex. "magic-house-1") |

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

## Questions
### Generating Questions

```
GET https://mathcraft-api.herokuapp.com/generate/?type=<question_type>&difficulty=<question_difficulty>
```
Parameters:

|  Attributes   |  Type   | Description                                               |
|---------------|---------|-----------------------------------------------------------|
| type          | string  | The type of question that will be asked (e.g addition)    |
| difficulty    | string  | The difficulty of each question (e.g "hard")              |


Example Response:
```json
// 20170718100500
// https://mathcraft-api.herokuapp.com/generate/?type=addition&difficulty=hard

{
  "instructions":"
    Return the sum of the two numbers",
  "questions":
    [
      {"problem":"16 + 13","answer":29},
      {"problem":"29 + 27","answer":56},
      {"problem":"11 + 11","answer":22},
      {"problem":"28 + 18","answer":46},
      {"problem":"26 + 12","answer":38},
      {"problem":"22 + 19","answer":41},
      {"problem":"11 + 11","answer":22},
      {"problem":"21 + 17","answer":38},
      {"problem":"16 + 11","answer":27},
      {"problem":"18 + 12","answer":30},
      {"problem":"15 + 15","answer":30},
      {"problem":"23 + 19","answer":42},
      {"problem":"23 + 12","answer":35},
      {"problem":"28 + 27","answer":55},
      {"problem":"20 + 19","answer":39}
    ]
}
```
### Current Question Types

  * Basic: Addition, Subtraction, Multiplication, Division
  * Tens: Given a number, make it add up to 10 (or some target number)
