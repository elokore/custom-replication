local module = {}

function module.splitNumber(x: number): (number, number)
	local n1: number = bit32.band(x, 0b_0000_1111)
	local n2: number = bit32.rshift(bit32.band(x, 0b_1111_0000), 4)

	return n1, n2
end

return module
