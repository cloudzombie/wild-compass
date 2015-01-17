require 'spreadsheet'
class MonthlyReportSpreadsheet

	@book = Spreadsheet.open 'monthly_report.xlsx'
	@sheet = @book.worksheet 0
	@start_date = Time.now - 1000
	@end_date = Time.now 
		
		# Date
		[4,52,97,140,184,275,318].each do |cell|
			@sheet.rows[6][cell] =  @start_date.strftime('Y')
			@sheet.rows[8][cell] =  @start_date.strftime('b')
			@sheet.rows[9][cell] =  @start_date.strftime('d')
			@sheet.rows[10][cell] =  @end_date.strftime('Y')
			@sheet.rows[12][cell] =  @end_date.strftime('b')
			@sheet.rows[13][cell] =  @end_date.strftime('d')
		end

		# ID & License number



		# Part A
		@sheet.rows[3][11] = weightable.total_weight
		@sheet.rows[3][13] = '12345'
		
		# Part B
		#Order.where('created_at >= ? AND created_at <= ?', @start_date, @end_date).each do ||
		#end

		# Part C
		@sheet.rows[6][35] = Customer.where('created_at <= ?', @end_date).count
		@sheet.rows[6][35] = Customer.where('created_at >= ?', @start_date).count

		# Part D
		@sheet.rows[6][43] = "Total clients who couldn't register." 
		@sheet.rows[6][44] = "Total clients whose orders could not be filled."

		# Part E
		@sheet.rows[7][60] = Plant.count
		@sheet.rows[7][61] = "Drying completed (not tested) KG"
		@sheet.rows[7][62] = "Drying completed (tested/ not approved) KG"		
		@sheet.rows[7][63] = "Ready for saled (tested/approved/packaged/labelled) KG"		
		@sheet.rows[7][64] = "Samples (for retention or further testing) g"		
		@sheet.rows[7][65] = "Dried M targeted for destructon"		
		@sheet.rows[7][66] = Plant.all.count		

		# Part F
		@sheet.rows[3][71] = "Amount imported." 

		# Part G
		@sheet.rows[3][76] = "Amount exported." 

		# Part H
		@sheet.rows[3][81] = "Amount lost or stolen."

		# Part I 
		@sheet.rows[87][3] = "Dried to be destroyed"
		@sheet.rows[88][3] = "Returned"
		@sheet.rows[89][3] = "Waste"

		# Part J
		@sheet.rows[102][3] = Order.where('created_at = ?', )
		@sheet.rows[103][3] = "Other Licensed products"
		@sheet.rows[104][3] = "licensed dealers"
		@sheet.rows[105][3] = "other clients"
		@sheet.rows[107][3] = "other clients details"

		# Part K
		
		# Registered Clients
		Order.where('created_at = ?',)
		@sheet.rows[3][114] = ""
		@sheet.rows[4][114] = ""
		@sheet.rows[5][114] = ""
		@sheet.rows[6][114] = ""
		@sheet.rows[7][114] = ""
		@sheet.rows[8][114] = ""
		@sheet.rows[9][114] = ""
		@sheet.rows[10][114] = ""
		@sheet.rows[11][114] = ""
		@sheet.rows[12][114] = ""
		@sheet.rows[13][114] = ""
		@sheet.rows[14][114] = ""
		@sheet.rows[15][114] = ""

		# Other licensed prducers
		Order.where('created_at = ?',)
		@sheet.rows[3][115] = ""
		@sheet.rows[4][115] = ""
		@sheet.rows[5][115] = ""
		@sheet.rows[6][115] = ""
		@sheet.rows[7][115] = ""
		@sheet.rows[8][115] = ""
		@sheet.rows[9][115] = ""
		@sheet.rows[10][115] = ""
		@sheet.rows[11][115] = ""
		@sheet.rows[12][115] = ""
		@sheet.rows[13][115] = ""
		@sheet.rows[14][115] = ""
		@sheet.rows[15][115] = ""

		# Licensed dealers
		Order.where('created_at = ?',)
		@sheet.rows[3][116] = ""
		@sheet.rows[4][116] = ""
		@sheet.rows[5][116] = ""
		@sheet.rows[6][116] = ""
		@sheet.rows[7][116] = ""
		@sheet.rows[8][116] = ""
		@sheet.rows[9][116] = ""
		@sheet.rows[10][116] = ""
		@sheet.rows[11][116] = ""
		@sheet.rows[12][116] = ""
		@sheet.rows[13][116] = ""
		@sheet.rows[14][116] = ""
		@sheet.rows[15][116] = ""

		# Other clients
		Order.where('created_at = ?',)
		@sheet.rows[3][117] = ""
		@sheet.rows[4][117] = ""
		@sheet.rows[5][117] = ""
		@sheet.rows[6][117] = ""
		@sheet.rows[7][117] = ""
		@sheet.rows[8][117] = ""
		@sheet.rows[9][117] = ""
		@sheet.rows[10][117] = ""
		@sheet.rows[11][117] = ""
		@sheet.rows[12][117] = ""
		@sheet.rows[13][117] = ""
		@sheet.rows[14][117] = ""
		@sheet.rows[15][117] = ""

		# Other clients details
		@sheet.rows[3][119] = ""

		# Part J
	
	@book.write 'rapport.xlsx'
end

sawg = MonthlyReportSpreadsheet.new
puts sawg