<?xml version="1.0" encoding="iso-8859-1"?>
<iso:schema    xmlns="http://purl.oclc.org/dsdl/schematron" 
	       xmlns:iso="http://purl.oclc.org/dsdl/schematron"
	       xmlns:nrgxsl="http://nrg.wustl.edu/validate" 
	       queryBinding='xslt2'
	       schemaVersion="ISO19757-3">

<iso:ns uri="http://nrg.wustl.edu/xnat" prefix="xnat"/>

  <iso:title>Protocol Validator</iso:title>

<!-- It is expected that each rule file would have the following Patterns available viz. Start, ListScanIds -->

  <iso:pattern id="Start">
	   <iso:title>Validation report</iso:title>
	    <iso:rule context="/">
	     	<iso:assert test="xnat:MRSession">The root element must be an MRSession</iso:assert>
	    </iso:rule>
	    <iso:rule context="xnat:MRSession">
		<iso:report id="expt_id" test="true()"><iso:value-of select="@ID"/></iso:report>
		<iso:report id="expt_project" test="true()"><iso:value-of select="@project"/></iso:report>
		<iso:report id="expt_label" test="true()"><iso:value-of select="@label"/></iso:report>
	    </iso:rule>
 </iso:pattern>
 



<iso:pattern id="Acquisition T1">
	    <iso:rule context="xnat:scans">
		<iso:assert test="count(xnat:scan[@type='Ax 3D T1 BRAVO 1mm']) = 1 or count(xnat:scan[@type='Ax 3D T1 BRAVO 1mm **']) = 1"> 
		<nrgxsl:acquisition>
		<nrgxsl:cause-id>Localizer Count T1,</nrgxsl:cause-id>
		  MRSession must have 1 T1-BRAVO scan. Found <iso:value-of select="count(xnat:scan[@type='Ax 3D T1 BRAVO 1mm']) + count(xnat:scan[@type='Ax 3D T1 BRAVO 1mm **'])"/> T1 scan(s). 
		</nrgxsl:acquisition> 
		</iso:assert>
            </iso:rule>
</iso:pattern>

<iso:pattern id="Acquisition T2">
	    <iso:rule context="xnat:scans">
		<iso:assert test="(count(xnat:scan[@type='Sag CUBE FLAIR 1.8mm']) = 1 or count(xnat:scan[@type='Sag CUBE FLAIR 1.8mm (Avec zip512)']) = 1 or count(xnat:scan[@type='Sag CUBE FLAIR 1.8mm (Sans zip512)']) = 1) and count(xnat:scan[@type='Sag CUBE T2 1.8mm']) = 1"> 
		<nrgxsl:acquisition>
		<nrgxsl:cause-id>Localizer Count T2,</nrgxsl:cause-id>
		  MRSession must have 1 FLAIR and 1 T2 scans. Found <iso:value-of select="count(xnat:scan[@type='Sag CUBE FLAIR 1.8mm']) + count(xnat:scan[@type='Sag CUBE FLAIR 1.8mm (Avec zip512)']) + count(xnat:scan[@type='Sag CUBE FLAIR 1.8mm (Sans zip512)'])"/> FLAIR scan(s) and <iso:value-of select="count(xnat:scan[@type='Sag CUBE T2 1.8mm'])"/> T2 scan(s). 
		</nrgxsl:acquisition> 
		</iso:assert>
            </iso:rule>
</iso:pattern>



<iso:pattern id="ListScanIds">
	    <iso:rule context="//xnat:scan">
		<iso:report test="@ID">
		  <nrgxsl:scans>
		    <iso:value-of select="@ID"/>
		  </nrgxsl:scans> 	
		</iso:report>
            </iso:rule>
</iso:pattern>




