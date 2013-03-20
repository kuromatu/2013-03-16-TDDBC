class LTSV
  def initialize(hash = {})
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
    escape(@hash[key][:value]) if @hash[key]
  end

  def get_index(key)
    @hash[key][:index]
  end

  def dump
    ordered = ordered_hash
    ordered.map {|elem|
      "#{elem[:k]}:#{get(elem[:k])}"
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

  def set(key, value)
    raise 'nilはdamedayo' if key == nil || key == ''
    raise 'nilはdamedayo' if value == nil || value == ''

    original_value = nil
    if @hash[key.to_sym]
      original_value = get(key.to_sym)
    end

    hash = {
      key.to_sym => {
        :value => value,
        :index => @max_index,
      }
    }
    @max_index += 1
    @hash.merge!(hash)
    original_value
  end

  def escape(str)
    str.gsub(/:/, '\:')
  end
end
