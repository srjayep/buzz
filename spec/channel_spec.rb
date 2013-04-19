require 'spec_helper'
require 'buzz'

describe Channel do
  describe "#create" do
    context "when channel label is not provided" do
      let(:create) { Channel.start(['create']) }
  
      it "asks for a channel label" do
        $stdin.should_receive(:create).and_return('fucked')
        results = capture(:stdout) { create }

      end
    end
  end
end
   
