files = [ "dsp_cores_pkg.vhd" ];

modules = { "local" : [
#			"position_calc",
#    		"wb_position_calc",
			"wb_position_calc_nosysgen",
			"wb_un_cross",
            "sw_windowing",
			"multiplier",
			"cic",
			"cordic",
			"divider",
			"fixed_dds",
			"mixer",
			"downconv",
			"delta_sigma",
			"pipeline",
			"position_nosysgen",
			"input_gen"
                      ] };
