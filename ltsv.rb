class LTSV
  def initialize(hash)
    @max_index = 0
    @hash = hash.map{|k, v|
      h = {
        k => {
          :value => v,
          :index => @max_index
        }
      }
      @max_index += 1

      h
    }.inject({}) {|r, i| r.merge!(i) }
  end

  def get(key)
    @hash[key][:value]
  end

  def get_index(key)
    @hash[key][:index]
  end

  def dump
    'foo:hoge\tbar:fuga\n'
    ordered = ordered_hash
    ordered.map {|elem|
      "#{elem[:k]}:#{elem[:v]}"
    }.join('\t') + '\n'
  end

  def ordered_hash
    @hash.to_a.sort{|a, b|
        a[1][:index] <=> b[1][:index] 
    }.map{|i|
      {
        :k => i[0],
        :v => i[1][:value],
      }
    }
  end
end
