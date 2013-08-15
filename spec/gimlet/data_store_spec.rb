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

    it do
      expect(subject[:hello][:message]).to eq('Hello world')
    end
  end

  describe 'deep' do
    subject { Gimlet::DataStore.new(fixture_path('deep')) }
    it do
      expect(subject.to_h).to eq({'hello' => {'message' => {'en' => 'Hello world'}}})
    end

    it do
      expect(subject.hello.message.en).to eq('Hello world')
    end

    it do
      expect(subject[:hello][:message][:en]).to eq('Hello world')
    end
  end

  describe 'array' do
    subject { Gimlet::DataStore.new(fixture_path('array')) }

    it do
      expect(subject.to_h).to eq('hello' => ['Hello world', 'こんにちは世界'])
    end

    it do
      expect(subject.hello.first).to eq('Hello world')
    end
  end

  describe 'directries' do
    subject { Gimlet::DataStore.new(fixture_path('directories')) }

    it do
      expect(subject.to_h).to eq({'hello' => {'world' => {'message' => 'Hello world'}}})
    end

    it do
      expect(subject.hello.world.message).to eq('Hello world')
    end
  end

  describe 'suffix' do
    subject { Gimlet::DataStore.new(fixture_path('suffix')) }

    it do
      expect(subject.to_h).to eq({'yaml' => {'name' => 'yaml'}, 'yml' => {'name' => 'yml'}})
    end
  end

  describe 'filename' do
    subject { Gimlet::DataStore.new(fixture_path('yaml/hello')) }

    it do
      expect(subject.to_h).to eq({'message' => 'Hello world'})
    end
  end

  describe 'not found' do
    subject { Gimlet::DataStore.new('NOT_FOUND') }

    it do
      expect(->{ subject }).to raise_error(Gimlet::DataStore::SourceNotFound)
    end
  end
end
