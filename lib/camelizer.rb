class String
  def camelize(first_letter_in_uppercase = true)
    if first_letter_in_uppercase
      self.
        gsub(/\/(.?)/) { "::#{$1.upcase}" }.
        gsub(/(?:^|_)(.)/) { $1.upcase }
    else
      self[0].chr.downcase + self[1..1].camelize
    end
  end

  def camelize!(first_letter_in_uppercase = true)
    self.replace(self.camelize first_letter_in_uppercase)
  end
end
