require 'rails_helper'

RSpec.describe Resource, type: :model do

  describe 'attributes' do
    let(:resource) { Resource.new }
    it 'has a name' do
        resource.name = 'wood'
        expect(resource.name).to eq 'wood'
    end
  end

  describe 'validations' do
    context 'name' do
      it 'is present' do
        resource = Resource.create
        expect(resource.errors.full_messages.length).to eq 1
      end

      it 'is unique' do
        Resource.create({ name: 'wood', asset_link: "/path/to/asset" })
        resource = Resource.create({ name: 'wood', asset_link: "/path/to/asset" })
        expect(resource.errors.full_messages.length).to eq 1
      end
    end
  end

end
