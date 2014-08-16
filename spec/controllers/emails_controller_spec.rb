require "spec_helper"

describe EmailsController do
  let(:user) do
    User.create email: "user@example.com",
      password: "asdf1234",
      password_confirmation: "asdf1234"
  end

  let(:note) do
    Note.create user: user, url: "http://google.com"
  end

  let(:from) { "" }
  let(:to) { "" }
  let(:text) { "" }
  let(:params) do
    {
      from: from,
      to: to,
      subject: "Test subject",
      "stripped-text" => text
    }.with_indifferent_access
  end

  def post_with_params
    post :post, params
  end

  describe "#post" do
    before do
      post_with_params
    end

    context "when the sender is a valid user" do
      let(:from) { user.email }

      context "when sent to read@mg.learnstream.org" do
        let(:to) { "read@mg.learnstream.org" }
        let(:text) { "http://google.com" }

        it "makes note" do
          expect(Note).to receive(:create).with(user: user, url: text)
          post_with_params
        end

        it "returns OK" do
          expect(response.status).to eq 200
        end
      end

      context "when sent to note-:id@mg.learnstream.org" do
        let(:to) { "note-#{note.id}@mg.learnstream.org" }
        let(:text) { "I learned a lot..." }
        
        it "makes summary" do
          expect_any_instance_of(Note).to receive(:update_attributes).with(summary: text)
          post_with_params
        end

        it "returns OK" do
          expect(response.status).to eq 200
        end
      end
    end

    context "when the sender is invalid" do
      let(:from) { "noone@example.com" }

      it "forbids the request" do
        expect(response.status).to eq 403
      end
    end
  end
end
