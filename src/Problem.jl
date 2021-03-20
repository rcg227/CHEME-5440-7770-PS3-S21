# ----------------------------------------------------------------------------------- #
# Copyright (c) 2018 Varnerlab
# Robert Frederick Smith School of Chemical and Biomolecular Engineering
# Cornell University, Ithaca NY 14850
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# ----------------------------------------------------------------------------------- #

# ----------------------------------------------------------------------------------- #
# Function: generate_problem_dictionary
# Description: Holds simulation and model parameters as key => value pairs in a Julia Dict()
# Generated on: 2018-03-15T00:00:56.939
#
# Output arguments:
# data_dictionary::Dict{AbstractString,Any} => Dictionary holding model and simulation parameters as key => value pairs
# ----------------------------------------------------------------------------------- #
function generate_problem_dictionary()

	# Load the stoichiometric network from disk -
	path_to_network_file = joinpath(_PATH_TO_CONFIG,"Network.dat")
	stoichiometric_matrix = readdlm(path_to_network_file);

	# What is the system dimension? -
	(number_of_species,number_of_reactions) = size(stoichiometric_matrix)

	# Setup the flux bounds array -
	flux_bounds_array = zeros(number_of_reactions,2)
	# TODO: update the flux_bounds_array for each reaction in your network, col 1 => lower bound, col 2 => upper bound, each row is a reaction
	#flux in units of micromole/gDW-sec
	flux_bounds_array[1,1]=0
	flux_bounds_array[1,2]=2.03 #Vmax for v1
	flux_bounds_array[2,1]=0
	flux_bounds_array[2,2]=0.345 #Vmax for v2
	flux_bounds_array[3,1]=0
	flux_bounds_array[3,2]=2.49 #Vmax for v3
	flux_bounds_array[4,1]=0
	flux_bounds_array[4,2]=0.881 #Vmax for v4
	flux_bounds_array[5,1]=0
	flux_bounds_array[5,2]=0.137 #Vmax for v5

	flux_bounds_array[6,1]=0
	flux_bounds_array[6,2]=2.78 #upper bound for b1, in micromole/gDW-sec
	flux_bounds_array[7,1]=0
	flux_bounds_array[7,2]=2.78 #upper bound for b2
	flux_bounds_array[8,1]=0
	flux_bounds_array[8,2]=2.78 #upper bound for b3
	flux_bounds_array[9,1]=0
	flux_bounds_array[9,2]=2.78 #upper bound for b4
	flux_bounds_array[10,1]=0
	flux_bounds_array[10,2]=2.78 #upper bound for b5

	# Setup default species bounds array -
	species_bounds_array = zeros(number_of_species,2)
	# TODO: NOTE - we by default assume Sv = 0, so species_bounds_array should be a M x 2 array of zeros
	# TODO: however, if you formulate the problem differently you *may* need to change this
	# so...I don't need to change anything here, right?

	# Min/Max flag - default is minimum -
	is_minimum_flag = true

	# Setup the objective coefficient array -
	objective_coefficient_array = zeros(number_of_reactions)
	# TODO: update me to maximize Urea production (Urea leaving the virtual box)
	# what is the physical significance of this? Did I code it corectly?
	# TODO: if is_minimum_flag = true => put a -1 in the index for Urea export (reaction b4)

	if is_minimum_flag == true
		objective_coefficient_array[9]= -1.0
	end


	# =============================== DO NOT EDIT BELOW THIS LINE ============================== #
	data_dictionary = Dict{String,Any}()
	data_dictionary["stoichiometric_matrix"] = stoichiometric_matrix
	data_dictionary["objective_coefficient_array"] = objective_coefficient_array
	data_dictionary["flux_bounds_array"] = flux_bounds_array;
	data_dictionary["species_bounds_array"] = species_bounds_array
	data_dictionary["is_minimum_flag"] = is_minimum_flag
	data_dictionary["number_of_species"] = number_of_species
	data_dictionary["number_of_reactions"] = number_of_reactions
	# =============================== DO NOT EDIT ABOVE THIS LINE ============================== #
	return data_dictionary
end
