RSpec.describe Webui::Users::SubscriptionsController do
  describe 'GET #index' do
    it { is_expected.to use_after_action(:verify_authorized) }

    context 'for logged in user' do
      let!(:user) { create(:confirmed_user) }

      before do
        login user
        get :index
      end

      it { expect(response).to have_http_status(:success) }
      it { expect(response).to render_template(:index) }
    end
  end

  describe 'PUT #update' do
    include_context 'a user and subscriptions with defaults'

    let(:params) { { subscriptions: subscription_params } }

    it { is_expected.to use_after_action(:verify_authorized) }

    context 'for logged in user' do
      before do
        login user
        put :update, params: params
      end

      it { expect(response).to redirect_to(action: :index) }

      it_behaves_like 'a subscriptions form for subscriber'
    end
  end
end
