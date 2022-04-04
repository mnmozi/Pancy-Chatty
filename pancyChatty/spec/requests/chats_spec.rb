require 'rails_helper'

describe 'Chats API', type: :request do

    describe 'POST /api/v1/apps/' do
        it 'create a new app' do
            expect{ 
                post '/api/v1/apps', params: {app: {name: 'app'}}

            }.to change { App.count }.from(0).to(1)

            expect(response).to have_http_status(:created)
        end
    end


end