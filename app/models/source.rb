class Source < ActiveRecord::Base
  has_many :posters

  before_create :setup_meta

  private

  def setup_meta
    begin
      og = LinkThumbnailer.generate(self.url)
      self.title = og.title
      self.description = og.description
    rescue Exception
    end
  end
end
