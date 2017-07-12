# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

RegisteredApp.create({email_address: 'project-mathcraft', password: 'fishsticks'})

max_level = 15
while Experience.count < max_level
  Experience.create({ level: Experience.count, experience_needed: Experience.count ** 3 })
end

#create levels
Level.create({ assets: { "phaser-background" => "forest.png",
                         "calculator-background" => "forest.png",
                         "minions" => ["stumpy.png"],
                         "boss" => "hard_mode"
                       },
                position: 1,
                experience: 10,
                time_limit: 30,
                level_requirement: 0,
                title: 'forest',
                level_type: 'time_attack'
              })

Level.create({ assets: { "phaser-background" => "cave.png",
                         "calculator-background" => "cave.pngg",
                         "minions" => ["golem.png"],
                         "boss" => "hard_mode"
                        },
               position: 2,
               experience: 20,
               time_limit: 30,
               level_requirement: 1,
               title: 'cave',
               level_type: 'time_attack'
              })

Level.create({ assets: { "phaser-background" => "temple.jpg",
                          "calculator-background" => "temple.jpg",
                          "minions" => [],
                          "boss" => { "alive": "boss-stomp.png", "death": "boss-death.png"}
                        },
               position: 3,
               experience: 30,
               level_requirement: 2,
               time_limit: 30,
               title: 'temple',
               level_type: 'boss_battle'
              })
