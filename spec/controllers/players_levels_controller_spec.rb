require 'rails_helper'
# routes work but tests cause ActionController::UrlGenerationError  :/
RSpec.describe PlayersLevelsController, type: :controller do
  context 'POST #start' do
    it 'responds with a status 201' do
      player = Player.create({email_address: 'test', password: 'test', username: 'test', avatar_asset_link: 'test/test/test.test' })
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
      post :start,  params: { data: { level_id: level.id, player_id: player.id} }
      expect(response.status).to eq 201
    end

    it 'responds with a player' do
      player = Player.create({email_address: 'test', password: 'test', username: 'test', avatar_asset_link: 'test/test/test.test' })
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
      post :start,  params: { data: { level_id: level.id, player_id: player.id} }
      expect(response.body.to_json).to include("player")
    end

    it 'responds with an error if player or level is not preset' do
      player = Player.create({email_address: 'test', password: 'test', username: 'test', avatar_asset_link: 'test/test/test.test' })
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
      post :start,  params: { data: { player_id: player.id} }
      expect(response.body.to_json).to include("error")
    end

    it 'responds with status 404 if player or level is not preset' do
      player = Player.create({email_address: 'test', password: 'test', username: 'test', avatar_asset_link: 'test/test/test.test' })
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
      post :start,  params: { data: { player_id: player.id} }
      expect(response.status).to eq 404
    end
  end
end
