require_relative '../spec_helper'

describe Gimlet::DataStore do
  describe 'empty' do
    subject { Gimlet::DataStore.new(fixture_path('empty')) }

    it do
      expect(subject.to_h).to eq({})
    end
  end

  describe 'yaml' do
    subject { Gimlet::DataStore.new(fixture_path('yaml')) }

    it do
      expect(subject.to_h).to eq({'hello' => {'message' => 'Hello world'}})
    end

    it do
      expect(subject.hello.message).to eq('Hello world')
    end
  end
end
