# require 'rails_helper'
#
# RSpec.xdescribe PlayersBuildingsController, type: :controller do
#
#   context "GET #index" do
#     player = Player.create({username: 'test',
#                             email_address: 'test@test.com',
#                             password: 'test',
#                             experience: 0,
#                             avatar_asset_link: '/path/to/asset/link.jpg'})
#
#     building = Building.create({name: 'alchemy-lab-1', asset_link: 'alchemy-lab-1.png', building_level: 1, building_class: "Alchemy Lab", offsetX: -80, offsetY: -10 })
#
#     PlayersBuilding.create({ player: player, building: building, position: 1 })
#
#     it 'responds with status code 200' do
#       get :index, params: { data: { player_id: player.id } }
#       expect(response.status).to eq 200
#     end
#
#   end
#
#   context "POST #create" do
#
#   end
#
#   context "POST upgrade" do
#
#   end
#
#   context "POST move" do
#
#
#   end
#
# end
