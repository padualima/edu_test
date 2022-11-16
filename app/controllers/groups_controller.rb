class GroupsController < ApplicationController
  before_action :set_group

  # GET /groups/:id/states
  def states
    groups = @node_group.children.order(:slug).pluck(:slug, :id)

    render json: groups
  end

  private

  def set_group
    @node_group = NodeGroup.find(params[:id])
  end
end
