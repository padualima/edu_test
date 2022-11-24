require 'rails_helper'

RSpec.describe Member::Record, type: :model do
  describe 'validations' do
    describe 'name' do
      subject { described_class.new }

      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to allow_value(Faker::Name.name).for(:name) }
    end

    describe 'cpf' do
      it { is_expected.to validate_presence_of(:cpf) }
      it { is_expected.to validate_uniqueness_of(:cpf) }
      it { is_expected.to_not allow_value(Faker::CPF.formatted).for(:cpf) }
      it { is_expected.to_not allow_value("123.567.911").for(:cpf) } # length is 11 but invalid
      it { is_expected.to allow_value(Faker::CPF.number).for(:cpf) }
    end

    describe 'ide' do
      it { is_expected.to validate_presence_of(:ide) }
      it { is_expected.to validate_uniqueness_of(:ide) }
    end
  end
end
