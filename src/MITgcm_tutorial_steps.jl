
function rerun1(myexp)

rundir=joinpath(myexp.folder,string(myexp.ID),"run")
logdir=joinpath(myexp.folder,string(myexp.ID),"log")
pardir=joinpath(logdir,"tracked_parameters")

# output files parameters

fil=joinpath(pardir,"data")
nml=read(fil,MITgcm_namelist())

nml.params[1][:useSingleCpuIO]=true

nml.params[3][:pChkptFreq] = 31104000.0
nml.params[3][:chkptFreq]  = 31104000.0
nml.params[3][:dumpFreq]   = 31104000.0
nml.params[3][:taveFreq]   = 31104000.0
nml.params[3][:taveFreq]   = 31104000.0
nml.params[3][:monitorFreq]= 86400.0

write(fil,nml)
git_log_fil(myexp,fil,"update parameter file : "*split(fil,"/")[end])

# output files parameters

fil=joinpath(pardir,"data.diagnostics")
nml=read(fil,MITgcm_namelist())
nml.params[1][Symbol("frequency(1)")]=2592000.0
write(fil,nml)
git_log_fil(myexp,fil,"update parameter file : "*split(fil,"/")[end])

# Set up Atmosphere CO2 concentration to pre-industrial level
#  (e.g. dic_pCO2 = 0.000278 for pre-industrial level
#   or   dic_pCO2 = 0.00035 for already changed climate)

fil=joinpath(pardir,"data.dic")
nml=read(fil,MITgcm_namelist())
nml.params[3][:dic_int1]=1
nml.params[3][:dic_pCO2]=0.000278
write(fil,nml)
git_log_fil(myexp,fil,"update parameter file : "*split(fil,"/")[end])

# change model run duration 
#  (e.g. nTimeSteps = 720 for one 360-day year with 1/2 day time step
#    or  nTimeSteps = 2160 for three years)

fil=joinpath(pardir,"data")
nml=read(fil,MITgcm_namelist())
nml.params[3][:nTimeSteps] = 120
write(fil,nml)
git_log_fil(myexp,fil,"update parameter file : "*split(fil,"/")[end])

# rerun model with updated parameters

clean(myexp)
setup(myexp)
launch(myexp)

fil=joinpath(logdir,"output_run1.txt")
cp(joinpath(rundir,"output.txt"),fil)
git_log_fil(myexp,fil,"output file from run1")

return true

end

##

function rerun2(myexp)

    rundir=joinpath(myexp.folder,string(myexp.ID),"run")
    logdir=joinpath(myexp.folder,string(myexp.ID),"log")
pardir=joinpath(logdir,"tracked_parameters")

# change model run duration 
#  (e.g. nTimeSteps = 720 for one 360-day year with 1/2 day time step
#    or  nTimeSteps = 2160 for three years)

fil=joinpath(pardir,"data")
nml=read(fil,MITgcm_namelist())
nml.params[3][:nTimeSteps] = 2160
write(fil,nml)
git_log_fil(myexp,fil,"update parameter file : "*split(fil,"/")[end])

# rerun model with updated parameters

clean(myexp)
setup(myexp)
launch(myexp)

fil=joinpath(logdir,"output_run2.txt")
cp(joinpath(rundir,"output.txt"),fil)
git_log_fil(myexp,fil,"output file from run2")

    return true

end

##

function rerun3(myexp)

rundir=joinpath(myexp.folder,string(myexp.ID),"run")
logdir=joinpath(myexp.folder,string(myexp.ID),"log")
pardir=joinpath(logdir,"tracked_parameters")

# Set up Atmosphere CO2 concentration to already changed climate
#  (e.g. dic_pCO2 = 0.000278 for pre-industrial level
#   or   dic_pCO2 = 0.00035 for already changed climate)

fil=joinpath(pardir,"data.dic")
nml=read(fil,MITgcm_namelist())
nml.params[3][:dic_int1]=1
nml.params[3][:dic_pCO2]=0.00035
write(fil,nml)
git_log_fil(myexp,fil,"update parameter file : "*split(fil,"/")[end])

# rerun model with updated parameters

clean(myexp)
setup(myexp)
launch(myexp)

fil=joinpath(logdir,"output_run3.txt")
cp(joinpath(rundir,"output.txt"),fil)
git_log_fil(myexp,fil,"output file from run3")

    return true

end
