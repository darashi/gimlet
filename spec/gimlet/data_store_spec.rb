require_relative '../spec_helper'
require_relative '../../lib/gimlet/data_store'

describe Gimlet::DataStore do
  describe 'empty' do
    subject { Gimlet::DataStore.new(fixture_path('empty')) }

    it do
      expect(subject.data).to eq({})
    end
  end

  describe 'yaml' do
    subject { Gimlet::DataStore.new(fixture_path('yaml')) }

    it do
      expect(subject.data).to eq({'hello' => {'message' => 'Hello world'}})
    end
  end
end
