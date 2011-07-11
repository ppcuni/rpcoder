class String
  def camelize(first_letter_in_uppercase = true)
    if first_letter_in_uppercase
      self.
        gsub(/\/(.?)/) { "::#{$1.upcase}" }.
        gsub(/(?:^|_)(.)/) { $1.upcase }
    else
      camelized = self.camelize
      camelized[0].chr.downcase + camelized[1..self.size-1]
    end
  end

  def camelize!(first_letter_in_uppercase = true)
    self.replace(self.camelize first_letter_in_uppercase)
  end
end
