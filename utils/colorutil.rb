# encoding=utf-8
#Author: Stephen Zhang

module ColorUtils
	def self.NormalizeColorCode(colorCode)
		normalizedCode = ""
		if(colorCode[0] != "#") then
			raise "Not a Color Hex Code"
		end
		if(colorCode.length == 4) then
			normalizedCode += colorCode[0]
			normalizedCode += colorCode[1] + colorCode[1]
			normalizedCode += colorCode[2] + colorCode[2]
			normalizedCode += colorCode[3] + colorCode[3]
		elsif(colorCode.length == 7)
			normalizedCode = colorCode
		else
			raise "Not a 3 digit short hand or 6 digit color code"
		end
		return normalizedCode 
	end

	def self.ConvertRgbToHex(rgb)
		if(rgb[0..3] == "rgba") then
			rgbToConvert = rgb.match(/^rgba\((\d+),\s*(\d+),\s*(\d+),\s*(\d+)\)$/)
		else
			rgbToConvert = rgb.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/)
		end
		if(rgbToConvert) then
			return "#" + hex(rgbToConvert[1]) + hex(rgbToConvert[2]) + hex(rgbToConvert[3])
		end
		return rgb
	end

	def self.hex(x)
		return ("0" + x.to_i.to_s(16))[-2, 2]
	end

end

