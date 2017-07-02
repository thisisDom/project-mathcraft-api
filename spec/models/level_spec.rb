require 'rails_helper'

RSpec.describe Level, type: :model do

  describe 'attributes' do
    let(:level) { Level.new }

    it 'has level assets' do
      level.assets = [ '/path/to/background', '/path/to/foreground' ]
      expect(level.assets.length).to be 2
      expect(level.assets).to be_an(Array)
    end

    it 'has a position' do
      level.position = 1
      expect(level.position).to eq 1
    end
  end

  describe 'validations' do
    context 'assets' do
      it 'has assets' do
        level = Level.create( { position: 1 } )
        expect(level.errors.full_messages.length).to eq 1
      end
    end

    context 'position' do
      it 'has position greater than 0' do
        level = Level.create({ assets: [ '/path/to/background', '/path/to/foreground' ],
                               position: 0
                              })
        expect(level.errors.full_messages.length).to eq 1
      end

      it 'is unique' do
        Level.create({ assets: [ '/path/to/background', '/path/to/foreground' ],
                               position: 1
                              })
        level = Level.create({ assets: [ '/path/to/background', '/path/to/foreground' ],
                               position: 1
                              })
        expect(level.errors.full_messages.length).to eq 1
      end

    end
  end

end
