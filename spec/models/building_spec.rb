require 'rails_helper'

RSpec.describe Building, type: :model do

  describe 'attributes' do
    let(:building) { Building.new }

    it 'has an asset_link' do
      building.asset_link = "/path/to/asset"
      expect(building.asset_link).to eq "/path/to/asset"
    end

    it 'has a offsetX' do
      building.offsetX = 2
      expect(building.offsetX).to eq 2
    end

    it 'has a offsetY' do
      building.offsetY = 2
      expect(building.offsetY).to eq 2

    end

    it 'has a building_class' do
      building.building_class = 'resource'
      expect(building.building_class).to eq 'resource'
    end

    it 'has a level' do
      building.building_level = 1
      expect(building.building_level).to eq 1
    end

  end

  describe 'validations' do
    context 'asset_link' do
      it 'has an asset link' do
        building = Building.create({  offsetX: 1,
                                      offsetY: 2,
                                      building_class: 'resource',
                                      building_level: 1,
                                    })
        expect(building.errors.full_messages.length).to eq 1
      end

      it 'has a unique asset link' do
        Building.create({ asset_link: "/path/to/asset",
                          offsetX: 1,
                          offsetY: 2,
                          building_class: 'resource',
                          building_level: 1,
                        })

        building = Building.create({  asset_link: "/path/to/asset",
                                      offsetX: 1,
                                      offsetY: 2,
                                      building_class: 'resource',
                                      building_level: 1,
                                    })
        expect(building.errors.full_messages.length).to eq 1
      end
    end

    context 'offsetX' do
      it 'has an offsetX ' do
        building = Building.create({  asset_link: "/path/to/asset",
                                      offsetY: 2,
                                      building_class: 'resource',
                                      building_level: 1,
                                    })

        expect(building.errors.full_messages.length).to eq 2
      end

    end

    context 'offsetY' do
      it 'has an offsetY ' do
        building = Building.create({  asset_link: "/path/to/asset",
                                      offsetY: 1,
                                      building_class: 'resource',
                                      building_level: 1,
                                    })
        expect(building.errors.full_messages.length).to eq 2
      end

    end

    context 'building_class' do
      it 'has a building_class' do
        building = Building.create({  asset_link: "/path/to/asset",
                                      offsetX: 1,
                                      offsetY: 1,
                                      building_level: 1,
                                    })
        expect(building.errors.full_messages.length).to eq 1
      end

    end

    context 'buidling level' do
      it 'has a level greater than 0' do
        building = Building.create({  asset_link: "/path/to/asset",
                                      offsetX: 1,
                                      offsetY: 1,
                                      building_class: 'resource',
                                      building_level: 0,
                                    })
        expect(building.errors.full_messages.length).to eq 1
      end

    end

  end

end
