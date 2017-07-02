require 'rails_helper'

RSpec.describe Building, building_class: :model do

  describe 'attributes' do
    let(:building) { Building.new }

    it 'has an asset_link' do
      building.asset_link = "/path/to/asset"
      expect(building.asset_link).to eq "/path/to/asset"
    end

    it 'has a width' do
      building.width = 2
      expect(building.width).to eq 2
    end

    it 'has a height' do
      building.height = 2
      expect(building.height).to eq 2

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
        building = Building.create({  width: 1,
                                      height: 2,
                                      building_class: 'resource',
                                      building_level: 1,
                                    })
        expect(building.errors.full_messages.length).to eq 1
      end

      it 'has a unique asset link' do
        Building.create({ asset_link: "/path/to/asset",
                          width: 1,
                          height: 2,
                          building_class: 'resource',
                          building_level: 1,
                        })

        building = Building.create({  asset_link: "/path/to/asset",
                                      width: 1,
                                      height: 2,
                                      building_class: 'resource',
                                      building_level: 1,
                                    })
        expect(building.errors.full_messages.length).to eq 1
      end
    end

    context 'width' do
      it 'has a width greater than 0' do
        building = Building.create({  asset_link: "/path/to/asset",
                                      width: 0,
                                      height: 2,
                                      building_class: 'resource',
                                      building_level: 1,
                                    })
        expect(building.errors.full_messages.length).to eq 1
      end

    end

    context 'height' do
      it 'has a height greater than 0' do
        building = Building.create({  asset_link: "/path/to/asset",
                                      width: 1,
                                      height: 0,
                                      building_class: 'resource',
                                      building_level: 1,
                                    })
        expect(building.errors.full_messages.length).to eq 1
      end

    end

    context 'building_class' do
      it 'has a building_class' do
        building = Building.create({  asset_link: "/path/to/asset",
                                      width: 1,
                                      height: 1,
                                      building_level: 1,
                                    })
        expect(building.errors.full_messages.length).to eq 1
      end

    end

    context 'buidling level' do
      it 'has a level greater than 0' do
        building = Building.create({  asset_link: "/path/to/asset",
                                      width: 1,
                                      height: 1,
                                      building_class: 'resource',
                                      building_level: 0,
                                    })
        expect(building.errors.full_messages.length).to eq 1
      end

    end

  end

end
