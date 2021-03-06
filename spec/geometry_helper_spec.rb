require 'spec_helper'

describe "Lookup details from arcgis rest directory services" do

  it "should throw a exception if argument is wrong" do
    lambda{RGis::Helper::GeometryHelper.parse("wrong args")}.should raise_error(ArgumentError, "argument geometry must a Hash")
  end

  it "should throw a exception if array or hash is empty" do
    lambda{RGis::Helper::GeometryHelper.parse(:point => {})}.should raise_error(ArgumentError, "geometry must have at least one element")
  end

  it "should throw a exception if array contains only one numeric element" do
    lambda{RGis::Helper::GeometryHelper.parse(:point => [10.122])}.should raise_error(ArgumentError, "element of array geometry must have at least 2 numeric elements")
  end

  it "should throw a exception if array contains a non-numeric element" do
    lambda{RGis::Helper::GeometryHelper.parse(:point => [10.122, "asasa"])}.should raise_error(ArgumentError, "elements of array geometry must have at only numeric elements")
  end

  it "should throw a exception if hash contains a non-numeric element" do
    lambda{RGis::Helper::GeometryHelper.parse(:point => { :x => 1, :y => "a" })}.should raise_error(ArgumentError, "elements of hash geometry must have at only numeric elements")
  end

  it "should identify a point from array with one array element" do
    geometry = RGis::Helper::GeometryHelper.parse(:point => [[1, 2]])
    geometry[:geometryType].should == 'esriGeometryPoint'
    geometry[:geometries].should be_a(Array)
    geometry[:geometries].should =~ [{ :x => 1, :y => 2 }]
  end

  it "should identify a point from array with one element" do
    geometry = RGis::Helper::GeometryHelper.parse(:point => [1, 2])
    geometry[:geometryType].should == 'esriGeometryPoint'
    geometry[:geometries].should be_a(Array)
    geometry[:geometries].should =~ [{ :x => 1, :y => 2 }]
  end

  it "should identify a polygon from array elements" do
    geometry = RGis::Helper::GeometryHelper.parse(:polygon => [[1, 2],[2, 3], [3, 4], [1, 2]])
    geometry[:geometryType].should == 'esriGeometryPolygon'
    geometry[:rings].should be_a(Array)
    geometry[:rings].should =~ [[[1, 2],[2, 3], [3, 4], [1, 2]]]
  end

  it "should identify a polyline from array elements" do
    geometry = RGis::Helper::GeometryHelper.parse(:polyline => [[1, 2],[2, 3], [3, 4]])
    geometry[:geometryType].should == 'esriGeometryPolyline'
    geometry[:paths].should be_a(Array)
    geometry[:paths].should =~ [[[1, 2],[2, 3], [3, 4]]]
  end

  it "should identify a point from hash with one array element" do
    geometry = RGis::Helper::GeometryHelper.parse(:point => [[1, 2]])
    geometry[:geometryType].should == 'esriGeometryPoint'
    geometry[:geometries].should be_a(Array)
    geometry[:geometries].should =~ [{ :x => 1, :y => 2 }]
  end

  it "should identify a point from hash with one array element" do
    geometry = RGis::Helper::GeometryHelper.parse(:point => [1, 2])
    geometry[:geometryType].should == 'esriGeometryPoint'
    geometry[:geometries].should be_a(Array)
    geometry[:geometries].should =~ [{ :x => 1, :y => 2 }]
  end

  it "should identify a point from hash with one hash with x and y" do
    geometry = RGis::Helper::GeometryHelper.parse(:point => { :x => 1, :y => 2 })
    geometry[:geometryType].should == 'esriGeometryPoint'
    geometry[:geometries].should be_a(Array)
    geometry[:geometries].should =~ [{ :x => 1, :y => 2 }]
  end

  it "should identify a envelope from hash with x and y max e min" do
    geometry = RGis::Helper::GeometryHelper.parse(:envelope => { :xmin => 1, :ymin => 2, :xmax => 1, :ymax => 2 })
    geometry[:geometryType].should == 'esriGeometryEnvelope'
    geometry[:geometries].should be_a(Hash)
    geometry[:geometries].should == { :xmin => 1, :ymin => 2, :xmax => 1, :ymax => 2 }
  end

  it "should identify a envelope from hash with two arrays" do
    geometry = RGis::Helper::GeometryHelper.parse(:envelope => [[1, 2],[2, 3]])
    geometry[:geometryType].should == 'esriGeometryEnvelope'
    geometry[:geometries].should be_a(Hash)
    geometry[:geometries].should == { :xmin => 1, :ymin => 2, :xmax => 2, :ymax => 3 }
  end

end
