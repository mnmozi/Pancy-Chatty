require 'rails_helper'

describe 'Apps API', type: :request do
    describe 'GET /apps' do
        it 'return all apps' do
            FactoryBot.create(:app, name: 'voda', chatCount: 0)
            FactoryBot.create(:app, name: 'insta', chatCount: 0)
            get '/api/v1/apps'
            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(2)
        end
    end

    describe 'POST /apps' do
        it 'create a new app' do
            expect{ 
                post '/api/v1/apps', params: {app: {name: 'app'}}

            }.to change { App.count }.from(0).to(1)

            expect(response).to have_http_status(:created)
        end
    end


end
