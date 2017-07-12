require 'rails_helper'

RSpec.describe LevelsController, type: :controller do
  context 'GET #index' do
    it 'response with a collection of all the levels' do
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
      get :index
      expect(JSON.parse(response.body)['levels'].length).to eq 3
    end
  end
end
