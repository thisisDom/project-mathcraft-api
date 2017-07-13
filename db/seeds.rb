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

#create levels\
max_count = 3
while Level.count < max_count
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
end


r1 = Resource.create(name: "wood", asset_link: 'wood.png')
r2 = Resource.create(name: "stone", asset_link: 'stone.png')
r3 = Resource.create(name: "gold", asset_link: 'gold.png')

building = Building.create({name: 'alchemy-lab-1', asset_link: 'alchemy-lab-1.png', building_level: 1, building_class: "Alchemy Lab", offsetX: -80, offsetY: -10 })
BuildingsResource.create({resource: r2, building: building, quantity: 3})

building = Building.create({name: 'alchemy-lab-2', asset_link: 'alchemy-lab-2.png', building_level: 2, building_class: "Alchemy Lab", offsetX: -120, offsetY: -30 })
BuildingsResource.create({resource: r2, building: building, quantity: 5})

building = Building.create({name: 'alchemy-lab-3', asset_link: 'alchemy-lab-3.png', building_level: 3, building_class: "Alchemy Lab", offsetX: -150, offsetY: -60})
BuildingsResource.create({resource: r2, building: building, quantity: 10})

building = Building.create({name: 'tesla-factory-1', asset_link: 'tesla-factory-1.png', building_level: 1, building_class: "Tesla Factory", offsetX: -90, offsetY: 0 })
BuildingsResource.create({resource: r1, building: building, quantity: 5})

building = Building.create({name: 'tesla-factory-2', asset_link: 'tesla-factory-2.png', building_level: 2, building_class: "Tesla Factory", offsetX: -140, offsetY: -60 })
BuildingsResource.create({resource: r1, building: building, quantity: 5})

building = Building.create({name: 'tesla-factory-3', asset_link: 'tesla-factory-3.png', building_level: 3, building_class: "Tesla Factory", offsetX: -160, offsetY: -70})
BuildingsResource.create({resource: r1, building: building, quantity: 10})

building = Building.create({name: 'magic-house-1', asset_link: 'magic-house-1.png', building_level: 1, building_class: "Magic House", offsetX: -90, offsetY: -10 })

BuildingsResource.create({resource: r3, building: building, quantity: 2})

building = Building.create({name: 'magic-house-2', asset_link: 'magic-house-2.png', building_level: 2, building_class: "Magic House", offsetX: -90, offsetY: -20 })

BuildingsResource.create({resource: r3, building: building, quantity: 5})

building = Building.create({name: 'magic-house-3', asset_link: 'magic-house-3.png', building_level: 3, building_class: "Magic House", offsetX: -90, offsetY: -20}
BuildingsResource.create({resource: r3, building: building, quantity: 10})




player = Player.create({username: "Jasper", email_address: 'test', password: 'test', avatar_asset_link: 'test' })
