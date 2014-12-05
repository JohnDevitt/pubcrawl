class CreateRoutesPubs < ActiveRecord::Migration
  def self.up
    create_table :pubs_routes, :id => false do |t|
	t.references :pub
	t.references :route
    end
    add_index :pubs_routes, [:pub_id, :route_id]
    add_index :pubs_routes, :route_id
  end

  def self.down
     drop_table :pubs_routes
  end
end
