require 'rails_helper'

RSpec.describe BuildingsResource, type: :model do
  describe 'attributes' do
    let(:buildingsresource) { BuildingsResource.new }

    it 'has a quantity' do
      buildingsresource.quantity = 20
      expect(buildingsresource.quantity).to eq 20
    end

    it 'has a resource id' do
      buildingsresource.building_id = 1
      expect(buildingsresource.building_id).to eq 1
    end

    it 'has a player_id' do
      buildingsresource.resource_id = 1
      expect(buildingsresource.resource_id).to eq 1
    end
  end
  describe 'validations' do
    let(:resource) { Resource.create({ name: 'wood', asset_link: "/path/to/asset" }) }
    let(:building) { Building.create({  asset_link: "/path/to/asset",
                                        width: 1,
                                        height: 1,
                                        building_class: 'resource',
                                        building_level: 1,
                                      }) }
    context 'quantity' do
      it 'is greater than or equal to 0' do
        buildingsresource = BuildingsResource.create({ resource: resource,
                                                       building: building,
                                                       quantity: -1
                                                     })
        expect(buildingsresource.errors.full_messages.length).to eq 1
      end
    end
  end
  describe 'associations' do
    let(:resource) { Resource.create({ name: 'wood', asset_link: "/path/to/asset" }) }
    let(:building) { Building.create({  asset_link: "/path/to/asset",
                                        width: 1,
                                        height: 1,
                                        building_class: 'resource',
                                        building_level: 1,
                                      }) }
    let(:buildingsresource) { BuildingsResource.create({ resource: resource,
                                                         building: building,
                                                         quantity: 10
                                                       }) }

    it 'belongs to a resource' do
      expect(buildingsresource.resource).to be_a(Resource)
    end

    it 'belongs to a building' do
      expect(buildingsresource.building).to be_a(Building)
    end

  end
end
