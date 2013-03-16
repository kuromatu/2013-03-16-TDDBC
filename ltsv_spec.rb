require_relative 'ltsv.rb'

describe LTSV, 'をnewしたときにkeyとvalueを渡すと' do
  
  before do
    @ltsv = LTSV.new({:foo => 'hoge'})
  end

  it '#get でvalueが取れるべき' do
    @ltsv.get(:foo).should == 'hoge' 

  end
end
