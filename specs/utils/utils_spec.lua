require 'lfs'

-- Ensure the test is launched within the specs/ folder
assert(string.match(lfs.currentdir(), "specs")~=nil, "You must run this test in specs folder")

local initial_dir = lfs.currentdir()

-- Go to specs folder
while (not string.match(lfs.currentdir(), "/specs$")) do
  lfs.chdir("..")
end

local specs_dir = lfs.currentdir()
lfs.chdir("..")-- one more directory and it is lib root

-- Include Dataframe lib
dofile("init.lua")

-- Go back into initial dir
lfs.chdir(initial_dir)

describe("#get_variable_type tests", function()
	describe("check integer rules", function()
		it("Single integer should give integer as result", function()
			local type = get_variable_type("1")
			assert.are.same(type, "integer")
			type = get_variable_type(23213)
			assert.are.same(type, "integer")
		end)

		it("previous double should give double", function()
			local type = get_variable_type("1", "double")
			assert.are.same(type, "double")
			type = get_variable_type(23213, "double")
			assert.are.same(type, "double")
		end)

		it("previous boolean should give string", function()
			local type = get_variable_type("1", "boolean")
			assert.are.same(type, "string")
			type = get_variable_type(23213, "boolean")
			assert.are.same(type, "string")
		end)
	end)

	describe("check double rules", function()
		it("Single double should give double as result", function()
			local type = get_variable_type("1.2")
			assert.are.same(type, "double")
			type = get_variable_type(23213.2)
			assert.are.same(type, "double")
		end)

		it("previous integer should give double", function()
			local type = get_variable_type("1.1", "integer")
			assert.are.same(type, "double")
			type = get_variable_type(23213.2, "integer")
			assert.are.same(type, "double")
		end)

		it("previous boolean should give string", function()
			local type = get_variable_type("1.2", "boolean")
			assert.are.same(type, "string")
			type = get_variable_type(23213.2, "boolean")
			assert.are.same(type, "string")
		end)
	end)

	describe("check boolean rules", function()
		it("Single boolean should give boolean as result", function()
			local type = get_variable_type("true")
			assert.are.same(type, "boolean")
			type = get_variable_type(true)
			assert.are.same(type, "boolean")
		end)

		it("previous integer should give string", function()
			local type = get_variable_type("true", "integer")
			assert.are.same(type, "string")
			type = get_variable_type(false, "integer")
			assert.are.same(type, "string")
		end)

		it("previous boolean should give boolean", function()
			local type = get_variable_type("false", "boolean")
			assert.are.same(type, "boolean")
			type = get_variable_type(true, "boolean")
			assert.are.same(type, "boolean")
		end)

		it("True/false should be case independent", function()
			for _,spelling in pairs({"tRue", "fAlse", "FALSE", "TRUE", "True", "False"}) do
				local type = get_variable_type(spelling)
				assert.are.same(type, "boolean")
			end
		end)
	end)
end)
