class String
  def numeric?
    true if Float(self) rescue false
  end
end

module Kernel
  def Boolean(str)
    if str.kind_of?(String)
      return true if str =~ /true/i
      false
    else
      str
    end
  end
end
