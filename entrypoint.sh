
# -- Generate NonLinLoc grid given velocity model (1D example)
Vel2Grid NonLinLoc.in

# changing from P- to S-wave type and generate grid
sed -i "s@VGTYPE P@VGTYPE S@" NonLinLoc.in && Vel2Grid NonLinLoc.in

# -- Generate NonLinLoc Travel Time grids (see NonLinLoc.in file for list of station)
Grid2Time NonLinLoc.in

# S-wave (watch-out if you change path or name of travel time grids)
sed -i "s@TIME/travel_times P@TIME/travel_times S@" NonLinLoc.in && Grid2Time NonLinLoc.in

# -- run NonLinLoc location algorithm 
NLLoc NonLinLoc.in