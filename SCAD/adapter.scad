/* [Build Params] */
//Inlet (Small end) outer diameter
IN_OD = 39.5; 
//Inlet (Small end) inner diameter
IN_ID = 34.5; 
//Diameter of collar around the inlet.  This can be zero if no collar is needed.
IN_COLLAR_DIA = 42.5; 
//Length of the collar around the inlet
IN_COLLAR_LEN = 5; 
//Distance from the opening of the inlet side to the collar
IN_COLLAR_OFFSET = 35; 
//Overall length of the inlet portion
IN_LEN = 35; 

//Length of the tapered portion between the inlet and outlet
TAPER_LEN = 35; 

//Outlet (Large end) outer diameter
OUT_OD = 65.25; 
//Outlet (Large end) inner diameter
OUT_ID = 58; 
//Diameter of collar around the outlet.  This can be zero if no collar is needed.
OUT_COLLAR_DIA = 67.75; 
//Length of the collar around the outlet
OUT_COLLAR_LEN = 3; 
//Distance from the opening of the outlet side to the collar
OUT_COLLAR_OFFSET = 5; 
//Overall length of the outlet portion
OUT_LEN = 35; 

//Vent hole count (0 for no vents)
VENT_COUNT = 0; //[0:50]
//Vent hole diameter (0 for no vents)
VENT_DIA = 0; 

/* [Hidden] */

$fn = 300;

module buildAdapterOuter()
{
    translate([0,0,OUT_LEN+TAPER_LEN])
        cylinder(IN_LEN,IN_OD/2,IN_OD/2);
        
    translate([0,0,OUT_LEN])
        cylinder(TAPER_LEN,OUT_OD/2,IN_OD/2);
    
    cylinder(OUT_LEN,OUT_OD/2,OUT_OD/2);
    
    translate([0,0,OUT_COLLAR_OFFSET])
        cylinder(OUT_COLLAR_LEN,OUT_COLLAR_DIA/2,OUT_COLLAR_DIA/2);

    translate([0,0,OUT_LEN+TAPER_LEN+IN_LEN-IN_COLLAR_LEN-IN_COLLAR_OFFSET])
        cylinder(IN_COLLAR_LEN,IN_COLLAR_DIA/2,IN_COLLAR_DIA/2);
    
}

module buildAdapterInner()
{

    translate([0,0,OUT_LEN+TAPER_LEN])
        cylinder(IN_LEN,IN_ID/2,IN_ID/2);
        
    translate([0,0,OUT_LEN])
        cylinder(TAPER_LEN,OUT_ID/2,IN_ID/2);
    
    cylinder(OUT_LEN,OUT_ID/2,OUT_ID/2);
    

}

module buildHoles(maxDia)
{
    maxRad = maxDia/2;
    ventRad = VENT_DIA/2;
    for(n = [1:1:VENT_COUNT])
    {
        translate([0,0,OUT_LEN+TAPER_LEN/2])
            rotate([0,90,360/VENT_COUNT*n])
                cylinder(maxRad,ventRad,ventRad);

    }
}

module build()
{
    difference()
    {
        buildAdapterOuter();
        buildAdapterInner();
        
        if(IN_OD > OUT_OD)
            buildHoles(IN_OD);
        else
            buildHoles(OUT_OD);

    }

}

build();
