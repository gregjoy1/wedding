module HashHelper
  def self.password_hash(password)
    salt = ENV['PRIVATE_KEY'] || ''
    Digest::SHA256.hexdigest(self.interleave_strings(salt, password))
  end

  # Fn that interleaves two strings "test1" + "test2" => "tteesstt12"
  def self.interleave_strings(string_a, string_b)
    string_a.split('').zip(string_b.split('')).flatten.join('')
  end
end
