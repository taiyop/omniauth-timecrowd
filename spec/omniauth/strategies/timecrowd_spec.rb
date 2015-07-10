require 'spec_helper'

describe OmniAuth::Strategies::TimeCrowd do  
  let(:access_token) { stub('AccessToken', options: {}) }
  let(:parsed_response) { stub('ParsedResponse') }
  let(:response) { stub('Response', parsed: parsed_response) }

  let(:local_site)          { 'https://localhost:3000/' }
  let(:local_authorize_url) { 'https://localhost:3000/oauth/authorize' }
  let(:local_token_url)     { 'https://localhost:3000/oauth/token' }
  let(:local) do
    OmniAuth::Strategies::TimeCrowd.new('GITHUB_KEY', 'GITHUB_SECRET',
      {
        client_options: {
          site: local_site,
          authorize_url: local_authorize_url,
          token_url: local_token_url
        }
      }
    )
  end

  subject do
    OmniAuth::Strategies::TimeCrowd.new({})
  end

  before do
    subject.stub!(:access_token).and_return(access_token)
  end

  context "client options" do
    it 'should have correct site' do
      subject.options.client_options.site.should eq("https://timecrowd.net")
    end

    it 'should have correct authorize url' do
      subject.options.client_options.authorize_url.should eq('/oauth/authorize')
    end

    it 'should have correct token url' do
      subject.options.client_options.token_url.should eq('/oauth/token')
    end

    describe "should be overrideable" do
      it "for site" do
        local.options.client_options.site.should eq(local_site)
      end

      it "for authorize url" do
        local.options.client_options.authorize_url.should eq(local_authorize_url)
      end

      it "for token url" do
        local.options.client_options.token_url.should eq(local_token_url)
      end
    end
  end

  context "#info" do
    it 'should use nickname, image from raw_info' do
      subject.stub(:raw_info).and_return({ 'nickname' => 'me', 'image' => 'http://example.com' })
      subject.info[:nickname].should == 'me'
      subject.info[:image].should == 'http://example.com'
    end
  end

  context "#extra" do
    it 'should use raw_info' do
      subject.stub(:raw_info).and_return({})
      subject.extra[:raw_info].should == {}
    end
  end

  context "#raw_info" do
    it "should use info api" do
      access_token.should_receive(:get).with('api/v1/user/info').and_return(response)
      subject.raw_info.should eq(parsed_response)
    end
  end
end
