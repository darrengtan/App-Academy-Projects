require 'rspec'
require 'arrays'

describe "Array#my_uniq" do
  subject(:test_arr) { [1, 2, 1, 3, 3] }

  it "should return unique elements in order they appear" do
    expect(test_arr.my_uniq).to eq([1, 2, 3])
  end

  it "should not use Array#uniq method" do
    expect(test_arr.my_uniq).to_not receive(:uniq)
  end
end

describe "Array#two_sum" do
  it "should return nil if count of array smaller than 2" do
    test_arr = [1]
    expect(test_arr.two_sum).to be_nil
  end

  it "should return empty array if there is no pairs" do
    test_arr = [1,2,3,4,5]
    expect(test_arr.two_sum).to eq([])
  end

  it "should find all index pairs where those elements sum to zero" do
    test_arr = [-1, 0, 2, -2, 1]
    expect(test_arr.two_sum).to eq([[0, 4], [2, 3]])
  end

  it "should list the pairs from smaller index to bigger index" do
    test_arr = [1, 1, -1]
    expect(test_arr.two_sum).to eq([[0, 2], [1, 2]])
  end

  it "should have the smaller second elements come first" do
    test_arr = [-1, 1, 1]
    expect(test_arr.two_sum).to eq([[0, 1], [0, 2]])
  end
end

describe "#median" do
  context "the given array contains even number of integers" do
    it "returns the average of the middle two items from the sorted array" do
      test_arr = [1,2,3,4,5,6]
      expect(median(test_arr)).to eq(3)
    end
  end

  context "the given array contains odd number of integers" do
    it "returns the middle item from the sorted array" do
      test_arr = [1,2,3,4,5,6,7]
      expect(median(test_arr)).to eq(4)
    end
  end
end


describe "#my_transpose" do
  subject(:test_matrix) { [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ]
  }

  it "raises an error when the given array contains different size of elements" do
    test_matrix = [[1,2,3],[2],[1,2]]
    expect do
      my_transpose(test_matrix)
    end.to raise_error "NOOOO"
  end

  it "transposes the matrix array" do
    expect(my_transpose(test_matrix)).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
  end

  it "does not use the #transpose" do
    expect(my_transpose(test_matrix)).to_not receive(:transpose)
  end
end
