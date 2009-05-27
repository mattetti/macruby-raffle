class Stylist
  
  def self.large_style(obj)
    obj.setFont       font(:name => "Monaco", :size => 36)
    obj.setTextColor  color(:red => 0.170, :green => 0.15, :blue => 0.19)
  end
  
  def self.small_style(obj)
    obj.setFont       font(:name => "Monaco", :size => 24)
    obj.setTextColor  color(:red => 0.170, :green => 0.15, :blue => 0.19)
  end
  
end