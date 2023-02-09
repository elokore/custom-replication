return function()
	local splitter = require(game.ReplicatedStorage.Common.SplitterModule)

	describe("SplitterModule", function()
		it("Should take the first 8 bits and split it in half into two 4-bit numbers", function()
			local n1: number, n2: number = splitter.splitNumber(255)
			expect(n1).to.equal(15)
			expect(n2).to.equal(12)
		end)
	end)
end
