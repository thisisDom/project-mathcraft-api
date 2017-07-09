require 'rails_helper'

RSpec.describe LevelsResource, type: :model do
  describe 'attributes' do
    let(:levelsresource) { LevelsResource.new }

    it 'has a gain rate' do
      levelsresource.rate = 2
      expect(levelsresource.rate).to eq 2
    end

    it 'has a max resource gain' do
      levelsresource.max_quantity = 20
      expect(levelsresource.max_quantity).to eq 20
    end

    it 'has a mininum resources gain' do
      levelsresource.min_quantity = 5
      expect(levelsresource.min_quantity).to eq 5
    end

    it 'has a resource id' do
      levelsresource.resource_id = 1
      expect(levelsresource.resource_id).to eq 1
    end

    it 'has a level id' do
      levelsresource.level_id = 1
      expect(levelsresource.level_id).to eq 1
    end
  end

  describe 'validations' do
    let(:resource) { Resource.create({ name: 'wood', asset_link: "/path/to/asset" }) }
    let(:level) { Level.create({ assets: [ '/path/to/background', '/path/to/foreground' ],
                                 position: 1
                                }) }

    context 'rate' do
      it 'is greater than or equal to 0' do
        levelsresource = LevelsResource.create( { rate: -1,
                                                  max_quantity: 20,
                                                  min_quantity: 5,
                                                  resource: resource,
                                                  level: level } )
        expect(levelsresource.errors.full_messages.length).to eq 1
      end
    end

    context 'min resource' do
      it 'is greater than or equal to 0' do
        levelsresource = LevelsResource.create( { rate: 1,
                                                  max_quantity: 20,
                                                  min_quantity: -1,
                                                  resource: resource,
                                                  level: level } )
        expect(levelsresource.errors.full_messages.length).to eq 1
      end
    end

    context 'max resources' do
      it 'is greater than or equal to 0' do
        levelsresource = LevelsResource.create( { rate: 1,
                                                  max_quantity: -1,
                                                  min_quantity: 1,
                                                  resource: resource,
                                                  level: level } )
        expect(levelsresource.errors.full_messages.length).to eq 1
      end
    end
  end

  describe 'associations' do
      let(:resource) { Resource.create({ name: 'wood', asset_link: "/path/to/asset" }) }
      let(:level) { Level.create({ assets: [ '/path/to/background', '/path/to/foreground' ],
                                   position: 1
                                  }) }
      let(:levelsresource) { LevelsResource.create( { rate: 1,
                                                      max_quantity: 5,
                                                      min_quantity: 1,
                                                      resource: resource,
                                                      level: level } ) }

      it 'belongs to a resource' do
        expect(levelsresource.resource).to be_a(Resource)
      end

      it 'belongs to a level' do
        expect(levelsresource.level).to be_a(Level)
      end

  end
end