<iso:pattern id="Scan">
	<iso:rule context="/xnat:MRSession/xnat:scans/xnat:scan[@type='Ax 3D T1 BRAVO 1mm']">
			<iso:assert test="xnat:frames = 166" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Frames</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>frames</nrgxsl:xmlpath>
			      <iso:value-of select="concat( 'Expected: 166 Found: ', ./xnat:frames)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:imageType = 'ORIGINAL\\PRIMARY\\OTHER'" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Image type</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.imageType</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: ORIGINAL\\PRIMARY\\OTHER Found: ', ./xnat:parameters/xnat:imageType)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:coil = 'Head 24'" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Coil</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>coil</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: Head 24 Found: ', ./xnat:coil)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:fieldStrength = 3.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Field strength</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>fieldStrength</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 3.0 Found: ', ./xnat:fieldStrength)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:voxelRes//@x = 0.9375" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Vox.Res.x</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.voxelRes.x</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 0.9375 Found: ', ./xnat:parameters/xnat:voxelRes//@x)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:voxelRes//@y = 0.9375" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Vox.Res.y</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.voxelRes.y</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 0.9375 Found: ', ./xnat:parameters/xnat:voxelRes//@y)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:voxelRes//@z = 1.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Vox.Res.z</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.voxelRes.z</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 1.0 Found: ', ./xnat:parameters/xnat:voxelRes//@z)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:fov//@x = 256" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>FOV x</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.fov.x</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 256 Found: ', ./xnat:parameters/xnat:fov/xnat//@x)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:fov//@y = 256" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>FOV y</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.fov.y</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 256 Found: ', ./xnat:parameters/xnat:fov/xnat//@y)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:tr &gt; 8.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TR</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.tr</nrgxsl:xmlpath>
			   <iso:value-of select="concat('Expected: between 8.0 and 9.0 Found: ', ./xnat:parameters/xnat:tr)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:tr &lt; 9.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TR</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.tr</nrgxsl:xmlpath>
			   <iso:value-of select="concat('Expected: between 8.0 and 9.0 Found: ', ./xnat:parameters/xnat:tr)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:te &gt; 3.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TE</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.te</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: between 3.0 and 4.0 Found: ', ./xnat:parameters/xnat:te)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:te &lt; 4.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TE</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.te</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: between 3.0 and 4.0 Found: ', ./xnat:parameters/xnat:te)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:ti = 450" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TI</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.ti</nrgxsl:xmlpath>
			   	<iso:value-of select="concat('Expected: 450 Found: ', ./xnat:parameters/xnat:ti)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:flip = 15" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Flip</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.flip</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 15 Found: ', ./xnat:parameters/xnat:flip)"/>
			   </nrgxsl:scan>
			</iso:assert>
	</iso:rule>
</iso:pattern>

<iso:pattern id="Scan">
	<iso:rule context="/xnat:MRSession/xnat:scans/xnat:scan[@type='Ax 3D T1 BRAVO 1mm **']"> 	
			<iso:assert test="xnat:frames = 166" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Frames</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>frames</nrgxsl:xmlpath>
			      <iso:value-of select="concat( 'Expected: 166 Found: ', ./xnat:frames)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:imageType = 'ORIGINAL\\PRIMARY\\OTHER'" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Image type</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.imageType</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: ORIGINAL\\PRIMARY\\OTHER Found: ', ./xnat:parameters/xnat:imageType)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:coil = 'Head 24'" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Coil</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>coil</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: Head 24 Found: ', ./xnat:coil)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:fieldStrength = 3.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Field strength</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>fieldStrength</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 3.0 Found: ', ./xnat:fieldStrength)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:voxelRes//@x = 0.9375" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Vox.Res.x</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.voxelRes.x</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 0.9375 Found: ', ./xnat:parameters/xnat:voxelRes//@x)"/>
			   </nrgxsl:scan>
			</iso:assert>		
			<iso:assert test="xnat:parameters/xnat:voxelRes//@y = 0.9375" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Vox.Res.y</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.voxelRes.y</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 0.9375 Found: ', ./xnat:parameters/xnat:voxelRes//@y)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:voxelRes//@z = 1.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Vox.Res.z</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.voxelRes.z</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 1.0 Found: ', ./xnat:parameters/xnat:voxelRes//@z)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:fov//@x = 256" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>FOV x</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.fov.x</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 256 Found: ', ./xnat:parameters/xnat:fov/xnat//@x)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:fov//@y = 256" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>FOV y</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.fov.y</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 256 Found: ', ./xnat:parameters/xnat:fov/xnat//@y)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:tr &gt; 8.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TR</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.tr</nrgxsl:xmlpath>
			   <iso:value-of select="concat('Expected: between 8.0 and 9.0 Found: ', ./xnat:parameters/xnat:tr)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:tr &lt; 9.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TR</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.tr</nrgxsl:xmlpath>
			   <iso:value-of select="concat('Expected: between 8.0 and 9.0 Found: ', ./xnat:parameters/xnat:tr)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:te &gt; 3.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TE</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.te</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: between 3.0 and 4.0 Found: ', ./xnat:parameters/xnat:te)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:te &lt; 4.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TE</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.te</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: between 3.0 and 4.0 Found: ', ./xnat:parameters/xnat:te)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:ti = 450" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TI</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.ti</nrgxsl:xmlpath>
			   	<iso:value-of select="concat('Expected: 450 Found: ', ./xnat:parameters/xnat:ti)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:flip = 15" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Flip</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.flip</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 15 Found: ', ./xnat:parameters/xnat:flip)"/>
			   </nrgxsl:scan>
			</iso:assert>
	</iso:rule>
