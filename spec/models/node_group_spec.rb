require 'rails_helper'

RSpec.describe NodeGroup, type: :model do
  describe "creating a new NodeGroup" do
    context "when is valid NodeGroup" do
      let(:node_group) { build(:node_group) }

      it "should be valid" do
        expect(node_group).to be_valid
      end
    end

    context "when NodeGroup has a valid child" do
      let(:node_group) { create(:node_group) }
      let(:node_group_child) do
        build(:node_group, slug: 'PI') do |c|
          c.parent = node_group
          c.save
        end
      end

      it 'should be valid' do
        expect { node_group_child }.to change(NodeGroup, :count).by(2)
        expect(node_group_child.ancestry.to_i).to eq(node_group.id)
      end
    end

    context "when NodeGroup has a parent and a child" do
      let(:node_group) do
        build(:node_group, slug: 'PI') do |g|
          g.parent = create(:node_group)
          g.save
        end
      end

      let(:node_group_child) do
        build(:node_group) do |g|
          g.parent = node_group
        end
      end

      it "should be not_valid" do
        expect(node_group_child.save).to_not be_truthy
        expect(node_group_child.errors.messages[:ancestry]).to match(["Invalid Ancestry Tree"])
      end
    end

    context "#slug" do
      context "when not present" do
        let(:node_group) { build(:node_group, slug: "") }

        it "should be not_valid" do
          expect(node_group).to_not be_valid
        end
      end

      context "when slug is year invalid" do
        let(:node_group) { build(:node_group, slug: (Date.current + 1.year).year.to_s) }

        it "should not be valid next year" do
          expect(node_group).to_not be_valid
        end

        it "should not be valid year below 2008" do
          node_group.slug = "2007"
          expect(node_group).to_not be_valid
        end
      end

      context "when slug is a disallowed abbreviation state" do
        let(:node_group) { build(:node_group, slug: "SPP") }

        it "should not be valid" do
          expect(node_group).to_not be_valid
        end
      end

      context "when has siblings" do
        let(:node_group) { create(:node_group) }

        context "with same slug" do
          let(:sibling_group) { build(:node_group, slug: node_group.slug) }

          it "should not be valid" do
            expect(node_group).to_not be_valid
          end
        end
      end
    end
  end
end
