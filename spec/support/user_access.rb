# frozen_string_literal: true

# Used for Feature Specs
RSpec.shared_examples "unauthenticated user does not have access" do
  before(:each) do
    sign_in user if user
    visit path.dup
  end

  context "when no user logged in" do
    let(:user) { nil }

    it "demands signup" do
      expect(page).to have_content "You need to sign in or sign up before continuing."
    end
  end

  context "when user is unconfirmed" do
    let(:user) { create(:user, :unconfirmed) }

    it "prompts the user to confirm email" do
      expect(page).to have_content "You have to confirm your email address before continuing."
    end
  end
end

# Used for Request Specs
# Devise prevented access
RSpec.shared_examples "redirect to sign in" do
  it "redirects to sign in" do
    subject
    expect(response).to redirect_to new_user_session_path
  end
end

# Used for Request Specs
# Devise prevented access
RSpec.shared_examples "unauthenticated access in json" do
  it "redirects to user sign in" do
    subject
    error = JSON.parse(response.body)["error"]
    expect(error).to eq "You need to sign in or sign up before continuing."
  end

  it "returns a 401 unauthorized" do
    subject
    expect(response).to have_http_status(401)
  end
end

# Used for Request Specs
# Pundit prevented access
RSpec.shared_examples "unauthorized access" do
  it "redirects to root" do
    subject
    expect(response).to redirect_to root_path
  end

  it "has an unauthorized message" do
    subject
    expect(flash[:alert]).to eq "You are not authorized to perform this action."
  end
end
