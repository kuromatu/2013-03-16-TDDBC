require_relative '../ltsv.rb'

describe LTSV, 'をnewしたときにkeyとvalueを渡すと' do
  
  before do
    @ltsv = LTSV.new({:foo => 'hoge', :bar => 'fuga'})
  end

  it '#initialize でvalue-indexのhashに変換されるべき' do
    @ltsv.instance_variable_get(:@hash).should == 
      { :foo => {:value=>"hoge", :index=>0}, 
        :bar => {:value=>"fuga", :index=>1}}
  end

  it '#get でvalueが取れるべき' do
    @ltsv.get(:foo).should == 'hoge' 
    @ltsv.get(:bar).should == 'fuga' 
  end

  it '#get_index でindexが取れるべき' do
    @ltsv.get_index(:foo).should == 0
    @ltsv.get_index(:bar).should == 1
  end

  it '#ordered_hash でindexでsortされたkey-valueの配列を返す' do
    @ltsv.ordered_hash.should == [{
      :k => :foo,
      :v => 'hoge',
    }, {
      :k => :bar,
      :v => 'fuga',
    }]
  end

  it '#dump でkey-valueのコロンと\tで結合された文字列が格納順に取れるべき' do
    @ltsv.dump().should == 'foo:hoge\tbar:fuga\n'
  end

  it '#set で存在しないkeyとvalueを渡すとnilが取れて値が設定されるべき' do
    @ltsv.set('buzz', 'piyo').should == nil
    @ltsv.get(:buzz).should == 'piyo'
  end

  it '#set で存在するkeyとvalueを渡すと元のvalueが取れて値が設定されるべき' do
    @ltsv.set('foo', 'piyo').should == 'hoge'
    @ltsv.get(:foo).should == 'piyo'
  end

  it '#set 新たにsetしたときに新たにindexをふる' do
    @ltsv.set('foo', 'piyo')
    @ltsv.dump.should == 'bar:fuga\tfoo:piyo\n'
  end
end

describe LTSV, 'をnewしたときに何もない状況だと' do
  before do
    @ltsv = LTSV.new
  end

  it '#initialize で空の@hashができるべき' do
    @ltsv.instance_variable_get(:@hash).should == {}
  end

  it '#get 存在しないkeyはnilを返すべき' do
    @ltsv.get(:toto).should == nil
  end

  it '#set keyがnilの場合は例外' do
    expect { @ltsv.set(nil, 'momo') }.to raise_error
  end

  it '#set keyが空文字の場合は例外' do
    expect { @ltsv.set('', 'gogo') }.to raise_error
  end

  it '#set valueがnilの場合は例外' do
    expect { @ltsv.set('key', nil) }.to raise_error
  end

  it '#set valueが空文字の場合は例外' do
    expect { @ltsv.set('key', '') }.to raise_error
  end

  it '#escape valueにコロンがあったときはエスケープする' do
    @ltsv.set('key', ':')
    @ltsv.get(:key).should == '\:'
    @ltsv.dump().should == 'key:\:\n'
  end
end