</iso:pattern>

<iso:pattern id="Scan">
		<iso:rule context="/xnat:MRSession/xnat:scans/xnat:scan[@type='Sag CUBE FLAIR 1.8mm']">
			<iso:assert test="xnat:frames = 112" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Frames</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>frames</nrgxsl:xmlpath>
			      <iso:value-of select="concat( 'Expected: 112 Found: ', ./xnat:frames)"/>
			   </nrgxsl:scan>
			</iso:assert>			
			<iso:assert test="xnat:parameters/xnat:imageType = 'ORIGINAL\\PRIMARY\\OTHER'" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Image type</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.imageType</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: ORIGINAL\\PRIMARY\\OTHER Found: ', ./xnat:parameters/xnat:imageType)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:coil = 'Head 24'" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Coil</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>coil</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: Head 24 Found: ', ./xnat:coil)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:fieldStrength = 3.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Field strength</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>fieldStrength</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 3.0 Found: ', ./xnat:fieldStrength)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:voxelRes//@x = 1.875" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Vox.Res.x</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.voxelRes.x</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 1.875 Found: ', ./xnat:parameters/xnat:voxelRes//@x)"/>
			   </nrgxsl:scan>
			</iso:assert>		
			<iso:assert test="xnat:parameters/xnat:voxelRes//@y = 1.875" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Vox.Res.y</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.voxelRes.y</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 1.875 Found: ', ./xnat:parameters/xnat:voxelRes//@y)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:voxelRes//@z = 1.8" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Vox.Res.z</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.voxelRes.z</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 1.8 Found: ', ./xnat:parameters/xnat:voxelRes//@z)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:fov//@x = 512" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>FOV x</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.fov.x</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 512 Found: ', ./xnat:parameters/xnat:fov/xnat//@x)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:fov//@y = 512" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>FOV y</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.fov.y</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 512 Found: ', ./xnat:parameters/xnat:fov/xnat//@y)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:tr = 9000.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TR</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.tr</nrgxsl:xmlpath>
			   <iso:value-of select="concat('Expected: 9000.0 Found: ', ./xnat:parameters/xnat:tr)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:te &gt; 130.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TE</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.te</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: between 130.0 and 145.0 Found: ', ./xnat:parameters/xnat:te)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:te &lt; 145.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TE</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.te</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: between 137.0 and 145.0 Found: ', ./xnat:parameters/xnat:te)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:ti &gt; 2360.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TI</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.ti</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: between 2360.0 and 2370.0 Found: ', ./xnat:parameters/xnat:ti)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:ti &lt; 2370.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TI</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.ti</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: between 2360.0 and 2370.0 Found: ', ./xnat:parameters/xnat:ti)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:flip = 90" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Flip</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.flip</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 90 Found: ', ./xnat:parameters/xnat:flip)"/>
			   </nrgxsl:scan>
			</iso:assert>
		</iso:rule>
</iso:pattern>

