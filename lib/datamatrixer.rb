require 'chunky_png'

class Data_Matrix

	def initialize()


	@matrix = ChunkyPNG::Image.new(1500,1500, ChunkyPNG::Color::WHITE)

	@length_rows = [10, 12, 14, 16, 18, 20, 22, 24, 26,  # 24 squares et 6 rectangular
        32, 36, 40, 44, 48, 52, 64, 72, 80,  88, 96, 104, 120, 132, 144,
        8, 8, 12, 12, 16, 16]
	@length_cols = [10, 12, 14, 16, 18, 20, 22, 24, 26,  # Number of columns for the entire datamatrix
        32, 36, 40, 44, 48, 52, 64, 72, 80, 88, 96, 104, 120, 132, 144,
        18, 32, 26, 36, 36, 48]
	@data_cw_count = [3, 5, 8, 12,  18,  22,  30,  36,  # Number of data codewords for the datamatrix
        44, 62, 86, 114, 144, 174, 204, 280, 368, 456, 576, 696, 816, 1050,
        1304, 1558, 5, 10, 16, 22, 32, 49]
	@solomon_cw_count = [ 5, 7, 10, 12, 14, 18, 20, 24, 28,# Number of Reed-Solomon codewords for the datamatrix
        36, 42, 48, 56, 68, 84, 112, 144, 192, 224, 272, 336, 408, 496, 620,
        7, 11, 14, 18, 24, 28]
	@data_region_rows = [8, 10, 12, 14, 16, 18, 20, 22, # Number of rows per region
        24, 14, 16, 18, 20, 22, 24, 14, 16, 18, 20, 22, 24, 18, 20, 22,
        6,  6, 10, 10, 14, 14]
	@data_region_cols = [8, 10, 12, 14, 16, 18, 20, 22, # Number of columns per region
        24, 14, 16, 18, 20, 22, 24, 14, 16, 18, 20, 22, 24, 18, 20, 22,
        16, 14, 24, 16, 16, 22]
	@region_rows = [1, 1, 1, 1, 1, 1, 1, 1, # Number of regions per row
        1, 2, 2, 2, 2, 2, 2, 4, 4, 4, 4, 4, 4, 6, 6, 6,
        1, 1, 1, 1, 1, 1]
	@region_cols = [1, 1, 1, 1, 1, 1, 1, 1, #Number of regions per column
        1, 2, 2, 2, 2, 2, 2, 4, 4, 4, 4, 4, 4, 6, 6, 6,
        1, 2, 1, 2, 2, 2]
	@inter_leaved_blocks = [ 1, 1, 1, 1, 1, 1, 1, 1,# Number of blocks
        1, 1, 1, 1, 1, 1, 2, 2, 4, 4, 4, 4, 6, 6, 8, 8,
        1, 1, 1, 1, 1, 1]

	@log_tab = [-255, 255, 1, 240, 2, 225, 241, 53, 3,
				38, 226, 133, 242, 43, 54, 210, 4, 195, 39, 114, 227, 106, 134, 28,
		        243, 140, 44, 23, 55, 118, 211, 234, 5, 219, 196, 96, 40, 222, 115,
		        103, 228, 78, 107, 125, 135, 8, 29, 162, 244, 186, 141, 180, 45, 99,
		        24, 49, 56, 13, 119, 153, 212, 199, 235, 91, 6, 76, 220, 217, 197,
		        11, 97, 184, 41, 36, 223, 253, 116, 138, 104, 193, 229, 86, 79, 171,
		        108, 165, 126, 145, 136, 34, 9, 74, 30, 32, 163, 84, 245, 173, 187,
		        204, 142, 81, 181, 190, 46, 88, 100, 159, 25, 231, 50, 207, 57, 147,
		        14, 67, 120, 128, 154, 248, 213, 167, 200, 63, 236, 110, 92, 176, 7,
		        161, 77, 124, 221, 102, 218, 95, 198, 90, 12, 152, 98, 48, 185, 179,
		        42, 209, 37, 132, 224, 52, 254, 239, 117, 233, 139, 22, 105, 27, 194,
		        113, 230, 206, 87, 158, 80, 189, 172, 203, 109, 175, 166, 62, 127,
		        247, 146, 66, 137, 192, 35, 252, 10, 183, 75, 216, 31, 83, 33, 73,
		        164, 144, 85, 170, 246, 65, 174, 61, 188, 202, 205, 157, 143, 169, 82,
		        72, 182, 215, 191, 251, 47, 178, 89, 151, 101, 94, 160, 123, 26, 112,
		        232, 21, 51, 238, 208, 131, 58, 69, 148, 18, 15, 16, 68, 17, 121, 149,
		        129, 19, 155, 59, 249, 70, 214, 250, 168, 71, 201, 156, 64, 60, 237,
		        130, 111, 20, 93, 122, 177, 150]
	
	@anti_log_tab = [1, 2, 4, 8, 16, 32, 64, 128, 45, 90,
					180, 69, 138, 57, 114, 228, 229, 231, 227, 235, 251, 219, 155, 27, 54,
			        108, 216, 157, 23, 46, 92, 184, 93, 186, 89, 178, 73, 146, 9, 18, 36,
			        72, 144, 13, 26, 52, 104, 208, 141, 55, 110, 220, 149, 7, 14, 28, 56,
			        112, 224, 237, 247, 195, 171, 123, 246, 193, 175, 115, 230, 225, 239,
			        243, 203, 187, 91, 182, 65, 130, 41, 82, 164, 101, 202, 185, 95, 190,
			        81, 162, 105, 210, 137, 63, 126, 252, 213, 135, 35, 70, 140, 53, 106,
			        212, 133, 39, 78, 156, 21, 42, 84, 168, 125, 250, 217, 159, 19, 38, 76,
			        152, 29, 58, 116, 232, 253, 215, 131, 43, 86, 172, 117, 234, 249, 223,
			        147, 11, 22, 44, 88, 176, 77, 154, 25, 50, 100, 200, 189, 87, 174, 113,
			        226, 233, 255, 211, 139, 59, 118, 236, 245, 199, 163, 107, 214, 129,
			        47, 94, 188, 85, 170, 121, 242, 201, 191, 83, 166, 97, 194, 169, 127,
			        254, 209, 143, 51, 102, 204, 181, 71, 142, 49, 98, 196, 165, 103, 206,
			        177, 79, 158, 17, 34, 68, 136, 61, 122, 244, 197, 167, 99, 198, 161,
			        111, 222, 145, 15, 30, 60, 120, 240, 205, 183, 67, 134, 33, 66, 132,
			        37, 74, 148, 5, 10, 20, 40, 80, 160, 109, 218, 153, 31, 62, 124, 248,
			        221, 151, 3, 6, 12, 24, 48, 96, 192, 173, 119, 238, 241, 207, 179, 75,
			        150, 1]
	end


	def champ_galois_mult(a, b)
		if (!a or !b) then return 0
		else return @anti_log_tab[(@log_tab[a] + @log_tab[b]) % 255]
		end

	end

	def champ_galois_doub(a, b)
		if !a then
			c = 0
		elsif !b then
			c = a
		else
			c = @anti_log_tab[(@log_tab[a] + b) % 255]
		end

		return c
	end	

	def champ_galois_sum(a, b)
		return (a ^ b)
	end

	def select_index(data_code_words_count, rectangular)
		if ((data_code_words_count < 1 or data_code_words_count > 1558) and rectangular == 0) then return -1
		end
		if ((data_code_words_count < 1 or data_code_words_count > 49) and rectangular == 1) then return -1
		end

		n = 0

		while(@data_cw_count[n] < data_code_words_count) do
			n += 1
		end

		return n

	end

	def encode_data_code_words_ascii(text)
		data_cw = Array.new
		n = 0
		len = text.length
		for i in 0..(len-1)
			c = text[i].ord
			if c > 127
				data_cw[n] = 235
				c -= 127
				n += 1
			elsif ((c >= 48 and c <= 57) and (i + 1 < len) and (text.match('[0-9]', i+1)))
				c = ((c - 48) * 10) + text[i+1].to_i
				c += 130
			else c += 1
			end
			data_cw[n] = c
			n += 1
		end
		return data_cw
		end


	def add_pad_cw(tab, from, to)
		if from >= to then return nil 
		end
		tab[from] = 129
		for i in (from+1)...to
			r =  ((149 * (i+1)) % 253) + 1
			tab[i] = (129 + r) % 254
		end
	
	end

	def calcul_sol_factor_table(solomon_cw_count)
		g = Array.new(solomon_cw_count+1, 1)
		for i in 1..(solomon_cw_count+1)  
			for j in (i-1).downto(0)
				g[j] = self.champ_galois_doub(g[j], i)
				if (j > 0) then g[j] = self.champ_galois_sum(g[j], g[j-1])
				end
			end
		end
		return g
	end

	def add_reed_solomon_cw(n_solomon_cw, coeff_tab, n_data_cw, data_tab, blocks)
		error_blocks = n_solomon_cw / blocks
		correction_cw = Array.new
		for k in (0...blocks)
			for i in (0..error_blocks) do 
				correction_cw[i] = 0
			end
			(k...n_data_cw).step(blocks) do |i|
				temp = self.champ_galois_sum(data_tab[i], correction_cw[error_blocks-1])
				(error_blocks-1).downto(0).each do |j|
					if temp.nil? then
						correction_cw[j] = 0
					else
						correction_cw[j] = self.champ_galois_mult(temp, coeff_tab[j])
					end

					if (j>0) then
						correction_cw[j] = self.champ_galois_sum(correction_cw[j-1], correction_cw[j])
					end
				end
			end

			j = n_data_cw + k

			for i in (error_blocks-1).downto(0)
				data_tab[j] = correction_cw[i]
				j += blocks
			end
		end
		puts data_tab

		return data_tab
	end

	def get_bits(int)
		if int.nil?
			bit = '%08b' % 128
		else
			bit = '%08b' % int
		end
		
		end

	def place_bit_in_datamatrix(datamatrix, assigned, bit, row, col, total_rows, total_cols)
		if row < 0 then
			row += total_rows
			col += 4 - ((total_rows + 4) % 8)
		end

		if col < 0 then
			col += total_cols
			row += 4 - ((total_cols + 4) % 8)
		end
		if (assigned[row][col] == 0 or assigned[row[col] != 1])
			datamatrix[col][row] = bit.to_i
			assigned[row][col] = 1
		end
	end

	def next(etape, total_rows, total_cols, code_words_bit, datamatrix, assigned)
		chr = 0
		row = 4
		col = 0

		while ((row < total_rows) or (col < total_cols)) do 
			if ((row == total_rows) and (col == 0)) then
				self.pattern_shape_special_1(datamatrix, assigned, code_words_bit[chr], total_rows, total_cols)
				chr+= 1
			elsif ((etape < 3) and (row == total_rows-2) and (col == 0) and (total_cols % 4 != 0)) 
				self.pattern_shape_special_2(datamatrix, assigned, code_words_bit[chr], total_rows, total_cols)
				chr+= 1
			elsif ((row == total_rows-2) and (col == 0) and (total_cols % 8 == 4)) 
				self.pattern_shape_special_3(datamatrix, assigned, code_words_bit[chr], total_rows, total_cols)
				chr+= 1
			elsif ((row == total_rows+4) and (col == 2) and (total_cols % 8 == 0)) 
				self.pattern_shape_special_4(datamatrix, assigned, code_words_bit[chr], total_rows, total_cols)
				chr+= 1

			end

			while ((row >= 0) and (col < total_cols)) do
			 	
				if ((row < total_rows) and (col >= 0) and ((assigned[row][col] == 0) or (assigned[row][col] != 1))) then
					self.pattern_shape_standard(datamatrix, assigned, code_words_bit[chr], row, col, total_rows, total_cols)
					chr +=1
				end
				row -= 2
				col += 2

			end
			row += 1
			col += 3

			while ((row < total_rows) and (col >= 0))

			
				if ((row >= 0) and (col < total_cols) and ((assigned[row][col].nil?) or (assigned[row][col] != 1)))
					self.pattern_shape_standard(datamatrix, assigned, code_words_bit[chr], row, col, total_rows, total_cols)
					chr +=1
				end
				row += 2
				col -= 2

			end
			row += 3
			col += 1 
		end
	end

	def pattern_shape_standard(datamatrix, assigned, bits, row, col, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[0], row-2, col-2, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[1], row-2, col-1, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[2], row-1, col-2, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[3], row-1, col-1, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[4], row-1, col, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[5], row, col-2, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[6], row, col-1, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[7], row, col, total_rows, total_cols)
	end

	def pattern_shape_special_1(datamatrix, assigned, bits, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[0], total_rows-1, 0, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[1], total_rows-1, 1, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[2], total_rows-1, 2, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[3], 0, total_cols-2, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[4], 0, total_cols-1, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[5], 1, total_cols-1, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[6], 2, total_cols-1, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[7], 3, total_cols-1, total_rows, total_cols)
	end

	def pattern_shape_special_2(datamatrix, assigned, bits, total_rows, totals_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[0], total_rows-3, 0, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[1], total_rows-2, 0, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[2], total_rows-1, 0, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[3], 0, total_cols-4, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[4], 0, total_cols-3, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[5], 0, total_cols-2, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[6], 0, total_cols-1, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[7], 1, total_cols-1, total_rows, total_cols)
	end	

	def pattern_shape_special_3(datamatrix, assigned, bits, total_rows, totals_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[0], total_rows-3, 0, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[1], total_rows-2, 0, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[2], total_rows-1, 0, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[3], 0, total_cols-2, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[4], 0, total_cols-1, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[5], 1, total_cols-1, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[6], 2, total_cols-1, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[7], 3, total_cols-1, total_rows, total_cols)
	end	

	def pattern_shape_special_4(datamatrix, assigned, bits, total_rows, totals_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[0], total_rows-1, 0, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[1], total_rows-1, 0, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[2], 0, total_cols-3, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[3], 0, total_cols-2, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[4], 0, total_cols-1, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[5], 1, total_cols-3, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[6], 1, total_cols-2, total_rows, total_cols)
		self.place_bit_in_datamatrix(datamatrix, assigned, bits[7], 1, total_cols-1, total_rows, total_cols)
	end	

	def add_finder_pattern(datamatrix, rows_region, cols_region, rows_region_cw, cols_region_cw)
		total_rows_cw = (rows_region_cw + 2) * rows_region
		total_cols_cw = (cols_region_cw + 2) * cols_region

		datamatrix_temp = Array.new
		datamatrix_temp[0] = Array.new(total_cols_cw+2, 0)

		for i in 0..(total_rows_cw-1)
			datamatrix_temp[i+1] = Array.new
			datamatrix_temp[i+1][0] = 0
			datamatrix_temp[i+1][total_cols_cw+1] = 0

			for j in 0..(total_cols_cw-1)
				if (i % (rows_region_cw+2) == 0)
					if j % 2 == 0
						datamatrix_temp[i+1][j+1] = 1
					else
						datamatrix_temp[i+1][j+1] = 0
					end
				elsif (i % (rows_region_cw+2) == rows_region_cw + 1)
					datamatrix_temp[i+1][j+1] = 1
				elsif (j % (cols_region_cw+2) == cols_region_cw + 1)
					if i % 2 == 0
						datamatrix_temp[i+1][j+1] = 0
					else
						datamatrix_temp[i+1][j+1] = 1
					end
				elsif (j % (cols_region_cw+2)) == 0
					datamatrix_temp[i+1][j+1] = 1
				else
					datamatrix_temp[i+1][j+1] = 0
					datamatrix_temp[i+1][j+1] = datamatrix[i-1-(2*(i/(rows_region_cw+2)).floor)][j-1-(2*(j/(cols_region_cw+2)).floor)]
				end
			end
		end

		datamatrix_temp[total_rows_cw+1] = Array.new
		for j in 0..(total_cols_cw+1)
			datamatrix_temp[total_rows_cw+1][j] = 0
		end

		return datamatrix_temp

	end
	
	def getDigit(text, rectangular)
		data_code_words = encode_data_code_words_ascii(text)
		data_cw_count = data_code_words.length
		index = self.select_index(data_cw_count, 0)
		total_data_cw_count = @data_cw_count[index]
		solomon_cw_count = @solomon_cw_count[index]
		total_cw_count = total_data_cw_count + solomon_cw_count
		rows_total = @length_rows[index]
		cols_total = @length_cols[index]
		rows_region = @region_rows[index]
		cols_region = @region_cols[index]
		rows_region_cw = @data_region_rows[index]
		cols_region_cw = @data_region_cols[index]
		rows_length_matrice = rows_total-2*rows_region
		cols_length_matrice = cols_total-2*cols_region
		blocks = @inter_leaved_blocks[index]
		error_blocks = solomon_cw_count / blocks

		self.add_pad_cw(data_code_words, data_cw_count, total_data_cw_count)

		g = self.calcul_sol_factor_table(error_blocks)

		self.add_reed_solomon_cw(solomon_cw_count, g, total_data_cw_count, data_code_words, blocks)

		code_words_bit = Array.new
		for i in 0..(total_cw_count-1)
			code_words_bit[i] = get_bits(data_code_words[i])
		end

		datamatrix = Array.new(cols_length_matrice, 0) {Array.new(rows_length_matrice, 0)}
		assigned = Array.new(cols_length_matrice) {Array.new(rows_length_matrice, 0)}

		if(((rows_length_matrice * cols_length_matrice) % 8) == 4)
			datamatrix[rows_length_matrice-2][cols_length_matrice-2] = 1
			datamatrix[rows_length_matrice-1][cols_length_matrice-1] = 1
			datamatrix[rows_length_matrice-1][cols_length_matrice-2] = 0
			datamatrix[rows_length_matrice-2][cols_length_matrice-1] = 0
			assigned[rows_length_matrice-2][cols_length_matrice-2] = 1
			assigned[rows_length_matrice-1][cols_length_matrice-1] = 1
			assigned[rows_length_matrice-1][cols_length_matrice-2] = 1
			assigned[rows_length_matrice-2][cols_length_matrice-1] = 1
		end

		self.next(0, rows_length_matrice, cols_length_matrice, code_words_bit, datamatrix, assigned)
		datamatrix = self.add_finder_pattern(datamatrix, rows_region, cols_region, rows_region_cw, cols_region_cw)

		self.draw_matrix(datamatrix)
		@matrix.save('datamatrix.png', :interlace => true)
		return datamatrix
	end



	def draw_matrix(matrix_arr)
		matrix_arr.each_with_index do |row, y|
			row.each_with_index do |col, x|
				if matrix_arr[y][x] == 1
					draw_square((x+1)*50,(y+1)*50)
				end
			
			end
			

		end
	end

	def draw_square(x,y)
		@matrix.rect(x,y,x+50,y+50, stroke_color = ChunkyPNG::Color::BLACK, fill_color = ChunkyPNG::Color::BLACK)
	end

end

data = Data_Matrix.new
print data.getDigit('a', false)
