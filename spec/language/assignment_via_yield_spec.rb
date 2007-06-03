require File.dirname(__FILE__) + '/../spec_helper'

describe "Assignment via yield" do
  
  it "should assign objects to block variables" do
    def f; yield nil; end;      f {|a| a.should == nil }
    def f; yield 1; end;        f {|a| a.should == 1 }
    def f; yield []; end;       f {|a| a.should == [] }
    def f; yield [1]; end;      f {|a| a.should == [1] }
    def f; yield [nil]; end;    f {|a| a.should == [nil] }
    def f; yield [[]]; end;     f {|a| a.should == [[]] }
    def f; yield [*[]]; end;    f {|a| a.should == [] }
    def f; yield [*[1]]; end;   f {|a| a.should == [1] }
    def f; yield [*[1,2]]; end; f {|a| a.should == [1,2] }
  end
  
  it "should assign splatted objects to block variables" do
    def f; yield *nil; end;     f {|a| a.should == nil }
    def f; yield *1; end;       f {|a| a.should == 1 }
    def f; yield *[1]; end;     f {|a| a.should == 1 }
    def f; yield *[nil]; end;   f {|a| a.should == nil }
    def f; yield *[[]]; end;    f {|a| a.should == [] }
    def f; yield *[*[1]]; end;  f {|a| a.should == 1 }
  end

  it "should assign objects to block variables that include the splat operator inside the block" do
    def f; yield; end;          f {|*a| a.should == [] }
    def f; yield nil; end;      f {|*a| a.should == [nil] }
    def f; yield 1; end;        f {|*a| a.should == [1] }
    def f; yield []; end;       f {|*a| a.should == [[]] }
    def f; yield [1]; end;      f {|*a| a.should == [[1]] }
    def f; yield [nil]; end;    f {|*a| a.should == [[nil]] }
    def f; yield [[]]; end;     f {|*a| a.should == [[[]]] }
    def f; yield [1,2]; end;    f {|*a| a.should == [[1,2]] }
    def f; yield [*[]]; end;    f {|*a| a.should == [[]] }
    def f; yield [*[1]]; end;   f {|*a| a.should == [[1]] }
    def f; yield [*[1,2]]; end; f {|*a| a.should == [[1,2]] }    
  end
  
  it "should assign objects to splatted block variables that include the splat operator inside the block" do
    def f; yield *nil; end;      f {|*a| a.should == [nil] }
    def f; yield *1; end;        f {|*a| a.should == [1] }
    def f; yield *[]; end;       f {|*a| a.should == [] }
    def f; yield *[1]; end;      f {|*a| a.should == [1] }
    def f; yield *[nil]; end;    f {|*a| a.should == [nil] }
    def f; yield *[[]]; end;     f {|*a| a.should == [[]] }
    def f; yield *[*[]]; end;    f {|*a| a.should == [] }
    def f; yield *[*[1]]; end;   f {|*a| a.should == [1] }
    def f; yield *[*[1,2]]; end; f {|*a| a.should == [1,2] }    
  end
  
  it "should assign objects to multiple block variables" do
    def f; yield; end;          f {|a,b,*c| [a,b,c].should == [nil,nil,[]] }
    def f; yield nil; end;      f {|a,b,*c| [a,b,c].should == [nil,nil,[]] }
    def f; yield 1; end;        f {|a,b,*c| [a,b,c].should == [1,nil,[]] }
    def f; yield []; end;       f {|a,b,*c| [a,b,c].should == [nil,nil,[]] }
    def f; yield [1]; end;      f {|a,b,*c| [a,b,c].should == [1,nil,[]] }
    def f; yield [nil]; end;    f {|a,b,*c| [a,b,c].should == [nil,nil,[]] }
    def f; yield [[]]; end;     f {|a,b,*c| [a,b,c].should == [[],nil,[]] }
    def f; yield [*[]]; end;    f {|a,b,*c| [a,b,c].should == [nil,nil,[]] }
    def f; yield [*[1]]; end;   f {|a,b,*c| [a,b,c].should == [1,nil,[]] }
    def f; yield [*[1,2]]; end; f {|a,b,*c| [a,b,c].should == [1,2,[]] }
  end
  
  it "should assign splatted objects to multiple block variables" do
    def f; yield *nil; end;      f {|a,b,*c| [a,b,c].should == [nil,nil,[]] }
    def f; yield *1; end;        f {|a,b,*c| [a,b,c].should == [1,nil,[]] }
    def f; yield *[]; end;       f {|a,b,*c| [a,b,c].should == [nil,nil,[]] }
    def f; yield *[1]; end;      f {|a,b,*c| [a,b,c].should == [1,nil,[]] }
    def f; yield *[nil]; end;    f {|a,b,*c| [a,b,c].should == [nil,nil,[]] }
    def f; yield *[[]]; end;     f {|a,b,*c| [a,b,c].should == [[],nil,[]] }
    def f; yield *[*[]]; end;    f {|a,b,*c| [a,b,c].should == [nil,nil,[]] }
    def f; yield *[*[1]]; end;   f {|a,b,*c| [a,b,c].should == [1,nil,[]] }
    def f; yield *[*[1,2]]; end; f {|a,b,*c| [a,b,c].should == [1,2,[]] }    
  end
  
end