<iso:pattern id="Scan">
		<iso:rule context="/xnat:MRSession/xnat:scans/xnat:scan[@type='Sag CUBE FLAIR 1.8mm (Avec zip512)']">
			<iso:assert test="xnat:frames = 112" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Frames</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>frames</nrgxsl:xmlpath>
			      <iso:value-of select="concat( 'Expected: 112 Found: ', ./xnat:frames)"/>
			   </nrgxsl:scan>
			</iso:assert>			
			<iso:assert test="xnat:parameters/xnat:imageType = 'ORIGINAL\\PRIMARY\\OTHER'" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Image type</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.imageType</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: ORIGINAL\\PRIMARY\\OTHER Found: ', ./xnat:parameters/xnat:imageType)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:coil = 'Head 24'" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Coil</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>coil</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: Head 24 Found: ', ./xnat:coil)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:fieldStrength = 3.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Field strength</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>fieldStrength</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 3.0 Found: ', ./xnat:fieldStrength)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:voxelRes//@x = 1.875" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Vox.Res.x</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.voxelRes.x</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 1.875 Found: ', ./xnat:parameters/xnat:voxelRes//@x)"/>
			   </nrgxsl:scan>
			</iso:assert>		
			<iso:assert test="xnat:parameters/xnat:voxelRes//@y = 1.875" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Vox.Res.y</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.voxelRes.y</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 1.875 Found: ', ./xnat:parameters/xnat:voxelRes//@y)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:voxelRes//@z = 1.8" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Vox.Res.z</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.voxelRes.z</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 1.8 Found: ', ./xnat:parameters/xnat:voxelRes//@z)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:fov//@x = 512" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>FOV x</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.fov.x</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 512 Found: ', ./xnat:parameters/xnat:fov/xnat//@x)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:fov//@y = 512" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>FOV y</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.fov.y</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 512 Found: ', ./xnat:parameters/xnat:fov/xnat//@y)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:tr = 9000.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TR</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.tr</nrgxsl:xmlpath>
			   <iso:value-of select="concat('Expected: 9000.0 Found: ', ./xnat:parameters/xnat:tr)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:te &gt; 130.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TE</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.te</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: between 130.0 and 145.0 Found: ', ./xnat:parameters/xnat:te)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:te &lt; 145.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TE</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.te</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: between 137.0 and 145.0 Found: ', ./xnat:parameters/xnat:te)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:ti &gt; 2360.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TI</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.ti</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: between 2360.0 and 2370.0 Found: ', ./xnat:parameters/xnat:ti)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:ti &lt; 2370.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TI</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.ti</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: between 2360.0 and 2370.0 Found: ', ./xnat:parameters/xnat:ti)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:flip = 90" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Flip</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.flip</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 90 Found: ', ./xnat:parameters/xnat:flip)"/>
			   </nrgxsl:scan>
			</iso:assert>
		</iso:rule>
</iso:pattern>

<iso:pattern id="Scan">
		<iso:rule context="/xnat:MRSession/xnat:scans/xnat:scan[@type='Sag CUBE FLAIR 1.8mm (Sans zip512)']">
			<iso:assert test="xnat:frames = 112" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Frames</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>frames</nrgxsl:xmlpath>
			      <iso:value-of select="concat( 'Expected: 112 Found: ', ./xnat:frames)"/>
			   </nrgxsl:scan>
			</iso:assert>			
			<iso:assert test="xnat:parameters/xnat:imageType = 'ORIGINAL\\PRIMARY\\OTHER'" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Image type</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.imageType</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: ORIGINAL\\PRIMARY\\OTHER Found: ', ./xnat:parameters/xnat:imageType)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:coil = 'Head 24'" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Coil</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>coil</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: Head 24 Found: ', ./xnat:coil)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:fieldStrength = 3.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Field strength</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>fieldStrength</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 3.0 Found: ', ./xnat:fieldStrength)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:voxelRes//@x = 1.875" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Vox.Res.x</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.voxelRes.x</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 1.875 Found: ', ./xnat:parameters/xnat:voxelRes//@x)"/>
			   </nrgxsl:scan>
			</iso:assert>		
			<iso:assert test="xnat:parameters/xnat:voxelRes//@y = 1.875" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Vox.Res.y</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.voxelRes.y</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 1.875 Found: ', ./xnat:parameters/xnat:voxelRes//@y)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:voxelRes//@z = 1.8" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Vox.Res.z</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.voxelRes.z</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 1.8 Found: ', ./xnat:parameters/xnat:voxelRes//@z)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:fov//@x = 512" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>FOV x</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.fov.x</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 512 Found: ', ./xnat:parameters/xnat:fov/xnat//@x)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:fov//@y = 512" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>FOV y</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.fov.y</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 512 Found: ', ./xnat:parameters/xnat:fov/xnat//@y)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:tr = 9000.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TR</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.tr</nrgxsl:xmlpath>
			   <iso:value-of select="concat('Expected: 9000.0 Found: ', ./xnat:parameters/xnat:tr)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:te &gt; 130.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TE</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.te</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: between 130.0 and 145.0 Found: ', ./xnat:parameters/xnat:te)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:te &lt; 145.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TE</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.te</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: between 137.0 and 145.0 Found: ', ./xnat:parameters/xnat:te)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:ti &gt; 2360.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TI</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.ti</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: between 2360.0 and 2370.0 Found: ', ./xnat:parameters/xnat:ti)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:ti &lt; 2370.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TI</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.ti</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: between 2360.0 and 2370.0 Found: ', ./xnat:parameters/xnat:ti)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:flip = 90" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Flip</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.flip</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 90 Found: ', ./xnat:parameters/xnat:flip)"/>
			   </nrgxsl:scan>
			</iso:assert>
		</iso:rule>
