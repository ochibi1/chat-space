require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:group) { create(:group) }
  let(:user) { create(:user) }

  describe '#index' do
    
    context 'log in' do
      before do 
        login user 
        get :index, params: { group_id: group.id }
      end

      it "assigns @message" do
        expect(assigns(:message)).to be_a_new(Message)
      end

      it "assigns @group" do
        expect(assigns(:group)).to eq group
      end

      it "renders index" do
        expect(response).to render_template :index
      end
    end

    context 'not log in' do
      before do
        get :index, params: { group_id: group.id}
      end

        it "redirects to new_user/session_path" do
          expect(response).to redirect_to(new_user_session_path)
        end
    end
  end

  describe '#create' do
    let(:params) { {group_id: group.id, user_id: user.id, message: attributes_for(:message) } }

    context 'log in' do
      before do 
        login user 
      end 

      context 'can save' do
        subject { post :create, params: params } #ログインしているかつ、保存に成功した場合

        it "count up message" do #メッセージの保存はできたのか 
          expect{ subject }.to change(Message, :count).by(1)
        end

        it "redirects to group_messages_path" do #意図した画面(メッセージを送った後の画面だから、メッセージしたグループのチャット画面）に遷移しているか
          subject
          expect(response).to redirect_to(group_messages_path(group))
        end
      end

      context 'can not save' do #ログインしているが、保存に失敗した場合
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, body: nil, image: nil) } }

        subject { post :create, params: invalid_params }

        it "does not count up" do #メッセージの保存は行われなかったか
          expect{ subject }.not_to change(Message, :count)
        end
        
        it "renders index" do #意図したビューが描画されているか
          subject
          expect(response).to render_template :index
        end
      end
    end

    context 'not log in' do #ログインしていない場合

      it "redirects to new_user_session_path" do #意図した画面にリダイレクトできているか
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end