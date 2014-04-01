require 'spec_helper'

def test_redirect(options)
  session.merge! options[:session]
  self.send(options[:method], options[:route], options[:params])
  redirect_matcher = redirect_to options[:redirect_to]
  if options[:should_redirect]
    response.should redirect_matcher
  else
    response.should_not redirect_matcher
  end
end

shared_examples_for 'redirects when not logged in' do |options|
  before :each do
    @options = options.clone
    @options[:method] ||= :get
    @options[:route] ||= :show
    @options[:params] ||= {}
    @options[:redirect_to] ||= root_url
    @options[:role] ||= nil
    @options[:session] ||= {}
    if @options[:should_redirect].nil?
      @options[:should_redirect] = true
    end
  end

  context 'not logged in' do
    it 'redirects' do
      test_redirect(@options)
    end
  end

  context 'logged in with no role' do
    before :each do
      @options[:session].merge! userid: create(:user)
    end

    it 'redirects' do
      test_redirect @options
    end
  end

  if options[:role]
    context "logged in as a #{options[:role]}" do
      before :each do
        roles = [create(:role, name: @options[:role])]
        user = create(:user, roles: roles)
        @options[:session].merge! userid: user
      end

      it 'does not redirect' do
        @options[:should_redirect] = false
        test_redirect @options
      end
    end
  end
end