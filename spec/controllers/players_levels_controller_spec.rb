require 'rails_helper'
# routes work but tests cause ActionController::UrlGenerationError  :/
RSpec.describe PlayersLevelsController, type: :controller do
  before(:each) do
    max_level = 15
    while Experience.count < max_level
      Experience.create({ level: Experience.count, experience_needed: Experience.count ** 3 })
    end

    max_count = 3
    while Level.count < max_count
    level = Level.create({ assets: { "phaser-background" => "forest.png",
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

    resource = Resource.create({ name: 'wood', asset_link: "/path/to/asset" })

    LevelsResource.create( { rate: 150,
                            max_quantity: 200,
                            min_quantity: 1,
                            resource: resource,
                            level: level } )

  end

  context 'POST #start' do
    it 'responds with a status 201' do
      player = Player.create({email_address: 'test', password: 'test', username: 'test', avatar_asset_link: 'test/test/test.test' })
      level = Level.first
      post :start,  params: { data: { level_id: level.id, player_id: player.id} }
      expect(response.status).to eq 201
    end

    it 'responds with a player' do
      player = Player.create({email_address: 'test', password: 'test', username: 'test', avatar_asset_link: 'test/test/test.test' })
      level = Level.first
      post :start,  params: { data: { level_id: level.id, player_id: player.id} }
      expect(response.body.to_json).to include("player")
    end

    it 'responds with an error if player or level is not preset' do
      player = Player.create({email_address: 'test', password: 'test', username: 'test', avatar_asset_link: 'test/test/test.test' })
      level = Level.first
      post :start,  params: { data: { player_id: player.id} }
      expect(response.body.to_json).to include("error")
    end

    it 'responds with status 404 if player or level is not preset' do
      player = Player.create({email_address: 'test', password: 'test', username: 'test', avatar_asset_link: 'test/test/test.test' })
      level = Level.first
      post :start,  params: { data: { player_id: player.id} }
      expect(response.status).to eq 404
    end
  end

  context 'POST #complete' do
    it 'responds with status 202' do
      player = Player.create({email_address: 'test', password: 'test', username: 'test', avatar_asset_link: 'test/test/test.test' })
      level = Level.first
      post :start,  params: { data: { level_id: level.id, player_id: player.id} }
      level_id  = JSON.parse(response.body)["player_level"]["id"]
      post :complete,  params: { data: { player_id: player.id, players_level_id: level_id, correct_answers: 10 } }
      expect(response.status).to eq 202
    end

    it 'responds with a player' do
      player = Player.create({email_address: 'test', password: 'test', username: 'test', avatar_asset_link: 'test/test/test.test' })
      level = Level.first
      post :start,  params: { data: { level_id: level.id, player_id: player.id} }
      level_id  = JSON.parse(response.body)["player_level"]["id"]
      post :complete,  params: { data: { player_id: player.id, players_level_id: level_id, correct_answers: 10 } }
      expect(JSON.parse(response.body)).to include("player")
    end

    it 'responds with status 404 if players level is not valid' do
      player = Player.create({email_address: 'test', password: 'test', username: 'test', avatar_asset_link: 'test/test/test.test' })
      level = Level.first
      post :start,  params: { data: { level_id: level.id, player_id: player.id} }
      level_id  = JSON.parse(response.body)["player_level"]["id"]
      post :complete,  params: { id: 300, data: { player_id: player.id, correct_answers: 10 } }
      expect(response.status).to eq 404
    end
  end

end
