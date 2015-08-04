require "graduate_helper"

class GraduateHelperWrapper
  include GraduateHelper
end

describe GraduateHelper do

  subject(:graduate_helper) do
    GraduateHelperWrapper.new
  end

  before do
    stub_graduate_data
  end

  let(:grad1) { { "name" => "Davina", "categories" => ["mum", "grad"] } }
  let(:grad2) { { "name" => "Dave", "categories" => ["dad", "grad"] } }

  it "finds all the graduates" do
    expect(graduate_helper.find_graduates).to eq([grad1, grad2])
  end

  context "given a category to filter by" do
    it "finds only gradutes for that category" do
      expect(graduate_helper.find_graduates("dad")).to eq([grad2])
    end
  end

  def stub_graduate_data
    allow(graduate_helper).to receive(:graduates).and_return([grad1, grad2])
  end
end
