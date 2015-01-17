	
class monthly_report_spreadsheet(start_date, end_date)
	
	@book = Spreadsheet.open 'monthly_report.xlsx'
	@sheet = book.worksheet 0

		# Date
		[4,52,97,140,184,275,318].each do |cell|
			@sheet.rows[6][cell] =  start_date.strftime('Y')
			@sheet.rows[8][cell] =  start_date.strftime('b')
			@sheet.rows[9][cell] =  start_date.strftime('d')
			@sheet.rows[10][cell] =  end_date.strftime('Y')
			@sheet.rows[12][cell] =  end_date.strftime('b')
			@sheet.rows[13][cell] =  end_date.strftime('d')
		end
		# Part A
		@sheet.rows[3][11] = weightable.total_weight
		@sheet.rows[3][13] = '12345'

		# Part B
		Order.where('created_at >= ? AND created_at <= ?', start_date, end_date).each do ||

		# Part C
		@sheet.rows[6][35] = Customer.where('created_at <= ?', end_date).count
		@sheet.rows[6][35] = Customer.where('created_at >= ?', start_date).count

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

		Order.where('created_at = ?',)
		@sheet.rows[3][113] = ""
		@sheet.rows[3][113] = ""
		@sheet.rows[3][113] = ""
		@sheet.rows
