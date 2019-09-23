class AddDigestToShortLink < ActiveRecord::Migration[5.2]
  def change
    add_column :short_links, :digest, :string
  end
end
