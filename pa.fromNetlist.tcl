
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name CS331FinalProject -dir "C:/Users/Waqas/Documents/Xilinx Projects/CS331FinalProject/planAhead_run_1" -part xc3s250evq100-5
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/Waqas/Documents/Xilinx Projects/CS331FinalProject/Sonar.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/Waqas/Documents/Xilinx Projects/CS331FinalProject} }
set_property target_constrs_file "Sonar.ucf" [current_fileset -constrset]
add_files [list {Sonar.ucf}] -fileset [get_property constrset [current_run]]
link_design
