class InitSources < ActiveRecord::Migration
  def up
    Poster.where(source: nil).each do |p|
      p.source = Source.find_or_create_by(url: p.url) do |s|
        s.assign_attributes(title: p.read_attribute(:title), description: p.read_attribute(:description), image: p.read_attribute(:image))
        s.save!
      end
      p.save!
    end
  end
end