</iso:pattern>

<iso:pattern id="Scan">
		<iso:rule context="/xnat:MRSession/xnat:scans/xnat:scan[@type='Sag CUBE T2 1.8mm']">
			<iso:assert test="xnat:frames = 112" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Frames</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>frames</nrgxsl:xmlpath>
			      <iso:value-of select="concat( 'Expected: 112 Found: ', ./xnat:frames)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:imageType = 'ORIGINAL\\PRIMARY\\OTHER'" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Image type</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.imageType</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: ORIGINAL\\PRIMARY\\OTHER Found: ', ./xnat:parameters/xnat:imageType)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:coil = 'Head 24'" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Coil</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>coil</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: Head 24 Found: ', ./xnat:coil)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:fieldStrength = 3.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Field strength</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>fieldStrength</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 3.0 Found: ', ./xnat:fieldStrength)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:voxelRes//@x = 1.875" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Vox.Res.x</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.voxelRes.x</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 1.875 Found: ', ./xnat:parameters/xnat:voxelRes//@x)"/>
			   </nrgxsl:scan>
			</iso:assert>		
			<iso:assert test="xnat:parameters/xnat:voxelRes//@y = 1.875" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Vox.Res.y</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.voxelRes.y</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 1.875 Found: ', ./xnat:parameters/xnat:voxelRes//@y)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:voxelRes//@z = 1.8" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Vox.Res.z</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.voxelRes.z</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 1.8 Found: ', ./xnat:parameters/xnat:voxelRes//@z)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:fov//@x = 512" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>FOV x</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.fov.x</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 512 Found: ', ./xnat:parameters/xnat:fov/xnat//@x)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:fov//@y = 512" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>FOV y</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.fov.y</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 512 Found: ', ./xnat:parameters/xnat:fov/xnat//@y)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:tr = 2400.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TR</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.tr</nrgxsl:xmlpath>
			   <iso:value-of select="concat('Expected: 2400.0 Found: ', ./xnat:parameters/xnat:tr)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:te &gt; 80.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TE</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.te</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: between 80.0 and 95.0 Found: ', ./xnat:parameters/xnat:te)"/>
			   </nrgxsl:scan>
			</iso:assert>
			<iso:assert test="xnat:parameters/xnat:te &lt; 95.0" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>TE</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.te</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: between 80.0 and 95.0 Found: ', ./xnat:parameters/xnat:te)"/>
			   </nrgxsl:scan>
			</iso:assert>			
			<iso:assert test="xnat:parameters/xnat:flip = 90" >
			   <nrgxsl:scan>
			      <nrgxsl:scan-id><iso:value-of select="@ID"/></nrgxsl:scan-id>
			      <nrgxsl:cause-id>Flip</nrgxsl:cause-id>
			      <nrgxsl:xmlpath>parameters.flip</nrgxsl:xmlpath>
				<iso:value-of select="concat('Expected: 90 Found: ', ./xnat:parameters/xnat:flip)"/>
			   </nrgxsl:scan>
			</iso:assert>
		</iso:rule>
</iso:pattern>


</iso:schema>



