require 'spec_helper'

describe "Lookup details from arcgis rest directory services" do

  it "should throw a exception if argument is wrong" do
    lambda{RGis::Helper::GeometryHelper.parse("wrong args")}.should raise_error(ArgumentError, "argument geometry must be a Array or Hash")
  end

  it "should throw a exception if array or hash is empty" do
    lambda{RGis::Helper::GeometryHelper.parse([])}.should raise_error(ArgumentError, "geometry must have at least one element")
    lambda{RGis::Helper::GeometryHelper.parse({})}.should raise_error(ArgumentError, "geometry must have at least one element")
  end

  it "should throw a exception if array contains only one numeric element" do
    lambda{RGis::Helper::GeometryHelper.parse([10])}.should raise_error(ArgumentError, "element of array geometry must have at least 2 numeric elements")
    lambda{RGis::Helper::GeometryHelper.parse([10.122])}.should raise_error(ArgumentError, "element of array geometry must have at least 2 numeric elements")
  end

  it "should throw a exception if array contains a non-numeric element" do
    lambda{RGis::Helper::GeometryHelper.parse([10, "asasa"])}.should raise_error(ArgumentError, "elements of array geometry must have at only numeric elements")
    lambda{RGis::Helper::GeometryHelper.parse([10.122, "asasa"])}.should raise_error(ArgumentError, "elements of array geometry must have at only numeric elements")
  end


  it "should identify a point from array with one array element" do
    geometry = RGis::Helper::GeometryHelper.parse([[1, 2]])
    geometry[:geometryType].should == 'esriGeometryPoint'
    geometry[:geometries].should be_a(Array)
    geometry[:geometries].should =~ [{ :x => 1, :y => 2 }]
  end

  it "should identify a point from array with one element" do
    geometry = RGis::Helper::GeometryHelper.parse([1, 2])
    geometry[:geometryType].should == 'esriGeometryPoint'
    geometry[:geometries].should be_a(Array)
    geometry[:geometries].should =~ [{ :x => 1, :y => 2 }]
  end

end