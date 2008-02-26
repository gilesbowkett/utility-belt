class Hash
  alias :+ :merge
  def -(thing_to_be_deleted)
    if thing_to_be_deleted.is_a? Hash
      thing_to_be_deleted.each do |key, value|
        self.delete(key) if self[key] == value
      end
    elsif self.keys.include? thing_to_be_deleted
      self.delete(thing_to_be_deleted)
    end
    self
  end
end
