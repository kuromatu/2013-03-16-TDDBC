class LTSV
  def initialize(hash)
    @hash = hash
  end

  def get(key)
    @hash[key]
  end
end
