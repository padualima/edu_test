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
      let(:node_group) { create(:node_group, :with_state_type_child_group) }

      it 'should be valid' do
        expect { node_group }.to change(NodeGroup, :count).by(2)
      end
    end

    context "when NodeGroup is of kind state and has a child" do
      let(:node_group) { create(:node_group, :with_state_type_child_group) }

      let(:node_group_child) do
        build(:node_group) do |g|
          g.parent = node_group.children.sample
        end
      end

      it "should be not_valid" do
        expect(node_group_child.save).to_not be_truthy
        expect(node_group_child.errors.messages[:ancestry]).to match(["Invalid Ancestry Tree"])
      end
    end

    context "when NodeGroup is of kind state and has not parent" do
      let(:node_group) do
        build(:node_group, slug: NodeGroup.states_allowed.sample, kind: NodeGroup.kinds.keys[1])
      end

      it 'should be not_valid' do
        expect(node_group).to_not be_valid
      end
    end

    context '.oldest_year' do
      before do
        (1..3).each do |n|
          create(:node_group, slug: (Date.current - n.year).year)
        end
      end

      it 'should be return oldest year' do
        expect(NodeGroup.oldest_year).to eql NodeGroup.find_by(slug: (Date.current - 3.year).year)
      end
    end

    context "#slug" do
      context "when not present" do
        let(:node_group) { build(:node_group, slug: "") }

        it "should be not_valid" do
          expect(node_group).to_not be_valid
        end
      end

      context "when node_group is of type year and has invalid slug" do
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
        let(:node_group) { create(:node_group, :with_state_type_child_group) }

        it "should not be valid" do
          expect(NodeGroup.find_by(ancestry: node_group).update(slug: "SSP")).to_not be_truthy
        end
      end

      context "when has siblings" do
        let(:node_group) { create(:node_group) }

        context "with same slug" do
          let(:sibling_group) { build(:node_group, slug: node_group.slug) }

          it "should not be valid" do
            expect(sibling_group).to_not be_valid
            expect(sibling_group.errors.full_messages)
              .to match(["Slug Already exists a NodeGroup with same slug"])
            expect { sibling_group }.to change(NodeGroup, :count).by(0)
          end
        end
      end
    end
  end
end
