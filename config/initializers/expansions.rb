class String
  def numeric?
    true if Float(self) rescue false
  end
end

module Kernel
  def Boolean(str)
    return true if str =~ /true/i
    return false
  end
end
