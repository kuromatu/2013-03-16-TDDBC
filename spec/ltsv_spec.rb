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
      :foo => 'hoge',
    }, {
      :bar => 'fuga',
    }]
  end

  it '#dump でkey-valueのコロンと\tで結合された文字列が格納順に取れるべき' do
    #@ltsv.dump().should == 'foo:hoge\tbar:fuga\n'
  end
end
