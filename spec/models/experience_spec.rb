require 'rails_helper'

RSpec.describe Experience, type: :model do
  describe 'attributes' do
    let(:experience) { Experience.new }
    it 'has a level' do
      experience.level = 16
      expect(experience.level).to eq 16
    end

    it 'has experience needed' do
      experience.level = 4
      expect(experience.experience_needed).to eq 64
    end
  end

  describe 'validations' do
    context 'level' do
      it 'is greater_than_or_equal_to 0' do
        experience = Experience.create({ level: -1})
        expect(experience.errors.full_messages.length).to eq 2
      end

      it 'is unique' do
        Experience.create({ level: 16})
        experience = Experience.create({ level: 16})
        expect(experience.errors.full_messages.length).to eq 2
      end
    end

    context 'experience_needed' do
      # experience_needed = level ** 3
      it 'is greater_than_or_equal_to 0' do
        experience = Experience.create({ level: -1})
        expect(experience.errors.full_messages.length).to eq 2
      end

      it 'is unique' do
        Experience.create({ level: 17 })
        experience = Experience.create({ level: 17})
        expect(experience.errors.full_messages.length).to eq 2
      end
    end
  end
end
