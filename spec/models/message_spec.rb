require 'rails_helper'

describe Message, type: :model do

  describe '#create' do

    context 'can save' do
      it "is valid with body" do
        expect(build(:message, image: nil)).to be_valid
      end

      it "is valid with image" do
        expect(build(:message, body: nil)).to be_valid
      end

      it "is valid with body and image" do
        expect(build(:message)).to be_valid
      end
    end

    context ' can not save' do
      it "is invalid without body and image" do
        body = build(:message, body: nil, image: nil)
        body.valid?
        expect(body.errors[:body]).to include("を入力してください")
      end

      it "is invalid without group_id" do
        body = build(:message, group_id: nil)
        body.valid?
        expect(body.errors[:group]).to include("を入力してください")
      end

      it "is invalid without user_id" do
        body = build(:message, user_id: nil)
        body.valid?
        expect(body.errors[:user]).to include("を入力してください")
      end
    end

  end
  
end