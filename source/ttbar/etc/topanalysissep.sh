#!/bin/bash
prepreindices=(0)
preindices=(0 1)
#1 2 3 4 5 6 )
processes=(bbcyyc bbuyyu yycyyu yyuyyc)
fermions=( 6 ) 

pols=(eL.pR)
eve=(400)
#eve=(400)

for proc in ${processes[@]}
  do
  for pol in ${pols[@]}
    do

if [ ${pol} == "eR.pL" ]; then
	if [ ${proc} == "bbcyyc" ]; then
	    pid=37623
	elif [ ${proc} == "bbuyyu" ]; then
	    pid=37611
	elif [ ${proc} == "yycyyu" ]; then
	    pid=36915
	elif [ ${proc} == "yyuyyc" ]; then
	    pid=36911
	elif [ ${proc} == "zz" ]; then
	    pid=250004
	elif [ ${proc} == "ww" ]; then
	    pid=250008	    
	elif [ ${proc} == "yyxylv" ]; then
	    pid=36903
	elif [ ${proc} == "yyxyev" ]; then
	    pid=36899
	elif [ ${proc} == "yyveyx" ]; then
	    pid=36883
	elif [ ${proc} == "yyvlyx" ]; then
	    pid=36895
	elif [ ${proc} == "z_h" ]; then
	    pid=250116
	fi 
    elif [ ${pol} == "eL.pR" ]; then
  	if [ ${proc} == "bbcyyc" ]; then
	    pid=37622
	elif [ ${proc} == "bbuyyu" ]; then
	    pid=37610
	elif [ ${proc} == "yycyyu" ]; then
	    pid=36914
	elif [ ${proc} == "yyuyyc" ]; then
	    pid=36910
	elif [ ${proc} == "zz" ]; then
	    pid=250002
	elif [ ${proc} == "ww" ]; then
	    pid=250006
	elif [ ${proc} == "yyxylv" ]; then
            pid=36902
	elif [ ${proc} == "yyxyev" ]; then
	    pid=36898
	elif [ ${proc} == "yyveyx" ]; then
	    pid=36882
	elif [ ${proc} == "yyvlyx" ]; then
	    pid=36894	    
	elif [ ${proc} == "z_h" ]; then
	    pid=250114
	elif [ ${proc} == "ww_l" ]; then
	    pid=250026
	fi 
fi

for prepreindex in ${prepreindices[@]}
  do

for preindex in ${preindices[@]}
  do
if [ ${preindex} -lt 10 ]; then
         indices=( 0 1 2 3 4 5 6 7 8 9  )
     elif [ ${preindex} -eq 6 ]; then
         indices=( 0 1 2 3 4 5 )
     fi


  for index in ${indices[@]}
    do
    echo Index is $preindex$index Process ID $pid  Process $proc Polarization $pol

    cat > mytopsruntest.xml << EOF
    
    <marlin>
    
    <execute>
       <processor name="ttbarTreeWriter"/>

    </execute>
    
  <!--######## Global   ######################################## -->
       
       
       <global>
       <!--parameter name="LCIOInputFiles">/sps/flc/amjad/data/top/flavortagged/P4f_ggremoved_${proc}.${pol}-00${prepreindex}${preindex}${index}-DST.slcio </parameter--> 
       <parameter name="LCIOInputFiles">/sps/flc/amjad/data/top/flavortagged/xggremove_withbg_I${pid}.P${fermions}f_${proc}.${pol}-00${prepreindex}${preindex}${index}-DST.slcio </parameter> 
       <parameter name="GearXMLFile" value="gear_ILD_o1_v05.xml"/>
       <parameter name="MaxRecordNumber" value=${eve}/>
       <parameter name="SkipNEvents" value="0"/>
       <parameter name="SupressCheck" value="false"/>
       <!--parameter name="Verbosity" options="DEBUG0-4,MESSAGE0-4,WARNING0-4,ERROR0-4,SILENT"> MESSAGE </parameter-->
       <parameter name="RandomSeed" value="1234567890" />
       </global>
  
   
       <!--########  ttbarTreeWriter  ######################################## -->
       
       
       <processor name="ttbarTreeWriter" type="ttbar">
       <parameter name="RefinedJets" type="string" lcioInType="ReconstructedParticle"> RefinedJets </parameter>
       <parameter name="RefinedJets_vtx_RP" type="string" lcioInType="ReconstructedParticle"> RefinedJets_vtx_RP </parameter>
       <parameter name="RefinedJets_rel" type="string" lcioInType="LCRelation"> RefinedJets_rel </parameter>
       <parameter name="MCCollection" type="string" lcioInType="MCParticle"> MCParticlesSkimmed  </parameter>
       <parameter name="ROOTFileName" type="string"> /sps/flc/amjad/data/top/rootfiles/xggremove_withbg_I${pid}.P${fermions}f_${proc}.${pol}-00${prepreindex}${preindex}${index}-DST_sep.root </parameter>
       </processor>


  </marlin>
  

  
EOF
 
Marlin  mytopsruntest.xml 
  
  done
done

done
  done
done
exit 0
