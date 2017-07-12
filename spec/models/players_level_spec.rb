require 'rails_helper'

RSpec.describe PlayersLevel, type: :model do
  describe 'attribute' do
    let(:level_attempt) { PlayersLevel.new }

    it 'has a time started' do
      time_started =  DateTime.parse('2017-07-02 10:59')
      level_attempt.time_started = time_started
      expect(level_attempt.time_started).to eq time_started
    end

    it 'has a time completed' do
      time_completed =  DateTime.parse('2017-07-02 11:00')
      level_attempt.time_completed = time_completed
      expect(level_attempt.time_completed).to eq time_completed
    end

    it 'has a player id' do
      level_attempt.player_id = 1
      expect(level_attempt.player_id).to eq 1

    end

    it 'has a level id' do
      level_attempt.level_id = 1
      expect(level_attempt.level_id).to eq 1
    end
  end

  describe 'validations' do
    let(:player) { Player.create({username: 'test',
                                  email_address: 'test@test.com',
                                  password: 'test',
                                  experience: 0,
                                  avatar_asset_link: '/path/to/asset/link.jpg'}) }
    let(:level) { Level.create({ assets: [ '/path/to/background', '/path/to/foreground' ],
                                 position: 1
                                }) }

    context 'time started' do
      it 'is present' do
        time_completed =  DateTime.parse('2017-07-02 11:00')
        level_attempt = PlayersLevel.create( {  time_completed: time_completed,
                                                player: player,
                                                level: level } )
        expect(level_attempt.errors.full_messages.length).to eq 1
      end
    end

    context 'time completed' do
      it 'is present' do
        time_started =  DateTime.parse('2017-07-02 11:00')
        level_attempt = PlayersLevel.create( {  time_started: time_started,
                                                player: player,
                                                level: level } )
        expect(level_attempt.errors.full_messages.length).to eq 1
      end
    end
  end

  describe 'associations' do

    let(:player) { Player.create({username: 'test',
                                  email_address: 'test@test.com',
                                  password: 'test',
                                  experience: 0,
                                  avatar_asset_link: '/path/to/asset/link.jpg'}) }
    let(:level) { Level.create({ assets: [ '/path/to/background', '/path/to/foreground' ],
                                 position: 1
                                }) }
    let(:level_attempt) { PlayersLevel.create( {  time_started: DateTime.parse('2017-07-02 10:59').to_i,
                                                  time_completed: DateTime.parse('2017-07-02 11:00').to_i,
                                                  player: player,
                                                  level: level } ) }

    it 'belongs to a Level' do
      expect(level_attempt.level).to be_a(Level)
    end

    it 'belongs to a Player' do
      expect(level_attempt.player).to be_a(Player)
    end
  end

  describe 'methods' do
    let(:player) { Player.create({username: 'test',
                                  email_address: 'test@test.com',
                                  password: 'test',
                                  experience: 0,
                                  avatar_asset_link: '/path/to/asset/link.jpg'}) }
    let(:level) { Level.create({ assets: [ '/path/to/background', '/path/to/foreground' ],
                                 position: 1
                                }) }
    let(:resource) { Resource.create({ name: 'wood', asset_link: "/path/to/asset" }) }
    let(:level_attempt) { PlayersLevel.create( {  time_started: Time.new(2017,07,02,01,00,00),
                                                  time_completed: Time.new(2017,07,02,01,00,00).advance(seconds: 30),
                                                  player: player,
                                                  level: level,
                                                  correct_answers: 5
                                                } ) }

    context 'getting time for a level attempt' do
      it 'can get the time it took to complete a level' do
        expect(level_attempt.time).to eq 30
      end
    end

    context 'adding resources' do
      it 'can add resources to a players inventory' do
        players_resource = PlayersResource.create({ resource: resource,
                                                    player: player,
                                                    quantity: 0
                                                   })

        levels_resource = LevelsResource.create({ rate: 1,
                                                   max_quantity: 5,
                                                   min_quantity: 1,
                                                   resource: resource,
                                                   level: level
                                                 })

        level_attempt.add_resources
        expect(PlayersResource.find_by(id: players_resource).quantity).to eq 5
      end

      it 'can create an entry in the players_resources table if player does not have resource yet' do

        levels_resource = LevelsResource.create({ rate: 1,
                                                   max_quantity: 5,
                                                   min_quantity: 1,
                                                   resource: resource,
                                                   level: level
                                                 })
        level_attempt.add_resources
        expect(PlayersResource.where(player: player).first.quantity).to eq 5
        level_attempt.correct_answers
      end
    end
  end
end
