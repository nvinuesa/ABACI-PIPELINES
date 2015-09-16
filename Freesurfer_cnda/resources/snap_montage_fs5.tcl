set subject    [GetSubjectName 0]

global env
set subjectsdir $env(SUBJECTS_DIR)
set subjectdir "${subjectsdir}/${subject}"

set prefix $env(PREFIX)
set loadothers $env(LOADOTHERS)
set aseg $env(ASEG)
set aparc_aseg $env(APARC_ASEG)

set    imagedir "${subjectsdir}/${subject}/snapshots"

puts "Subject    : $subject"
puts "Subject Dir: $subjectdir"
puts  "Prefix: $prefix"
puts  "LOADOTHERS: $loadothers"


SetZoomLevel 1
RedrawScreen
set outpth "${subjectsdir}/${subject}/snapshots"

if {$loadothers == 1} {
	puts "Load main surfaces"
	LoadMainSurface      0 lh.white
	LoadPialSurface      0 lh.pial
	LoadOriginalSurface  0 lh.orig

	puts "Load aux surfaces"
	LoadMainSurface      1 rh.white
	LoadPialSurface      1 rh.pial
	LoadOriginalSurface  1 rh.orig

}

if {$aseg == 1} {
 LoadSegmentationVolume 0 aseg.mgz $env(FREESURFER_HOME)/FreeSurferColorLUT.txt
 RedrawScreen
}

if {$aparc_aseg == 1} {
 LoadSegmentationVolume 0 aparc+aseg.mgz $env(FREESURFER_HOME)/FreeSurferColorLUT.txt
 RedrawScreen
}


puts "SetDisplayFlags"
# SetDisplayFlag  2 1
SetDisplayFlag    4 1
SetDisplayFlag    5 1
SetDisplayFlag    6 1
SetDisplayFlag   22 1


#---------------------------
proc makeSliceRGB {orient  slicenum} {
#---------------------------
global imagedir
global subject
global prefix

  switch -exact -- $orient {
    0 { set viewname cor }
    1 { set viewname axl }
    2 { set viewname sag }
  }

  set slicestr [format "%03d" $slicenum]

  SetOrientation $orient
  SetSlice $slicenum

  RedrawScreen
  RedrawAll
  RedrawScreen
  RedrawAll
  RedrawScreen
  RedrawAll
  RedrawScreen
  RedrawAll
	

  # Use braces to avoid tcl's utterly brain-dead catenation inadequacies...
  set imagepath "${imagedir}/${subject}_${prefix}_${viewname}_${slicestr}.rgb"

  SaveRGB $imagepath

}

#---------------------------
proc createSlices {orient firstSlice lastSlice} {
#---------------------------
	set slicenum $firstSlice
	while { $slicenum < $lastSlice } {
	  makeSliceRGB $orient $slicenum
	  incr slicenum 2
	} 
} 

  #coronal	
  #createSlices 0 40 170
  #transverse
  #createSlices 1 120 190
  #sagittal
  #createSlices 2 90 175

  #coronal	
  createSlices 0 33 212
  #transverse
  createSlices 1 57 200
  #sagittal
  createSlices 2 63 194


  #coronal	
  createSlices 0 27 212
  #transverse
  createSlices 1 41 200
  #sagittal
  createSlices 2 63 194



QuitMedit

