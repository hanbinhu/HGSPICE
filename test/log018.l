********************************************************************************
*  **********************************************
*  *             TSMC SPICE MODEL               *
*  **********************************************
*
*    PROCESS :  0.18um LOGIC SALICIDE (1P6M, 1.8V/3.3V)                 
*    MODEL   :  BSIM3 ( V3.24 )                                          
*    DOC. NO.:  T-018-LO-SP-001                                                        
*    VERSION :  2.1
*    DATE    :  Sep. 12, 2004
*    HSPICE VERSION : H98.2 & H98.4 (or above)
*
********************************************************************************                 
******************************************************************************                   
*                                                                            *                   
*       IN THIS MODEL LIB CONTAINS :                                         *                 
*                                                                            *                 
*       1.LIB TT                                                             *                 
*             SS                                                             *                 
*             FF                                                             *                 
*             SF                                                             *                 
*             FS                                                             *       
*        ( 1.8V Normal devices with different geometric and corner models)   *       
*                                                                            *       
*       2.LIB TT_3V                                                          *       
*             SS_3V                                                          *       
*             FF_3V                                                          *       
*             SF_3V                                                          *       
*             FS_3V                                                          *       
*        ( 3.3V normal devices  with different geometric and corner models)  *                            *
*                                                                            *       
*                                                                            *       
*       3.LIB TT_NA                                                          *       
*             SS_NA                                                          *       
*             FF_NA                                                          *       
*             SF_NA                                                          *       
*             FS_NA                                                          *                                                       
*        ( 1.8V native NMOS with different geometric and corner models)      *                                                       
*                                                                            *                                                                                                                                                                   
*       4.LIB TT_3VNA                                                        *                                                                                                                                                                   
*             SS_3VNA                                                        *                                                                                                                                                                   
*             FF_3VNA                                                        *                                                                                                                                                                   
*             SF_3VNA                                                        *                                                                                                                                                                   
*             FS_3VNA                                                        *                                                                                                                                                                   
*        ( 3.3V native NMOS with different geometric and corner models)      *                                                                                                                                                                   
*                                                                            *                                                                                                                                                                   
*       5.LIB BIP                                                            *                                                                                                                                                                   
*        ( 1.8V P+/NW/PSUB 10x10, 5x5 and 2x2 vertical PNP bipolar )         *                                                                                                                                
*                                                                            *                                                                                                                                
*       6.LIB BIP3                                                           *
*        ( 3.3V P+/NW/PSUB 10x10, 5x5 and 2x2 vertical PNP bipolar )         *
*                                                                            *
*       7.LIB DIO                                                            *
*        ( 1.8V P+/NW , N+/PW & NW/PSUB diode )                              *                                                                                                            
*                                                                            *                                                                                                            
*       8.LIB DIO3                                                           *                                                                                                            
*        ( 3.3V P+/NW , N+/PW & NW/PSUB diode )                              *                                                                                                            
*                                                                            *                                                                                                            
*       9.LIB RES                                                            *                                                                                                            
*         (resist model)                                                     *                                                                                                                                                                                                                                                                                                         
*                                                                            *                                                                                                                                                                                                                                                                                                         
******************************************************************************                                                                                                                                                                                                                                                                                                         
******************************************************************************                                                                                                                                                                                                                                                                                                         
*                                                                            *                                                                                                                                                                                                                                                                                                         
* 1)To use these models directly by programming in this style:               *                                                                                                                                                                                             
*                                                                            *                                                                                                                                                                                             
*     .lib 'lib_path/lib_name' model_name                                    *                                                                                                                                                                                             
*                                                                            *                                                                                                                                                                                             
*                                                                            *                                                                                                                                                                                             
*    EX: .lib '/home/user/tsmc/LOGIC/log018.l' TT                            *                                                                                                                                                                                             
*        for typical 1.8V N,PMOS                                             *
*        .lib '/home/user/tsmc/LOGIC/log018.l' TT_3V                         *
*        for typical 3.3V N,PMOS                                             *
*  note:                                                                     *
*      corner_name                                                           *                                                                                                            
*       TT : typical model for 1.8V devices                                  *                                                                                                                                                                                             
*       SS : Slow NMOS Slow PMOS model for 1.8V devices                      *                                                                                                                                                                                             
*       FF : Fast NMOS Fast PMOS model for 1.8V devices                      *                                                                                                                                                                                                                                                                              
*       SF : Slow NMOS Fast PMOS model for 1.8V devices                      *                                                                                                                                                                                                                                                                                                         
*       FS : Fast NMOS Slow PMOS model for 1.8V devices                      *                                                                                                                                                                                                                                                                                                         
*                                                                            *                                                                                                                                                                                                                                                                                                         
*       TT_3V : typical model for 3.3V devices                               *                                                                                                                                                                                                                                                                                                                                                               
*       SS_3V : Slow NMOS Slow PMOS model for 3.3V devices                   *                                                                                                                                                                                                                                                                                                                                                                                          
*       FF_3V : Fast NMOS Fast PMOS model for 3.3V devices                   *                                                                                                                                                                                                                                                                                                                                                                                          
*       SF_3V : Slow NMOS Fast PMOS model for 3.3V devices                   *                                                                                                                                                                                                                                                                                                                                                                                                                                                
*       FS_3V : Fast NMOS Slow PMOS model for 3.3V devices                   *                                                                                                                                                                                                                                                                                                                                    
*                                                                            *                                                                                                                                                                                                                                                     
*       TT_NA : typical model for 1.8V native NMOS                           *                                                                                                                                                                                                                                                                                                                                                                 
*       SS_NA : Slow NMOS for 1.8V native NMOS                               *                                                                                                                                                                                                                                                                                                                                                                                              
*       FF_NA : Fast NMOS for 1.8V native NMOS                               *                                                                                                                                                                                                                                                                                                                                                                   
*       SF_NA : Slow NMOS for 1.8V native NMOS                               *                                                                                                                                                                                                                                                                                                                                                                   
*       FS_NA : Fast NMOS for 1.8V native NMOS                               *                                                                                                                                                                                                                                                                                                                                                                   
*                                                                            *                                                                                                                                                                                                                                                                                                                                                                  
*       TT_3VNA : typical model for 3.3V native NMOS                         *                                                                                                                                                                                                                                                                                                                                       
*       SS_3VNA : Slow NMOS for 3.3V native NMOS                             *                                                                                                                                                                                                                                                                                                                                       
*       FF_3VNA : Fast NMOS for 3.3V native NMOS                             *                                                                                                                                                                                                                                                                                                                                                                                             
*       SF_3VNA : Slow NMOS for 3.3V native NMOS                             *                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
*       FS_3VNA : Fast NMOS for 3.3V native NMOS                             *                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
*                                                                            *                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
* 2)HDIF depends on your layout poly spacer to contact center distance.      *                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
*   The value listed here is TSMC minimum-rule value. You can change it      *                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
*   according to your layout.                                                *                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
*                                                                            *                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
******************************************************************************                                                                                                                                                                                                                                                                                                                                                                                                                                                  
***************************************************************                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
*                                                             *                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
*                1.8V NORMAL DEVICES LIB                      *                                                                                                                                                                                                                                                                                                                                                     
*                                                             *                                                                                                                                                         
*************************************************************** 
******************************    LIBRARY OF TYPICAL CASE    ******************************
.LIB TT
.param
+toxn             = 4.08E-09     cjn              = 0.001000266  cjswn            = 2.040547E-10
+cjswgn           = 3.340547E-10 cgon             = 3.665E-10    dvthn            = 0           
+hdifn            = 2E-07        dvsatn		  = 0            dwvthn		  = 0
+rshn             = 6.8  	 				 dpvthn		  = 0
+toxp             = 4.08E-09     cjp              = 0.001121     cjswp            = 2.481E-10   
+cjswgp           = 4.221E-10    cgop             = 3.28E-10     dvthp            = 0           
+hdifp            = 2E-07        dxl              = 0            dxw              = 0           
+rshp             = 7.2      
.lib 'log018.l' MOS
.ENDL TT

******************************  LIBRARY OF SNSP CORNER CASE  ******************************
.LIB SS
.param
+toxn             = 4.213E-09    cjn              = 0.001050279  cjswn            = 2.142574E-10
+cjswgn           = 3.507574E-10 cgon             = 3.48175E-10  dvthn            = 0.067         
+hdifn            = 2E-07        dvsatn		  = -3500        dwvthn		  = 7.5E-10
+rshn             = 6.8 					 dpvthn		  = 7.5E-16
+toxp             = 4.213E-09    cjp              = 0.00117705   cjswp            = 2.60505E-10 
+cjswgp           = 4.43205E-10  cgop             = 3.116E-10    dvthp            = -0.067      
+hdifp            = 2E-07        dxl              = 1.33E-08     dxw              = -2.2E-08    
+rshp             = 7.2         
.lib 'log018.l' MOS
.ENDL SS

******************************  LIBRARY OF FNFP CORNER CASE  ******************************
.LIB FF
.param
+toxn             = 3.947E-09    cjn              = 0.0009502527 cjswn            = 1.93852E-10 
+cjswgn           = 3.17352E-10  cgon             = 3.84825E-10  dvthn            = -0.067        
+hdifn            = 2E-07        dvsatn		  = 3500         dwvthn		  = -7.5E-10
+rshn             = 6.8                                          dpvthn		  = -7.5E-16
+toxp             = 3.947E-09    cjp              = 0.00106495   cjswp            = 2.35695E-10 
+cjswgp           = 4.00995E-10  cgop             = 3.444E-10    dvthp            = 0.067       
+hdifp            = 2E-07        dxl              = -1.33E-08    dxw              = 2.2E-08     
+rshp             = 7.2         
.lib 'log018.l' MOS
.ENDL FF

******************************  LIBRARY OF SNFP CORNER CASE  ******************************
.LIB SF
.param
+toxn             = 4.08E-09     cjn              = 0.001050279  cjswn            = 2.142574E-10
+cjswgn           = 3.507574E-10 cgon             = 3.665E-10    dvthn            = 0.067         
+hdifn            = 2E-07        dvsatn		  = 0            dwvthn		  = 7.5E-10
+rshn             = 6.8                                          dpvthn		  = 7.5E-16
+toxp             = 4.08E-09     cjp              = 0.00106495   cjswp            = 2.35695E-10 
+cjswgp           = 4.00995E-10  cgop             = 3.28E-10     dvthp            = 0.067       
+hdifp            = 2E-07        dxl              = 0.0          dxw              = 0.0         
+rshp             = 7.2         
.lib 'log018.l' MOS
.ENDL SF

******************************  LIBRARY OF FNSP CORNER CASE  ******************************
.LIB FS
.param
+toxn             = 4.08E-09     cjn              = 0.0009502527 cjswn            = 1.93852E-10 
+cjswgn           = 3.17352E-10  cgon             = 3.665E-10    dvthn            = -0.067        
+hdifn            = 2E-07        dvsatn		  = 0            dwvthn		  = -7.5E-10
+rshn             = 6.8                                          dpvthn		  = -7.5E-16
+toxp             = 4.08E-09     cjp              = 0.00117705   cjswp            = 2.60505E-10 
+cjswgp           = 4.43205E-10  cgop             = 3.28E-10     dvthp            = -0.067      
+hdifp            = 2E-07        dxl              = 0.0          dxw              = 0.0         
+rshp             = 7.2        
.lib 'log018.l' MOS
.ENDL FS

*******************************************************************************************
***************************************************************
*                                                             *
*                3.3V NORMAL DEVICES LIB                      *
*                                                             *
***************************************************************
******************************    LIBRARY OF TYPICAL CASE    ******************************
.LIB TT_3V
.param
+toxn3          = 6.8E-009     cjn3           = 0.0008964788 cjswn3         = 2.50664E-10 
+cjswgn3        = 3.00664E-10  cgon3          = 3.18E-10     dvthn3         = 0           
+hdifn3         = 2E-07                  
+rshn3          = 6.8 
+toxp3          = 6.77E-09     cjp3           = 0.00103531   cjswp3         = 2.23115E-10 
+cjswgp3        = 2.345762E-10 cgop3          = 2.77E-10     dvthp3         = 0           
+hdifp3         = 2E-07        dxl3           = 0            dxw3           = 0           
+rshp3          = 7.2        
.lib 'log018.l' MOS_3V
.ENDL TT_3V

******************************  LIBRARY OF SNSP CORNER CASE  ******************************
.LIB SS_3V
.param
+toxn3          = 7.5E-009     cjn3           = 0.0009413027 cjswn3         = 2.631972E-10
+cjswgn3        = 3.156972E-10 cgon3          = 3.021E-10    dvthn3         = 0.1         
+hdifn3         = 2E-07           
+rshn3          = 6.8
+toxp3          = 7.47E-09     cjp3           = 0.001087076  cjswp3         = 2.342708E-10
+cjswgp3        = 2.46305E-10  cgop3          = 2.6315E-10   dvthp3         = -0.1        
+hdifp3         = 2E-07        dxl3           = 1.33E-08     dxw3           = -2.2E-08    
+rshp3          = 7.2         
.lib 'log018.l' MOS_3V
.ENDL SS_3V

******************************  LIBRARY OF FNFP CORNER CASE  ******************************
.LIB FF_3V
.param
+toxn3          = 6.1E-09      cjn3           = 0.0008516549 cjswn3         = 2.381308E-10
+cjswgn3        = 2.856308E-10 cgon3          = 3.339E-10   dvthn3         = -0.1        
+hdifn3         = 2E-07           
+rshn3          = 6.8
+toxp3          = 6.07E-09     cjp3           = 0.0009835445 cjswp3         = 2.119593E-10
+cjswgp3        = 2.228474E-10 cgop3          = 2.9085E-10  dvthp3         = 0.1         
+hdifp3         = 2E-07        dxl3           = -1.33E-08   dxw3           = 2.2E-08     
+rshp3          = 7.2         
.lib 'log018.l' MOS_3V
.ENDL FF_3V

******************************  LIBRARY OF SNFP CORNER CASE  ******************************
.LIB SF_3V
.param
+toxn3          = 6.8E-09      cjn3           = 0.0009413027 cjswn3         = 2.631972E-10
+cjswgn3        = 3.156972E-10 cgon3          = 3.18E-10     dvthn3         = 0.1         
+hdifn3         = 2E-07                 
+rshn3          = 6.8  
+toxp3          = 6.77E-09     cjp3           = 0.0009835445 cjswp3         = 2.119593E-10
+cjswgp3        = 2.228474E-10 cgop3          = 2.77E-10     dvthp3         = 0.1         
+hdifp3         = 2E-07        dxl3           = 0.0          dxw3           = 0.0         
+rshp3          = 7.2       
.lib 'log018.l' MOS_3V
.ENDL SF_3V

******************************  LIBRARY OF FNSP CORNER CASE  ******************************
.LIB FS_3V
.param
+toxn3          = 6.8E-09      cjn3           = 0.0008516549 cjswn3         = 2.381308E-10
+cjswgn3        = 2.856308E-10 cgon3          = 3.18E-10     dvthn3         = -0.1        
+hdifn3         = 2E-07                 
+rshn3          = 6.8
+toxp3          = 6.77E-09     cjp3           = 0.001087076  cjswp3         = 2.342708E-10
+cjswgp3        = 2.46305E-10  cgop3          = 2.77E-10     dvthp3         = -0.1        
+hdifp3         = 2E-07        dxl3           = 0.0          dxw3           = 0.0         
+rshp3          = 7.2         
.lib 'log018.l' MOS_3V
.ENDL FS_3V

*******************************************************************************************
***************************************************************
*                                                             *
*               1.8V NATIVE NMOS LIB                          *
*                                                             *
***************************************************************
***************** CORNER_LIB OF TYPICAL MODEL ***************
.LIB TT_NA
.param
+toxna   = 4.08E-09        cjna    = 0.0001337865    cjswna  = 1.553397E-10
+cjswgna = 3.173876E-10    cgona   = 5.553E-10
+dvthna  = 0               hdifna  = 2E-07
+dxlna   = 0               dxwna   = 0
.lib 'log018.l' MOSNA
.ENDL TT_NA
***************** CORNER_LIB OF SNSP MODEL ***************
.LIB SS_NA
.param
+toxna   = 4.213E-09       cjna    = 0.0001404758    cjswna  = 1.631067E-10
+cjswgna = 3.33257E-10     cgona   = 5.27535E-10
+dvthna  = 0.08            hdifna  = 2E-07
+dxlna   = 1.33E-08        dxwna   = -2.2E-08
.lib 'log018.l' MOSNA
.ENDL SS_NA
***************** CORNER_LIB OF FNFP MODEL ***************
.LIB FF_NA
.param
+toxna   = 3.947E-09       cjna    = 0.0001270972    cjswna  = 1.475727E-10
+cjswgna = 3.015182E-10    cgona   = 5.83065E-10
+dvthna  = -0.08           hdifna  = 2E-07
+dxlna   = -1.33E-08       dxwna   = 2.2E-08
.lib 'log018.l' MOSNA
.ENDL FF_NA
***************** CORNER_LIB OF SNFP MODEL ***************
.LIB SF_NA
.param
+toxna   = 4.08E-09        cjna    = 0.0001404758    cjswna  = 1.631067E-10
+cjswgna = 3.33257E-10     cgona   = 5.553E-10
+dvthna  = 0.08            hdifna  = 2E-07
+dxlna   = 0               dxwna   = 0
.lib 'log018.l' MOSNA
.ENDL SF_NA
***************** CORNER_LIB OF FNSP MODEL ***************
.LIB FS_NA
.param
+toxna   = 4.08E-09        cjna    = 0.0001270972    cjswna  = 1.475727E-10
+cjswgna = 3.015182E-10    cgona   = 5.553E-10
+dvthna  = -0.08           hdifna  = 2E-07
+dxlna   = 0               dxwna   = 0
.lib 'log018.l' MOSNA
.ENDL FS_NA
***************************************************************
*                                                             *
*               3.3V NATIVE NMOS LIB                          *
*                                                             *
***************************************************************
***************** CORNER_LIB OF TYPICAL MODEL ***************
.LIB TT_3VNA
.param
+toxna3 = 6.8E-09         cjna3  = 0.0001247448    cjswna3= 1.458794E-10
+cjswgna3 = 3.180842E-10    cgona3   = 4.942E-10
+dvthna3  = 0               hdifna3  = 2E-08
+dxlna3    = 0              dxwna3    = 0
.lib 'log018.l' MOSNA3
.ENDL TT_3VNA
***************** CORNER_LIB OF SNSP MODEL ***************
.LIB SS_3VNA
.param
+toxna3 = 7.5E-09         cjna3  = 0.000130982     cjswna3= 1.531734E-10
+cjswgna3 = 3.339884E-10    cgona3   = 4.6949E-10
+dvthna3  = 0.1             hdifna3  = 2E-08
+dxlna3    = 1.33E-08       dxwna3    = -2.2E-08
.lib 'log018.l' MOSNA3
.ENDL SS_3VNA
***************** CORNER_LIB OF FNFP MODEL ***************
.LIB FF_3VNA
.param
+toxna3 = 6.1E-09         cjna3  = 0.0001185076    cjswna3= 1.385854E-10
+cjswgna3 = 3.0218E-10      cgona3   = 5.1891E-10
+dvthna3  = -0.1            hdifna3  = 2E-08
+dxlna3    = -1.33E-08      dxwna3    = 2.2E-08
.lib 'log018.l' MOSNA3
.ENDL FF_3VNA
***************** CORNER_LIB OF SNFP MODEL ***************
.LIB SF_3VNA
.param
+toxna3 = 6.8E-09         cjna3  = 0.000130982     cjswna3= 1.531734E-10
+cjswgna3 = 3.339884E-10    cgona3   = 4.942E-10
+dvthna3  = 0.1             hdifna3  = 2E-08
+dxlna3    = 0              dxwna3    = 0
.lib 'log018.l' MOSNA3
.ENDL SF_3VNA
***************** CORNER_LIB OF FNSP MODEL ***************
.LIB FS_3VNA
.param
+toxna3 = 6.8E-09         cjna3  = 0.0001185076    cjswna3= 1.385854E-10
+cjswgna3 = 3.0218E-10      cgona3   = 4.942E-10
+dvthna3  = -0.1            hdifna3  = 2E-08
+dxlna3    = 0              dxwna3    = 0
.lib 'log018.l' MOSNA3
.ENDL FS_3VNA

.LIB MOS
***************************************************************
*                                                             *
*               1.8V  NMOS DEVICES MODEL                      *
*                                                             *
***************************************************************
*******************************************************************************************
*                                                                                         *
*                              1.8V CORE DEVICE MODELS                                    *
*                                                                                         *
*******************************************************************************************

.MODEL nch.1 NMOS	(	LMIN     = '1.000E-05-dxl'         LMAX     = 20.001e-006              
+WMIN     = '1.0000E-05-dxw'                                   WMAX     = 900.001e-6               
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn'              TOXM     = 'toxn'              XJ       = 1.6000000E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1                   LINT     = 1.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 3.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn'             RSH      = 'rshn'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.4365561+dvthn'   WVTH0     = '0+dwvthn'	       PVTH0    = '0+dpvthn'
+K1       = 0.5142301           K2       = 1.4797844E-02       
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = '9.0000010E04+dvsatn'        
+UA       = -6.1227400E-10      UB       = 2.3135539E-18       UC       = 1.0876087E-10       
+RDSW     = 1.7000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 4.2203390E-02       A0       = 0.3700794           
+KETA     = 9.2634850E-03       A1       = 0.00                A2       = 0.9900000           
+AGS      = 2.0000000E-02       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1405780          NFACTOR  = 1.0000000           CIT      = -1.0000001E-04      
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = 5.0000000E-05       ETAB     = -5.0000000E-05      DSUB     = 0.00                
+PCLM     = 0.8000001           PDIBLC1  = 1.0000000E-06       PDIBLC2  = 6.9999990E-04       
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 2.0000003E08        
+PSCBE2   = 1.0000000E-06       PVAG     = 0.00                DELTA    = 1.0000000E-02       
+ALPHA0   = 0.0                 ALPHA1   = 0.448150714         BETA0    = 11.59263            
+KT1      = -0.2240464          KT2      = -3.0266136E-02      AT       = 2.0000000E04        
+UTE      = -1.5799998          UA1      = 1.2240000E-09       UB1      = -1.1209314E-18      
+UC1      = 1.1643822E-11       KT1L     = 0.00                PRT      = 0                   
+CJ       = cjn                 PB       = 0.6882682           MJ       = 0.3595262
+CJSW     = cjswn               PBSW     = 0.6882682           MJSW     = 0.2003879
+CJSWG    = cjswgn              PBSWG    = 0.6882682           MJSWG    = 0.43879
+CGDO     = cgon                CGSO     = cgon                TCJ      = 0.001040287
+TCJSW    = 0.000645489         TCJSWG   = 0.000645489         TPB      = 0.001554306
+TPBSW    = 0.001554306         TPBSWG   = 0.001554306
+JS       = 3.50E-07            JSW      = 1.45E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+DLC      = 3E-9                LLC      = -0.039              NOIMOD  = 2
+NOIA     = 2.00E19		NOIB     = 1.2E04	       NOIC	= 2.5E-13
+EM       = 3.0E07		EF       = 0.874               )

.MODEL nch.2 NMOS	(	LMIN     = '1.200E-06-dxl'         LMAX     = '1.000E-05-dxl'         
+WMIN     = '1.0000E-05-dxw'                                   WMAX     = 900.001e-6               
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn'              TOXM     = 'toxn'              XJ       = 1.6000000E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1                   LINT     = 1.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 3.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn'             RSH      = 'rshn'              RD       = 0                   
+RS       = 0                                     
+VTH0     = '0.4304705+dvthn'   LVTH0    = 6.0612860E-08       WVTH0     = '0+dwvthn'
+PVTH0    = '0+dpvthn'
+K1       = 0.5127332           
+LK1      = 1.4908842E-08       K2       = 1.5913645E-02       LK2      = -1.1113380E-08      
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = '9.0658910E04+dvsatn'        
+LVSAT    = -6.5626380E-03      UA       = -5.6565540E-10      LUA      = -4.6432150E-16      
+UB       = 2.2395009E-18       LUB      = 7.3756760E-25       UC       = 1.0484686E-10       
+LUC      = 3.8983540E-17       RDSW     = 1.7000000E02        PRWB     = 0.00                
+PRWG     = 0.00                WR       = 1.0000000           U0       = 4.1872890E-02       
+LU0      = 3.2918090E-09       A0       = 0.4051807           LA0      = -3.4960930E-07      
+KETA     = 1.3601615E-02       LKETA    = -4.3207800E-08      A1       = 0.00                
+A2       = 0.9900000           AGS      = 2.0000000E-02       B0       = 0.00                
+B1       = 0.00                VOFF     = -0.1395267          LVOFF    = -1.0471327E-08      
+NFACTOR  = 1.0000000           CIT      = -1.2675909E-04      LCIT     = 2.6652050E-10       
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = 5.0000000E-05       ETAB     = -5.0000000E-05      DSUB     = 0.00                
+PCLM     = 0.7736172           LPCLM    = 2.6277317E-07       PDIBLC1  = 1.0000000E-06       
+PDIBLC2  = 3.9681830E-04       LPDIBLC2 = 3.0196909E-09       PDIBLCB  = 1.0000000E-02       
+DROUT    = 0.00                PSCBE1   = 1.7363640E08        LPSCBE1  = 2.6258182E+02        
+PSCBE2   = 1.0000000E-06       PVAG     = 0.00                DELTA    = 1.0000000E-02       
+ALPHA0   = 0.0                 ALPHA1   = 0.448150714         BETA0    = 11.59263            
+KT1      = -0.2240468          KT2      = -3.0265680E-02      LKT2     = -4.5534910E-12      
+AT       = 2.0000000E04        UTE      = -1.5799941          LUTE     = -5.7439520E-11      
+UA1      = 1.2240000E-09       UB1      = -1.1209769E-18      LUB1     = 4.5273160E-28       
+UC1      = 1.1635963E-11       LUC1     = 7.8277720E-20       KT1L     = 0.00                
+PRT      = 0                                   
+CJ       = cjn                 PB       = 0.6882682           MJ       = 0.3595262
+CJSW     = cjswn               PBSW     = 0.6882682           MJSW     = 0.2003879
+CJSWG    = cjswgn              PBSWG    = 0.6882682           MJSWG    = 0.43879
+CGDO     = cgon                CGSO     = cgon                TCJ      = 0.001040287
+TCJSW    = 0.000645489         TCJSWG   = 0.000645489         TPB      = 0.001554306
+TPBSW    = 0.001554306         TPBSWG   = 0.001554306
+JS       = 3.50E-07            JSW      = 1.45E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+DLC      = 3E-9                LLC      = -0.039              NOIMOD  = 2
+NOIA     = 2.00E19		NOIB     = 1.2E04	       NOIC	= 2.5E-13
+EM       = 3.0E07		EF       = 0.874               )

.MODEL nch.3 NMOS	(	LMIN     = '5.000E-07-dxl'         LMAX     = '1.200E-06-dxl'         
+WMIN     = '1.0000E-05-dxw'                                   WMAX     = 900.001e-6               
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn'              TOXM     = 'toxn'              XJ       = 1.6000000E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1                   LINT     = 1.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 3.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn'             RSH      = 'rshn'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.4793240+dvthn'   LVTH0    = 3.9427570E-09       WVTH0     = '0+dwvthn'
+PVTH0    = '0+dpvthn'
+K1       = 0.5318048           
+LK1      = -7.2142450E-09      K2       = 4.8649130E-03       LK2      = 1.7031508E-09       
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = '8.5658600E04+dvsatn'        
+LVSAT    = -7.6228570E-04      UA       = -1.0347512E-09      LUA      = 7.9829650E-17       
+UB       = 3.0100842E-18       LUB      = -1.5630905E-25      UC       = 1.4678947E-10       
+LUC      = -9.6698940E-18      RDSW     = 1.7000000E02        PRWB     = 0.00                
+PRWG     = 0.00                WR       = 1.0000000           U0       = 4.3813580E-02       
+LU0      = 1.0406078E-09       A0       = -0.2911571          LA0      = 4.5814260E-07       
+KETA     = -1.5927499E-02      LKETA    = -8.9540280E-09      A1       = 0.00                
+A2       = 0.9900000           AGS      = 4.6247390E-02       LAGS     = -3.0446980E-08      
+B0       = 0.00                B1       = 0.00                VOFF     = -0.1621186          
+LVOFF    = 1.5735257E-08       NFACTOR  = 1.0000000           CIT      = -1.5788565E-04      
+LCIT     = 3.0262734E-10       CDSC     = 0.00                CDSCB    = 0.00                
+CDSCD    = 0.00                ETA0     = 1.7142866E-05       LETA0    = 3.8114280E-11       
+ETAB     = -1.7142866E-05      LETAB    = -3.8114280E-11      DSUB     = 0.00                
+PCLM     = 0.8687172           LPCLM    = 1.5245718E-07       PDIBLC1  = 1.0000000E-06       
+PDIBLC2  = 1.6847572E-03       LPDIBLC2 = 1.5256819E-09       PDIBLCB  = 1.0000000E-02       
+DROUT    = 0.00                PSCBE1   = 4.0000010E08        PSCBE2   = 1.0000000E-06       
+PVAG     = 0.00                DELTA    = 1.0000000E-02       ALPHA0   = 0.0                 
+ALPHA1   = 0.448150714         BETA0    = 11.59263            KT1      = -0.2290285          
+LKT1     = 5.7826780E-09       KT2      = -3.1611916E-02      LKT2     = 1.5570837E-09       
+AT       = 2.0000000E04        UTE      = -1.3504703          LUTE     = -2.6630502E-07      
+UA1      = 1.2266247E-09       LUA1     = -3.0446746E-18      UB1      = -8.5744080E-20      
+LUB1     = -1.2004174E-24      UC1      = 6.7886830E-11       LUC1     = -6.5172730E-17      
+KT1L     = 0.00                PRT      = 0                     
+CJ       = cjn                 PB       = 0.6882682           MJ       = 0.3595262
+CJSW     = cjswn               PBSW     = 0.6882682           MJSW     = 0.2003879
+CJSWG    = cjswgn              PBSWG    = 0.6882682           MJSWG    = 0.43879
+CGDO     = cgon                CGSO     = cgon                TCJ      = 0.001040287
+TCJSW    = 0.000645489         TCJSWG   = 0.000645489         TPB      = 0.001554306
+TPBSW    = 0.001554306         TPBSWG   = 0.001554306
+JS       = 3.50E-07            JSW      = 1.45E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+DLC      = 3E-9                LLC      = -0.039              NOIMOD  = 2
+NOIA     = 2.00E19		NOIB     = 1.2E04	       NOIC	= 2.5E-13
+EM       = 3.0E07		EF       = 0.874               )

.MODEL nch.4 NMOS	(	LMIN     = 1.8e-007                 LMAX     = '5.000E-07-dxl'         
+WMIN     = '1.0000E-05-dxw'                                   WMAX     = 900.001e-6               
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn'              TOXM     = 'toxn'              XJ       = 1.6000000E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1                   LINT     = 1.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 3.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn'             RSH      = 'rshn'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.4752311+dvthn'   LVTH0    = 5.8255000E-09       WVTH0     = '0+dwvthn'
+PVTH0    = '0+dpvthn'
+K1       = 0.4096095           
+LK1      = 4.8995580E-08       K2       = 5.9309460E-02       LK2      = -2.3341336E-08      
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = '8.4438960E04+dvsatn'        
+LVSAT    = -2.0125005E-04      UA       = -8.5891920E-10      LUA      = -1.0530929E-18      
+UB       = 2.6581962E-18       LUB      = 5.5594780E-27       UC       = 1.1678118E-10       
+LUC      = 4.1339190E-18       RDSW     = 1.7000000E02        PRWB     = 0.00                
+PRWG     = 0.00                WR       = 1.0000000           U0       = 4.3354470E-02       
+LU0      = 1.2517989E-09       A0       = 0.5407774           LA0      = 7.5452710E-08       
+KETA     = -4.1823270E-02      LKETA    = 2.9580252E-09       A1       = 0.00                
+A2       = 0.9900000           AGS      = -1.9916179E-02      LAGS     = -1.1735286E-11      
+B0       = 0.00                B1       = 0.00                VOFF     = -0.1245498          
+LVOFF    = -1.5463618E-09      NFACTOR  = 1.0000000           CIT      = 2.7188900E-04       
+LCIT     = 1.0493098E-10       CDSC     = 0.00                CDSCB    = 0.00                
+CDSCD    = 0.00                ETA0     = -2.9375011E-04      LETA0    = 1.8112505E-10       
+ETAB     = 1.3875004E-03       LETAB    = -6.8425020E-10      DSUB     = 0.00                
+PCLM     = 1.1076791           LPCLM    = 4.2534670E-08       PDIBLC1  = 1.0000000E-06       
+PDIBLC2  = -5.9354060E-03      LPDIBLC2 = 5.0309570E-09       PDIBLCB  = 1.0000000E-02       
+DROUT    = 0.00                PSCBE1   = 4.0000000E08        PSCBE2   = 1.0000000E-06       
+PVAG     = 0.00                DELTA    = 1.0000000E-02       ALPHA0   = 0.0                 
+ALPHA1   = 0.448150714         BETA0    = 11.59263            KT1      = -0.2271500          
+LKT1     = 4.9185610E-09       KT2      = -2.9537767E-02      LKT2     = 6.0297430E-10       
+AT       = 2.0000000E04        UTE      = -2.0822306          LUTE     = 7.0304750E-08       
+UA1      = 1.2182583E-09       LUA1     = 8.0390990E-19       UB1      = -3.5266740E-18      
+LUB1     = 3.8241010E-25       UC1      = -1.3815420E-10      LUC1     = 2.9606131E-17       
+KT1L     = 0.00                PRT      = 0                       
+CJ       = cjn                 PB       = 0.6882682           MJ       = 0.3595262
+CJSW     = cjswn               PBSW     = 0.6882682           MJSW     = 0.2003879
+CJSWG    = cjswgn              PBSWG    = 0.6882682           MJSWG    = 0.43879
+CGDO     = cgon                CGSO     = cgon                TCJ      = 0.001040287
+TCJSW    = 0.000645489         TCJSWG   = 0.000645489         TPB      = 0.001554306
+TPBSW    = 0.001554306         TPBSWG   = 0.001554306
+JS       = 3.50E-07            JSW      = 1.45E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+DLC      = 3E-9                LLC      = -0.039              NOIMOD  = 2
+NOIA     = 2.00E19		NOIB     = 1.2E04	       NOIC	= 2.5E-13
+EM       = 3.0E07		EF       = 0.874               )

.MODEL nch.5 NMOS	(	LMIN     = '1.000E-05-dxl'         LMAX     = 20.001e-006              
+WMIN     = '1.2000E-06-dxw'                                   WMAX     = '1.0000E-05-dxw'         
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn'              TOXM     = 'toxn'              XJ       = 1.6000000E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1                   LINT     = 1.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 3.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn'             RSH      = 'rshn'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.4364873+dvthn'   WVTH0    = '6.8761140E-10+dwvthn' PVTH0    = '0+dpvthn'     
+K1       = 0.5102321           
+WK1      = 3.9956060E-08       K2       = 1.6091494E-02       WK2      = -1.2928737E-08      
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = '9.0000010E04+dvsatn'        
+UA       = -5.8859420E-10      WUA      = -2.3665659E-16      UB       = 2.3329335E-18       
+WUB      = -1.9367960E-25      UC       = 1.1057788E-10       WUC      = -1.8159270E-17      
+RDSW     = 1.7000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 4.3035900E-02       WU0      = -8.3200990E-09      
+A0       = 0.3702259           WA0      = -1.4643313E-09      KETA     = 1.0357677E-02       
+WKETA    = -1.0935369E-08      A1       = 0.00                A2       = 0.9900000           
+AGS      = 2.0000000E-02       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1406671          WVOFF    = 8.9072240E-10       NFACTOR  = 1.0000000           
+CIT      = -1.0000001E-04      CDSC     = 0.00                CDSCB    = 0.00                
+CDSCD    = 0.00                ETA0     = 5.0000000E-05       ETAB     = -5.0000000E-05      
+DSUB     = 0.00                PCLM     = 0.8000001           PDIBLC1  = 1.0000000E-06       
+PDIBLC2  = 6.9999990E-04       PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                
+PSCBE1   = 2.0000003E08        PSCBE2   = 1.0000000E-06       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.0                 ALPHA1   = 0.448150714         
+BETA0    = 11.59263            KT1      = -0.2232244          WKT1     = -8.2151660E-09      
+KT2      = -3.0428693E-02      WKT2     = 1.6245854E-09       AT       = 2.0000000E04        
+UTE      = -1.5803809          WUTE     = 3.8084330E-09       UA1      = 1.2240000E-09       
+UB1      = -1.0684574E-18      WUB1     = -5.2442470E-25      UC1      = 2.4230474E-11       
+WUC1     = -1.2579110E-16      PUC1     = -1.4905616E-28      KT1L     = 0.00                
+PRT      = 0                               
+CJ       = cjn                 PB       = 0.6882682           MJ       = 0.3595262
+CJSW     = cjswn               PBSW     = 0.6882682           MJSW     = 0.2003879
+CJSWG    = cjswgn              PBSWG    = 0.6882682           MJSWG    = 0.43879
+CGDO     = cgon                CGSO     = cgon                TCJ      = 0.001040287
+TCJSW    = 0.000645489         TCJSWG   = 0.000645489         TPB      = 0.001554306
+TPBSW    = 0.001554306         TPBSWG   = 0.001554306
+JS       = 3.50E-07            JSW      = 1.45E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+DLC      = 3E-9                LLC      = -0.039              NOIMOD  = 2
+NOIA     = 2.00E19		NOIB     = 1.2E04	       NOIC	= 2.5E-13
+EM       = 3.0E07		EF       = 0.874               )

.MODEL nch.6 NMOS	(	LMIN     = '1.200E-06-dxl'         LMAX     = '1.000E-05-dxl'         
+WMIN     = '1.2000E-06-dxw'                                   WMAX     = '1.0000E-05-dxw'         
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn'              TOXM     = 'toxn'              XJ       = 1.6000000E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1                   LINT     = 1.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 3.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn'             RSH      = 'rshn'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.4303924+dvthn'   LVTH0    = 6.0706090E-08       WVTH0    = '7.8115020E-10+dwvthn'       
+PVTH0    = '-9.3168750E-16+dpvthn'      K1       = 0.5085090           LK1      = 1.7161611E-08       
+WK1      = 4.2216520E-08       PK1      = -2.2514154E-14      K2       = 1.7310230E-02       
+LK2      = -1.2138612E-08      WK2      = -1.3957471E-08      PK2      = 1.0246181E-14       
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = '9.0678020E04+dvsatn'        
+LVSAT    = -6.7530250E-03      WVSAT    = -1.9104627E-04      PVSAT    = 1.9027204E-09       
+UA       = -5.3771250E-10      LUA      = -5.0678040E-16      WUA      = -2.7926046E-16      
+PUA      = 4.2433420E-22       UB       = 2.2537915E-18       LUB      = 7.8825360E-25       
+WUB      = -1.4282058E-25      PUB      = -5.0655580E-31      UC       = 1.0657759E-10       
+LUC      = 3.9842870E-17       WUC      = -1.7297008E-17      PUC      = -8.5881340E-24      
+RDSW     = 1.7000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 4.2730270E-02       LU0      = 3.0440912E-09       
+WU0      = -8.5686630E-09      PU0      = 2.4756895E-15       A0       = 0.4062600           
+LA0      = -3.5889950E-07      WA0      = -1.0786144E-08      PA0      = 9.2845460E-14       
+KETA     = 1.4894814E-02       LKETA    = -4.5189890E-08      WKETA    = -1.2924230E-08      
+PKETA    = 1.9809019E-14       A1       = 0.00                A2       = 0.9900000           
+AGS      = 2.0000000E-02       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1395822          LVOFF    = -1.0806052E-08      WVOFF    = 5.5485390E-10       
+PVOFF    = 3.3452410E-15       NFACTOR  = 1.0000000           CIT      = -1.2675911E-04      
+LCIT     = 2.6652053E-10       CDSC     = 0.00                CDSCB    = 0.00                
+CDSCD    = 0.00                ETA0     = 5.0000000E-05       ETAB     = -5.0000000E-05      
+DSUB     = 0.00                PCLM     = 0.7755287           LPCLM    = 2.4373449E-07       
+WPCLM    = -1.9103656E-08      PPCLM    = 1.9027247E-13       PDIBLC1  = 1.0000000E-06       
+PDIBLC2  = 3.9681810E-04       LPDIBLC2 = 3.0196912E-09       PDIBLCB  = 1.0000000E-02       
+DROUT    = 0.00                PSCBE1   = 1.7363640E08        LPSCBE1  = 2.6258185E02        
+PSCBE2   = 1.0000000E-06       PVAG     = 0.00                DELTA    = 1.0000000E-02       
+ALPHA0   = 0.0                 ALPHA1   = 0.448150714         BETA0    = 11.59263            
+KT1      = -0.2231775          LKT1     = -4.6746150E-10      WKT1     = -8.6881510E-09      
+PKT1     = 4.7109120E-15       KT2      = -3.0469729E-02      LKT2     = 4.0873210E-10       
+WKT2     = 2.0392819E-09       PKT2     = -4.1303770E-15      AT       = 2.0000000E04        
+UTE      = -1.5809486          LUTE     = 5.6541540E-09       WUTE     = 9.5395260E-09       
+PUTE     = -5.7081670E-14      UA1      = 1.2240000E-09       UB1      = -1.0643074E-18      
+LUB1     = -4.1333620E-26      WUB1     = -5.6635370E-25      PUB1     = 4.1761280E-31       
+UC1      = 2.4967807E-11       LUC1     = -7.3437550E-18      WUC1     = -1.3323848E-16      
+PUC1     = 7.4175780E-23       KT1L     = 0.00                PRT      = 0                   
+CJ       = cjn                 PB       = 0.6882682           MJ       = 0.3595262
+CJSW     = cjswn               PBSW     = 0.6882682           MJSW     = 0.2003879
+CJSWG    = cjswgn              PBSWG    = 0.6882682           MJSWG    = 0.43879
+CGDO     = cgon                CGSO     = cgon                TCJ      = 0.001040287
+TCJSW    = 0.000645489         TCJSWG   = 0.000645489         TPB      = 0.001554306
+TPBSW    = 0.001554306         TPBSWG   = 0.001554306
+JS       = 3.50E-07            JSW      = 1.45E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+DLC      = 3E-9                LLC      = -0.039              NOIMOD  = 2
+NOIA     = 2.00E19		NOIB     = 1.2E04	       NOIC	= 2.5E-13
+EM       = 3.0E07		EF       = 0.874               )

.MODEL nch.7 NMOS	(	LMIN     = '5.000E-07-dxl'         LMAX     = '1.200E-06-dxl'         
+WMIN     = '1.2000E-06-dxw'                                   WMAX     = '1.0000E-05-dxw'         
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn'              TOXM     = 'toxn'              XJ       = 1.6000000E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1                   LINT     = 1.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 3.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn'             RSH      = 'rshn'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.4799949+dvthn'   LVTH0    = 3.1671320E-09       WVTH0    = '-6.7044360E-09+dwvthn'      
+PVTH0    = '7.7515980E-15+dpvthn'      K1       = 0.5329412           LK1      = -1.1179709E-08      
+WK1      = -1.1356744E-08      PK1      = 3.9630840E-14       K2       = 3.8880950E-03       
+LK2      = 3.4310650E-09       WK2      = 9.7623110E-09       PK2      = -1.7268767E-14      
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = '8.5513590E04+dvsatn'        
+LVSAT    = -7.6228650E-04      WVSAT    = 1.4492224E-03       UA       = -1.0276002E-09      
+LUA      = 6.1489260E-17       WUA      = -7.1467150E-17      PUA      = 1.8329395E-22       
+UB       = 3.0435232E-18       LUB      = -1.2783527E-25      WUB      = -3.3419020E-25      
+PUB      = -2.8456703E-31      UC       = 1.4653272E-10       LUC      = -6.5050680E-18      
+WUC      = 2.5660584E-18       PUC      = -3.1629300E-23      RDSW     = 1.7000000E02        
+PRWB     = 0.00                PRWG     = 0.00                WR       = 1.0000000           
+U0       = 4.4526490E-02       LU0      = 9.6047130E-10       WU0      = -7.1248670E-09      
+PU0      = 8.0088650E-16       A0       = -0.3035701          LA0      = 4.6450350E-07       
+WA0      = 1.2405528E-07       PA0      = -6.3570630E-14      KETA     = -1.5493870E-02      
+LKETA    = -9.9390180E-09      WKETA    = -4.3336820E-09      PKETA    = 9.8439870E-15       
+A1       = 0.00                A2       = 0.9900000           AGS      = 4.9808680E-02       
+LAGS     = -3.4578080E-08      WAGS     = -3.5591570E-08      PAGS     = 4.1286230E-14       
+B0       = 0.00                B1       = 0.00                VOFF     = -0.1627226          
+LVOFF    = 1.6036822E-08       WVOFF    = 6.0367980E-09       PVOFF    = -3.0138140E-15      
+NFACTOR  = 1.0000000           CIT      = -1.5788565E-04      LCIT     = 3.0262734E-10       
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = 1.7142869E-05       LETA0    = 3.8114280E-11       ETAB     = -1.7142869E-05      
+LETAB    = -3.8114280E-11      DSUB     = 0.00                PCLM     = 0.8548421           
+LPCLM    = 1.5173094E-07       WPCLM    = 1.3866737E-07       PPCLM    = 7.2580320E-15       
+PDIBLC1  = 1.0000000E-06       PDIBLC2  = 1.7737894E-03       LPDIBLC2 = 1.4224044E-09       
+WPDIBLC2 = -8.8978950E-10      PPDIBLC2 = 1.0321563E-15       PDIBLCB  = 1.0000000E-02       
+DROUT    = 0.00                PSCBE1   = 4.0000010E08        PSCBE2   = 1.0000000E-06       
+PVAG     = 0.00                DELTA    = 1.0000000E-02       ALPHA0   = 0.0                 
+ALPHA1   = 0.448150714         BETA0    = 11.59263            KT1      = -0.2286601          
+LKT1     = 5.8923870E-09       WKT1     = -3.6818220E-09      PKT1     = -1.0964308E-15      
+KT2      = -3.1479932E-02      LKT2     = 1.5805686E-09       WKT2     = -1.3190541E-09      
+PKT2     = -2.3470743E-16      AT       = 2.0000000E04        UTE      = -1.3089141          
+LUTE     = -3.0990586E-07      WUTE     = -4.1531240E-07      PUTE     = 4.3574660E-13       
+UA1      = 1.2269809E-09       LUA1     = -3.4577810E-18      WUA1     = -3.5591300E-18      
+PUA1     = 4.1285910E-24       UB1      = 7.5674550E-20       LUB1     = -1.3637128E-24      
+WUB1     = -1.6132161E-24      PUB1     = 1.6319734E-30       UC1      = 8.5944920E-11       
+LUC1     = -7.8077210E-17      WUC1     = -1.8047248E-16      PUC1     = 1.2896722E-22       
+KT1L     = 0.00                PRT      = 0                        
+CJ       = cjn                 PB       = 0.6882682           MJ       = 0.3595262
+CJSW     = cjswn               PBSW     = 0.6882682           MJSW     = 0.2003879
+CJSWG    = cjswgn              PBSWG    = 0.6882682           MJSWG    = 0.43879
+CGDO     = cgon                CGSO     = cgon                TCJ      = 0.001040287
+TCJSW    = 0.000645489         TCJSWG   = 0.000645489         TPB      = 0.001554306
+TPBSW    = 0.001554306         TPBSWG   = 0.001554306
+JS       = 3.50E-07            JSW      = 1.45E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+DLC      = 3E-9                LLC      = -0.039              NOIMOD  = 2
+NOIA     = 2.00E19		NOIB     = 1.2E04	       NOIC	= 2.5E-13
+EM       = 3.0E07		EF       = 0.874               )

.MODEL nch.8 NMOS	(	LMIN     = 1.8e-007                 LMAX     = '5.000E-07-dxl'         
+WMIN     = '1.2000E-06-dxw'                                   WMAX     = '1.0000E-05-dxw'         
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn'              TOXM     = 'toxn'              XJ       = 1.6000000E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1                   LINT     = 1.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 3.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn'             RSH      = 'rshn'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.4751966+dvthn'   LVTH0    = 5.3743360E-09       WVTH0    = '3.4482360E-10+dwvthn'       
+PVTH0    = '4.5089380E-15+dpvthn'      K1       = 0.4007356           LK1      = 4.9634880E-08       
+WK1      = 8.8686750E-08       PK1      = -6.3891820E-15      K2       = 6.3188600E-02       
+LK2      = -2.3847164E-08      WK2      = -3.8768180E-08      PK2      = 5.0552590E-15       
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = '8.4294280E04+dvsatn'        
+LVSAT    = -2.0140363E-04      WVSAT    = 1.4459029E-03       PVSAT    = 1.5350395E-12       
+UA       = -9.0172960E-10      LUA      = 3.5887640E-18       WUA      = 4.2784730E-16       
+PUA      = -4.6390690E-23      UB       = 2.7527719E-18       LUB      = 5.9103390E-27       
+WUB      = -9.4519130E-25      PUB      = -3.5064990E-33      UC       = 1.2291169E-10       
+LUC      = 4.3605990E-18       WUC      = -6.1268420E-17      PUC      = -2.2654354E-24      
+RDSW     = 1.7000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 4.3840840E-02       LU0      = 1.2758692E-09       
+WU0      = -4.8608560E-09      PU0      = -2.4055863E-16      A0       = 0.5262308           
+LA0      = 8.2795080E-08       WA0      = 1.4537927E-07       PA0      = -7.3379640E-14      
+KETA     = -4.4118840E-02      LKETA    = 3.2284670E-09       WKETA    = 2.2941933E-08       
+PKETA    = -2.7027957E-15      A1       = 0.00                A2       = 0.9900000           
+AGS      = -2.7693154E-02      LAGS     = 1.0727657E-09       WAGS     = 7.7723050E-08       
+PAGS     = -1.0838496E-14      B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1247105          LVOFF    = -1.4487617E-09      WVOFF    = 1.6054964E-09       
+PVOFF    = -9.7541500E-16      NFACTOR  = 1.0000000           CIT      = 2.7498236E-04       
+LCIT     = 1.0350804E-10       WCIT     = -3.0914837E-11      PCIT     = 1.4220811E-17       
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = -2.9405078E-04      LETA0    = 1.8126334E-10       WETA0    = 3.0046217E-12       
+PETA0    = -1.3821218E-18      ETAB     = 1.3878694E-03       LETAB    = -6.8441990E-10      
+WETAB    = -3.6866540E-12      PETAB    = 1.6959704E-18       DSUB     = 0.00                
+PCLM     = 1.1010191           LPCLM    = 3.8489530E-08       WPCLM    = 6.6560680E-08       
+PPCLM    = 4.0427110E-14       PDIBLC1  = 1.0000000E-06       PDIBLC2  = -6.1190130E-03      
+LPDIBLC2 = 5.0530930E-09       WPDIBLC2 = 1.8349379E-09       PPDIBLC2 = -2.2121929E-16      
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 4.0000000E08        
+PSCBE2   = 1.0000000E-06       PVAG     = 0.00                DELTA    = 1.0000000E-02       
+ALPHA0   = 0.0                 ALPHA1   = 0.448150714         BETA0    = 11.59263            
+KT1      = -0.2269240          LKT1     = 5.0937890E-09       WKT1     = -2.2583577E-09      
+PKT1     = -1.7512235E-15      KT2      = -2.9338669E-02      LKT2     = 5.9558730E-10       
+WKT2     = -1.9897783E-09      PKT2     = 7.3825670E-17       AT       = 2.0000000E04        
+UTE      = -2.1610963          LUTE     = 8.2097990E-08       WUTE     = 7.8818350E-07       
+PUTE     = -1.1786150E-13      UA1      = 1.2174792E-09       LUA1     = 9.1298580E-19       
+WUA1     = 7.7858620E-18       PUA1     = -1.0901051E-24      UB1      = -3.8124500E-18      
+LUB1     = 4.2482470E-25       WUB1     = 2.8560549E-24       PUB1     = -4.2389140E-31      
+UC1      = -1.5406690E-10      LUC1     = 3.2328220E-17       WUC1     = 1.5903152E-16       
+PUC1     = -2.7204607E-23      KT1L     = 0.00                PRT      = 0                   
+CJ       = cjn                 PB       = 0.6882682           MJ       = 0.3595262
+CJSW     = cjswn               PBSW     = 0.6882682           MJSW     = 0.2003879
+CJSWG    = cjswgn              PBSWG    = 0.6882682           MJSWG    = 0.43879
+CGDO     = cgon                CGSO     = cgon                TCJ      = 0.001040287
+TCJSW    = 0.000645489         TCJSWG   = 0.000645489         TPB      = 0.001554306
+TPBSW    = 0.001554306         TPBSWG   = 0.001554306
+JS       = 3.50E-07            JSW      = 1.45E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+DLC      = 3E-9                LLC      = -0.039              NOIMOD  = 2
+NOIA     = 2.00E19		NOIB     = 1.2E04	       NOIC	= 2.5E-13
+EM       = 3.0E07		EF       = 0.874               )

.MODEL nch.9 NMOS	(	LMIN     = '1.000E-05-dxl'         LMAX     = 20.001e-006              
+WMIN     = '5.0000E-07-dxw'                                   WMAX     = '1.2000E-06-dxw'         
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn'              TOXM     = 'toxn'              XJ       = 1.6000000E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1                   LINT     = 1.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 3.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn'             RSH      = 'rshn'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.4406337+dvthn'   WVTH0    = '-4.2631090E-09+dwvthn'  PVTH0    = '0+dpvthn'    
+K1       = 0.5610723           
+WK1      = -2.0747230E-08      K2       = 1.1422717E-03       WK2      = 4.9206340E-09       
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = '9.0000010E04+dvsatn'        
+UA       = -9.0664090E-10      WUA      = 1.4309126E-16       UB       = 2.2997995E-18       
+WUB      = -1.5411778E-25      UC       = 1.0721270E-10       WUC      = -1.4141237E-17      
+RDSW     = 1.7000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 3.5199720E-02       WU0      = 1.0362965E-09       
+A0       = 0.3047864           WA0      = 7.6670510E-08       KETA     = 1.0152902E-03       
+WKETA    = 2.1944087E-10       A1       = 0.00                A2       = 0.9900000           
+AGS      = 2.0000000E-02       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1391954          WVOFF    = -8.6656900E-10      NFACTOR  = 1.0000000           
+CIT      = -1.0000004E-04      CDSC     = 0.00                CDSCB    = 0.00                
+CDSCD    = 0.00                ETA0     = 5.0000000E-05       ETAB     = -5.0000000E-05      
+DSUB     = 0.00                PCLM     = 0.8000001           PDIBLC1  = 1.0000000E-06       
+PDIBLC2  = 7.0000030E-04       PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                
+PSCBE1   = 2.0000003E08        PSCBE2   = 1.0000000E-06       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.0                 ALPHA1   = 0.448150714         
+BETA0    = 11.59263            KT1      = -0.2313184          WKT1     = 1.4490446E-09       
+KT2      = -2.9076951E-02      WKT2     = 1.0605161E-11       AT       = 2.0000000E04        
+UTE      = -1.6093186          WUTE     = 3.8360070E-08       UA1      = 1.2240000E-09       
+UB1      = -1.5012456E-18      WUB1     = -7.6755530E-27      UC1      = -6.8805160E-11      
+WUC1     = -1.4706552E-17      KT1L     = 0.00                PRT      = 0                   
+CJ       = cjn                 PB       = 0.6882682           MJ       = 0.3595262
+CJSW     = cjswn               PBSW     = 0.6882682           MJSW     = 0.2003879
+CJSWG    = cjswgn              PBSWG    = 0.6882682           MJSWG    = 0.43879
+CGDO     = cgon                CGSO     = cgon                TCJ      = 0.001040287
+TCJSW    = 0.000645489         TCJSWG   = 0.000645489         TPB      = 0.001554306
+TPBSW    = 0.001554306         TPBSWG   = 0.001554306
+JS       = 3.50E-07            JSW      = 1.45E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+DLC      = 3E-9                LLC      = -0.039              NOIMOD  = 2
+NOIA     = 2.00E19		NOIB     = 1.2E04	       NOIC	= 2.5E-13
+EM       = 3.0E07		EF       = 0.874               )

.MODEL nch.10 NMOS	(	LMIN     = '1.200E-06-dxl'         LMAX     = '1.000E-05-dxl'         
+WMIN     = '5.0000E-07-dxw'                                   WMAX     = '1.2000E-06-dxw'         
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn'              TOXM     = 'toxn'              XJ       = 1.6000000E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1                   LINT     = 1.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 3.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn'             RSH      = 'rshn'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.4340151+dvthn'   LVTH0    = 6.5920480E-08       WVTH0    = '-3.5444660E-09+dwvthn'      
+PVTH0    = '-7.1576720E-15+dpvthn'     K1       = 0.5600169           LK1      = 1.0512358E-08       
+WK1      = -1.9283881E-08      PK1      = -1.4574950E-14      K2       = 1.6854487E-03       
+LK2      = -5.4100510E-09      WK2      = 4.6985170E-09       PK2      = 2.2122807E-15       
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = '9.0622610E04+dvsatn'        
+LVSAT    = -6.2011020E-03      WVSAT    = -1.2487893E-04      PVSAT    = 1.2437262E-09       
+UA       = -8.8743970E-10      LUA      = -1.9124487E-16      WUA      = 1.3831368E-16       
+PUA      = 4.7584710E-23       UB       = 2.2584638E-18       LUB      = 4.1170380E-25       
+WUB      = -1.4839938E-25      PUB      = -5.6955330E-32      UC       = 1.0315766E-10       
+LUC      = 4.0388150E-17       WUC      = -1.3213606E-17      PUC      = -9.2391890E-24      
+RDSW     = 1.7000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 3.4827660E-02       LU0      = 3.7057520E-09       
+WU0      = 8.6705280E-10       PU0      = 1.6856667E-15       A0       = 0.3245910           
+LA0      = -1.9725388E-07      WA0      = 8.6726660E-08       PA0      = -1.0015934E-13      
+KETA     = 3.8292700E-03       LKETA    = -2.8027248E-08      WKETA    = 2.8803285E-10       
+PKETA    = -6.8318020E-16      A1       = 0.00                A2       = 0.9900000           
+AGS      = 2.0000000E-02       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1388337          LVOFF    = -3.6022220E-09      WVOFF    = -3.3884450E-10      
+PVOFF    = -5.2561320E-15      NFACTOR  = 1.0000000           CIT      = -1.2672294E-04      
+LCIT     = 2.6616018E-10       WCIT     = -4.3173710E-14      PCIT     = 4.3027530E-19       
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = 5.0000000E-05       ETAB     = -5.0000000E-05      DSUB     = 0.00                
+PCLM     = 0.7699873           LPCLM    = 2.9892766E-07       WPCLM    = -1.2487239E-08      
+PPCLM    = 1.2437180E-13       PDIBLC1  = 1.0000000E-06       PDIBLC2  = 3.9681850E-04       
+LPDIBLC2 = 3.0196912E-09       PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                
+PSCBE1   = 1.7363640E08        LPSCBE1  = 2.6258185E02        PSCBE2   = 1.0000000E-06       
+PVAG     = 0.00                DELTA    = 1.0000000E-02       ALPHA0   = 0.0                 
+ALPHA1   = 0.448150714         BETA0    = 11.59263            KT1      = -0.2310088          
+LKT1     = -3.0828107E-09      WKT1     = 6.6253410E-10       PKT1     = 7.8336390E-15       
+KT2      = -2.8688708E-02      LKT2     = -3.8668810E-09      WKT2     = -8.7256760E-11      
+PKT2     = 9.7470440E-16       AT       = 2.0000000E04        UTE      = -1.6080947          
+LUTE     = -1.2190513E-08      WUTE     = 4.1951950E-08       PUTE     = -3.5775140E-14      
+UA1      = 1.2240000E-09       UB1      = -1.5338095E-18      LUB1     = 3.2433570E-25       
+WUB1     = -5.7682950E-27      PUB1     = -1.8996434E-32      UC1      = -7.3164090E-11      
+LUC1     = 4.3414890E-17       WUC1     = -1.6068998E-17      PUC1     = 1.3569954E-23       
+KT1L     = 0.00                PRT      = 0                    
+CJ       = cjn                 PB       = 0.6882682           MJ       = 0.3595262
+CJSW     = cjswn               PBSW     = 0.6882682           MJSW     = 0.2003879
+CJSWG    = cjswgn              PBSWG    = 0.6882682           MJSWG    = 0.43879
+CGDO     = cgon                CGSO     = cgon                TCJ      = 0.001040287
+TCJSW    = 0.000645489         TCJSWG   = 0.000645489         TPB      = 0.001554306
+TPBSW    = 0.001554306         TPBSWG   = 0.001554306
+JS       = 3.50E-07            JSW      = 1.45E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+DLC      = 3E-9                LLC      = -0.039              NOIMOD  = 2
+NOIA     = 2.00E19		NOIB     = 1.2E04	       NOIC	= 2.5E-13
+EM       = 3.0E07		EF       = 0.874               )

.MODEL nch.11 NMOS	(	LMIN     = '5.000E-07-dxl'         LMAX     = '1.200E-06-dxl'         
+WMIN     = '5.0000E-07-dxw'                                   WMAX     = '1.2000E-06-dxw'         
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn'              TOXM     = 'toxn'              XJ       = 1.6000000E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1                   LINT     = 1.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 3.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn'             RSH      = 'rshn'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.4821278+dvthn'   LVTH0    = 1.0109751E-08       WVTH0    = '-9.2511780E-09+dwvthn'      
+PVTH0    = '-5.3788820E-16+dpvthn'      K1       = 0.5552615           LK1      = 1.6028618E-08       
+WK1      = -3.8007200E-08      PK1      = 7.1440980E-15       K2       = 3.5447990E-03       
+LK2      = -7.5668960E-09      WK2      = 1.0172209E-08       PK2      = -4.1372030E-15      
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = '8.5937130E04+dvsatn'        
+LVSAT    = -7.6594880E-04      WVSAT    = 9.4352240E-04       PVSAT    = 4.3808180E-12       
+UA       = -1.3333591E-09      LUA      = 3.2602160E-16       WUA      = 2.9360883E-16       
+PUA      = -1.3255767E-22      UB       = 2.9690860E-18       LUB      = -4.1261800E-25      
+WUB      = -2.4531215E-25      PUB      = 5.5463480E-32       UC       = 1.6160392E-10       
+LUC      = -2.7409531E-17      WUC      = -1.5428970E-17      PUC      = -6.6693660E-24      
+RDSW     = 1.7000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 3.5811860E-02       LU0      = 2.5640821E-09       
+WU0      = 3.2804070E-09       PU0      = -1.1138246E-15      A0       = -0.1914371          
+LA0      = 4.0133880E-07       WA0      = -9.8314440E-09      PA0      = 1.1848049E-14       
+KETA     = -1.7824383E-02      LKETA    = -2.9090079E-09      WKETA    = -1.5510503E-09      
+PKETA    = 1.4501565E-15       A1       = 0.00                A2       = 0.9900000           
+AGS      = 2.0000000E-02       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1515625          LVOFF    = 1.1163230E-08       WVOFF    = -7.2883150E-09      
+PVOFF    = 2.8052535E-15       NFACTOR  = 1.0000000           CIT      = -1.5834050E-04      
+LCIT     = 3.0283653E-10       WCIT     = 5.4312310E-13       PCIT     = -2.4980728E-19      
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = 1.7142847E-05       LETA0    = 3.8114300E-11       ETAB     = -1.7142847E-05      
+LETAB    = -3.8114300E-11      DSUB     = 0.00                PCLM     = 0.9444105           
+LPCLM    = 9.6596760E-08       WPCLM    = 3.1722750E-08       PPCLM    = 7.3088240E-14       
+PDIBLC1  = 1.0000000E-06       PDIBLC2  = 1.1219129E-03       LPDIBLC2 = 2.1785818E-09       
+WPDIBLC2 = -1.1144895E-10      PPDIBLC2 = 1.2928064E-16       PDIBLCB  = 1.0000000E-02       
+DROUT    = 0.00                PSCBE1   = 4.0000010E08        PSCBE2   = 1.0000000E-06       
+PVAG     = 0.00                DELTA    = 1.0000000E-02       ALPHA0   = 0.0                 
+ALPHA1   = 0.448150714         BETA0    = 11.59263            KT1      = -0.2417087          
+LKT1     = 9.3290630E-09       WKT1     = 1.1898274E-08       PKT1     = -5.1998210E-15      
+KT2      = -3.4342460E-02      LKT2     = 2.6914670E-09       WKT2     = 2.0987987E-09       
+PKT2     = -1.5611203E-15      AT       = 2.0000000E04        UTE      = -1.8126432          
+LUTE     = 2.2508574E-07       WUTE     = 1.8614003E-07       PUTE     = -2.0303331E-13      
+UA1      = 1.2240000E-09       UB1      = -1.6810433E-18      LUB1     = 4.9512690E-25       
+WUB1     = 4.8430470E-25       PUB1     = -5.8748110E-31      UC1      = -8.8066520E-11      
+LUC1     = 6.0701720E-17       WUC1     = 2.7297169E-17       PUC1     = -3.6734800E-23      
+KT1L     = 0.00                PRT      = 0                    
+CJ       = cjn                 PB       = 0.6882682           MJ       = 0.3595262
+CJSW     = cjswn               PBSW     = 0.6882682           MJSW     = 0.2003879
+CJSWG    = cjswgn              PBSWG    = 0.6882682           MJSWG    = 0.43879
+CGDO     = cgon                CGSO     = cgon                TCJ      = 0.001040287
+TCJSW    = 0.000645489         TCJSWG   = 0.000645489         TPB      = 0.001554306
+TPBSW    = 0.001554306         TPBSWG   = 0.001554306
+JS       = 3.50E-07            JSW      = 1.45E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+DLC      = 3E-9                LLC      = -0.039              NOIMOD  = 2
+NOIA     = 2.00E19		NOIB     = 1.2E04	       NOIC	= 2.5E-13
+EM       = 3.0E07		EF       = 0.874               )

.MODEL nch.12 NMOS	(	LMIN     = 1.8e-007                 LMAX     = '5.000E-07-dxl'         
+WMIN     = '5.0000E-07-dxw'                                   WMAX     = '1.2000E-06-dxw'         
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn'              TOXM     = 'toxn'              XJ       = 1.6000000E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1                   LINT     = 1.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 3.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn'             RSH      = 'rshn'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.4891579+dvthn'   LVTH0    = 6.8759450E-09       WVTH0    = '-1.6324883E-08+dwvthn'      
+PVTH0    = '2.7160160E-15+dpvthn'       K1       = 0.4899670           LK1      = 4.6064080E-08       
+WK1      = -1.7855582E-08      PK1      = -2.1256446E-15      K2       = 2.9298484E-02       
+LK2      = -1.9413593E-08      WK2      = 1.6966123E-09       PK2      = -2.3842633E-16      
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = '8.4736300E04+dvsatn'        
+LVSAT    = -2.1356932E-04      WVSAT    = 9.1813100E-04       PVSAT    = 1.6060880E-11       
+UA       = -5.2740020E-10      LUA      = -4.4719440E-17      WUA      = -1.9101984E-17      
+PUA      = 1.1289303E-23       UB       = 2.0039751E-18       LUB      = 3.1333025E-26       
+WUB      = -5.1128100E-26      PUB      = -3.3861180E-32      UC       = 7.9146470E-11       
+LUC      = 1.0520902E-17       WUC      = -9.0127290E-18      PUC      = -9.6208370E-24      
+RDSW     = 1.7000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 3.9805520E-02       LU0      = 7.2699450E-10       
+WU0      = -4.2684650E-11      PU0      = 4.1479770E-16       A0       = 0.5005398           
+LA0      = 8.3029360E-08       WA0      = 1.7605426E-07       PA0      = -7.3659360E-14      
+KETA     = -2.7587207E-02      LKETA    = 1.5818911E-09       WKETA    = 3.2031690E-09       
+PKETA    = -7.3678430E-16      A1       = 0.00                A2       = 0.9900000           
+AGS      = 4.0857530E-02       LAGS     = -9.5944640E-09      WAGS     = -4.1264700E-09      
+PAGS     = 1.8981756E-15       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1264125          LVOFF    = -4.0576950E-10      WVOFF    = 3.6377740E-09       
+PVOFF    = -2.2207474E-15      NFACTOR  = 1.0000000           CIT      = 2.2317801E-04       
+LCIT     = 1.2733804E-10       WCIT     = 3.0939650E-11       PCIT     = -1.4232223E-17      
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = -3.1223928E-04      LETA0    = 1.8963006E-10       WETA0    = 2.4721704E-11       
+PETA0    = -1.1371991E-17      ETAB     = 1.4101875E-03       LETAB    = -6.9468620E-10      
+WETAB    = -3.0334849E-11      PETAB    = 1.3954016E-17       DSUB     = 0.00                
+PCLM     = 0.9948969           LPCLM    = 7.3373010E-08       WPCLM    = 1.9327061E-07       
+PPCLM    = -1.2237712E-15      PDIBLC1  = 1.0000000E-06       PDIBLC2  = -4.0132200E-03      
+LPDIBLC2 = 4.5407440E-09       WPDIBLC2 = -6.7937070E-10      PPDIBLC2 = 3.9052370E-16       
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 4.0000000E08        
+PSCBE2   = 1.0000000E-06       PVAG     = 0.00                DELTA    = 1.0000000E-02       
+ALPHA0   = 0.0                 ALPHA1   = 0.448150714         BETA0    = 11.59263            
+KT1      = -0.2249505          LKT1     = 1.6202869E-09       WKT1     = -4.6146780E-09      
+PKT1     = 2.3961372E-15       KT2      = -2.8312566E-02      LKT2     = -8.2282570E-11      
+WKT2     = -3.2149460E-09      PKT2     = 8.8320210E-16       AT       = 2.0000000E04        
+UTE      = -1.2073984          LUTE     = -5.3326850E-08      WUTE     = -3.5053180E-07      
+PUTE     = 4.3835750E-14       UA1      = 1.2240000E-09       UB1      = -4.6211320E-19      
+LUB1     = -6.5580890E-26      WUB1     = -1.1442477E-24      PUB1     = 1.6165291E-31       
+UC1      = 6.0016960E-11       LUC1     = -7.4166880E-18      WUC1     = -9.6584590E-17      
+PUC1     = 2.0250814E-23       KT1L     = 0.00                PRT      = 0                   
+CJ       = cjn                 PB       = 0.6882682           MJ       = 0.3595262
+CJSW     = cjswn               PBSW     = 0.6882682           MJSW     = 0.2003879
+CJSWG    = cjswgn              PBSWG    = 0.6882682           MJSWG    = 0.43879
+CGDO     = cgon                CGSO     = cgon                TCJ      = 0.001040287
+TCJSW    = 0.000645489         TCJSWG   = 0.000645489         TPB      = 0.001554306
+TPBSW    = 0.001554306         TPBSWG   = 0.001554306
+JS       = 3.50E-07            JSW      = 1.45E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+DLC      = 3E-9                LLC      = -0.039              NOIMOD  = 2
+NOIA     = 2.00E19		NOIB     = 1.2E04	       NOIC	= 2.5E-13
+EM       = 3.0E07		EF       = 0.874               )

.MODEL nch.13 NMOS	(	LMIN     = '1.000E-05-dxl'         LMAX     = 20.001e-006              
+WMIN     = 2.2e-007                                           WMAX     = '5.0000E-07-dxw'         
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn'              TOXM     = 'toxn'              XJ       = 1.6000000E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1                   LINT     = 1.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 3.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn'             RSH      = 'rshn'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.4632908+dvthn'   WVTH0    = '-1.5455745E-08+dwvthn'      PVTH0    = '0+dpvthn'
+K1       = 0.5220979           
+WK1      = -1.4938487E-09      K2       = 1.6542569E-02       WK2      = -2.6871128E-09      
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = '8.9999990E04+dvsatn'        
+UA       = -5.8606080E-10      WUA      = -1.5275344E-17      UB       = 1.7266676E-18       
+WUB      = 1.2900942E-25       UC       = 7.2522020E-11       WUC      = 2.9959555E-18       
+RDSW     = 1.7000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 3.5337420E-02       WU0      = 9.6827260E-10       
+A0       = 0.3529820           WA0      = 5.2861860E-08       KETA     = 2.0642520E-03       
+WKETA    = -2.9874625E-10      A1       = 0.00                A2       = 0.9900000           
+AGS      = 2.0000000E-02       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1374522          WVOFF    = -1.7276782E-09      NFACTOR  = 1.0000000           
+CIT      = -9.9999980E-05      CDSC     = 0.00                CDSCB    = 0.00                
+CDSCD    = 0.00                ETA0     = 5.0000000E-05       ETAB     = -5.0000000E-05      
+DSUB     = 0.00                PCLM     = 0.7999999           PDIBLC1  = 1.0000000E-06       
+PDIBLC2  = 6.9999990E-04       PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                
+PSCBE1   = 2.0000003E08        PSCBE2   = 1.0000000E-06       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.0                 ALPHA1   = 0.448150714         
+BETA0    = 11.59263            KT1      = -0.2387670          WKT1     = 5.1286530E-09       
+KT2      = -3.6205880E-02      WKT2     = 3.5322950E-09       AT       = 2.0000000E04        
+UTE      = -1.5833832          WUTE     = 2.5547985E-08       UA1      = 1.2240000E-09       
+UB1      = -1.4270478E-18      WUB1     = -4.4329310E-26      UC1      = -6.3987300E-11      
+WUC1     = -1.7086574E-17      KT1L     = 0.00                PRT      = 0                   
+CJ       = cjn                 PB       = 0.6882682           MJ       = 0.3595262
+CJSW     = cjswn               PBSW     = 0.6882682           MJSW     = 0.2003879
+CJSWG    = cjswgn              PBSWG    = 0.6882682           MJSWG    = 0.43879
+CGDO     = cgon                CGSO     = cgon                TCJ      = 0.001040287
+TCJSW    = 0.000645489         TCJSWG   = 0.000645489         TPB      = 0.001554306
+TPBSW    = 0.001554306         TPBSWG   = 0.001554306
+JS       = 3.50E-07            JSW      = 1.45E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+DLC      = 3E-9                LLC      = -0.039              NOIMOD  = 2
+NOIA     = 2.00E19		NOIB     = 1.2E04	       NOIC	= 2.5E-13
+EM       = 3.0E07		EF       = 0.874               )

.MODEL nch.14 NMOS	(	LMIN     = '1.200E-06-dxl'         LMAX     = '1.000E-05-dxl'         
+WMIN     = 2.2e-007                                           WMAX     = '5.0000E-07-dxw'         
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn'              TOXM     = 'toxn'              XJ       = 1.6000000E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1                   LINT     = 1.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 3.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn'             RSH      = 'rshn'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.4576404+dvthn'   LVTH0    = 5.6278240E-08       WVTH0    = '-1.5215344E-08+dwvthn'      
+PVTH0    = '-2.3944025E-15+dpvthn'      K1       = 0.5284545           LK1      = -6.3312430E-08      
+WK1      = -3.6920920E-09      PK1      = 2.1894499E-14       K2       = 1.4454342E-02       
+LK2      = 2.0798732E-08       WK2      = -1.6093152E-09      PK2      = -1.0734859E-14      
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = '9.0528880E04+dvsatn'        
+LVSAT    = -5.2677570E-03      WVSAT    = -7.8579540E-05      PVSAT    = 7.8265330E-10       
+UA       = -5.7313250E-10      LUA      = -1.2876533E-16      WUA      = -1.6954039E-17      
+PUA      = 1.6719826E-23       UB       = 1.6479914E-18       LUB      = 7.8361630E-25       
+WUB      = 1.5317406E-25       PUB      = -2.4068014E-31      UC       = 6.5429030E-11       
+LUC      = 7.0646260E-17       WUC      = 5.4243400E-18       PUC      = -2.4186704E-23      
+RDSW     = 1.7000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 3.4344000E-02       LU0      = 9.8945550E-09       
+WU0      = 1.1059835E-09       PU0      = -1.3716021E-15      A0       = 0.3780467           
+LA0      = -2.4964379E-07      WA0      = 6.0319560E-08       PA0      = -7.4278730E-14      
+KETA     = 5.1141510E-03       LKETA    = -3.0377027E-08      WKETA    = -3.4669910E-10      
+PKETA    = 4.7761250E-16       A1       = 0.00                A2       = 0.9900000           
+AGS      = 2.0000000E-02       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1354716          LVOFF    = -1.9727372E-08      WVOFF    = -1.9997353E-09      
+PVOFF    = 2.7096929E-15       NFACTOR  = 1.0000000           CIT      = -1.2649217E-04      
+LCIT     = 2.6386249E-10       WCIT     = -1.5715551E-13      PCIT     = 1.5653096E-18       
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = 5.0000000E-05       ETAB     = -5.0000000E-05      DSUB     = 0.00                
+PCLM     = 0.7606163           LPCLM    = 3.9226100E-07       WPCLM    = -7.8579230E-09      
+PPCLM    = 7.8265150E-14       PDIBLC1  = 1.0000000E-06       PDIBLC2  = 3.9681830E-04       
+LPDIBLC2 = 3.0196909E-09       PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                
+PSCBE1   = 1.7363640E08        LPSCBE1  = 2.6258182E02        PSCBE2   = 1.0000000E-06       
+PVAG     = 0.00                DELTA    = 1.0000000E-02       ALPHA0   = 0.0                 
+ALPHA1   = 0.448150714         BETA0    = 11.59263            KT1      = -0.2407974          
+LKT1     = 2.0222748E-08       WKT1     = 5.4980620E-09       PKT1     = -3.6793080E-15      
+KT2      = -3.5896250E-02      LKT2     = -3.0839447E-09      WKT2     = 3.4732650E-09       
+PKT2     = 5.8793360E-16       AT       = 2.0000000E04        UTE      = -1.5785241          
+LUTE     = -4.8396960E-08      WUTE     = 2.7344081E-08       PUTE     = -1.7889165E-14      
+UA1      = 1.2240000E-09       UB1      = -1.4513121E-18      LUB1     = 2.4167225E-25       
+WUB1     = -4.6522010E-26      PUB1     = 2.1839324E-32       UC1      = -6.9917860E-11      
+LUC1     = 5.9068390E-17       WUC1     = -1.7672629E-17      PUC1     = 5.8371280E-24       
+KT1L     = 0.00                PRT      = 0                       
+CJ       = cjn                 PB       = 0.6882682           MJ       = 0.3595262
+CJSW     = cjswn               PBSW     = 0.6882682           MJSW     = 0.2003879
+CJSWG    = cjswgn              PBSWG    = 0.6882682           MJSWG    = 0.43879
+CGDO     = cgon                CGSO     = cgon                TCJ      = 0.001040287
+TCJSW    = 0.000645489         TCJSWG   = 0.000645489         TPB      = 0.001554306
+TPBSW    = 0.001554306         TPBSWG   = 0.001554306
+JS       = 3.50E-07            JSW      = 1.45E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+DLC      = 3E-9                LLC      = -0.039              NOIMOD  = 2
+NOIA     = 2.00E19		NOIB     = 1.2E04	       NOIC	= 2.5E-13
+EM       = 3.0E07		EF       = 0.874               )

.MODEL nch.15 NMOS	(	LMIN     = '5.000E-07-dxl'         LMAX     = '1.200E-06-dxl'         
+WMIN     = 2.2e-007                                           WMAX     = '5.0000E-07-dxw'         
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn'              TOXM     = 'toxn'              XJ       = 1.6000000E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1                   LINT     = 1.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 3.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn'             RSH      = 'rshn'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.4985188+dvthn'   LVTH0    = 8.8592590E-09       WVTH0    = '-1.7348324E-08+dwvthn'      
+PVTH0    = '7.9854650E-17+dpvthn'       K1       = 0.4140751           LK1      = 6.9367740E-08       
+WK1      = 3.1738890E-08       PK1      = -1.9205430E-14      K2       = 5.9564120E-02       
+LK2      = -3.1528607E-08      WK2      = -1.7501334E-08      PK2      = 7.6998830E-15       
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = '8.6668210E04+dvsatn'        
+LVSAT    = -7.8937880E-04      WVSAT    = 5.8236690E-04       PVSAT    = 1.5955267E-11       
+UA       = -7.3702990E-10      LUA      = 6.1355590E-17       WUA      = -9.7776210E-19      
+PUA      = -1.8126578E-24      UB       = 2.5777392E-18       LUB      = -2.9489129E-25      
+WUB      = -5.1986800E-26      PUB      = -2.6935000E-33      UC       = 1.4975288E-10       
+LUC      = -2.7169401E-17      WUC      = -9.5745500E-18      PUC      = -6.7879900E-24      
+RDSW     = 1.7000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 4.4377760E-02       LU0      = -1.7446106E-09      
+WU0      = -9.5114710E-10      PU0      = 1.0146696E-15       A0       = -7.7693450E-02      
+LA0      = 2.7901473E-07       WA0      = -6.6020820E-08      PA0      = 7.2276130E-14       
+KETA     = -1.5611105E-02      LKETA    = -6.3357300E-09      WKETA    = -2.6444102E-09      
+PKETA    = 3.1429577E-15       A1       = 0.00                A2       = 0.9900000           
+AGS      = 2.0000000E-02       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1694116          LVOFF    = 1.9643004E-08       WVOFF    = 1.5290980E-09       
+PVOFF    = -1.3837542E-15      NFACTOR  = 1.0000000           CIT      = -1.6124053E-04      
+LCIT     = 3.0417063E-10       WCIT     = 1.9757180E-12       PCIT     = -9.0883360E-19      
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = 1.7142866E-05       LETA0    = 3.8114280E-11       ETAB     = -1.7142866E-05      
+LETAB    = -3.8114280E-11      DSUB     = 0.00                PCLM     = 0.9728217           
+LPCLM    = 1.4610272E-07       WPCLM    = 1.7687656E-08       PPCLM    = 4.8632290E-14       
+PDIBLC1  = 1.0000000E-06       PDIBLC2  = 1.7171376E-03       LPDIBLC2 = 1.4881204E-09       
+WPDIBLC2 = -4.0549010E-10      PPDIBLC2 = 4.7036850E-16       PDIBLCB  = 1.0000000E-02       
+DROUT    = 0.00                PSCBE1   = 4.0000010E08        PSCBE2   = 1.0000000E-06       
+PVAG     = 0.00                DELTA    = 1.0000000E-02       ALPHA0   = 0.0                 
+ALPHA1   = 0.448150714         BETA0    = 11.59263            KT1      = -0.2426658          
+LKT1     = 2.2390124E-08       WKT1     = 1.2371058E-08       PKT1     = -1.1651986E-14      
+KT2      = -4.0695580E-02      LKT2     = 2.4832894E-09       WKT2     = 5.2372430E-09       
+PKT2     = -1.4582807E-15      AT       = 2.0000000E04        UTE      = -1.4758356          
+LUTE     = -1.6751561E-07      WUTE     = 1.9757099E-08       PUTE     = -9.0882650E-15      
+UA1      = 1.2240000E-09       UB1      = -4.8661160E-19      LUB1     = -8.7738050E-25      
+WUB1     = -1.0574451E-25      PUB1     = 9.0537450E-32       UC1      = 4.8991040E-11       
+LUC1     = -7.8865980E-17      WUC1     = -4.0409280E-17      PUC1     = 3.2211650E-23       
+KT1L     = 0.00                PRT      = 0                     
+CJ       = cjn                 PB       = 0.6882682           MJ       = 0.3595262
+CJSW     = cjswn               PBSW     = 0.6882682           MJSW     = 0.2003879
+CJSWG    = cjswgn              PBSWG    = 0.6882682           MJSWG    = 0.43879
+CGDO     = cgon                CGSO     = cgon                TCJ      = 0.001040287
+TCJSW    = 0.000645489         TCJSWG   = 0.000645489         TPB      = 0.001554306
+TPBSW    = 0.001554306         TPBSWG   = 0.001554306
+JS       = 3.50E-07            JSW      = 1.45E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+DLC      = 3E-9                LLC      = -0.039              NOIMOD  = 2
+NOIA     = 2.00E19		NOIB     = 1.2E04	       NOIC	= 2.5E-13
+EM       = 3.0E07		EF       = 0.874               )

.MODEL nch.16 NMOS	(	LMIN     = 1.8e-007                 LMAX     = '5.000E-07-dxl'         
+WMIN     = 2.2e-007                                           WMAX     = '5.0000E-07-dxw'         
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn'              TOXM     = 'toxn'              XJ       = 1.6000000E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1                   LINT     = 1.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 3.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn'             RSH      = 'rshn'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.4862920+dvthn'   LVTH0    = 1.4483583E-08       WVTH0    = '-1.4909164E-08+dwvthn'      
+PVTH0    = '-1.0421574E-15+dpvthn'      K1       = 0.4942783           LK1      = 3.2474290E-08       
+WK1      = -1.9985334E-08      PK1      = 4.5877080E-15       K2       = 2.3518253E-02       
+LK2      = -1.4947512E-08      WK2      = 4.5520450E-09       PK2      = -2.4446703E-15      
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = '8.5400580E04+dvsatn'        
+LVSAT    = -2.0626588E-04      WVSAT    = 5.8998060E-04       PVSAT    = 1.2452966E-11       
+UA       = -6.6143480E-10      LUA      = 2.6581833E-17       WUA      = 4.7111080E-17       
+PUA      = -2.3933522E-23      UB       = 2.1301375E-18       LUB      = -8.8994460E-26      
+WUB      = -1.1345223E-25      PUB      = 2.5580594E-32       UC       = 1.2526492E-10       
+LUC      = -1.5904941E-17      WUC      = -3.1795240E-17      PUC      = 3.4335290E-24       
+RDSW     = 1.7000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 3.7103500E-02       LU0      = 1.6015452E-09       
+WU0      = 1.2921135E-09       PU0      = -1.7230291E-17      A0       = 0.2707940           
+LA0      = 1.1871046E-07       WA0      = 2.8954867E-07       PA0      = -9.1285820E-14      
+KETA     = -3.0443965E-02      LKETA    = 4.8738500E-10       WKETA    = 4.6144070E-09       
+PKETA    = -1.9609824E-16      A1       = 0.00                A2       = 0.9900000           
+AGS      = 5.4803800E-02       LAGS     = -1.6009743E-08      WAGS     = -1.1015922E-08      
+PAGS     = 5.0673230E-15       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1182414          LVOFF    = -3.8952710E-09      WVOFF    = -3.9877300E-10      
+PVOFF    = -4.9693370E-16      NFACTOR  = 1.0000000           CIT      = 2.9138371E-04       
+LCIT     = 9.5963440E-11       WCIT     = -2.7539906E-12      PCIT     = 1.2668360E-18       
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = -2.6219533E-04      LETA0    = 1.6660984E-10       ETAB     = 1.3487812E-03       
+LETAB    = -6.6643920E-10      DSUB     = 0.00                PCLM     = 1.1355271           
+LPCLM    = 7.1258150E-08       WPCLM    = 1.2379924E-07       PPCLM    = -1.7902992E-16      
+PDIBLC1  = 1.0000000E-06       PDIBLC2  = -7.1402370E-03      LPDIBLC2 = 5.5625120E-09       
+WPDIBLC2 = 8.6537500E-10       PPDIBLC2 = -1.1422951E-16      PDIBLCB  = 1.0000000E-02       
+DROUT    = 0.00                PSCBE1   = 4.0000000E08        PSCBE2   = 1.0000000E-06       
+PVAG     = 0.00                DELTA    = 1.0000000E-02       ALPHA0   = 0.0                 
+ALPHA1   = 0.448150714         BETA0    = 11.59263            KT1      = -0.1929406          
+LKT1     = -4.8343960E-10      WKT1     = -2.0427562E-08      PKT1     = 3.4353780E-15       
+KT2      = -3.9379210E-02      LKT2     = 1.8777602E-09       WKT2     = 2.2519782E-09       
+PKT2     = -8.5058880E-17      AT       = 2.0000000E04        UTE      = -1.9466008          
+LUTE     = 4.9036400E-08       WUTE     = 1.4634106E-08       PUTE     = -6.7316880E-15      
+UA1      = 1.2240000E-09       UB1      = -3.1027764E-18      LUB1     = 3.2605530E-25       
+WUB1     = 1.6023990E-25       PUB1     = -3.1815360E-32      UC1      = -2.4653823E-10      
+LUC1     = 5.7077470E-17       WUC1     = 5.4853660E-17       PUC1     = -1.1609298E-23      
+KT1L     = 0.00                PRT      = 0                   
+CJ       = cjn                 PB       = 0.6882682           MJ       = 0.3595262
+CJSW     = cjswn               PBSW     = 0.6882682           MJSW     = 0.2003879
+CJSWG    = cjswgn              PBSWG    = 0.6882682           MJSWG    = 0.43879
+CGDO     = cgon                CGSO     = cgon                TCJ      = 0.001040287
+TCJSW    = 0.000645489         TCJSWG   = 0.000645489         TPB      = 0.001554306
+TPBSW    = 0.001554306         TPBSWG   = 0.001554306
+JS       = 3.50E-07            JSW      = 1.45E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+DLC      = 3E-9                LLC      = -0.039              NOIMOD  = 2
+NOIA     = 2.00E19		NOIB     = 1.2E04	       NOIC	= 2.5E-13
+EM       = 3.0E07		EF       = 0.874               )

*******************************************************************************************
*                                                                                         *
*                              1.8V CORE PMOS DEVICE MODELS                               *
*                                                                                         *
*******************************************************************************************

.MODEL pch.1 PMOS	(	LMIN     = '1.000E-05-dxl'         LMAX     = 20.001e-006              
+WMIN     = '1.0000E-05-dxw'                                   WMAX     = 900.001e-6               
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp'              TOXM     = 'toxp'              XJ       = 1.7000001E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 1.4999999E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 5.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp'             RSH      = 'rshp'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.4384811+dvthp'  K1       = 0.5375325           K2       = 3.5032560E-02       
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                        VSAT     = 1.4999998E05        
+UA       = 8.2329400E-10       UB       = 6.8543220E-19       UC       = -8.6554110E-11      
+RDSW     = 5.3000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 1.0865118E-02       A0       = 1.0461572           
+KETA     = 2.6632193E-02       A1       = 0.00                A2       = 0.4000000           
+AGS      = 2.0000000E-02       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1275921          NFACTOR  = 1.0000000           CIT      = -1.0000000E-04      
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = 5.0000000E-05       ETAB     = -5.0000000E-05      DSUB     = 0.00                
+PCLM     = 0.6000001           PDIBLC1  = 1.0000000E-06       PDIBLC2  = 1.0000003E-03       
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 1.9999997E08        
+PSCBE2   = 5.0000000E-07       PVAG     = 0.00                DELTA    = 1.0000000E-02       
+ALPHA0   = 0.00                ALPHA1   = 6.8730453846        BETA0    = 22.67827            
+KT1      = -0.2311294          KT2      = -2.4339920E-02      AT       = 1.0000000E04        
+UTE      = -0.8288856          UA1      = 1.2240000E-09       UB1      = -1.3928839E-18      
+UC1      = -4.5946700E-12      KT1L     = 0.00                PRT      = 0                   
+CJ       = cjp                 PB       = 0.895226
+MJ       = 0.4476              CJSW     = cjswp               PBSW     = 0.895226
+MJSW     = 0.3683619           CJSWG    = cjswgp              PBSWG    = 0.895226
+MJSWG    = 0.3683619           CGDO     = cgop                CGSO     = cgop
+TCJ      = 0.0009739001        TCJSW    = 0.0004130718        TCJSWG   = 0.0004130718   
+TPB      = 0.001572025	        TPBSW    = 0.001572025         TPBSWG   = 0.001572025    
+JS       = 2.50E-07            JSW      = 1.2E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   DLC      = 2E-9                LLC      = -0.039      
+NOIMOD  = 2
+NOIA     = 9.50E18		NOIB     = 1.0E05	       NOIC	= 1.4E-12
+EM       = 3.0E07		EF       = 1.064               )

.MODEL pch.2 PMOS	(	LMIN     = '1.200E-06-dxl'         LMAX     = '1.000E-05-dxl'         
+WMIN     = '1.0000E-05-dxw'                                   WMAX     = 900.001e-6               
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp'              TOXM     = 'toxp'              XJ       = 1.7000001E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 1.4999999E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 5.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp'             RSH      = 'rshp'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.4359872+dvthp'  LVTH0    = -2.4814051E-08      K1       = 0.5356447           
+LK1      = 1.8783622E-08       K2       = 3.5584030E-02       LK2      = -5.4871720E-09      
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = 1.5130680E05        
+LVSAT    = -1.3002842E-02      UA       = 8.6253130E-10       LUA      = -3.9041110E-16      
+UB       = 6.4019980E-19       LUB      = 4.5006260E-25       UC       = -8.8551450E-11      
+LUC      = 1.9873555E-17       RDSW     = 5.3000000E02        PRWB     = 0.00                
+PRWG     = 0.00                WR       = 1.0000000           U0       = 1.0995165E-02       
+LU0      = -1.2939688E-09      A0       = 1.0385712           LA0      = 7.5481240E-08       
+KETA     = 2.6837848E-02       LKETA    = -2.0462676E-09      A1       = 0.00                
+A2       = 0.4000000           AGS      = 2.0000000E-02       B0       = 0.00                
+B1       = 0.00                VOFF     = -0.1274002          LVOFF    = -1.9091309E-09      
+NFACTOR  = 1.0000000           CIT      = -1.0000000E-04      CDSC     = 0.00                
+CDSCB    = 0.00                CDSCD    = 0.00                ETA0     = 5.0000000E-05       
+ETAB     = -5.0000000E-05      DSUB     = 0.00                PCLM     = 0.5738637           
+LPCLM    = 2.6005682E-07       PDIBLC1  = 1.0000000E-06       PDIBLC2  = 4.7727310E-04       
+LPDIBLC2 = 5.2011360E-09       PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                
+PSCBE1   = 1.8039770E08        LPSCBE1  = 1.9504262E02        PSCBE2   = 5.0000000E-07       
+PVAG     = 0.00                DELTA    = 1.0000000E-02       ALPHA0   = 0.00                
+ALPHA1   = 6.8730453846        BETA0    = 22.67827            KT1      = -0.2295883          
+LKT1     = -1.5333228E-08      KT2      = -2.4031118E-02      LKT2     = -3.0725884E-09      
+AT       = 1.0000000E04        UTE      = -0.8385549          LUTE     = 9.6209710E-08       
+UA1      = 1.2240000E-09       UB1      = -1.3977103E-18      LUB1     = 4.8023250E-26       
+UC1      = -6.6949170E-12      LUC1     = 2.0897464E-17       KT1L     = 0.00                
+PRT      = 0                   CJ       = cjp                 PB       = 0.895226
+MJ       = 0.4476              CJSW     = cjswp               PBSW     = 0.895226
+MJSW     = 0.3683619           CJSWG    = cjswgp              PBSWG    = 0.895226
+MJSWG    = 0.3683619           CGDO     = cgop                CGSO     = cgop
+TCJ      = 0.0009739001        TCJSW    = 0.0004130718        TCJSWG   = 0.0004130718   
+TPB      = 0.001572025	        TPBSW    = 0.001572025         TPBSWG   = 0.001572025    
+JS       = 2.50E-07            JSW      = 1.2E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   DLC      = 2E-9                LLC      = -0.039  
+NOIMOD  = 2
+NOIA     = 9.50E18		NOIB     = 1.0E05	       NOIC	= 1.4E-12
+EM       = 3.0E07		EF       = 1.064               )

.MODEL pch.3 PMOS	(	LMIN     = '5.000E-07-dxl'         LMAX     = '1.200E-06-dxl'         
+WMIN     = '1.0000E-05-dxw'                                   WMAX     = 900.001e-6               
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp'              TOXM     = 'toxp'              XJ       = 1.7000001E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 1.4999999E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 5.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp'             RSH      = 'rshp'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.4517478+dvthp'  LVTH0    = -6.6894430E-09      K1       = 0.5405614           
+LK1      = 1.3129390E-08       K2       = 3.4901570E-02       LK2      = -4.7023350E-09      
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = 1.4642853E05        
+LVSAT    = -7.3928340E-03      UA       = 5.2669400E-10       LUA      = -4.1981260E-18      
+UB       = 1.1734415E-18       LUB      = -1.6316541E-25      UC       = -4.3321150E-11      
+LUC      = -3.2141290E-17      RDSW     = 5.3000000E02        PRWB     = 0.00                
+PRWG     = 0.00                WR       = 1.0000000           U0       = 1.0224584E-02       
+LU0      = -4.0780070E-10      A0       = 1.0045334           LA0      = 1.1462460E-07       
+KETA     = 3.2152590E-02       LKETA    = -8.1582250E-09      A1       = 0.00                
+A2       = 0.4000000           AGS      = 2.0000000E-02       B0       = 0.00                
+B1       = 0.00                VOFF     = -0.1282353          LVOFF    = -9.4878250E-10      
+NFACTOR  = 1.0000000           CIT      = -2.9480612E-04      LCIT     = 2.2402702E-10       
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = 1.7857143E-05       LETA0    = 3.6964280E-11       ETAB     = -1.7857143E-05      
+LETAB    = -3.6964280E-11      DSUB     = 0.00                PCLM     = 0.6714287           
+LPCLM    = 1.4785704E-07       PDIBLC1  = 1.0000000E-06       PDIBLC2  = 1.7857143E-03       
+LPDIBLC2 = 3.6964280E-09       PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                
+PSCBE1   = 3.4999990E08        PSCBE2   = 5.0000000E-07       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.00                ALPHA1   = 6.8730453846        
+BETA0    = 22.67827            KT1      = -0.2442909          LKT1     = 1.5747349E-09       
+KT2      = -2.7549893E-02      LKT2     = 9.7400280E-10       AT       = 1.0000000E04        
+UTE      = -0.7866690          LUTE     = 3.6540920E-08       UA1      = 1.2240000E-09       
+UB1      = -1.3827429E-18      LUB1     = 3.0810812E-26       UC1      = -1.4394627E-11      
+LUC1     = 2.9752128E-17       KT1L     = 0.00                PRT      = 0                   
+CJ       = cjp                 PB       = 0.895226
+MJ       = 0.4476              CJSW     = cjswp               PBSW     = 0.895226
+MJSW     = 0.3683619           CJSWG    = cjswgp              PBSWG    = 0.895226
+MJSWG    = 0.3683619           CGDO     = cgop                CGSO     = cgop
+TCJ      = 0.0009739001        TCJSW    = 0.0004130718        TCJSWG   = 0.0004130718   
+TPB      = 0.001572025	        TPBSW    = 0.001572025         TPBSWG   = 0.001572025    
+JS       = 2.50E-07            JSW      = 1.2E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   DLC      = 2E-9                LLC      = -0.039         
+NOIMOD  = 2
+NOIA     = 9.50E18		NOIB     = 1.0E05	       NOIC	= 1.4E-12
+EM       = 3.0E07		EF       = 1.064               )

.MODEL pch.4 PMOS	(	LMIN     = 1.8e-007                 LMAX     = '5.000E-07-dxl'         
+WMIN     = '1.0000E-05-dxw'                                   WMAX     = 900.001e-6               
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp'              TOXM     = 'toxp'              XJ       = 1.7000001E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 1.4999999E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 5.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp'             RSH      = 'rshp'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.4483009+dvthp'  LVTH0    = -8.2405520E-09      K1       = 0.5323869           
+LK1      = 1.6807924E-08       K2       = 3.7510190E-02       LK2      = -5.8762150E-09      
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = 1.3081252E05        
+LVSAT    = -3.6562650E-04      UA       = 8.7289950E-10       LUA      = -1.5999061E-16      
+UB       = 5.3978560E-19       LUB      = 1.2197973E-25       UC       = -1.5585878E-10      
+LUC      = 1.8500639E-17       RDSW     = 5.3000000E02        PRWB     = 0.00                
+PRWG     = 0.00                WR       = 1.0000000           U0       = 9.5382440E-03       
+LU0      = -9.8947820E-11      A0       = 1.2232625           LA0      = 1.6196543E-08       
+KETA     = 1.5869336E-02       LKETA    = -8.3075960E-10      A1       = 0.00                
+A2       = 0.4000000           AGS      = 2.0000000E-02       B0       = 0.00                
+B1       = 0.00                VOFF     = -0.1302643          LVOFF    = -3.5715920E-11      
+NFACTOR  = 1.0000000           CIT      = -4.0544020E-05      LCIT     = 1.0960906E-10       
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = -8.1250030E-05
+LCDSCD   = 3.6562510E-11                
+ETA0     = -4.6875020E-04      LETA0    = 2.5593752E-10       ETAB     = 1.0775371E-03       
+LETAB    = -5.2989170E-10      DSUB     = 0.00                PCLM     = 0.9102259           
+LPCLM    = 4.0398310E-08       PDIBLC1  = 1.0000000E-06       PDIBLC2  = 7.9687500E-03       
+LPDIBLC2 = 9.1406260E-10       PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                
+PSCBE1   = 3.5000000E08        PSCBE2   = 5.0000000E-07       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.00                ALPHA1   = 6.8730453846        
+BETA0    = 22.67827            KT1      = -0.2348693          LKT1     = -2.6650055E-09      
+KT2      = -2.4868647E-02      LKT2     = -2.3255770E-10      AT       = 1.0000000E04        
+UTE      = -0.7090256          LUTE     = 1.6013461E-09       UA1      = 1.2240000E-09       
+UB1      = -1.3783631E-18      LUB1     = 2.8839880E-26       UC1      = 6.6936230E-11       
+LUC1     = -6.8467590E-18      KT1L     = 0.00                PRT      = 0                   
+CJ       = cjp                 PB       = 0.895226
+MJ       = 0.4476              CJSW     = cjswp               PBSW     = 0.895226
+MJSW     = 0.3683619           CJSWG    = cjswgp              PBSWG    = 0.895226
+MJSWG    = 0.3683619           CGDO     = cgop                CGSO     = cgop
+TCJ      = 0.0009739001        TCJSW    = 0.0004130718        TCJSWG   = 0.0004130718   
+TPB      = 0.001572025	        TPBSW    = 0.001572025         TPBSWG   = 0.001572025    
+JS       = 2.50E-07            JSW      = 1.2E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   DLC      = 2E-9                LLC      = -0.039   
+NOIMOD  = 2
+NOIA     = 9.50E18		NOIB     = 1.0E05	       NOIC	= 1.4E-12
+EM       = 3.0E07		EF       = 1.064               )

.MODEL pch.5 PMOS	(	LMIN     = '1.000E-05-dxl'         LMAX     = 20.001e-006              
+WMIN     = '1.2000E-06-dxw'                                   WMAX     = '1.0000E-05-dxw'         
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp'              TOXM     = 'toxp'              XJ       = 1.7000001E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 1.4999999E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 5.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp'             RSH      = 'rshp'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.4397694+dvthp'  WVTH0    = 1.2870458E-08       K1       = 0.5362856           
+WK1      = 1.2456701E-08       K2       = 3.5627170E-02       WK2      = -5.9401430E-09      
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = 1.4999998E05        
+UA       = 8.0573260E-10       WUA      = 1.7543858E-16       UB       = 7.5080710E-19       
+WUB      = -6.5309530E-25      UC       = -7.8596050E-11      WUC      = -7.9500960E-17      
+RDSW     = 5.3000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 1.0990191E-02       WU0      = -1.2494747E-09      
+A0       = 1.0509492           WA0      = -4.7871910E-08      KETA     = 2.6001440E-02       
+WKETA    = 6.3012270E-09       A1       = 0.00                A2       = 0.4000000           
+AGS      = 2.0000000E-02       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1274889          WVOFF    = -1.0305298E-09      NFACTOR  = 1.0000000           
+CIT      = -1.0000000E-04      CDSC     = 0.00                CDSCB    = 0.00                
+CDSCD    = 0.00                ETA0     = 5.0000000E-05       ETAB     = -5.0000000E-05      
+DSUB     = 0.00                PCLM     = 0.6000001           PDIBLC1  = 1.0000000E-06       
+PDIBLC2  = 1.0000004E-03       PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                
+PSCBE1   = 1.9999997E08        PSCBE2   = 5.0000000E-07       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.00                ALPHA1   = 6.8730453846        
+BETA0    = 22.67827            KT1      = -0.2319530          WKT1     = 8.2282740E-09       
+KT2      = -2.4488758E-02      WKT2     = 1.4868883E-09       AT       = 1.0000000E04        
+UTE      = -0.8394966          WUTE     = 1.0600407E-07       UA1      = 1.2240000E-09       
+UB1      = -1.3998005E-18      WUB1     = 6.9097150E-26       UC1      = -7.6331580E-12      
+WUC1     = 3.0354498E-17       KT1L     = 0.00                PRT      = 0                   
+CJ       = cjp                 PB       = 0.895226
+MJ       = 0.4476              CJSW     = cjswp               PBSW     = 0.895226
+MJSW     = 0.3683619           CJSWG    = cjswgp              PBSWG    = 0.895226
+MJSWG    = 0.3683619           CGDO     = cgop                CGSO     = cgop
+TCJ      = 0.0009739001        TCJSW    = 0.0004130718        TCJSWG   = 0.0004130718   
+TPB      = 0.001572025	        TPBSW    = 0.001572025         TPBSWG   = 0.001572025    
+JS       = 2.50E-07            JSW      = 1.2E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   DLC      = 2E-9                LLC      = -0.039   
+NOIMOD  = 2
+NOIA     = 9.50E18		NOIB     = 1.0E05	       NOIC	= 1.4E-12
+EM       = 3.0E07		EF       = 1.064               )

.MODEL pch.6 PMOS	(	LMIN     = '1.200E-06-dxl'         LMAX     = '1.000E-05-dxl'         
+WMIN     = '1.2000E-06-dxw'                                   WMAX     = '1.0000E-05-dxw'         
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp'              TOXM     = 'toxp'              XJ       = 1.7000001E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 1.4999999E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 5.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp'             RSH      = 'rshp'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.4373293+dvthp'  LVTH0    = -2.4279869E-08      WVTH0    = 1.3406786E-08       
+PVTH0    = -5.3364720E-15      K1       = 0.5344580           LK1      = 1.8184398E-08       
+WK1      = 1.1855070E-08       PK1      = 5.9862430E-15       K2       = 3.6157890E-02       
+LK2      = -5.2806350E-09      WK2      = -5.7327760E-09      PK2      = -2.0633070E-15      
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = 1.5130680E05        
+LVSAT    = -1.3002842E-02      UA       = 8.4528650E-10       LUA      = -3.9356080E-16      
+WUA      = 1.7227619E-16       PUA      = 3.1465633E-23       UB       = 7.0840050E-19       
+LUB      = 4.2194590E-25       WUB      = -6.8132500E-25      PUB      = 2.8088595E-31       
+UC       = -8.0493860E-11      LUC      = 1.8883157E-17       WUC      = -8.0495330E-17      
+PUC      = 9.8941000E-24       RDSW     = 5.3000000E02        PRWB     = 0.00                
+PRWG     = 0.00                WR       = 1.0000000           U0       = 1.1121400E-02       
+LU0      = -1.3055237E-09      WU0      = -1.2610760E-09      PU0      = 1.1543239E-16       
+A0       = 1.0440365           LA0      = 6.8781320E-08       WA0      = -5.4598760E-08      
+PA0      = 6.6932220E-14       KETA     = 2.6128704E-02       LKETA    = -1.2662711E-09      
+WKETA    = 7.0843590E-09       PKETA    = -7.7921670E-15      A1       = 0.00                
+A2       = 0.4000000           AGS      = 2.0000000E-02       B0       = 0.00                
+B1       = 0.00                VOFF     = -0.1273414          LVOFF    = -1.4683624E-09      
+WVOFF    = -5.8798940E-10      PVOFF    = -4.4032780E-15      NFACTOR  = 1.0000000           
+CIT      = -1.0000000E-04      CDSC     = 0.00                CDSCB    = 0.00                
+CDSCD    = 0.00                ETA0     = 5.0000000E-05       ETAB     = -5.0000000E-05      
+DSUB     = 0.00                PCLM     = 0.5738637           LPCLM    = 2.6005682E-07       
+PDIBLC1  = 1.0000000E-06       PDIBLC2  = 4.7727280E-04       LPDIBLC2 = 5.2011370E-09       
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 1.8039770E08        
+LPSCBE1  = 1.9504262E02        PSCBE2   = 5.0000000E-07       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.00                ALPHA1   = 6.8730453846        
+BETA0    = 22.67827            KT1      = -0.2303147          LKT1     = -1.6300865E-08      
+WKT1     = 7.2567470E-09       PKT1     = 9.6666970E-15       KT2      = -2.4155809E-02      
+LKT2     = -3.3128360E-09      WKT2     = 1.2456750E-09       PKT2     = 2.4000725E-15       
+AT       = 1.0000000E04        UTE      = -0.8492097          LUTE     = 9.6644970E-08       
+WUTE     = 1.0644106E-07       PUTE     = -4.3481010E-15      UA1      = 1.2240000E-09       
+UB1      = -1.4052706E-18      LUB1     = 5.4427270E-26       WUB1     = 7.5526920E-26       
+PUB1     = -6.3976190E-32      UC1      = -9.4700360E-12      LUC1     = 1.8276951E-17       
+WUC1     = 2.7723443E-17       PUC1     = 2.6178952E-23       KT1L     = 0.00                
+PRT      = 0                   CJ       = cjp                 PB       = 0.895226
+MJ       = 0.4476              CJSW     = cjswp               PBSW     = 0.895226
+MJSW     = 0.3683619           CJSWG    = cjswgp              PBSWG    = 0.895226
+MJSWG    = 0.3683619           CGDO     = cgop                CGSO     = cgop
+TCJ      = 0.0009739001        TCJSW    = 0.0004130718        TCJSWG   = 0.0004130718   
+TPB      = 0.001572025	        TPBSW    = 0.001572025         TPBSWG   = 0.001572025    
+JS       = 2.50E-07            JSW      = 1.2E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   DLC      = 2E-9                LLC      = -0.039   
+NOIMOD  = 2
+NOIA     = 9.50E18		NOIB     = 1.0E05	       NOIC	= 1.4E-12
+EM       = 3.0E07		EF       = 1.064               )

.MODEL pch.7 PMOS	(	LMIN     = '5.000E-07-dxl'         LMAX     = '1.200E-06-dxl'         
+WMIN     = '1.2000E-06-dxw'                                   WMAX     = '1.0000E-05-dxw'         
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp'              TOXM     = 'toxp'              XJ       = 1.7000001E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 1.4999999E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 5.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp'             RSH      = 'rshp'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.4527619+dvthp'  LVTH0    = -6.5323870E-09      WVTH0    = 1.0130710E-08       
+PVTH0    = -1.5689828E-15      K1       = 0.5429910           LK1      = 8.3714530E-09       
+WK1      = -2.4271484E-08      PK1      = 4.7531780E-14       K2       = 3.4362420E-02       
+LK2      = -3.2158540E-09      WK2      = 5.3860310E-09       PK2      = -1.4849934E-14      
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = 1.4642853E05        
+LVSAT    = -7.3928330E-03      UA       = 4.7628350E-10       LUA      = 3.0792715E-17       
+WUA      = 5.0360140E-16       PUA      = -3.4955840E-22      UB       = 1.2463172E-18       
+LUB      = -1.9665828E-25      WUB      = -7.2802750E-25      PUB      = 3.3459380E-31       
+UC       = -3.1899420E-11      LUC      = -3.7000450E-17      WUC      = -1.1410304E-16      
+PUC      = 4.8542970E-23       RDSW     = 5.3000000E02        PRWB     = 0.00                
+PRWG     = 0.00                WR       = 1.0000000           U0       = 1.0286789E-02       
+LU0      = -3.4572260E-10      WU0      = -6.2143110E-10      PU0      = -6.2015920E-16      
+A0       = 0.9932752           LA0      = 1.2715688E-07       WA0      = 1.1247056E-07       
+PA0      = -1.2519753E-13      KETA     = 3.2315410E-02       LKETA    = -8.3809840E-09      
+WKETA    = -1.6265284E-09      PKETA    = 2.2253538E-15       A1       = 0.00                
+A2       = 0.4000000           AGS      = 2.0000000E-02       B0       = 0.00                
+B1       = 0.00                VOFF     = -0.1274479          LVOFF    = -1.3458795E-09      
+WVOFF    = -7.8664910E-09      PVOFF    = 3.9669990E-15       NFACTOR  = 1.0000000           
+CIT      = -2.9301620E-04      LCIT     = 2.2196864E-10       WCIT     = -1.7881040E-11      
+PCIT     = 2.0563189E-17       CDSC     = 0.00                CDSCB    = 0.00                
+CDSCD    = 0.00                ETA0     = 1.7857139E-05       LETA0    = 3.6964290E-11       
+ETAB     = -1.7857139E-05      LETAB    = -3.6964290E-11      DSUB     = 0.00                
+PCLM     = 0.6714287           LPCLM    = 1.4785702E-07       PDIBLC1  = 1.0000000E-06       
+PDIBLC2  = 1.7857144E-03       LPDIBLC2 = 3.6964280E-09       PDIBLCB  = 1.0000000E-02       
+DROUT    = 0.00                PSCBE1   = 3.4999990E08        PSCBE2   = 5.0000000E-07       
+PVAG     = 0.00                DELTA    = 1.0000000E-02       ALPHA0   = 0.00                
+ALPHA1   = 6.8730453846        BETA0    = 22.67827            KT1      = -0.2459144          
+LKT1     = 1.6387112E-09       WKT1     = 1.6218328E-08       PKT1     = -6.3912370E-16      
+KT2      = -2.7846618E-02      LKT2     = 9.3159460E-10       WKT2     = 2.9642964E-09       
+PKT2     = 4.2365790E-16       AT       = 1.0000000E04        UTE      = -0.7951261          
+LUTE     = 3.4448810E-08       WUTE     = 8.4486070E-08       PUTE     = 2.0900147E-14       
+UA1      = 1.2240000E-09       UB1      = -1.3967723E-18      LUB1     = 4.4654300E-26       
+WUB1     = 1.4015321E-25       PUB1     = -1.3829640E-31      UC1      = -2.3838735E-11      
+LUC1     = 3.4800940E-17       WUC1     = 9.4346610E-17       PUC1     = -5.0437680E-23      
+KT1L     = 0.00                PRT      = 0                   
+CJ       = cjp                 PB       = 0.895226
+MJ       = 0.4476              CJSW     = cjswp               PBSW     = 0.895226
+MJSW     = 0.3683619           CJSWG    = cjswgp              PBSWG    = 0.895226
+MJSWG    = 0.3683619           CGDO     = cgop                CGSO     = cgop
+TCJ      = 0.0009739001        TCJSW    = 0.0004130718        TCJSWG   = 0.0004130718   
+TPB      = 0.001572025	        TPBSW    = 0.001572025         TPBSWG   = 0.001572025    
+JS       = 2.50E-07            JSW      = 1.2E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   DLC      = 2E-9                LLC      = -0.039   
+NOIMOD  = 2
+NOIA     = 9.50E18		NOIB     = 1.0E05	       NOIC	= 1.4E-12
+EM       = 3.0E07		EF       = 1.064               )

.MODEL pch.8 PMOS	(	LMIN     = 1.8e-007                 LMAX     = '5.000E-07-dxl'         
+WMIN     = '1.2000E-06-dxw'                                   WMAX     = '1.0000E-05-dxw'         
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp'              TOXM     = 'toxp'              XJ       = 1.7000001E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 1.4999999E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 5.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp'             RSH      = 'rshp'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.4492160+dvthp'  LVTH0    = -8.1280260E-09      WVTH0    = 9.1421640E-09       
+PVTH0    = -1.1241356E-15      K1       = 0.5203763           LK1      = 1.8548040E-08       
+WK1      = 1.1998529E-07       PK1      = -1.7383759E-14      K2       = 4.1939260E-02       
+LK2      = -6.6254260E-09      WK2      = -4.4246340E-08      PK2      = 7.4846270E-15       
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = 1.3081252E05        
+LVSAT    = -3.6562710E-04      UA       = 9.3578630E-10       LUA      = -1.7598350E-16      
+WUA      = -6.2823680E-16      PUA      = 1.5976873E-22       UB       = 5.0912570E-19       
+LUB      = 1.3507784E-25       WUB      = 3.0629255E-25       PUB      = -1.3085017E-31      
+UC       = -1.5731644E-10      LUC      = 1.9437196E-17       WUC      = 1.4561782E-17       
+PUC      = -9.3561970E-24      RDSW     = 5.3000000E02        PRWB     = 0.00                
+PRWG     = 0.00                WR       = 1.0000000           U0       = 9.7957610E-03       
+LU0      = -1.2475933E-10      WU0      = -2.5725782E-09      PU0      = 2.5785697E-16       
+A0       = 1.2640158           LA0      = 5.3236360E-09       WA0      = -4.0712480E-07      
+PA0      = 1.0862038E-13       KETA     = 1.4996022E-02       LKETA    = -5.8725920E-10      
+WKETA    = 8.7244130E-09       PKETA    = -2.4325694E-15      A1       = 0.00                
+A2       = 0.4000000           AGS      = 1.9847063E-02       LAGS     = 6.8821010E-11       
+WAGS     = 1.5278273E-09       PAGS     = -6.8752220E-16      B0       = 0.00                
+B1       = 0.00                VOFF     = -0.1308021          LVOFF    = 1.6353495E-10       
+WVOFF    = 5.3724310E-09       PVOFF    = -1.9905158E-15      NFACTOR  = 1.0000000           
+CIT      = -6.0918400E-05      LCIT     = 1.1752459E-10       WCIT     = 2.0354016E-10       
+PCIT     = -7.9076310E-17      CDSC     = 0.00                CDSCB    = 0.00                
+CDSCD    = -8.2898130E-05      LCDSCD   = 3.7304140E-11       WCDSCD   = 1.6464351E-11       
+PCDSCD   = -7.4089540E-18            
+ETA0     = -4.6875020E-04      LETA0    = 2.5593752E-10       
+ETAB     = 1.1323938E-03       LETAB    = -5.5457720E-10      WETAB    = -5.4801690E-10      
+PETAB    = 2.4660761E-16       DSUB     = 0.00                PCLM     = 0.9107697           
+LPCLM    = 4.0153610E-08       WPCLM    = -5.4322380E-09      PPCLM    = 2.4445072E-15       
+PDIBLC1  = 1.0000000E-06       PDIBLC2  = 7.9878660E-03       LPDIBLC2 = 9.0546000E-10       
+WPDIBLC2 = -1.9097854E-10      PPDIBLC2 = 8.5940170E-17       PDIBLCB  = 1.0000000E-02       
+DROUT    = 0.00                PSCBE1   = 3.5000000E08        PSCBE2   = 5.0000000E-07       
+PVAG     = 0.00                DELTA    = 1.0000000E-02       ALPHA0   = 0.00                
+ALPHA1   = 6.8730453846        BETA0    = 22.67827            KT1      = -0.2367561          
+LKT1     = -2.4825255E-09      WKT1     = 1.8848993E-08       PKT1     = -1.8229216E-15      
+KT2      = -2.5532207E-02      LKT2     = -1.0989117E-10      WKT2     = 6.6289560E-09       
+PKT2     = -1.2254391E-15      AT       = 1.0000000E04        UTE      = -0.7199521          
+LUTE     = 6.2052350E-10       WUTE     = 1.0915658E-07       PUTE     = 9.7984170E-15       
+UA1      = 1.2240000E-09       UB1      = -1.3554493E-18      LUB1     = 2.6058948E-26       
+WUB1     = -2.2890885E-25      PUB1     = 2.7781507E-32       UC1      = 7.0516520E-11       
+LUC1     = -7.6589150E-18      WUC1     = -3.5766990E-17      PUC1     = 8.1134340E-24       
+KT1L     = 0.00                PRT      = 0                   
+CJ       = cjp                 PB       = 0.895226
+MJ       = 0.4476              CJSW     = cjswp               PBSW     = 0.895226
+MJSW     = 0.3683619           CJSWG    = cjswgp              PBSWG    = 0.895226
+MJSWG    = 0.3683619           CGDO     = cgop                CGSO     = cgop
+TCJ      = 0.0009739001        TCJSW    = 0.0004130718        TCJSWG   = 0.0004130718   
+TPB      = 0.001572025	        TPBSW    = 0.001572025         TPBSWG   = 0.001572025    
+JS       = 2.50E-07            JSW      = 1.2E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   DLC      = 2E-9                LLC      = -0.039   
+NOIMOD  = 2
+NOIA     = 9.50E18		NOIB     = 1.0E05	       NOIC	= 1.4E-12
+EM       = 3.0E07		EF       = 1.064               )

.MODEL pch.9 PMOS	(	LMIN     = '1.000E-05-dxl'         LMAX     = 20.001e-006              
+WMIN     = '5.0000E-07-dxw'                                   WMAX     = '1.2000E-06-dxw'         
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp'              TOXM     = 'toxp'              XJ       = 1.7000001E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 1.4999999E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 5.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp'             RSH      = 'rshp'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.4286388+dvthp'  WVTH0    = -3.7506110E-10      K1       = 0.5449055           
+WK1      = 2.1990281E-09       K2       = 3.3849380E-02       WK2      = -3.8245820E-09      
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = 1.4999998E05        
+UA       = 1.0698959E-09       WUA      = -1.3891575E-16      UB       = 3.0837888E-19       
+WUB      = -1.2660565E-25      UC       = -1.1659398E-10      WUC      = -3.4283420E-17      
+RDSW     = 5.3000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 1.0132165E-02       WU0      = -2.2842360E-10      
+A0       = 0.9810578           WA0      = 3.5298850E-08       KETA     = 3.2175460E-02       
+WKETA    = -1.0458587E-09      A1       = 0.00                A2       = 0.4000000           
+AGS      = 2.0000000E-02       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1280100          WVOFF    = -4.1052410E-10      NFACTOR  = 1.0000000           
+CIT      = -1.0000000E-04      CDSC     = 0.00                CDSCB    = 0.00                
+CDSCD    = 0.00                ETA0     = 5.0000000E-05       ETAB     = -5.0000000E-05      
+DSUB     = 0.00                PCLM     = 0.6000000           PDIBLC1  = 1.0000000E-06       
+PDIBLC2  = 9.9999980E-04       PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                
+PSCBE1   = 1.9999997E08        PSCBE2   = 5.0000000E-07       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.00                ALPHA1   = 6.8730453846        
+BETA0    = 22.67827            KT1      = -0.2307052          WKT1     = 6.7433300E-09       
+KT2      = -2.3348080E-02      WKT2     = 1.2948118E-10       AT       = 1.0000000E04        
+UTE      = -0.7480742          WUTE     = -2.7886795E-09      UA1      = 1.2240000E-09       
+UB1      = -1.3711068E-18      WUB1     = 3.4951630E-26       UC1      = 1.6263793E-12       
+WUC1     = 1.9335648E-17       KT1L     = 0.00                PRT      = 0                   
+CJ       = cjp                 PB       = 0.895226
+MJ       = 0.4476              CJSW     = cjswp               PBSW     = 0.895226
+MJSW     = 0.3683619           CJSWG    = cjswgp              PBSWG    = 0.895226
+MJSWG    = 0.3683619           CGDO     = cgop                CGSO     = cgop
+TCJ      = 0.0009739001        TCJSW    = 0.0004130718        TCJSWG   = 0.0004130718   
+TPB      = 0.001572025	        TPBSW    = 0.001572025         TPBSWG   = 0.001572025    
+JS       = 2.50E-07            JSW      = 1.2E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   DLC      = 2E-9                LLC      = -0.039   
+NOIMOD  = 2
+NOIA     = 9.50E18		NOIB     = 1.0E05	       NOIC	= 1.4E-12
+EM       = 3.0E07		EF       = 1.064               )

.MODEL pch.10 PMOS	(	LMIN     = '1.200E-06-dxl'         LMAX     = '1.000E-05-dxl'         
+WMIN     = '5.0000E-07-dxw'                                   WMAX     = '1.2000E-06-dxw'         
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp'              TOXM     = 'toxp'              XJ       = 1.7000001E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 1.4999999E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 5.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp'             RSH      = 'rshp'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.4245711+dvthp'  LVTH0    = -4.0472930E-08      WVTH0    = -1.7753915E-09      
+PVTH0    = 1.3933270E-14       K1       = 0.5429414           LK1      = 1.9542425E-08       
+WK1      = 1.7598129E-09       PK1      = 4.3701940E-15       K2       = 3.4365640E-02       
+LK2      = -5.1367190E-09      WK2      = -3.6000030E-09      PK2      = -2.2345663E-15      
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = 1.5130680E05        
+LVSAT    = -1.3002842E-02      UA       = 1.1283389E-09       LUA      = -5.8150770E-16      
+WUA      = -1.6455617E-16      PUA      = 2.5512236E-22       UB       = 1.9594849E-19       
+LUB      = 1.1186816E-24       WUB      = -7.1507210E-26      PUB      = -5.4822940E-31      
+UC       = -1.2405904E-10      LUC      = 7.4277340E-17       WUC      = -2.8652769E-17      
+PUC      = -5.6024980E-23      RDSW     = 5.3000000E02        PRWB     = 0.00                
+PRWG     = 0.00                WR       = 1.0000000           U0       = 1.0228163E-02       
+LU0      = -9.5517820E-10      WU0      = -1.9812424E-10      PU0      = -3.0147877E-16      
+A0       = 0.9688198           LA0      = 1.2176828E-07       WA0      = 3.4909120E-08       
+PA0      = 3.8777300E-15       KETA     = 3.2820440E-02       LKETA    = -6.4175870E-09      
+WKETA    = -8.7881330E-10      PKETA    = -1.6621007E-15      A1       = 0.00                
+A2       = 0.4000000           AGS      = 2.0000000E-02       B0       = 0.00                
+B1       = 0.00                VOFF     = -0.1269095          LVOFF    = -1.0948965E-08      
+WVOFF    = -1.1018445E-09      PVOFF    = 6.8786400E-15       NFACTOR  = 1.0000000           
+CIT      = -1.0000000E-04      CDSC     = 0.00                CDSCB    = 0.00                
+CDSCD    = 0.00                ETA0     = 5.0000000E-05       ETAB     = -5.0000000E-05      
+DSUB     = 0.00                PCLM     = 0.5738636           LPCLM    = 2.6005682E-07       
+PDIBLC1  = 1.0000000E-06       PDIBLC2  = 4.7727220E-04       LPDIBLC2 = 5.2011370E-09       
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 1.8039768E08        
+LPSCBE1  = 1.9504263E02        PSCBE2   = 5.0000000E-07       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.00                ALPHA1   = 6.8730453846        
+BETA0    = 22.67827            KT1      = -0.2296747          LKT1     = -1.0252924E-08      
+WKT1     = 6.4951250E-09       PKT1     = 2.4696450E-15       KT2      = -2.3308404E-02      
+LKT2     = -3.9477850E-10      WKT2     = 2.3726165E-10       PKT2     = -1.0724159E-15      
+AT       = 1.0000000E04        UTE      = -0.7541180          LUTE     = 6.0136590E-08       
+WUTE     = -6.7180150E-09      PUTE     = 3.9096880E-14       UA1      = 1.2240000E-09       
+UB1      = -1.3784619E-18      LUB1     = 7.3183410E-26       WUB1     = 4.3624580E-26       
+PUB1     = -8.6295970E-32      UC1      = -1.1517035E-12      LUC1     = 2.7641896E-17       
+WUC1     = 1.7824627E-17       PUC1     = 1.5034668E-23       KT1L     = 0.00                
+PRT      = 0                   CJ       = cjp                 PB       = 0.895226
+MJ       = 0.4476              CJSW     = cjswp               PBSW     = 0.895226
+MJSW     = 0.3683619           CJSWG    = cjswgp              PBSWG    = 0.895226
+MJSWG    = 0.3683619           CGDO     = cgop                CGSO     = cgop
+TCJ      = 0.0009739001        TCJSW    = 0.0004130718        TCJSWG   = 0.0004130718   
+TPB      = 0.001572025	        TPBSW    = 0.001572025         TPBSWG   = 0.001572025    
+JS       = 2.50E-07            JSW      = 1.2E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   DLC      = 2E-9                LLC      = -0.039   
+NOIMOD  = 2
+NOIA     = 9.50E18		NOIB     = 1.0E05	       NOIC	= 1.4E-12
+EM       = 3.0E07		EF       = 1.064               )

.MODEL pch.11 PMOS	(	LMIN     = '5.000E-07-dxl'         LMAX     = '1.200E-06-dxl'         
+WMIN     = '5.0000E-07-dxw'                                   WMAX     = '1.2000E-06-dxw'         
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp'              TOXM     = 'toxp'              XJ       = 1.7000001E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 1.4999999E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 5.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp'             RSH      = 'rshp'              RD       = 0                   
+RS       = 0                                     
+VTH0     = '-0.4566670+dvthp'  LVTH0    = -3.5627020E-09      WVTH0    = 1.4777807E-08       
+PVTH0    = -5.1029080E-15      K1       = 0.4715038           LK1      = 1.0169572E-07       
+WK1      = 6.0798340E-08       PK1      = -6.3524100E-14      K2       = 5.9786750E-02       
+LK2      = -3.4371000E-08      WK2      = -2.4868919E-08      PK2      = 2.2224691E-14       
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = 1.4642856E05        
+LVSAT    = -7.3928550E-03      UA       = 1.0361150E-09       LUA      = -4.7545010E-16      
+WUA      = -1.6259810E-16      PUA      = 2.5287059E-22       UB       = 1.0523674E-18       
+LUB      = 1.3379980E-25       WUB      = -4.9722730E-25      PUB      = -5.8651310E-32      
+UC       = -7.2051170E-11      LUC      = 1.4468274E-17       WUC      = -6.6322470E-17      
+PUC      = -1.2704817E-23      RDSW     = 5.3000000E02        PRWB     = 0.00                
+PRWG     = 0.00                WR       = 1.0000000           U0       = 1.0727104E-02       
+LU0      = -1.5289595E-09      WU0      = -1.1454039E-09      PU0      = 7.8789280E-16       
+A0       = 1.1936638           LA0      = -1.3680231E-07      WA0      = -1.2599192E-07      
+PA0      = 1.8891395E-13       KETA     = 3.5842650E-02       LKETA    = -9.8931220E-09      
+WKETA    = -5.8239420E-09      PKETA    = 4.0247990E-15       A1       = 0.00                
+A2       = 0.4000000           AGS      = 2.0000000E-02       B0       = 0.00                
+B1       = 0.00                VOFF     = -0.1409845          LVOFF    = 5.2372110E-09       
+WVOFF    = 8.2420830E-09       PVOFF    = -3.8668790E-15      NFACTOR  = 1.0000000           
+CIT      = -3.1597191E-04      LCIT     = 2.4836766E-10       WCIT     = 9.4362210E-12       
+PCIT     = -1.0851648E-17      CDSC     = 0.00                CDSCB    = 0.00                
+CDSCD    = 0.00                ETA0     = 1.7857154E-05       LETA0    = 3.6964260E-11       
+ETAB     = -1.7857154E-05      LETAB    = -3.6964260E-11      DSUB     = 0.00                
+PCLM     = 0.6714286           LPCLM    = 1.4785714E-07       PDIBLC1  = 1.0000000E-06       
+PDIBLC2  = 1.7857137E-03       LPDIBLC2 = 3.6964290E-09       PDIBLCB  = 1.0000000E-02       
+DROUT    = 0.00                PSCBE1   = 3.4999990E08        PSCBE2   = 5.0000000E-07       
+PVAG     = 0.00                DELTA    = 1.0000000E-02       ALPHA0   = 0.00                
+ALPHA1   = 6.8730453846        BETA0    = 22.67827            KT1      = -0.2439705          
+LKT1     = 6.1872760E-09       WKT1     = 1.3905176E-08       PKT1     = -6.0519150E-15      
+KT2      = -2.5852976E-02      LKT2     = 2.5314804E-09       WKT2     = 5.9186180E-10       
+PKT2     = -1.4802061E-15      AT       = 1.0000000E04        UTE      = -0.7903757          
+LUTE     = 1.0183292E-07       WUTE     = 7.8833130E-08       PUTE     = -5.9286950E-14      
+UA1      = 1.2240000E-09       UB1      = -1.2162624E-18      LUB1     = -1.1334610E-25      
+WUB1     = -7.4653720E-26      PUB1     = 4.9724100E-32       UC1      = 4.2107970E-11       
+LUC1     = -2.2106738E-17      WUC1     = 1.5870021E-17       PUC1     = 1.7282469E-23       
+KT1L     = 0.00                PRT      = 0                   
+CJ       = cjp                 PB       = 0.895226
+MJ       = 0.4476              CJSW     = cjswp               PBSW     = 0.895226
+MJSW     = 0.3683619           CJSWG    = cjswgp              PBSWG    = 0.895226
+MJSWG    = 0.3683619           CGDO     = cgop                CGSO     = cgop
+TCJ      = 0.0009739001        TCJSW    = 0.0004130718        TCJSWG   = 0.0004130718   
+TPB      = 0.001572025	        TPBSW    = 0.001572025         TPBSWG   = 0.001572025    
+JS       = 2.50E-07            JSW      = 1.2E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   DLC      = 2E-9                LLC      = -0.039   
+NOIMOD   = 2
+NOIA     = 9.50E18		NOIB     = 1.0E05	       NOIC	= 1.4E-12
+EM       = 3.0E07		EF       = 1.064               )

.MODEL pch.12 PMOS	(	LMIN     = 1.8e-007                 LMAX     = '5.000E-07-dxl'         
+WMIN     = '5.0000E-07-dxw'                                   WMAX     = '1.2000E-06-dxw'         
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp'              TOXM     = 'toxp'              XJ       = 1.7000001E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 1.4999999E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 5.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp'             RSH      = 'rshp'              RD       = 0                   
+RS       = 0                                     
+VTH0     = '-0.4463558+dvthp'  LVTH0    = -8.2027190E-09      WVTH0    = 5.7385650E-09       
+PVTH0    = -1.0352502E-15      K1       = 0.7171482           LK1      = -8.8442780E-09      
+WK1      = -1.1417325E-07      PK1      = 1.5213101E-14       K2       = -2.7492139E-02      
+LK2      = 4.9044990E-09       WK2      = 3.8377030E-08       PK2      = -6.2359860E-15      
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = 1.3081246E05        
+LVSAT    = -3.6561420E-04      UA       = -7.3364270E-11      LUA      = 2.3815556E-17       
+WUA      = 5.7265230E-16       PUA      = -7.7992140E-23      UB       = 1.4258127E-18       
+LUB      = -3.4250630E-26      WUB      = -7.8456510E-25      PUB      = 7.0650720E-32       
+UC       = -5.9462960E-11      LUC      = 8.8035780E-18       WUC      = -1.0188386E-16      
+PUC      = 3.2978070E-24       RDSW     = 5.3000000E02        PRWB     = 0.00                
+PRWG     = 0.00                WR       = 1.0000000           U0       = 6.8583350E-03       
+LU0      = 2.1198607E-10       WU0      = 9.2295840E-10       PU0      = -1.4287007E-16      
+A0       = 0.5166956           LA0      = 1.6783336E-07       WA0      = 4.8218620E-07       
+PA0      = -8.4766190E-14      KETA     = 1.7911140E-02       LKETA    = -1.8239428E-09      
+WKETA    = 5.2554230E-09       PKETA    = -9.6091580E-16      A1       = 0.00                
+A2       = 0.4000000           AGS      = 1.0547621E-02       LAGS     = 4.2535690E-09       
+WAGS     = 1.2594167E-08       PAGS     = -5.6673740E-15      B0       = 0.00                
+B1       = 0.00                VOFF     = -0.1286711          LVOFF    = -3.0382863E-10      
+WVOFF    = 2.8364715E-09       PVOFF    = -1.4343533E-15      NFACTOR  = 1.0000000           
+CIT      = 1.2746976E-04       LCIT     = 4.8818930E-11       WCIT     = -2.0641719E-11      
+PCIT     = 2.6834248E-18       CDSC     = 0.00                CDSCB    = 0.00                
+CDSCD    = -5.2000010E-05      LCDSCD   = 2.3400004E-11       WCDSCD   = -2.0304376E-11      
+PCDSCD   = 9.1369700E-18
+ETA0     = -4.6875000E-04      LETA0    = 2.5593747E-10       
+ETAB     = 6.7187530E-04       LETAB    = -3.4734380E-10      DSUB     = 0.00                
+PCLM     = 0.8585470           LPCLM    = 6.3653840E-08       WPCLM    = 5.6712850E-08       
+PPCLM    = -2.5520774E-14      PDIBLC1  = 1.0000000E-06       PDIBLC2  = 9.1502970E-03       
+LPDIBLC2 = 3.8236610E-10       WPDIBLC2 = -1.5742713E-09      PPDIBLC2 = 7.0842200E-16       
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 3.5000000E08        
+PSCBE2   = 5.0000000E-07       PVAG     = 0.00                DELTA    = 1.0000000E-02       
+ALPHA0   = 0.00                ALPHA1   = 6.8730453846        BETA0    = 22.67827            
+KT1      = -0.2211471          LKT1     = -4.0832670E-09      WKT1     = 2.7434011E-10       
+PKT1     = 8.1960910E-17       KT2      = -1.4824204E-02      LKT2     = -2.4314675E-09      
+WKT2     = -6.1135670E-09      PKT2     = 1.5372367E-15       AT       = 1.0000000E04        
+UTE      = -0.5812994          LUTE     = 7.7485560E-09       WUTE     = -5.5840220E-08      
+PUTE     = 1.3160581E-15       UA1      = 1.2240000E-09       UB1      = -1.6175756E-18      
+LUB1     = 6.7244840E-26       WUB1     = 8.3021400E-26       PUB1     = -2.1229706E-32      
+UC1      = -2.2818641E-11      LUC1     = 7.1102340E-18       WUC1     = 7.5301860E-17       
+PUC1     = -9.4618550E-24      KT1L     = 0.00                PRT      = 0                   
+CJ       = cjp                 PB       = 0.895226
+MJ       = 0.4476              CJSW     = cjswp               PBSW     = 0.895226
+MJSW     = 0.3683619           CJSWG    = cjswgp              PBSWG    = 0.895226
+MJSWG    = 0.3683619           CGDO     = cgop                CGSO     = cgop
+TCJ      = 0.0009739001        TCJSW    = 0.0004130718        TCJSWG   = 0.0004130718   
+TPB      = 0.001572025	        TPBSW    = 0.001572025         TPBSWG   = 0.001572025    
+JS       = 2.50E-07            JSW      = 1.2E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   DLC      = 2E-9                LLC      = -0.039   
+NOIMOD  = 2
+NOIA     = 9.50E18		NOIB     = 1.0E05	       NOIC	= 1.4E-12
+EM       = 3.0E07		EF       = 1.064               )

.MODEL pch.13 PMOS	(	LMIN     = '1.000E-05-dxl'         LMAX     = 20.001e-006              
+WMIN     = 2.2e-007                                           WMAX     = '5.0000E-07-dxw'         
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp'              TOXM     = 'toxp'              XJ       = 1.7000001E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 1.4999999E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 5.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp'             RSH      = 'rshp'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.4484667+dvthp'  WVTH0    = 9.3406130E-09       K1       = 0.5421249           
+WK1      = 3.5615110E-09       K2       = 3.5676420E-02       WK2      = -4.7198290E-09      
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = 1.4999998E05        
+UA       = 1.2584637E-09       WUA      = -2.3131395E-16      UB       = 4.9999990E-20       
+UC       = -1.6065008E-10      WUC      = -1.2695932E-17      RDSW     = 5.3000000E02        
+PRWB     = 0.00                PRWG     = 0.00                WR       = 1.0000000           
+U0       = 9.7483340E-03       WU0      = -4.0346860E-11      A0       = 0.8704194           
+WA0      = 8.9511660E-08       KETA     = 4.3109410E-02       WKETA    = -6.4034920E-09      
+A1       = 0.00                A2       = 0.4000000           AGS      = 2.0000000E-02       
+B0       = 0.00                B1       = 0.00                VOFF     = -0.1261533          
+WVOFF    = -1.3202980E-09      NFACTOR  = 1.0000000           CIT      = -1.0000000E-04      
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = 5.0000000E-05       ETAB     = -5.0000000E-05      DSUB     = 0.00                
+PCLM     = 0.5999999           PDIBLC1  = 1.0000000E-06       PDIBLC2  = 1.0000000E-03       
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 1.9999997E08        
+PSCBE2   = 5.0000000E-07       PVAG     = 0.00                DELTA    = 1.0000000E-02       
+ALPHA0   = 0.00                ALPHA1   = 6.8730453846        BETA0    = 22.67827            
+KT1      = -0.2247607          WKT1     = 3.8305540E-09       KT2      = -2.7069092E-02      
+WKT2     = 1.9527771E-09       AT       = 1.0000000E04        UTE      = -0.7678431          
+WUTE     = 6.8981090E-09       UA1      = 1.2240000E-09       UB1      = -1.3041941E-18      
+WUB1     = 2.1644123E-27       UC1      = 6.6651710E-11       WUC1     = -1.2526765E-17      
+KT1L     = 0.00                PRT      = 0                   
+CJ       = cjp                 PB       = 0.895226
+MJ       = 0.4476              CJSW     = cjswp               PBSW     = 0.895226
+MJSW     = 0.3683619           CJSWG    = cjswgp              PBSWG    = 0.895226
+MJSWG    = 0.3683619           CGDO     = cgop                CGSO     = cgop
+TCJ      = 0.0009739001        TCJSW    = 0.0004130718        TCJSWG   = 0.0004130718   
+TPB      = 0.001572025	        TPBSW    = 0.001572025         TPBSWG   = 0.001572025    
+JS       = 2.50E-07            JSW      = 1.2E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   DLC      = 2E-9                LLC      = -0.039   
+NOIMOD  = 2
+NOIA     = 9.50E18		NOIB     = 1.0E05	       NOIC	= 1.4E-12
+EM       = 3.0E07		EF       = 1.064               )

.MODEL pch.14 PMOS	(	LMIN     = '1.200E-06-dxl'         LMAX     = '1.000E-05-dxl'         
+WMIN     = 2.2e-007                                           WMAX     = '5.0000E-07-dxw'         
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp'              TOXM     = 'toxp'              XJ       = 1.7000001E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 1.4999999E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 5.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp'             RSH      = 'rshp'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.4480035+dvthp'  LVTH0    = -4.6083350E-09      WVTH0    = 9.7064800E-09       
+PVTH0    = -3.6403820E-15      K1       = 0.5470301           LK1      = -4.8806700E-08      
+WK1      = -2.4364055E-10      PK1      = 3.7861260E-14       K2       = 3.3334490E-02       
+LK2      = 2.3302198E-08       WK2      = -3.0947396E-09      PK2      = -1.6169635E-14      
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = 1.5130680E05        
+LVSAT    = -1.3002842E-02      UA       = 1.2617201E-09       LUA      = -3.2401100E-17      
+WUA      = -2.2991296E-16      PUA      = -1.3939852E-23      UB       = 5.0039600E-20       
+LUB      = -3.9414270E-28      WUB      = -1.1822094E-29      PUB      = 1.1764949E-34       
+UC       = -1.5373321E-10      LUC      = -6.8822930E-17      WUC      = -1.4112429E-17      
+PUC      = 1.4094153E-23       RDSW     = 5.3000000E02        PRWB     = 0.00                
+PRWG     = 0.00                WR       = 1.0000000           U0       = 9.7784860E-03       
+LU0      = -3.0000519E-10      WU0      = 2.2217313E-11       PU0      = -6.2251350E-16      
+A0       = 0.8193527           LA0      = 5.0811370E-07       WA0      = 1.0814799E-07       
+PA0      = -1.8543150E-13      KETA     = 4.7694810E-02       LKETA    = -4.5624760E-08      
+WKETA    = -8.1672530E-09      PKETA    = 1.7549415E-14       A1       = 0.00                
+A2       = 0.4000000           AGS      = 2.0000000E-02       B0       = 0.00                
+B1       = 0.00                VOFF     = -0.1259132          LVOFF    = -2.3886029E-09      
+WVOFF    = -1.5900530E-09      PVOFF    = 2.6840621E-15       NFACTOR  = 1.0000000           
+CIT      = -1.0000000E-04      CDSC     = 0.00                CDSCB    = 0.00                
+CDSCD    = 0.00                ETA0     = 5.0000000E-05       ETAB     = -5.0000000E-05      
+DSUB     = 0.00                PCLM     = 0.5738635           LPCLM    = 2.6005691E-07       
+PDIBLC1  = 1.0000000E-06       PDIBLC2  = 4.7727290E-04       LPDIBLC2 = 5.2011360E-09       
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 1.8039770E08        
+LPSCBE1  = 1.9504262E02        PSCBE2   = 5.0000000E-07       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.00                ALPHA1   = 6.8730453846        
+BETA0    = 22.67827            KT1      = -0.2237138          LKT1     = -1.0417262E-08      
+WKT1     = 3.5742560E-09       PKT1     = 2.5501714E-15       KT2      = -2.6908273E-02      
+LKT2     = -1.6001408E-09      WKT2     = 2.0011981E-09       PKT2     = -4.8178840E-16      
+AT       = 1.0000000E04        UTE      = -0.7908860          LUTE     = 2.2927659E-07       
+WUTE     = 1.1298283E-08       PUTE     = -4.3781730E-14      UA1      = 1.2240000E-09       
+UB1      = -1.2832692E-18      LUB1     = -2.0820251E-25      WUB1     = -3.0198158E-27      
+PUB1     = 5.1583110E-32       UC1      = 5.6680550E-11       LUC1     = 9.9213070E-17       
+WUC1     = -1.0513175E-17      PUC1     = -2.0035212E-23      KT1L     = 0.00                
+PRT      = 0                   CJ       = cjp                 PB       = 0.895226
+MJ       = 0.4476              CJSW     = cjswp               PBSW     = 0.895226
+MJSW     = 0.3683619           CJSWG    = cjswgp              PBSWG    = 0.895226
+MJSWG    = 0.3683619           CGDO     = cgop                CGSO     = cgop
+TCJ      = 0.0009739001        TCJSW    = 0.0004130718        TCJSWG   = 0.0004130718   
+TPB      = 0.001572025	        TPBSW    = 0.001572025         TPBSWG   = 0.001572025    
+JS       = 2.50E-07            JSW      = 1.2E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   DLC      = 2E-9                LLC      = -0.039   
+NOIMOD  = 2
+NOIA     = 9.50E18		NOIB     = 1.0E05	       NOIC	= 1.4E-12
+EM       = 3.0E07		EF       = 1.064               )

.MODEL pch.15 PMOS	(	LMIN     = '5.000E-07-dxl'         LMAX     = '1.200E-06-dxl'         
+WMIN     = 2.2e-007                                           WMAX     = '5.0000E-07-dxw'         
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp'              TOXM     = 'toxp'              XJ       = 1.7000001E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 1.4999999E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 5.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp'             RSH      = 'rshp'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.4385042+dvthp'  LVTH0    = -1.5532533E-08      WVTH0    = 5.8780540E-09       
+PVTH0    = 7.6230860E-16       K1       = 0.5102190           LK1      = -6.4738780E-09      
+WK1      = 4.1827890E-08       PK1      = -1.0521005E-14      K2       = 5.4106280E-02       
+LK2      = -5.8536280E-10      WK2      = -2.2085489E-08      PK2      = 5.6697290E-15       
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = 1.4642852E05        
+LVSAT    = -7.3928160E-03      UA       = 1.0922192E-09       LUA      = 1.6252487E-16       
+WUA      = -1.9008923E-16      PUA      = -5.9737160E-23      UB       = 2.0536515E-20       
+LUB      = 3.3534410E-26       WUB      = 8.3698470E-27       PUB      = -9.5212690E-33      
+UC       = -2.1836380E-10      LUC      = 5.5022750E-18       WUC      = 5.3707260E-18       
+PUC      = -8.3114780E-24      RDSW     = 5.3000000E02        PRWB     = 0.00                
+PRWG     = 0.00                WR       = 1.0000000           U0       = 9.2032870E-03       
+LU0      = 3.6147370E-10       WU0      = -3.9873410E-10      PU0      = -1.3841940E-16      
+A0       = 1.1508681           LA0      = 1.2687106E-07       WA0      = -1.0502199E-07      
+PA0      = 5.9713990E-14       KETA     = 4.4842080E-04       LKETA    = 8.7085910E-09       
+WKETA    = 1.1519229E-08       PKETA    = -5.0900410E-15      A1       = 0.00                
+A2       = 0.4000000           AGS      = 2.0000000E-02       B0       = 0.00                
+B1       = 0.00                VOFF     = -0.1186655          LVOFF    = -1.0723419E-08      
+WVOFF    = -2.6941984E-09      PVOFF    = 3.9538300E-15       NFACTOR  = 1.0000000           
+CIT      = -2.9671428E-04      LCIT     = 2.2622144E-10       CDSC     = 0.00                
+CDSCB    = 0.00                CDSCD    = 0.00                ETA0     = 1.7857146E-05       
+LETA0    = 3.6964280E-11       ETAB     = -1.7857146E-05      LETAB    = -3.6964280E-11      
+DSUB     = 0.00                PCLM     = 0.6714286           LPCLM    = 1.4785714E-07       
+PDIBLC1  = 1.0000000E-06       PDIBLC2  = 1.7857139E-03       LPDIBLC2 = 3.6964290E-09       
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 3.4999990E08        
+PSCBE2   = 5.0000000E-07       PVAG     = 0.00                DELTA    = 1.0000000E-02       
+ALPHA0   = 0.00                ALPHA1   = 6.8730453846        BETA0    = 22.67827            
+KT1      = -0.2426738          LKT1     = 1.1386779E-08       WKT1     = 1.3269771E-08       
+PKT1     = -8.5996710E-15      KT2      = -2.7530843E-02      LKT2     = -8.8418580E-10      
+WKT2     = 1.4140165E-09       PKT2     = 1.9347028E-16       AT       = 1.0000000E04        
+UTE      = -0.5904401          LUTE     = -1.2362289E-09      WUTE     = -1.9135335E-08      
+PUTE     = -8.7830670E-15      UA1      = 1.2240000E-09       UB1      = -1.4562286E-18      
+LUB1     = -9.2991590E-27      WUB1     = 4.2929760E-26       PUB1     = -1.2589071E-33      
+UC1      = 1.3909653E-10       LUC1     = 4.4346890E-18       WUC1     = -3.1654370E-17      
+PUC1     = 4.2771700E-24       KT1L     = 0.00                PRT      = 0                   
+CJ       = cjp                 PB       = 0.895226
+MJ       = 0.4476              CJSW     = cjswp               PBSW     = 0.895226
+MJSW     = 0.3683619           CJSWG    = cjswgp              PBSWG    = 0.895226
+MJSWG    = 0.3683619           CGDO     = cgop                CGSO     = cgop
+TCJ      = 0.0009739001        TCJSW    = 0.0004130718        TCJSWG   = 0.0004130718   
+TPB      = 0.001572025	        TPBSW    = 0.001572025         TPBSWG   = 0.001572025    
+JS       = 2.50E-07            JSW      = 1.2E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   DLC      = 2E-9                LLC      = -0.039   
+NOIMOD  = 2
+NOIA     = 9.50E18		NOIB     = 1.0E05	       NOIC	= 1.4E-12
+EM       = 3.0E07		EF       = 1.064               )

.MODEL pch.16 PMOS	(	LMIN     = 1.8e-007                 LMAX     = '5.000E-07-dxl'         
+WMIN     = 2.2e-007                                           WMAX     = '5.0000E-07-dxw'         
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp'              TOXM     = 'toxp'              XJ       = 1.7000001E-07       
+NCH      = 3.9000000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 1.4999999E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 5.0000000E-09       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl'      XW       = '0.0+dxw'           DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp'             RSH      = 'rshp'              RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.4513863+dvthp'  LVTH0    = -9.7355810E-09      WVTH0    = 8.2035130E-09       
+PVTH0    = -2.8414808E-16      K1       = 0.4651900           LK1      = 1.3789155E-08       
+WK1      = 9.2862840E-09       PK1      = 4.1227180E-15       K2       = 5.9709800E-02       
+LK2      = -3.1069460E-09      WK2      = -4.3519210E-09      PK2      = -2.3103772E-15      
+K3       = 0.00                DVT0     = 0.00                DVT1     = 0.00                
+DVT2     = 0.00                DVT0W    = 0.00                DVT1W    = 0.00                
+DVT2W    = 0.00                NLX      = 0.00                W0       = 0.00                
+K3B      = 0.00                VSAT     = 1.3081255E05        
+LVSAT    = -3.6563360E-04      UA       = 2.0400983E-09       LUA      = -2.6402067E-16      
+WUA      = -4.6294430E-16      PUA      = 6.3047610E-23       UB       = -4.9040330E-19      
+LUB      = 2.6345733E-25       WUB      = 1.5438073E-25       PUB      = -7.5226180E-32      
+UC       = -2.8037866E-10      LUC      = 3.3408970E-17       WUC      = 6.3648470E-18       
+PUC      = -8.7588340E-24      RDSW     = 5.3000000E02        PRWB     = 0.00                
+PRWG     = 0.00                WR       = 1.0000000           U0       = 1.0799064E-02       
+LU0      = -3.5662620E-10      WU0      = -1.0079994E-09      PU0      = 1.3574996E-16       
+A0       = 1.4167303           LA0      = 7.2330520E-09       WA0      = 4.1169190E-08       
+PA0      = -6.0720430E-15      KETA     = 3.1593680E-02       LKETA    = -5.3067750E-09      
+WKETA    = -1.4490222E-09      PKETA    = 7.4567200E-16       A1       = 0.00                
+A2       = 0.4000000           AGS      = 3.6250000E-02       LAGS     = -7.3124990E-09      
+B0       = 0.00                B1       = 0.00                VOFF     = -0.1287204          
+LVOFF    = -6.1987190E-09      WVOFF    = 2.8606606E-09       PVOFF    = 1.4541431E-15       
+NFACTOR  = 1.0000000           CIT      = 8.5343770E-05       LCIT     = 5.4295310E-11       
+CDSC     = 0.00                CDSCB    = 0.00                
+CDSCD    = -6.4492230E-05      
+LCDSCD   = 2.9021494E-11       WCDSCD   = -1.4183201E-11      PCDSCD   = 6.3824410E-18               
+ETA0     = -4.6875020E-04      LETA0    = 2.5593758E-10       ETAB     = 6.7187530E-04       
+LETAB    = -3.4734380E-10      DSUB     = 0.00                PCLM     = 0.9648299           
+LPCLM    = 1.5826547E-08       WPCLM    = 4.6342220E-09       PPCLM    = -2.0853998E-15      
+PDIBLC1  = 1.0000000E-06       PDIBLC2  = 5.9374990E-03       LPDIBLC2 = 1.8281252E-09       
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 3.5000000E08        
+PSCBE2   = 5.0000000E-07       PVAG     = 0.00                DELTA    = 1.0000000E-02       
+ALPHA0   = 0.00                ALPHA1   = 6.8730453846        BETA0    = 22.67827            
+KT1      = -0.2130934          LKT1     = -1.9244071E-09      WKT1     = -3.6719870E-09      
+PKT1     = -9.7588050E-16      KT2      = -3.5890840E-02      LKT2     = 2.8778120E-09       
+WKT2     = 4.2090850E-09       PKT2     = -1.0643102E-15      AT       = 1.0000000E04        
+UTE      = -0.5893072          LUTE     = -1.7460413E-09      WUTE     = -5.1916390E-08      
+PUTE     = 5.9684110E-15       UA1      = 1.2240000E-09       UB1      = -1.4433942E-18      
+LUB1     = -1.5074642E-26      WUB1     = -2.3274574E-27      PUB1     = 1.9106841E-32       
+UC1      = 2.0396977E-10       LUC1     = -2.4758267E-17      WUC1     = -3.5824470E-17      
+PUC1     = 6.1537120E-24       KT1L     = 0.00                PRT      = 0                   
+CJ       = cjp                 PB       = 0.895226
+MJ       = 0.4476              CJSW     = cjswp               PBSW     = 0.895226
+MJSW     = 0.3683619           CJSWG    = cjswgp              PBSWG    = 0.895226
+MJSWG    = 0.3683619           CGDO     = cgop                CGSO     = cgop
+TCJ      = 0.0009739001        TCJSW    = 0.0004130718        TCJSWG   = 0.0004130718   
+TPB      = 0.001572025	        TPBSW    = 0.001572025         TPBSWG   = 0.001572025    
+JS       = 2.50E-07            JSW      = 1.2E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   DLC      = 2E-9                LLC      = -0.039   
+NOIMOD  = 2
+NOIA     = 9.50E18		NOIB     = 1.0E05	       NOIC	= 1.4E-12
+EM       = 3.0E07		EF       = 1.064               )

.ENDL MOS

*
.LIB MOS_3V
*******************************************************************************************
*                                                                                         *
*                              3.3V I/O DEVICE MODELS                                     *
*                                                                                         *
*******************************************************************************************

.MODEL nch3.1 NMOS	(	LMIN     = '1.000E-05-dxl3'      LMAX     = 20.001e-006              
+WMIN     = '1.0000E-05-dxw3'                                WMAX     = 900.001e-6               
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn3'           TOXM     = 'toxn3'           XJ       = 1.7000001E-07       
+NCH      = 5.2600000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 4.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 1.4999999E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn3'          RSH      = 'rshn3'           RD       = 0                   
+RS       = 0                                     
+VTH0     = '0.7411730+dvthn3'
+K1       = 0.8520129           K2       = 3.2049370E-02       K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 1.0000000E05        UA       = -6.5967100E-10      
+UB       = 2.3514212E-18       UC       = 1.0151108E-10       RDSW     = 5.4500000E02        
+PRWB     = 0.00                PRWG     = 0.00                WR       = 1.0000000           
+U0       = 4.0383610E-02       A0       = 0.5957787           KETA     = 1.0636362E-02       
+A1       = 0.00                A2       = 0.9900000           AGS      = 2.0000000E-02       
+B0       = 0.00                B1       = 0.00                VOFF     = -0.1273081          
+NFACTOR  = 1.0000000           CIT      = 3.2298330E-04       CDSC     = 0.00                
+CDSCB    = 0.00                CDSCD    = 0.00                ETA0     = 1.0000000E-05       
+ETAB     = -1.0000000E-05      DSUB     = 0.00                PCLM     = 0.5000001           
+PDIBLC1  = 1.0000000E-06       PDIBLC2  = 5.0000000E-04       PDIBLCB  = 1.0000000E-02       
+DROUT    = 0.00                PSCBE1   = 2.0000000E08        PSCBE2   = 1.0000000E-06       
+PVAG     = 0.00                DELTA    = 1.0000000E-02       ALPHA0   = 0.0                 
+ALPHA1   = 7.049416            BETA0    = 21.5673             KT1      = -0.2967474          
+KT2      = -3.0051107E-02      AT       = 2.0000000E04        UTE      = -1.3699325          
+UA1      = 2.0399999E-09       UB1      = -2.3240355E-18      UC1      = -2.5228651E-11      
+KT1L     = 0.00                PRT      = 0                   
+CJ       = cjn3                PB       = 0.7076023
+MJ       = 0.3259624           CJSW     = cjswn3              PBSW     = 0.7076023
+MJSW     = 0.1513672           CJSWG    = cjswgn3             PBSWG    = 0.7076023
+MJSWG    = 0.3513672           CGDO     = cgon3               CGSO     = cgon3
+TCJ      = 0.0009923959        TCJSW    = 0.0005019466        TCJSWG   = 0.0005019466   
+TPB      = 0.001687207         TPBSW    = 0.001687207         TPBSWG   = 0.001687207
+JS       = 3.93E-07            JSW      = 1.43E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   LLC      = -0.0165             NOIMOD   = 2
+NOIA     = 1.0E20		NOIB     = 4.0E04	       NOIC	= -4.0E-13
+EM       = 3.0E07		EF       = 0.881               )

.MODEL nch3.2 NMOS	(	LMIN     = '1.200E-06-dxl3'      LMAX     = '1.000E-05-dxl3'      
+WMIN     = '1.0000E-05-dxw3'                                WMAX     = 900.001e-6               
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn3'           TOXM     = 'toxn3'           XJ       = 1.7000001E-07       
+NCH      = 5.2600000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 4.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 1.4999999E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn3'          RSH      = 'rshn3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.7338805+dvthn3'
+LVTH0    = 7.2196430E-08       K1       = 0.8436294           LK1      = 8.2996260E-08       
+K2       = 3.5836430E-02       LK2      = -3.7491980E-08      K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 1.0087500E05        LVSAT    = -8.6625000E-03      
+UA       = -6.5715190E-10      LUA      = -2.4938983E-17      UB       = 2.3501459E-18       
+LUB      = 1.2625015E-26       UC       = 9.9987010E-11       LUC      = 1.5088319E-17       
+RDSW     = 5.4500000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 4.0144190E-02       LU0      = 2.3703481E-09       
+A0       = 0.5985498           LA0      = -2.7434131E-08      KETA     = 1.3293392E-02       
+LKETA    = -2.6304601E-08      A1       = 0.00                A2       = 0.9900000           
+AGS      = 2.0000000E-02       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1288763          LVOFF    = 1.5525753E-08       NFACTOR  = 1.0000000           
+CIT      = 2.9848100E-04       LCIT     = 2.4257210E-10       CDSC     = 0.00                
+CDSCB    = 0.00                CDSCD    = 0.00                ETA0     = 5.0055810E-06       
+LETA0    = 4.9444760E-11       ETAB     = -5.0055810E-06      LETAB    = -4.9444760E-11      
+DSUB     = 0.00                PCLM     = 0.4766459           LPCLM    = 2.3120668E-07       
+PDIBLC1  = 1.0000000E-06       PDIBLC2  = 4.3750000E-04       LPDIBLC2 = 6.1875000E-10       
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 1.8500000E08        
+LPSCBE1  = 1.4850000E02        PSCBE2   = 1.0000000E-06       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.0                 ALPHA1   = 7.049416            
+BETA0    = 21.5673             KT1      = -0.2975682          LKT1     = 8.1267750E-09       
+KT2      = -3.0177854E-02      LKT2     = 1.2547903E-09       AT       = 2.0000000E04        
+UTE      = -1.3824263          LUTE     = 1.2368807E-07       UA1      = 2.0399999E-09       
+UB1      = -2.3458511E-18      LUB1     = 2.1597545E-25       UC1      = -2.8060729E-11      
+LUC1     = 2.8037565E-17       KT1L     = 0.00                PRT      = 0                   
+CJ       = cjn3                PB       = 0.7076023
+MJ       = 0.3259624           CJSW     = cjswn3              PBSW     = 0.7076023
+MJSW     = 0.1513672           CJSWG    = cjswgn3             PBSWG    = 0.7076023
+MJSWG    = 0.3513672           CGDO     = cgon3               CGSO     = cgon3
+TCJ      = 0.0009923959        TCJSW    = 0.0005019466        TCJSWG   = 0.0005019466   
+TPB      = 0.001687207         TPBSW    = 0.001687207         TPBSWG   = 0.001687207
+JS       = 3.93E-07            JSW      = 1.43E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   LLC      = -0.0165             NOIMOD  = 2
+NOIA     = 1.0E20		NOIB     = 4.0E04	       NOIC	= -4.0E-13
+EM       = 3.0E07		EF       = 0.881               )

.MODEL nch3.3 NMOS	(	LMIN     = '5.000E-07-dxl3'      LMAX     = '1.200E-06-dxl3'      
+WMIN     = '1.0000E-05-dxw3'                                WMAX     = 900.001e-6               
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn3'           TOXM     = 'toxn3'           XJ       = 1.7000001E-07       
+NCH      = 5.2600000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 4.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 1.4999999E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn3'          RSH      = 'rshn3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.7854808+dvthn3'
+LVTH0    = 1.5436049E-08       K1       = 0.8725621           LK1      = 5.1170270E-08       
+K2       = 2.6585609E-02       LK2      = -2.7316075E-08      K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 9.4142860E04        LVSAT    = -1.2571429E-03      
+UA       = -5.5044020E-10      LUA      = -1.4232186E-16      UB       = 2.2213255E-18       
+LUB      = 1.5432739E-25       UC       = 8.6765090E-11       LUC      = 2.9632438E-17       
+RDSW     = 5.4500000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 4.1177810E-02       LU0      = 1.2333661E-09       
+A0       = 0.5002358           LA0      = 8.0711320E-08       KETA     = 3.0733263E-03       
+LKETA    = -1.5062529E-08      A1       = 0.00                A2       = 0.9900000           
+AGS      = 4.2857150E-02       LAGS     = -2.5142864E-08      B0       = 0.00                
+B1       = 0.00                VOFF     = -0.1181122          LVOFF    = 3.6851710E-09       
+NFACTOR  = 1.0000000           CIT      = 5.2695760E-04       LCIT     = -8.7521730E-12      
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = -2.0721287E-04      LETA0    = 2.8288508E-10       ETAB     = 2.0721287E-04       
+LETAB    = -2.8288508E-10      DSUB     = 0.00                PCLM     = 0.6683022           
+LPCLM    = 2.0384716E-08       PDIBLC1  = 1.0000000E-06       PDIBLC2  = 9.9999980E-04       
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 3.0285712E08        
+LPSCBE1  = 18.8571820          PSCBE2   = 1.0000000E-06       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.0                 ALPHA1   = 7.049416            
+BETA0    = 21.5673             KT1      = -0.3058816          LKT1     = 1.7271480E-08       
+KT2      = -3.2605510E-02      LKT2     = 3.9252180E-09       AT       = 2.0000000E04        
+UTE      = -1.3841497          LUTE     = 1.2558385E-07       UA1      = 2.0399999E-09       
+UB1      = -2.6782768E-18      LUB1     = 5.8164370E-25       UC1      = -7.4947920E-11      
+LUC1     = 7.9613470E-17       KT1L     = 0.00                PRT      = 0                   
+CJ       = cjn3                PB       = 0.7076023
+MJ       = 0.3259624           CJSW     = cjswn3              PBSW     = 0.7076023
+MJSW     = 0.1513672           CJSWG    = cjswgn3             PBSWG    = 0.7076023
+MJSWG    = 0.3513672           CGDO     = cgon3               CGSO     = cgon3
+TCJ      = 0.0009923959        TCJSW    = 0.0005019466        TCJSWG   = 0.0005019466   
+TPB      = 0.001687207         TPBSW    = 0.001687207         TPBSWG   = 0.001687207
+JS       = 3.93E-07            JSW      = 1.43E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   LLC      = -0.0165             NOIMOD  = 2
+NOIA     = 1.0E20		NOIB     = 4.0E04	       NOIC	= -4.0E-13
+EM       = 3.0E07		EF       = 0.881               )

.MODEL nch3.4 NMOS	(	LMIN     = 3.5e-007                 LMAX     = '5.000E-07-dxl3'      
+WMIN     = '1.0000E-05-dxw3'                                WMAX     = 900.001e-6               
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn3'           TOXM     = 'toxn3'           XJ       = 1.7000001E-07       
+NCH      = 5.2600000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 4.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 1.4999999E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn3'          RSH      = 'rshn3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.8656338+dvthn3'
+LVTH0    = -1.6625165E-08      K1       = 0.7380362           LK1      = 1.0498064E-07       
+K2       = 0.1905548           LK2      = -9.2903750E-08      K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 9.2662950E04        LVSAT    = -6.6517710E-04      
+UA       = -7.6742930E-10      LUA      = -5.5526210E-17      UB       = 2.1708317E-18       
+LUB      = 1.7452491E-25       UC       = 2.5100996E-10       LUC      = -3.6065510E-17      
+RDSW     = 5.4500000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 4.2647680E-02       LU0      = 6.4541630E-10       
+A0       = 0.8895671           LA0      = -7.5021190E-08      KETA     = -5.8208280E-02      
+LKETA    = 9.4501150E-09       A1       = 0.00                A2       = 0.9900000           
+AGS      = -2.0000029E-02      B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1009514          LVOFF    = -3.1791380E-09      NFACTOR  = 1.0000000           
+CIT      = 4.9120500E-04       LCIT     = 5.5488980E-12       CDSC     = 0.00                
+CDSCB    = 0.00                CDSCD    = 0.00                ETA0     = -1.1666669E-03      
+LETA0    = 6.6666670E-10       ETAB     = 3.6657390E-03       LETAB    = -1.6662953E-09      
+DSUB     = 0.00                PCLM     = -0.1426817          LPCLM    = 3.4477830E-07       
+PDIBLC1  = 1.0000000E-06       PDIBLC2  = -1.0661089E-02      LPDIBLC2 = 4.6644360E-09       
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 3.5000020E08        
+PSCBE2   = 1.0000000E-06       PVAG     = 0.00                DELTA    = 1.0000000E-02       
+ALPHA0   = 0.0                 ALPHA1   = 7.049416            BETA0    = 21.5673             
+KT1      = -0.2689408          LKT1     = 2.4951499E-09       KT2      = -1.7957341E-02      
+LKT2     = -1.9340516E-09      AT       = 2.0000000E04        UTE      = -1.0052726          
+LUTE     = -2.5966962E-08      UA1      = 2.0399999E-09       UB1      = -1.6034720E-18      
+LUB1     = 1.5172175E-25       UC1      = 9.0686240E-11       LUC1     = 1.3359813E-17       
+KT1L     = 0.00                PRT      = 0                   
+CJ       = cjn3                PB       = 0.7076023
+MJ       = 0.3259624           CJSW     = cjswn3              PBSW     = 0.7076023
+MJSW     = 0.1513672           CJSWG    = cjswgn3             PBSWG    = 0.7076023
+MJSWG    = 0.3513672           CGDO     = cgon3               CGSO     = cgon3
+TCJ      = 0.0009923959        TCJSW    = 0.0005019466        TCJSWG   = 0.0005019466   
+TPB      = 0.001687207         TPBSW    = 0.001687207         TPBSWG   = 0.001687207
+JS       = 3.93E-07            JSW      = 1.43E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   LLC      = -0.0165             NOIMOD  = 2
+NOIA     = 1.0E20		NOIB     = 4.0E04	       NOIC	= -4.0E-13
+EM       = 3.0E07		EF       = 0.881               )

.MODEL nch3.5 NMOS	(	LMIN     = '1.000E-05-dxl3'      LMAX     = 20.001e-006              
+WMIN     = '1.2000E-06-dxw3'                                WMAX     = '1.0000E-05-dxw3'      
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn3'           TOXM     = 'toxn3'           XJ       = 1.7000001E-07       
+NCH      = 5.2600000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 4.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 1.4999999E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn3'          RSH      = 'rshn3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.7412278+dvthn3'
+WVTH0    = -5.4619160E-10      K1       = 0.8508129           WK1      = 1.1963754E-08       
+K2       = 3.1879250E-02       WK2      = 1.6960789E-09       K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 1.0000000E05        UA       = -6.5888360E-10      
+WUA      = -7.8505910E-18      UB       = 2.3875394E-18       WUB      = -3.6009940E-25      
+UC       = 1.0341122E-10       WUC      = -1.8944324E-17      RDSW     = 5.4500000E02        
+PRWB     = 0.00                PRWG     = 0.00                WR       = 1.0000000           
+U0       = 4.0690960E-02       WU0      = -3.0642096E-09      A0       = 0.5914139           
+WA0      = 4.3517560E-08       KETA     = 1.0701262E-02       WKETA    = -6.4705320E-10      
+A1       = 0.00                A2       = 0.9900000           AGS      = 2.0000000E-02       
+B0       = 0.00                B1       = 0.00                VOFF     = -0.1275286          
+WVOFF    = 2.1983364E-09       NFACTOR  = 1.0000000           CIT      = 3.2352310E-04       
+WCIT     = -5.3825510E-12      CDSC     = 0.00                CDSCB    = 0.00                
+CDSCD    = 0.00                ETA0     = 1.0000000E-05       ETAB     = -1.0000000E-05      
+DSUB     = 0.00                PCLM     = 0.5000001           PDIBLC1  = 1.0000000E-06       
+PDIBLC2  = 5.0000000E-04       PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                
+PSCBE1   = 2.0000000E08        PSCBE2   = 1.0000000E-06       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.0                 ALPHA1   = 7.049416            
+BETA0    = 21.5673             KT1      = -0.2959924          WKT1     = -7.5268250E-09      
+KT2      = -2.9950516E-02      WKT2     = -1.0028854E-09      AT       = 2.0000000E04        
+UTE      = -1.3781972          WUTE     = 8.2399010E-08       UA1      = 2.0399999E-09       
+UB1      = -2.3223396E-18      WUB1     = -1.6908192E-26      UC1      = -1.9919816E-11      
+WUC1     = -5.2929100E-17      KT1L     = 0.00                PRT      = 0                   
+CJ       = cjn3                PB       = 0.7076023
+MJ       = 0.3259624           CJSW     = cjswn3              PBSW     = 0.7076023
+MJSW     = 0.1513672           CJSWG    = cjswgn3             PBSWG    = 0.7076023
+MJSWG    = 0.3513672           CGDO     = cgon3               CGSO     = cgon3
+TCJ      = 0.0009923959        TCJSW    = 0.0005019466        TCJSWG   = 0.0005019466   
+TPB      = 0.001687207         TPBSW    = 0.001687207         TPBSWG   = 0.001687207
+JS       = 3.93E-07            JSW      = 1.43E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   LLC      = -0.0165             NOIMOD  = 2
+NOIA     = 1.0E20		NOIB     = 4.0E04	       NOIC	= -4.0E-13
+EM       = 3.0E07		EF       = 0.881               )

.MODEL nch3.6 NMOS	(	LMIN     = '1.200E-06-dxl3'      LMAX     = '1.000E-05-dxl3'      
+WMIN     = '1.2000E-06-dxw3'                                WMAX     = '1.0000E-05-dxw3'      
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn3'           TOXM     = 'toxn3'           XJ       = 1.7000001E-07       
+NCH      = 5.2600000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 4.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 1.4999999E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn3'          RSH      = 'rshn3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.7337149+dvthn3'
+LVTH0    = 7.4378140E-08       WVTH0    = 1.6509301E-09       PVTH0    = -2.1751505E-14      
+K1       = 0.8419480           LK1      = 8.7762780E-08       WK1      = 1.6763977E-08       
+PK1      = -4.7522210E-14      K2       = 3.5826360E-02       LK2      = -3.9076370E-08      
+WK2      = 1.0048508E-10       PK2      = 1.5796389E-14       K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 1.0087500E05        LVSAT    = -8.6625010E-03      
+UA       = -6.5616190E-10      LUA      = -2.6944907E-17      WUA      = -9.8707010E-18      
+PUA      = 1.9999060E-23       UB       = 2.3849762E-18       LUB      = 2.5376364E-26       
+WUB      = -3.4725790E-25      PUB      = -1.2713090E-31      UC       = 1.0178221E-10       
+LUC      = 1.6127195E-17       WUC      = -1.7898101E-17      PUC      = -1.0357598E-23      
+RDSW     = 5.4500000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 4.0439300E-02       LU0      = 2.4913751E-09       
+WU0      = -2.9423268E-09      PU0      = -1.2066391E-15      A0       = 0.5931649           
+LA0      = -1.7334720E-08      WA0      = 5.3688390E-08       PA0      = -1.0069116E-13      
+KETA     = 1.3365778E-02       LKETA    = -2.6378700E-08      WKETA    = -7.2167630E-10      
+PKETA    = 7.3875800E-16       A1       = 0.00                A2       = 0.9900000           
+AGS      = 2.0000000E-02       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1290965          LVOFF    = 1.5522346E-08       WVOFF    = 2.1949056E-09       
+PVOFF    = 3.3964270E-17       NFACTOR  = 1.0000000           CIT      = 2.9909017E-04       
+LCIT     = 2.4188637E-10       WCIT     = -6.0731490E-12      PCIT     = 6.8368810E-18       
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = 4.3415470E-06       LETA0    = 5.6018670E-11       WETA0    = 6.6203900E-12       
+PETA0    = -6.5541850E-17      ETAB     = -4.3415470E-06      LETAB    = -5.6018670E-11      
+WETAB    = -6.6203900E-12      PETAB    = 6.5541850E-17       DSUB     = 0.00                
+PCLM     = 0.4771902           LPCLM    = 2.2581794E-07       WPCLM    = -5.4269150E-09      
+PPCLM    = 5.3725680E-14       PDIBLC1  = 1.0000000E-06       PDIBLC2  = 4.3750000E-04       
+LPDIBLC2 = 6.1875000E-10       PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                
+PSCBE1   = 1.8499998E08        LPSCBE1  = 1.4850002E02        PSCBE2   = 1.0000000E-06       
+PVAG     = 0.00                DELTA    = 1.0000000E-02       ALPHA0   = 0.0                 
+ALPHA1   = 7.049416            BETA0    = 21.5673             KT1      = -0.2967275          
+LKT1     = 7.2770190E-09       WKT1     = -8.3825920E-09      PKT1     = 8.4720740E-15       
+KT2      = -3.0061465E-02      LKT2     = 1.0983974E-09       WKT2     = -1.1603842E-09      
+PKT2     = 1.5592368E-15       AT       = 2.0000000E04        UTE      = -1.3914689          
+LUTE     = 1.3138961E-07       WUTE     = 9.0155010E-08       PUTE     = -7.6784330E-14      
+UA1      = 2.0399999E-09       UB1      = -2.3428319E-18      LUB1     = 2.0287447E-25       
+WUB1     = -3.0101820E-26      PUB1     = 1.3061675E-31       UC1      = -2.2305425E-11      
+LUC1     = 2.3617550E-17       WUC1     = -5.7380370E-17      PUC1     = 4.4067530E-23       
+KT1L     = 0.00                PRT      = 0                   
+CJ       = cjn3                PB       = 0.7076023
+MJ       = 0.3259624           CJSW     = cjswn3              PBSW     = 0.7076023
+MJSW     = 0.1513672           CJSWG    = cjswgn3             PBSWG    = 0.7076023
+MJSWG    = 0.3513672           CGDO     = cgon3               CGSO     = cgon3
+TCJ      = 0.0009923959        TCJSW    = 0.0005019466        TCJSWG   = 0.0005019466   
+TPB      = 0.001687207         TPBSW    = 0.001687207         TPBSWG   = 0.001687207
+JS       = 3.93E-07            JSW      = 1.43E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   LLC      = -0.0165             NOIMOD  = 2
+NOIA     = 1.0E20		NOIB     = 4.0E04	       NOIC	= -4.0E-13
+EM       = 3.0E07		EF       = 0.881               )

.MODEL nch3.7 NMOS	(	LMIN     = '5.000E-07-dxl3'      LMAX     = '1.200E-06-dxl3'      
+WMIN     = '1.2000E-06-dxw3'                                WMAX     = '1.0000E-05-dxw3'      
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn3'           TOXM     = 'toxn3'           XJ       = 1.7000001E-07       
+NCH      = 5.2600000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 4.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 1.4999999E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn3'          RSH      = 'rshn3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.7882218+dvthn3'
+LVTH0    = 1.4420463E-08       WVTH0    = -2.7328070E-08      PVTH0    = 1.0125395E-14       
+K1       = 0.8741527           LK1      = 5.2337620E-08       WK1      = -1.5857541E-08      
+PK1      = -1.1638531E-14      K2       = 2.5716120E-02       LK2      = -2.7955116E-08      
+WK2      = 8.6687970E-09       PK2      = 6.3712410E-15       K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 9.4142860E04        LVSAT    = -1.2571429E-03      
+UA       = -5.5216260E-10      LUA      = -1.4134407E-16      WUA      = 1.7172625E-17       
+PUA      = -9.7485960E-24      UB       = 2.2626136E-18       LUB      = 1.5997525E-25       
+WUB      = -4.1164150E-25      PUB      = -5.6308880E-32      UC       = 8.8400200E-11       
+LUC      = 3.0847405E-17       WUC      = -1.6302085E-17      PUC      = -1.2113212E-23      
+RDSW     = 5.4500000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 4.1623130E-02       LU0      = 1.1891720E-09       
+WU0      = -4.4398320E-09      PU0      = 4.4061720E-16       A0       = 0.5080709           
+LA0      = 7.6268660E-08       WA0      = -7.8115730E-08      PA0      = 4.4293360E-14       
+KETA     = 3.3942350E-03       LKETA    = -1.5410004E-08      WKETA    = -3.1994660E-09      
+PKETA    = 3.4643260E-15       A1       = 0.00                A2       = 0.9900000           
+AGS      = 4.2857140E-02       LAGS     = -2.5142862E-08      B0       = 0.00                
+B1       = 0.00                VOFF     = -0.1178869          LVOFF    = 3.1917740E-09       
+WVOFF    = -2.2461877E-09      PVOFF    = 4.9191660E-15       NFACTOR  = 1.0000000           
+CIT      = 5.2714030E-04       LCIT     = -8.9688470E-12      WCIT     = -1.8216587E-12      
+PCIT     = 2.1602446E-18       CDSC     = 0.00                CDSCB    = 0.00                
+CDSCD    = 0.00                ETA0     = -1.9886503E-04      LETA0    = 2.7954594E-10       
+WETA0    = -8.3227900E-11      PETA0    = 3.3291270E-17       ETAB     = 1.9886503E-04       
+LETAB    = -2.7954594E-10      WETAB    = 8.3227900E-11       PETAB    = -3.3291270E-17      
+DSUB     = 0.00                PCLM     = 0.6760895           LPCLM    = 7.0287020E-09       
+WPCLM    = -7.7639390E-08      PPCLM    = 1.3315938E-13       PDIBLC1  = 1.0000000E-06       
+PDIBLC2  = 1.0042337E-03       LPDIBLC2 = -4.6571500E-12      WPDIBLC2 = -4.2211370E-11      
+PPDIBLC2 = 4.6432500E-17       PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                
+PSCBE1   = 3.0285712E08        LPSCBE1  = 18.8571820          PSCBE2   = 1.0000000E-06       
+PVAG     = 0.00                DELTA    = 1.0000000E-02       ALPHA0   = 0.0                 
+ALPHA1   = 7.049416            BETA0    = 21.5673             KT1      = -0.3071715          
+LKT1     = 1.8765444E-08       WKT1     = 1.2860058E-08       PKT1     = -1.4894836E-14      
+KT2      = -3.2976900E-02      LKT2     = 4.3053730E-09       WKT2     = 3.7026910E-09       
+PKT2     = -3.7901450E-15      AT       = 2.0000000E04        UTE      = -1.4001315          
+LUTE     = 1.4091844E-07       WUTE     = 1.5933820E-07       PUTE     = -1.5288584E-13      
+UA1      = 2.0399999E-09       UB1      = -2.7388682E-18      LUB1     = 6.3851440E-25       
+WUB1     = 6.0409630E-25       PUB1     = -5.6700110E-31      UC1      = -7.8913690E-11      
+LUC1     = 8.5886630E-17       WUC1     = 3.9538620E-17       PUC1     = -6.2543340E-23      
+KT1L     = 0.00                PRT      = 0                   
+CJ       = cjn3                PB       = 0.7076023
+MJ       = 0.3259624           CJSW     = cjswn3              PBSW     = 0.7076023
+MJSW     = 0.1513672           CJSWG    = cjswgn3             PBSWG    = 0.7076023
+MJSWG    = 0.3513672           CGDO     = cgon3               CGSO     = cgon3
+TCJ      = 0.0009923959        TCJSW    = 0.0005019466        TCJSWG   = 0.0005019466   
+TPB      = 0.001687207         TPBSW    = 0.001687207         TPBSWG   = 0.001687207
+JS       = 3.93E-07            JSW      = 1.43E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   LLC      = -0.0165             NOIMOD  = 2
+NOIA     = 1.0E20		NOIB     = 4.0E04	       NOIC	= -4.0E-13
+EM       = 3.0E07		EF       = 0.881               )

.MODEL nch3.8 NMOS	(	LMIN     = 3.5e-007                 LMAX     = '5.000E-07-dxl3'      
+WMIN     = '1.2000E-06-dxw3'                                WMAX     = '1.0000E-05-dxw3'      
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn3'           TOXM     = 'toxn3'           XJ       = 1.7000001E-07       
+NCH      = 5.2600000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 4.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 1.4999999E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn3'          RSH      = 'rshn3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.8659324+dvthn3'
+LVTH0    = -1.6663769E-08      WVTH0    = -2.9767808E-09      PVTH0    = 3.8488080E-16       
+K1       = 0.7465155           LK1      = 1.0339250E-07       WK1      = -8.4537670E-08      
+PK1      = 1.5833523E-14       K2       = 0.1900880           LK2      = -9.3703870E-08      
+WK2      = 4.6535320E-09       PK2      = 7.9773500E-15       K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 9.3130330E04        LVSAT    = -8.5213050E-04      
+WVSAT    = -4.6598160E-03      PVSAT    = 1.8639263E-09       UA       = -6.7444880E-10      
+LUA      = -9.2429640E-17      WUA      = -9.2701740E-16      PUA      = 3.6792740E-22       
+UB       = 2.1189834E-18       LUB      = 2.1742727E-25       WUB      = 5.1692720E-25       
+PUB      = -4.2773630E-31      UC       = 2.6250338E-10       LUC      = -3.8793870E-17      
+WUC      = -1.1458971E-16      PUC      = 2.7201846E-23       RDSW     = 5.4500000E02        
+PRWB     = 0.00                PRWG     = 0.00                WR       = 1.0000000           
+U0       = 4.3624590E-02       LU0      = 3.8858720E-10       WU0      = -9.7397600E-09      
+PU0      = 2.5605882E-15       A0       = 0.8771189           LA0      = -7.1350570E-08      
+WA0      = 1.2410786E-07       PA0      = -3.6596080E-14      KETA     = -5.3992410E-02      
+LKETA    = 7.5446550E-09       WKETA    = -4.2032270E-08      PKETA    = 1.8997448E-14       
+A1       = 0.00                A2       = 0.9900000           AGS      = -2.0000029E-02      
+B0       = 0.00                B1       = 0.00                VOFF     = -0.1004960          
+LVOFF    = -3.7645670E-09      WVOFF    = -4.5400990E-09      PVOFF    = 5.8367300E-15       
+NFACTOR  = 1.0000000           CIT      = 4.8816460E-04       LCIT     = 6.6214410E-12       
+WCIT     = 3.0312121E-11       PCIT     = -1.0693267E-17      CDSC     = 0.00                
+CDSCB    = 0.00                CDSCD    = 0.00                ETA0     = -1.1666667E-03      
+LETA0    = 6.6666660E-10       ETAB     = 3.7764110E-03       LETAB    = -1.7105642E-09      
+WETAB    = -1.1034047E-09      PETAB    = 4.4136180E-16       DSUB     = 0.00                
+PCLM     = -0.2024819          LPCLM    = 3.5845730E-07       WPCLM    = 5.9620970E-07       
+PPCLM    = -1.3638029E-13      PDIBLC1  = 1.0000000E-06       PDIBLC2  = -1.1344876E-02      
+LPDIBLC2 = 4.9349870E-09       WPDIBLC2 = 6.8173790E-09       PPDIBLC2 = -2.6974037E-15      
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 3.5000020E08        
+PSCBE2   = 1.0000000E-06       PVAG     = 0.00                DELTA    = 1.0000000E-02       
+ALPHA0   = 0.0                 ALPHA1   = 7.049416            BETA0    = 21.5673             
+KT1      = -0.2558013          LKT1     = -1.7826350E-09      WKT1     = -1.3100086E-07      
+PKT1     = 4.2649530E-14       KT2      = -1.8057920E-02      LKT2     = -1.6622183E-09      
+WKT2     = 1.0027706E-09       PKT2     = -2.7101770E-15      AT       = 2.0123486E04        
+LAT      = -4.9394840E-05      WAT      = -1.2311670E-03      PAT      = 4.9246680E-10       
+UTE      = -1.0240370          LUTE     = -9.5193410E-09      WUTE     = 1.8708050E-07       
+PUTE     = -1.6398275E-13      UA1      = 2.0380289E-09       LUA1     = 7.8843000E-19       
+WUA1     = 1.9651618E-17       PUA1     = -7.8606470E-24      UB1      = -1.5444776E-18      
+LUB1     = 1.6075813E-25       WUB1     = -5.8817450E-25      PUB1     = -9.0092720E-32      
+UC1      = 1.0033722E-10       LUC1     = 1.4186265E-17       WUC1     = -9.6220470E-17      
+PUC1     = -8.2396960E-24      KT1L     = 0.00                PRT      = 0                   
+CJ       = cjn3                PB       = 0.7076023
+MJ       = 0.3259624           CJSW     = cjswn3              PBSW     = 0.7076023
+MJSW     = 0.1513672           CJSWG    = cjswgn3             PBSWG    = 0.7076023
+MJSWG    = 0.3513672           CGDO     = cgon3               CGSO     = cgon3
+TCJ      = 0.0009923959        TCJSW    = 0.0005019466        TCJSWG   = 0.0005019466   
+TPB      = 0.001687207         TPBSW    = 0.001687207         TPBSWG   = 0.001687207
+JS       = 3.93E-07            JSW      = 1.43E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   LLC      = -0.0165             NOIMOD  = 2
+NOIA     = 1.0E20		NOIB     = 4.0E04	       NOIC	= -4.0E-13
+EM       = 3.0E07		EF       = 0.881               )

.MODEL nch3.9 NMOS	(	LMIN     = '1.000E-05-dxl3'      LMAX     = 20.001e-006              
+WMIN     = '5.0000E-07-dxw3'                                WMAX     = '1.2000E-06-dxw3'      
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn3'           TOXM     = 'toxn3'           XJ       = 1.7000001E-07       
+NCH      = 5.2600000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 4.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 1.4999999E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn3'          RSH      = 'rshn3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.7453005+dvthn3'
+WVTH0    = -5.3112130E-09      K1       = 0.8604288           WK1      = 7.1317190E-10       
+K2       = 3.3322110E-02       WK2      = 7.9219850E-12       K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 1.0000000E05        UA       = -6.8333380E-10      
+WUA      = 2.0756087E-17       UB       = 2.1833304E-18       WUB      = -1.2117484E-25      
+UC       = 9.6601420E-11       WUC      = -1.0976857E-17      RDSW     = 5.4500000E02        
+PRWB     = 0.00                PRWG     = 0.00                WR       = 1.0000000           
+U0       = 3.7005090E-02       WU0      = 1.2482622E-09       A0       = 0.6158070           
+WA0      = 1.4977592E-08       KETA     = 1.0741917E-02       WKETA    = -6.9461940E-10      
+A1       = 0.00                A2       = 0.9900000           AGS      = 2.0000000E-02       
+B0       = 0.00                B1       = 0.00                VOFF     = -0.1248287          
+WVOFF    = -9.6051810E-10      NFACTOR  = 1.0000000           CIT      = 1.9465643E-04       
+WCIT     = 1.4539148E-10       CDSC     = 0.00                CDSCB    = 0.00                
+CDSCD    = 0.00                ETA0     = 1.0000000E-05       ETAB     = -1.0000000E-05      
+DSUB     = 0.00                PCLM     = 0.5000000           PDIBLC1  = 1.0000000E-06       
+PDIBLC2  = 5.0000000E-04       PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                
+PSCBE1   = 2.0000000E08        PSCBE2   = 1.0000000E-06       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.0                 ALPHA1   = 7.049416            
+BETA0    = 21.5673             KT1      = -0.3068818          WKT1     = 5.2137960E-09       
+KT2      = -3.1908540E-02      WKT2     = 1.2880030E-09       AT       = 2.0000000E04        
+UTE      = -1.3297856          WUTE     = 2.5757439E-08       UA1      = 2.0399999E-09       
+UB1      = -2.2946240E-18      WUB1     = -4.9335480E-26      UC1      = -4.8472800E-11      
+WUC1     = -1.9522108E-17      KT1L     = 0.00                PRT      = 0                   
+CJ       = cjn3                PB       = 0.7076023
+MJ       = 0.3259624           CJSW     = cjswn3              PBSW     = 0.7076023
+MJSW     = 0.1513672           CJSWG    = cjswgn3             PBSWG    = 0.7076023
+MJSWG    = 0.3513672           CGDO     = cgon3               CGSO     = cgon3
+TCJ      = 0.0009923959        TCJSW    = 0.0005019466        TCJSWG   = 0.0005019466   
+TPB      = 0.001687207         TPBSW    = 0.001687207         TPBSWG   = 0.001687207
+JS       = 3.93E-07            JSW      = 1.43E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   LLC      = -0.0165             NOIMOD  = 2
+NOIA     = 1.0E20		NOIB     = 4.0E04	       NOIC	= -4.0E-13
+EM       = 3.0E07		EF       = 0.881               )

.MODEL nch3.10 NMOS	(	LMIN     = '1.200E-06-dxl3'      LMAX     = '1.000E-05-dxl3'      
+WMIN     = '5.0000E-07-dxw3'                                WMAX     = '1.2000E-06-dxw3'      
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn3'           TOXM     = 'toxn3'           XJ       = 1.7000001E-07       
+NCH      = 5.2600000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 4.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 1.4999999E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn3'          RSH      = 'rshn3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.7392390+dvthn3'
+LVTH0    = 6.0008470E-08       WVTH0    = -4.8123240E-09      PVTH0    = -4.9390020E-15      
+K1       = 0.8554150           LK1      = 4.9636120E-08       WK1      = 1.0075173E-09       
+PK1      = -2.9140208E-15      K2       = 3.5897850E-02       LK2      = -2.5499832E-08      
+WK2      = 1.6827269E-11       PK2      = -8.8160490E-17      K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 1.0087500E05        LVSAT    = -8.6625000E-03      
+UA       = -6.8346730E-10      LUA      = 1.3221220E-18       WUA      = 2.2076628E-17       
+PUA      = -1.3073367E-23      UB       = 2.1908280E-18       LUB      = -7.4224610E-26      
+WUB      = -1.2010437E-25      PUB      = -1.0597751E-32      UC       = 9.5323490E-11       
+LUC      = 1.2651537E-17       WUC      = -1.0341395E-17      PUC      = -6.2910760E-24      
+RDSW     = 5.4500000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 3.6837630E-02       LU0      = 1.6578280E-09       
+WU0      = 1.2716347E-09       PU0      = -2.3138870E-16      A0       = 0.6236824           
+LA0      = -7.7966580E-08      WA0      = 1.7982831E-08       PA0      = -2.9751866E-14      
+KETA     = 1.3718577E-02       LKETA    = -2.9468925E-08      WKETA    = -1.1344492E-09      
+PKETA    = 4.3543190E-15       A1       = 0.00                A2       = 0.9900000           
+AGS      = 2.0000000E-02       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1265495          LVOFF    = 1.7036285E-08       WVOFF    = -7.8502870E-10      
+PVOFF    = -1.7373450E-15      NFACTOR  = 1.0000000           CIT      = 1.5283188E-04       
+LCIT     = 4.1406270E-10       WCIT     = 1.6504902E-10       PCIT     = -1.9460947E-16      
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = 1.0000000E-05       ETAB     = -1.0000000E-05      DSUB     = 0.00                
+PCLM     = 0.4768089           LPCLM    = 2.2959227E-07       WPCLM    = -4.9807780E-09      
+PPCLM    = 4.9309700E-14       PDIBLC1  = 1.0000000E-06       PDIBLC2  = 4.3750000E-04       
+LPDIBLC2 = 6.1875000E-10       PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                
+PSCBE1   = 1.8500000E08        LPSCBE1  = 1.4850000E02        PSCBE2   = 1.0000000E-06       
+PVAG     = 0.00                DELTA    = 1.0000000E-02       ALPHA0   = 0.0                 
+ALPHA1   = 7.049416            BETA0    = 21.5673             KT1      = -0.3090271          
+LKT1     = 2.1238611E-08       WKT1     = 6.0080370E-09       PKT1     = -7.8629890E-15      
+KT2      = -3.2233010E-02      LKT2     = 3.2122820E-09       WKT2     = 1.3803272E-09       
+PKT2     = -9.1400860E-16      AT       = 2.0000000E04        UTE      = -1.3385403          
+LUTE     = 8.6671380E-08       WUTE     = 2.8228550E-08       PUTE     = -2.4463984E-14      
+UA1      = 2.0399999E-09       UB1      = -2.3244689E-18      LUB1     = 2.9546524E-25       
+WUB1     = -5.1586550E-26      PUB1     = 2.2285513E-32       UC1      = -5.3462490E-11      
+LUC1     = 4.9397990E-17       WUC1     = -2.0926594E-17      PUC1     = 1.3904406E-23       
+KT1L     = 0.00                PRT      = 0                   
+CJ       = cjn3                PB       = 0.7076023
+MJ       = 0.3259624           CJSW     = cjswn3              PBSW     = 0.7076023
+MJSW     = 0.1513672           CJSWG    = cjswgn3             PBSWG    = 0.7076023
+MJSWG    = 0.3513672           CGDO     = cgon3               CGSO     = cgon3
+TCJ      = 0.0009923959        TCJSW    = 0.0005019466        TCJSWG   = 0.0005019466   
+TPB      = 0.001687207         TPBSW    = 0.001687207         TPBSWG   = 0.001687207
+JS       = 3.93E-07            JSW      = 1.43E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   LLC      = -0.0165             NOIMOD  = 2
+NOIA     = 1.0E20		NOIB     = 4.0E04	       NOIC	= -4.0E-13
+EM       = 3.0E07		EF       = 0.881               )

.MODEL nch3.11 NMOS	(	LMIN     = '5.000E-07-dxl3'      LMAX     = '1.200E-06-dxl3'      
+WMIN     = '5.0000E-07-dxw3'                                WMAX     = '1.2000E-06-dxw3'      
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn3'           TOXM     = 'toxn3'           XJ       = 1.7000001E-07       
+NCH      = 5.2600000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 4.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 1.4999999E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn3'          RSH      = 'rshn3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.7679389+dvthn3'
+LVTH0    = 2.8438597E-08       WVTH0    = -3.5970320E-09      PVTH0    = -6.2758240E-15      
+K1       = 0.8724138           LK1      = 3.0937503E-08       WK1      = -1.3823059E-08      
+PK1      = 1.3399614E-14       K2       = 2.7055200E-02       LK2      = -1.5772912E-08      
+WK2      = 7.1020800E-09       PK2      = -7.8819390E-15      K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 9.4142860E04        LVSAT    = -1.2571429E-03      
+UA       = -5.2107010E-10      LUA      = -1.7731486E-16      WUA      = -1.9205736E-17      
+PUA      = 3.2337230E-23       UB       = 1.9324246E-18       LUB      = 2.1001913E-25       
+WUB      = -2.5320272E-26      PUB      = -1.1486027E-31      UC       = 7.7848640E-11       
+LUC      = 3.1873880E-17       WUC      = -3.9567560E-18      PUC      = -1.3314180E-23      
+RDSW     = 5.4500000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 3.6962610E-02       LU0      = 1.5203439E-09       
+WU0      = 1.0129666E-09       PU0      = 5.3146080E-17       A0       = 0.4526256           
+LA0      = 1.1019587E-07       WA0      = -1.3244798E-08      PA0      = 4.5985210E-15       
+KETA     = 1.3228342E-03       LKETA    = -1.5833610E-08      WKETA    = -7.7593030E-10      
+PKETA    = 3.9599480E-15       A1       = 0.00                A2       = 0.9900000           
+AGS      = 4.2857150E-02       LAGS     = -2.5142864E-08      B0       = 0.00                
+B1       = 0.00                VOFF     = -0.1177271          LVOFF    = 7.3315800E-09       
+WVOFF    = -2.4331537E-09      PVOFF    = 7.5592520E-17       NFACTOR  = 1.0000000           
+CIT      = 5.4556720E-04       LCIT     = -1.7946093E-11      WCIT     = -2.3381097E-11      
+PCIT     = 1.2663624E-17       CDSC     = 0.00                CDSCB    = 0.00                
+CDSCD    = 0.00                ETA0     = -2.6999993E-04      LETA0    = 3.0799999E-10       
+ETAB     = 2.6999993E-04       LETAB    = -3.0799999E-10      DSUB     = 0.00                
+PCLM     = 0.6877513           LPCLM    = -2.4444284E-09      WPCLM    = -9.1283720E-08      
+PPCLM    = 1.4424296E-13       PDIBLC1  = 1.0000000E-06       PDIBLC2  = 1.3304478E-03       
+LPDIBLC2 = -3.6349270E-10      WPDIBLC2 = -4.2388190E-10      PPDIBLC2 = 4.6627010E-16       
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 3.0285712E08        
+LPSCBE1  = 18.8571820          PSCBE2   = 1.0000000E-06       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.0                 ALPHA1   = 7.049416            
+BETA0    = 21.5673             KT1      = -0.2803507          LKT1     = -1.0305442E-08      
+WKT1     = -1.8520229E-08      PKT1     = 1.9118106E-14       KT2      = -2.7456122E-02      
+LKT2     = -2.0422997E-09      WKT2     = -2.7566189E-09      PKT2     = 3.6366320E-15       
+AT       = 2.0000000E04        UTE      = -1.2687004          LUTE     = 9.8474450E-09       
+WUTE     = 5.5637800E-09       PUTE     = 4.6726310E-16       UA1      = 2.0399999E-09       
+UB1      = -2.1894782E-18      LUB1     = 1.4697553E-25       WUB1     = -3.8690170E-26      
+PUB1     = 8.0994940E-33       UC1      = -3.5313570E-11      LUC1     = 2.9434180E-17       
+WUC1     = -1.1473530E-17      PUC1     = 3.5060390E-24       KT1L     = 0.00                
+PRT      = 0                   CJ       = cjn3                PB       = 0.7076023
+MJ       = 0.3259624           CJSW     = cjswn3              PBSW     = 0.7076023
+MJSW     = 0.1513672           CJSWG    = cjswgn3             PBSWG    = 0.7076023
+MJSWG    = 0.3513672           CGDO     = cgon3               CGSO     = cgon3
+TCJ      = 0.0009923959        TCJSW    = 0.0005019466        TCJSWG   = 0.0005019466   
+TPB      = 0.001687207         TPBSW    = 0.001687207         TPBSWG   = 0.001687207
+JS       = 3.93E-07            JSW      = 1.43E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   LLC      = -0.0165             NOIMOD  = 2
+NOIA     = 1.0E20		NOIB     = 4.0E04	       NOIC	= -4.0E-13
+EM       = 3.0E07		EF       = 0.881               )

.MODEL nch3.12 NMOS	(	LMIN     = 3.5e-007                 LMAX     = '5.000E-07-dxl3'      
+WMIN     = '5.0000E-07-dxw3'                                WMAX     = '1.2000E-06-dxw3'      
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn3'           TOXM     = 'toxn3'           XJ       = 1.7000001E-07       
+NCH      = 5.2600000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 4.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 1.4999999E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn3'          RSH      = 'rshn3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.9005772+dvthn3'
+LVTH0    = -2.4616741E-08      WVTH0    = -4.3511230E-08      PVTH0    = 9.6898540E-15       
+K1       = 0.6045249           LK1      = 1.3809307E-07       WK1      = 8.1591280E-08       
+PK1      = -2.4766122E-14      K2       = 0.2179352           LK2      = -9.2124900E-08      
+WK2      = -2.7927635E-08      PK2      = 6.1299460E-15       K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 9.2204430E04        LVSAT    = -4.8177310E-04      
+WVSAT    = -3.5765190E-03      PVSAT    = 1.4306075E-09       UA       = -1.5704804E-09      
+LUA      = 2.4244926E-16       WUA      = 1.2133967E-16       PUA      = -2.3880921E-23      
+UB       = 2.4269640E-18       LUB      = 1.2203315E-26       WUB      = 1.5658978E-25       
+PUB      = -1.8762427E-31      UC       = 1.6513216E-10       LUC      = -3.0395374E-18      
+WUC      = -6.6537900E-19      PUC      = -1.4630729E-23      RDSW     = 5.4500000E02        
+PRWB     = 0.00                PRWG     = 0.00                WR       = 1.0000000           
+U0       = 3.7385670E-02       LU0      = 1.3511215E-09       WU0      = -2.4402242E-09      
+PU0      = 1.4344223E-15       A0       = 0.8126235           LA0      = -3.3803300E-08      
+WA0      = 1.9956742E-07       PA0      = -8.0526360E-14      KETA     = -0.1224256          
+LKETA    = 3.3665760E-08       WKETA    = 3.8034560E-08       PKETA    = -1.1564247E-14      
+A1       = 0.00                A2       = 0.9900000           AGS      = -1.6226115E-02      
+LAGS     = -1.5095589E-09      WAGS     = -4.4154800E-09      PAGS     = 1.7661922E-15       
+B0       = 0.00                B1       = 0.00                VOFF     = -9.9843290E-02      
+LVOFF    = 1.7806077E-10       WVOFF    = -5.3038090E-09      PVOFF    = 1.2238547E-15       
+NFACTOR  = 1.0000000           CIT      = 4.9520520E-04       LCIT     = 2.1987145E-12       
+WCIT     = 2.2074649E-11       PCIT     = -5.5186740E-18      CDSC     = 0.00                
+CDSCB    = 0.00                CDSCD    = 0.00                ETA0     = -1.1666662E-03      
+LETA0    = 6.6666650E-10       ETAB     = 2.8333291E-03       LETAB    = -1.3333316E-09      
+DSUB     = 0.00                PCLM     = -4.2756410E-02      LPCLM    = 2.8975865E-07       
+WPCLM    = 4.0933080E-07       PPCLM    = -5.6002840E-14      PDIBLC1  = 1.0000000E-06       
+PDIBLC2  = -7.2087520E-03      LPDIBLC2 = 3.0521874E-09       WPDIBLC2 = 1.9781137E-09       
+PPDIBLC2 = -4.9452820E-16      PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                
+PSCBE1   = 3.5000020E08        PSCBE2   = 1.0000000E-06       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.0                 ALPHA1   = 7.049416            
+BETA0    = 21.5673             KT1      = -0.4885682          LKT1     = 7.2981510E-08       
+WKT1     = 1.4133636E-07       PKT1     = -4.4824520E-14      KT2      = -2.8753173E-02      
+LKT2     = -1.5234798E-09      WKT2     = 1.3516213E-08       PKT2     = -2.8725001E-15      
+AT       = 3.0581551E04        LAT      = -4.2326190E-03      WAT      = -1.3467096E-02      
+PAT      = 5.3868380E-09       UTE      = -0.7753763          LUTE     = -1.8748216E-07      
+WUTE     = -1.0385240E-07      PUTE     = 4.4233730E-14       UA1      = 1.7494718E-09       
+LUA1     = 1.1621127E-16       WUA1     = 3.5726330E-16       PUA1     = -1.4290532E-22      
+UB1      = -1.3971897E-18      LUB1     = -1.6993981E-25      WUB1     = -7.6050110E-25      
+PUB1     = 2.9682384E-31       UC1      = 6.9721260E-11       LUC1     = -1.2579750E-17      
+WUC1     = -6.0399780E-17      PUC1     = 2.3076537E-23       KT1L     = 0.00                
+PRT      = 0                   CJ       = cjn3                PB       = 0.7076023
+MJ       = 0.3259624           CJSW     = cjswn3              PBSW     = 0.7076023
+MJSW     = 0.1513672           CJSWG    = cjswgn3             PBSWG    = 0.7076023
+MJSWG    = 0.3513672           CGDO     = cgon3               CGSO     = cgon3
+TCJ      = 0.0009923959        TCJSW    = 0.0005019466        TCJSWG   = 0.0005019466   
+TPB      = 0.001687207         TPBSW    = 0.001687207         TPBSWG   = 0.001687207
+JS       = 3.93E-07            JSW      = 1.43E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   LLC      = -0.0165             NOIMOD  = 2
+NOIA     = 1.0E20		NOIB     = 4.0E04	       NOIC	= -4.0E-13
+EM       = 3.0E07		EF       = 0.881               )

.MODEL nch3.13 NMOS	(	LMIN     = '1.000E-05-dxl3'      LMAX     = 20.001e-006              
+WMIN     = 2.2e-007                                           WMAX     = '5.0000E-07-dxw3'      
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn3'           TOXM     = 'toxn3'           XJ       = 1.7000001E-07       
+NCH      = 5.2600000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 4.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 1.4999999E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn3'          RSH      = 'rshn3'           RD       = 0                   
+RS       = 0                                     
+VTH0     = '0.7828572+dvthn3'
+WVTH0    = -2.2962862E-08      K1       = 0.8670291           WK1      = -2.3889963E-09      
+K2       = 3.3539240E-02       WK2      = -9.4124950E-11      K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 1.0000000E05        UA       = -7.5109630E-10      
+WUA      = 5.2604480E-17       UB       = 2.0614427E-18       WUB      = -6.3887530E-26      
+UC       = 9.9038940E-11       WUC      = -1.2122493E-17      RDSW     = 5.4500000E02        
+PRWB     = 0.00                PRWG     = 0.00                WR       = 1.0000000           
+U0       = 3.6716620E-02       WU0      = 1.3838430E-09       A0       = 0.6640292           
+WA0      = -7.6868640E-09      KETA     = 1.4611328E-02       WKETA    = -2.5132423E-09      
+A1       = 0.00                A2       = 0.9900000           AGS      = 2.0000000E-02       
+B0       = 0.00                B1       = 0.00                VOFF     = -0.1274730          
+WVOFF    = 2.8231190E-10       NFACTOR  = 1.0000000           CIT      = 5.0400000E-04       
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = 1.0000000E-05       ETAB     = -1.0000000E-05      DSUB     = 0.00                
+PCLM     = 0.5000000           PDIBLC1  = 1.0000000E-06       PDIBLC2  = 5.0000000E-04       
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 2.0000000E08        
+PSCBE2   = 1.0000000E-06       PVAG     = 0.00                DELTA    = 1.0000000E-02       
+ALPHA0   = 0.0                 ALPHA1   = 7.049416            BETA0    = 21.5673             
+KT1      = -0.2971856          WKT1     = 6.5657340E-10       KT2      = -2.7439827E-02      
+WKT2     = -8.1229250E-10      AT       = 2.0000000E04        UTE      = -1.2430322          
+WUTE     = -1.5016651E-08      UA1      = 2.0399999E-09       UB1      = -2.1566485E-18      
+WUB1     = -1.1418396E-25      UC1      = -5.2926640E-11      WUC1     = -1.7428805E-17      
+KT1L     = 0.00                PRT      = 0                   
+CJ       = cjn3                PB       = 0.7076023
+MJ       = 0.3259624           CJSW     = cjswn3              PBSW     = 0.7076023
+MJSW     = 0.1513672           CJSWG    = cjswgn3             PBSWG    = 0.7076023
+MJSWG    = 0.3513672           CGDO     = cgon3               CGSO     = cgon3
+TCJ      = 0.0009923959        TCJSW    = 0.0005019466        TCJSWG   = 0.0005019466   
+TPB      = 0.001687207         TPBSW    = 0.001687207         TPBSWG   = 0.001687207
+JS       = 3.93E-07            JSW      = 1.43E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   LLC      = -0.0165             NOIMOD  = 2
+NOIA     = 1.0E20		NOIB     = 4.0E04	       NOIC	= -4.0E-13
+EM       = 3.0E07		EF       = 0.881               )

.MODEL nch3.14 NMOS	(	LMIN     = '1.200E-06-dxl3'      LMAX     = '1.000E-05-dxl3'      
+WMIN     = 2.2e-007                                           WMAX     = '5.0000E-07-dxw3'      
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn3'           TOXM     = 'toxn3'           XJ       = 1.7000001E-07       
+NCH      = 5.2600000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 4.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 1.4999999E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn3'          RSH      = 'rshn3'           RD       = 0                   
+RS       = 0                                     
+VTH0     = '0.7804866+dvthn3'
+LVTH0    = 2.3468242E-08       WVTH0    = -2.4198712E-08      PVTH0    = 1.2234904E-14       
+K1       = 0.8636016           LK1      = 3.3932720E-08       WK1      = -2.8401654E-09      
+PK1      = 4.4665790E-15       K2       = 3.5084160E-02       LK2      = -1.5294709E-08      
+WK2      = 3.9926540E-10       PK2      = -4.8845690E-15      K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 1.0087500E05        LVSAT    = -8.6625000E-03      
+UA       = -7.5848670E-10      LUA      = 7.3164600E-17       WUA      = 5.7335730E-17       
+PUA      = -4.6839330E-23      UB       = 2.0926081E-18       LUB      = -3.0854041E-25      
+WUB      = -7.3941130E-26      PUB      = 9.9530690E-32       UC       = 1.0056940E-10       
+LUC      = -1.5151562E-17      WUC      = -1.2806976E-17      PUC      = 6.7763810E-24       
+RDSW     = 5.4500000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 3.7054640E-02       LU0      = -3.3465050E-09      
+WU0      = 1.1696366E-09       PU0      = 2.1206480E-15       A0       = 0.6665249           
+LA0      = -2.4707576E-08      WA0      = -2.1531732E-09      PA0      = -5.4783600E-14      
+KETA     = 1.5772361E-02       LKETA    = -1.1494187E-08      WKETA    = -2.0997273E-09      
+PKETA    = -4.0938080E-15      A1       = 0.00                A2       = 0.9900000           
+AGS      = 2.0000000E-02       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1297337          LVOFF    = 2.2381130E-08       WVOFF    = 7.1154630E-10       
+PVOFF    = -4.2494230E-15      NFACTOR  = 1.0000000           CIT      = 5.0400000E-04       
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = 1.0000000E-05       ETAB     = -1.0000000E-05      DSUB     = 0.00                
+PCLM     = 0.4717489           LPCLM    = 2.7968576E-07       WPCLM    = -2.6026028E-09      
+PPCLM    = 2.5765768E-14       PDIBLC1  = 1.0000000E-06       PDIBLC2  = 4.3750000E-04       
+LPDIBLC2 = 6.1874990E-10       PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                
+PSCBE1   = 1.8500000E08        LPSCBE1  = 1.4850000E02        PSCBE2   = 1.0000000E-06       
+PVAG     = 0.00                DELTA    = 1.0000000E-02       ALPHA0   = 0.0                 
+ALPHA1   = 7.049416            BETA0    = 21.5673             KT1      = -0.2951206          
+LKT1     = -2.0443341E-08      WKT1     = -5.2802380E-10      PKT1     = 1.1727529E-14       
+KT2      = -2.7106613E-02      LKT2     = -3.2988250E-09      WKT2     = -1.0290813E-09      
+PKT2     = 2.1462119E-15       AT       = 2.0000000E04        UTE      = -1.2394767          
+LUTE     = -3.5199690E-08      WUTE     = -1.8331338E-08      PUTE     = 3.2815420E-14       
+UA1      = 2.0399999E-09       UB1      = -2.1723405E-18      LUB1     = 1.5535091E-25       
+WUB1     = -1.2308690E-25      PUB1     = 8.8139250E-32       UC1      = -5.9918290E-11      
+LUC1     = 6.9217410E-17       WUC1     = -1.7892370E-17      PUC1     = 4.5892800E-24       
+KT1L     = 0.00                PRT      = 0                   
+CJ       = cjn3                PB       = 0.7076023
+MJ       = 0.3259624           CJSW     = cjswn3              PBSW     = 0.7076023
+MJSW     = 0.1513672           CJSWG    = cjswgn3             PBSWG    = 0.7076023
+MJSWG    = 0.3513672           CGDO     = cgon3               CGSO     = cgon3
+TCJ      = 0.0009923959        TCJSW    = 0.0005019466        TCJSWG   = 0.0005019466   
+TPB      = 0.001687207         TPBSW    = 0.001687207         TPBSWG   = 0.001687207
+JS       = 3.93E-07            JSW      = 1.43E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   LLC      = -0.0165             NOIMOD  = 2
+NOIA     = 1.0E20		NOIB     = 4.0E04	       NOIC	= -4.0E-13
+EM       = 3.0E07		EF       = 0.881               )

.MODEL nch3.15 NMOS	(	LMIN     = '5.000E-07-dxl3'      LMAX     = '1.200E-06-dxl3'      
+WMIN     = 2.2e-007                                           WMAX     = '5.0000E-07-dxw3'      
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn3'           TOXM     = 'toxn3'           XJ       = 1.7000001E-07       
+NCH      = 5.2600000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 4.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 1.4999999E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn3'          RSH      = 'rshn3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.7807397+dvthn3'
+LVTH0    = 2.3189909E-08       WVTH0    = -9.6134030E-09      PVTH0    = -3.8089400E-15      
+K1       = 0.7736582           LK1      = 1.3287044E-07       WK1      = 3.2592050E-08       
+PK1      = -3.4508860E-14      K2       = 6.4881680E-02       LK2      = -4.8071990E-08      
+WK2      = -1.0676364E-08      PK2      = 7.2986250E-15       K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 9.4142860E04        LVSAT    = -1.2571429E-03      
+UA       = -5.9941190E-10      LUA      = -1.0181772E-16      WUA      = 1.7614915E-17       
+PUA      = -3.1464334E-24      UB       = 1.5764261E-18       LUB      = 2.5926002E-25       
+WUB      = 1.4199901E-25       PUB      = -1.3800350E-31      UC       = 4.5846500E-11       
+LUC      = 4.5043640E-17       WUC      = 1.1084252E-17       PUC      = -1.9503975E-23      
+RDSW     = 5.4500000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 3.1034408E-02       LU0      = 3.2757530E-09       
+WU0      = 3.7992220E-09       PU0      = -7.7189640E-16      A0       = 0.4857765           
+LA0      = 1.7411581E-07       WA0      = -2.8825673E-08      PA0      = -2.5443860E-14      
+KETA     = 2.5973169E-02       LKETA    = -2.2715076E-08      WKETA    = -1.2361587E-08      
+PKETA    = 7.1942380E-15       A1       = 0.00                A2       = 0.9900000           
+AGS      = 4.2857150E-02       LAGS     = -2.5142864E-08      B0       = 0.00                
+B1       = 0.00                VOFF     = -0.1085447          LVOFF    = -9.2680400E-10      
+WVOFF    = -6.7488680E-09      PVOFF    = 3.9570330E-15       NFACTOR  = 1.0000000           
+CIT      = 5.4827290E-04       LCIT     = -4.8700200E-11      WCIT     = -2.4652778E-11      
+PCIT     = 2.7118061E-17       CDSC     = 0.00                CDSCB    = 0.00                
+CDSCD    = 0.00                ETA0     = -2.7000002E-04      LETA0    = 3.0800001E-10       
+ETAB     = 2.7000002E-04       LETAB    = -3.0800001E-10      DSUB     = 0.00                
+PCLM     = 0.6242409           LPCLM    = 1.1194462E-07       WPCLM    = -6.1433820E-08      
+PPCLM    = 9.0480110E-14       PDIBLC1  = 1.0000000E-06       PDIBLC2  = 4.2857150E-04       
+LPDIBLC2 = 6.2857140E-10       PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                
+PSCBE1   = 3.0285712E08        LPSCBE1  = 18.8571830          PSCBE2   = 1.0000000E-06       
+PVAG     = 0.00                DELTA    = 1.0000000E-02       ALPHA0   = 0.0                 
+ALPHA1   = 7.049416            BETA0    = 21.5673             KT1      = -0.3598902          
+LKT1     = 5.0803170E-08       WKT1     = 1.8863313E-08       PKT1     = -9.6029440E-15      
+KT2      = -3.7711450E-02      LKT2     = 8.3664990E-09       WKT2     = 2.0633864E-09       
+PKT2     = -1.2555028E-15      AT       = 2.0000000E04        UTE      = -1.3677146          
+LUTE     = 1.0586200E-07       WUTE     = 5.2100470E-08       PUTE     = -4.4659580E-14      
+UA1      = 2.0399999E-09       UB1      = -2.1250930E-18      LUB1     = 1.0337858E-25       
+WUB1     = -6.8951290E-26      PUB1     = 2.8590071E-32       UC1      = -3.6162200E-12      
+LUC1     = 7.2851270E-18       WUC1     = -2.6371291E-17      PUC1     = 1.3916098E-23       
+KT1L     = 0.00                PRT      = 0                   
+CJ       = cjn3                PB       = 0.7076023
+MJ       = 0.3259624           CJSW     = cjswn3              PBSW     = 0.7076023
+MJSW     = 0.1513672           CJSWG    = cjswgn3             PBSWG    = 0.7076023
+MJSWG    = 0.3513672           CGDO     = cgon3               CGSO     = cgon3
+TCJ      = 0.0009923959        TCJSW    = 0.0005019466        TCJSWG   = 0.0005019466   
+TPB      = 0.001687207         TPBSW    = 0.001687207         TPBSWG   = 0.001687207
+JS       = 3.93E-07            JSW      = 1.43E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   LLC      = -0.0165             NOIMOD  = 2
+NOIA     = 1.0E20		NOIB     = 4.0E04	       NOIC	= -4.0E-13
+EM       = 3.0E07		EF       = 0.881               )

.MODEL nch3.16 NMOS	(	LMIN     = 3.5e-007                 LMAX     = '5.000E-07-dxl3'      
+WMIN     = 2.2e-007                                           WMAX     = '5.0000E-07-dxw3'      
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxn3'           TOXM     = 'toxn3'           XJ       = 1.7000001E-07       
+NCH      = 5.2600000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 4.0000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 1.4999999E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifn3'          RSH      = 'rshn3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '0.8306194+dvthn3'
+LVTH0    = 3.2380310E-09       WVTH0    = -1.0631036E-08      PVTH0    = -3.4018870E-15      
+K1       = 1.0625753           LK1      = 1.7303593E-08       WK1      = -1.3369242E-07      
+PK1      = 3.2004920E-14       K2       = 0.1064665           LK2      = -6.4705920E-08      
+WK2      = 2.4462622E-08       PK2      = -6.7569720E-15      K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 9.3605550E04        LVSAT    = -1.0422204E-03      
+WVSAT    = -4.2350440E-03      PVSAT    = 1.6940175E-09       UA       = 6.7111770E-11       
+LUA      = -3.6842710E-16      WUA      = -6.4832840E-16      PUA      = 2.6323089E-22       
+UB       = 1.2076053E-18       LUB      = 4.0678830E-25       WUB      = 7.2968810E-25       
+PUB      = -3.7307910E-31      UC       = 1.8743894E-10       LUC      = -1.1593328E-17      
+WUC      = -1.1149585E-17      PUC      = -1.0610441E-23      RDSW     = 5.4500000E02        
+PRWB     = 0.00                PRWG     = 0.00                WR       = 1.0000000           
+U0       = 5.3736130E-02       LU0      = -5.8049360E-09      WU0      = -1.0124940E-08      
+PU0      = 4.7977680E-15       A0       = 1.0752125           LA0      = -6.1658620E-08      
+WA0      = 7.6150530E-08       PA0      = -6.7434340E-14      KETA     = -9.2701760E-02      
+LKETA    = 2.4754891E-08       WKETA    = 2.4064352E-08       PKETA    = -7.3761370E-15      
+A1       = 0.00                A2       = 0.9900000           AGS      = 1.0422147E-02       
+LAGS     = -1.2168864E-08      WAGS     = -1.6940159E-08      PAGS     = 6.7760640E-15       
+B0       = 0.00                B1       = 0.00                VOFF     = -0.1289647          
+LVOFF    = 7.2411770E-09       WVOFF    = 8.3832410E-09       PVOFF    = -2.0958096E-15      
+NFACTOR  = 1.0000000           CIT      = 2.9739301E-04       LCIT     = 5.1651740E-11       
+WCIT     = 1.1504635E-10       PCIT     = -2.8761589E-17      CDSC     = 0.00                
+CDSCB    = 0.00                CDSCD    = 0.00                ETA0     = -1.1666659E-03      
+LETA0    = 6.6666640E-10       ETAB     = 2.8333315E-03       LETAB    = -1.3333327E-09      
+DSUB     = 0.00                PCLM     = 0.5943905           LPCLM    = 1.2388473E-07       
+WPCLM    = 1.0987172E-07       PPCLM    = 2.1957893E-14       PDIBLC1  = 1.0000000E-06       
+PDIBLC2  = -2.9999996E-03      LPDIBLC2 = 1.9999999E-09       PDIBLCB  = 1.0000000E-02       
+DROUT    = 0.00                PSCBE1   = 3.5000020E08        PSCBE2   = 1.0000000E-06       
+PVAG     = 0.00                DELTA    = 1.0000000E-02       ALPHA0   = 0.0                 
+ALPHA1   = 7.049416            BETA0    = 21.5673             KT1      = -0.1415831          
+LKT1     = -3.6519680E-08      WKT1     = -2.1746652E-08      PKT1     = 6.6410420E-15       
+KT2      = 3.7919310E-03       LKT2     = -8.2348550E-09      WKT2     = -1.7799852E-09      
+PKT2     = 2.8184582E-16       AT       = 1.0938882E04        LAT      = 3.6244480E-03       
+WAT      = -4.2350400E-03      PAT      = 1.6940163E-09       UTE      = -0.9606272          
+LUTE     = -5.6972970E-08      WUTE     = -1.6784552E-08      PUTE     = -1.7105571E-14      
+UA1      = 1.2040989E-09       LUA1     = 3.3436030E-16       WUA1     = 6.1358830E-16       
+PUA1     = -2.4543530E-22      UB1      = -5.2839440E-19      LUB1     = -5.3530060E-25      
+WUB1     = -1.1688345E-24      PUB1     = 4.6854330E-31       UC1      = 6.8918580E-11       
+LUC1     = -2.1728796E-17      WUC1     = -6.0022500E-17      PUC1     = 2.7376582E-23       
+KT1L     = 0.00                PRT      = 0                   
+CJ       = cjn3                PB       = 0.7076023
+MJ       = 0.3259624           CJSW     = cjswn3              PBSW     = 0.7076023
+MJSW     = 0.1513672           CJSWG    = cjswgn3             PBSWG    = 0.7076023
+MJSWG    = 0.3513672           CGDO     = cgon3               CGSO     = cgon3
+TCJ      = 0.0009923959        TCJSW    = 0.0005019466        TCJSWG   = 0.0005019466   
+TPB      = 0.001687207         TPBSW    = 0.001687207         TPBSWG   = 0.001687207
+JS       = 3.93E-07            JSW      = 1.43E-12
+N        = 1                   XTI      = 3                   CAPMOD   = 3
+NQSMOD   = 0                   XPART    = 1                   CF       = 0
+TLEV     = 1                   TLEVC    = 1                   CALCACM  = 1
+SFVTFLAG = 0                   LLC      = -0.0165             NOIMOD  = 2
+NOIA     = 1.0E20		NOIB     = 4.0E04	       NOIC	= -4.0E-13
+EM       = 3.0E07		EF       = 0.881               )

*******************************************************************************************
*                                                                                         *
*                              3.3V I/O PMOS DEVICE MODELS                                *
*                                                                                         *
*******************************************************************************************

.MODEL pch3.1 PMOS	(	LMIN     = '1.000E-05-dxl3'      LMAX     = 20.001e-006              
+WMIN     = '1.0000E-05-dxw3'                                WMAX     = 900.001e-6               
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp3'           TOXM     = 'toxp3'           XJ       = 1.7000001E-07       
+NCH      = 4.9500000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 3.5000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 2.0000000E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp3'          RSH      = 'rshp3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.6977456+dvthp3'
+K1       = 0.8513944           K2       = 7.3231060E-02       K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 1.5000002E05        UA       = 1.6792380E-09       
+UB       = 2.7609050E-19       UC       = -1.0631042E-10      RDSW     = 9.0000000E02        
+PRWB     = 0.00                PRWG     = 0.00                WR       = 1.0000000           
+U0       = 1.3079101E-02       A0       = 0.9726100           KETA     = 1.9578772E-02       
+A1       = 0.00                A2       = 0.9900000           AGS      = 2.0000000E-02       
+B0       = 0.00                B1       = 0.00                VOFF     = -0.1119244          
+NFACTOR  = 1.0000000           CIT      = 4.5372260E-04       CDSC     = 0.00                
+CDSCB    = 0.00                CDSCD    = 0.00                ETA0     = 1.0000000E-05       
+ETAB     = -1.0000000E-05      DSUB     = 0.00                PCLM     = 0.5000001           
+PDIBLC1  = 1.0000000E-06       PDIBLC2  = 1.0000000E-05       PDIBLCB  = 1.0000000E-02       
+DROUT    = 0.00                PSCBE1   = 2.0000003E08        PSCBE2   = 5.0000000E-07       
+PVAG     = 0.00                DELTA    = 1.0000000E-02       ALPHA0   = 0.00                
+ALPHA1   = 0.143217238         BETA0    = 16.10832            KT1      = -0.2913002          
+KT2      = -2.5890822E-02      AT       = -5.0000000E04       UTE      = -0.7959498          
+UA1      = 2.0310000E-09       UB1      = -2.6231965E-18      UC1      = 9.4352360E-12       
+KT1L     = 0.00                PRT      = 0                   
+CJ       = cjp3                PB       = 0.8049122           MJ       = 0.3954951
+CJSW     = cjswp3              PBSW     = 0.8049122           MJSW     = 0.2573111
+CJSWG    = cjswgp3             PBSWG    = 0.8049122           MJSWG    = 0.2573111
+CGDO     = cgop3               CGSO     = cgop3               TCJ      = 0.0009940197
+TCJSW    = 0.0006908749        TCJSWG   = 0.0006908749        TPB      = 0.001625007
+TPBSW    = 0.001625007         TPBSWG   = 0.001625007
+JS       = 1.900E-07           JSW      = 1.00E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+LLC      = -0.0165             
+NOIMOD  = 2
+NOIA     = 2.0E19		NOIB     = 8.0E03	       NOIC	= 5.4E-12
+EM       = 3.0E07		EF       = 1.094               )

.MODEL pch3.2 PMOS	(	LMIN     = '1.200E-06-dxl3'      LMAX     = '1.000E-05-dxl3'      
+WMIN     = '1.0000E-05-dxw3'                                WMAX     = 900.001e-6               
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp3'           TOXM     = 'toxp3'           XJ       = 1.7000001E-07       
+NCH      = 4.9500000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 3.5000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 2.0000000E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp3'          RSH      = 'rshp3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.6966490+dvthp3'
+LVTH0    = -1.0866771E-08      K1       = 0.8495954           LK1      = 1.7827986E-08       
+K2       = 7.3845220E-02       LK2      = -6.0863510E-09      K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 1.5378411E05        LVSAT    = -3.7500340E-02      
+UA       = 1.6902475E-09       LUA      = -1.0910469E-16      UB       = 2.6840783E-19       
+LUB      = 7.6135260E-26       UC       = -1.0827022E-10      LUC      = 1.9421627E-17       
+RDSW     = 9.0000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 1.3233015E-02       LU0      = -1.5252891E-09      
+A0       = 0.9807407           LA0      = -8.0575180E-08      KETA     = 2.0751586E-02       
+LKETA    = -1.1622598E-08      A1       = 0.00                A2       = 0.9900000           
+AGS      = 2.0000000E-02       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1119000          LVOFF    = -2.4146618E-10      NFACTOR  = 1.0000000           
+CIT      = 4.4763520E-04       LCIT     = 6.0325690E-11       CDSC     = 0.00                
+CDSCB    = 0.00                CDSCD    = 0.00                ETA0     = 1.0000000E-05       
+ETAB     = -1.0000000E-05      DSUB     = 0.00                PCLM     = 0.4845105           
+LPCLM    = 1.5350197E-07       PDIBLC1  = 1.0000000E-06       PDIBLC2  = 1.0000000E-05       
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 1.8738642E08        
+LPSCBE1  = 1.2500109E02        PSCBE2   = 5.0000000E-07       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.00                ALPHA1   = 0.143217238         
+BETA0    = 16.10832            KT1      = -0.2904292          LKT1     = -8.6317250E-09      
+KT2      = -2.5863823E-02      LKT2     = -2.6755742E-10      AT       = -5.0000000E04       
+UTE      = -0.8086896          LUTE     = 1.2625190E-07       UA1      = 2.0310000E-09       
+UB1      = -2.6370268E-18      LUB1     = 1.3705860E-25       UC1      = 7.1907790E-12       
+LUC1     = 2.2242592E-17       KT1L     = 0.00                PRT      = 0                   
+CJ       = cjp3                PB       = 0.8049122           MJ       = 0.3954951
+CJSW     = cjswp3              PBSW     = 0.8049122           MJSW     = 0.2573111
+CJSWG    = cjswgp3             PBSWG    = 0.8049122           MJSWG    = 0.2573111
+CGDO     = cgop3               CGSO     = cgop3               TCJ      = 0.0009940197
+TCJSW    = 0.0006908749        TCJSWG   = 0.0006908749        TPB      = 0.001625007
+TPBSW    = 0.001625007         TPBSWG   = 0.001625007
+JS       = 1.900E-07           JSW      = 1.00E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+LLC      = -0.0165             
+NOIMOD  = 2
+NOIA     = 2.0E19		NOIB     = 8.0E03	       NOIC	= 5.4E-12
+EM       = 3.0E07		EF       = 1.094               )

.MODEL pch3.3 PMOS	(	LMIN     = '5.000E-07-dxl3'      LMAX     = '1.200E-06-dxl3'      
+WMIN     = '1.0000E-05-dxw3'                                WMAX     = 900.001e-6               
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp3'           TOXM     = 'toxp3'           XJ       = 1.7000001E-07       
+NCH      = 4.9500000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 3.5000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 2.0000000E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp3'          RSH      = 'rshp3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.7066531+dvthp3'
+LVTH0    = 2.3770189E-10       K1       = 0.8542004           LK1      = 1.2716471E-08       
+K2       = 7.3637170E-02       LK2      = -5.8554080E-09      K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 1.2585714E05        LVSAT    = -6.5014080E-03      
+UA       = 2.0603699E-09       LUA      = -5.1994050E-16      UB       = 1.0048677E-19       
+LUB      = 2.6252766E-25       UC       = -1.2948420E-10      LUC      = 4.2969150E-17       
+RDSW     = 9.0000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 1.3020334E-02       LU0      = -1.2892131E-09      
+A0       = 0.8873466           LA0      = 2.3092309E-08       KETA     = 2.0400845E-02       
+LKETA    = -1.1233276E-08      A1       = 0.00                A2       = 0.9900000           
+AGS      = 2.0000000E-02       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1168895          LVOFF    = 5.2969330E-09       NFACTOR  = 1.0000000           
+CIT      = 4.9963790E-04       LCIT     = 2.6027104E-12       CDSC     = 0.00                
+CDSCB    = 0.00                CDSCD    = 0.00                ETA0     = -4.2714270E-05      
+LETA0    = 5.8512850E-11       ETAB     = 4.2714270E-05       LETAB    = -5.8512850E-11      
+DSUB     = 0.00                PCLM     = 0.5865320           LPCLM    = 4.0258040E-08       
+PDIBLC1  = 1.0000000E-06       PDIBLC2  = -5.6985720E-04      LPDIBLC2 = 6.4364150E-10       
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 2.7071427E08        
+LPSCBE1  = 32.5071400          PSCBE2   = 5.0000000E-07       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.00                ALPHA1   = 0.143217238         
+BETA0    = 16.10832            KT1      = -0.2962146          LKT1     = -2.2099222E-09      
+KT2      = -2.4729839E-02      LKT2     = -1.5262811E-09      AT       = -5.0000000E04       
+UTE      = -0.7447437          LUTE     = 5.5271930E-08       UA1      = 2.0310000E-09       
+UB1      = -2.7745749E-18      LUB1     = 2.8973695E-25       UC1      = 2.7087265E-11       
+LUC1     = 1.5749189E-19       KT1L     = 0.00                PRT      = 0                   
+CJ       = cjp3                PB       = 0.8049122           MJ       = 0.3954951
+CJSW     = cjswp3              PBSW     = 0.8049122           MJSW     = 0.2573111
+CJSWG    = cjswgp3             PBSWG    = 0.8049122           MJSWG    = 0.2573111
+CGDO     = cgop3               CGSO     = cgop3               TCJ      = 0.0009940197
+TCJSW    = 0.0006908749        TCJSWG   = 0.0006908749        TPB      = 0.001625007
+TPBSW    = 0.001625007         TPBSWG   = 0.001625007
+JS       = 1.900E-07           JSW      = 1.00E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+LLC      = -0.0165             
+NOIMOD  = 2
+NOIA     = 2.0E19		NOIB     = 8.0E03	       NOIC	= 5.4E-12
+EM       = 3.0E07		EF       = 1.094               )

.MODEL pch3.4 PMOS	(	LMIN     = 3.0e-007                 LMAX     = '5.000E-07-dxl3'      
+WMIN     = '1.0000E-05-dxw3'                                WMAX     = 900.001e-6               
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp3'           TOXM     = 'toxp3'           XJ       = 1.7000001E-07       
+NCH      = 4.9500000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 3.5000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 2.0000000E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp3'          RSH      = 'rshp3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.7654887+dvthp3'
+LVTH0    = 2.4360313E-08       K1       = 0.7697587           LK1      = 4.7337540E-08       
+K2       = 0.1288249           LK2      = -2.8482381E-08      K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 1.2050377E05        LVSAT    = -4.3065240E-03      
+UA       = 1.2215998E-09       LUA      = -1.7604479E-16      UB       = 1.0977573E-19       
+LUB      = 2.5871919E-25       UC       = -8.9515780E-11      LUC      = 2.6582101E-17       
+RDSW     = 9.0000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 1.0026056E-02       LU0      = -6.1558890E-11      
+A0       = 1.1557579           LA0      = -8.6956350E-08      KETA     = -9.8874240E-03      
+LKETA    = 1.1849141E-09       A1       = 0.00                A2       = 0.9900000           
+AGS      = 2.0000000E-02       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1251169          LVOFF    = 8.6701580E-09       NFACTOR  = 1.0000000           
+CIT      = 5.4583350E-04       LCIT     = -1.6337489E-11      CDSC     = 0.00                
+CDSCB    = 0.00                CDSCD    = 0.00                ETA0     = -3.2014790E-04      
+LETA0    = 1.7226064E-10       ETAB     = 8.4486390E-04       LETAB    = -3.8739420E-10      
+DSUB     = 0.00                PCLM     = 0.6685342           LPCLM    = 6.6371640E-09       
+PDIBLC1  = 1.0000000E-06       PDIBLC2  = -3.1977270E-03      LPDIBLC2 = 1.7210681E-09       
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 3.2899260E08        
+LPSCBE1  = 8.6130450           PSCBE2   = 5.0000000E-07       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.00                ALPHA1   = 0.143217238         
+BETA0    = 16.10832            KT1      = -0.3347960          LKT1     = 1.3608444E-08       
+KT2      = -3.0659514E-02      LKT2     = 9.0488570E-10       AT       = -5.0000000E04       
+UTE      = -0.1691541          LUTE     = -1.8071982E-07      UA1      = 3.4398240E-09       
+LUA1     = -5.7761800E-16      UB1      = -2.4997837E-18      LUB1     = 1.7707251E-25       
+UC1      = 5.3556920E-11       LUC1     = -1.0695066E-17      KT1L     = 0.00                
+PRT      = 0                                   
+CJ       = cjp3                PB       = 0.8049122           MJ       = 0.3954951
+CJSW     = cjswp3              PBSW     = 0.8049122           MJSW     = 0.2573111
+CJSWG    = cjswgp3             PBSWG    = 0.8049122           MJSWG    = 0.2573111
+CGDO     = cgop3               CGSO     = cgop3               TCJ      = 0.0009940197
+TCJSW    = 0.0006908749        TCJSWG   = 0.0006908749        TPB      = 0.001625007
+TPBSW    = 0.001625007         TPBSWG   = 0.001625007
+JS       = 1.900E-07           JSW      = 1.00E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+LLC      = -0.0165             
+NOIMOD  = 2
+NOIA     = 2.0E19		NOIB     = 8.0E03	       NOIC	= 5.4E-12
+EM       = 3.0E07		EF       = 1.094               )

.MODEL pch3.5 PMOS	(	LMIN     = '1.000E-05-dxl3'      LMAX     = 20.001e-006              
+WMIN     = '1.2000E-06-dxw3'                                WMAX     = '1.0000E-05-dxw3'      
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp3'           TOXM     = 'toxp3'           XJ       = 1.7000001E-07       
+NCH      = 4.9500000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 3.5000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 2.0000000E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp3'          RSH      = 'rshp3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.6984460+dvthp3'
+WVTH0    = 6.9768680E-09       K1       = 0.8503587           WK1      = 1.0315638E-08       
+K2       = 7.3487820E-02       WK2      = -2.5573503E-09      K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 1.5000002E05        UA       = 1.6894739E-09       
+WUA      = -1.0194988E-16      UB       = 3.0589336E-19       WUB      = -2.9683633E-25      
+UC       = -9.9785820E-11      WUC      = -6.4985050E-17      RDSW     = 9.0000000E02        
+PRWB     = 0.00                PRWG     = 0.00                WR       = 1.0000000           
+U0       = 1.3156584E-02       WU0      = -7.7172380E-10      A0       = 0.9693438           
+WA0      = 3.2530650E-08       KETA     = 1.9776296E-02       WKETA    = -1.9673381E-09      
+A1       = 0.00                A2       = 0.9900000           AGS      = 2.0000000E-02       
+B0       = 0.00                B1       = 0.00                VOFF     = -0.1118388          
+WVOFF    = -8.5173270E-10      NFACTOR  = 1.0000000           CIT      = 4.5291100E-04       
+WCIT     = 8.0838530E-12       CDSC     = 0.00                CDSCB    = 0.00                
+CDSCD    = 0.00                ETA0     = 1.0000000E-05       ETAB     = -1.0000000E-05      
+DSUB     = 0.00                PCLM     = 0.5000001           PDIBLC1  = 1.0000000E-06       
+PDIBLC2  = 1.0000000E-05       PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                
+PSCBE1   = 2.0000003E08        PSCBE2   = 5.0000000E-07       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.00                ALPHA1   = 0.143217238         
+BETA0    = 16.10832            KT1      = -0.2916738          WKT1     = 3.7208530E-09       
+KT2      = -2.5821852E-02      WKT2     = -6.8693400E-10      AT       = -5.0000000E04       
+UTE      = -0.8086289          WUTE     = 1.2628378E-07       UA1      = 2.0310000E-09       
+UB1      = -2.6415932E-18      WUB1     = 1.8323023E-25       UC1      = 4.3590560E-12       
+WUC1     = 5.0558750E-17       KT1L     = 0.00                PRT      = 0                   
+CJ       = cjp3                PB       = 0.8049122           MJ       = 0.3954951
+CJSW     = cjswp3              PBSW     = 0.8049122           MJSW     = 0.2573111
+CJSWG    = cjswgp3             PBSWG    = 0.8049122           MJSWG    = 0.2573111
+CGDO     = cgop3               CGSO     = cgop3               TCJ      = 0.0009940197
+TCJSW    = 0.0006908749        TCJSWG   = 0.0006908749        TPB      = 0.001625007
+TPBSW    = 0.001625007         TPBSWG   = 0.001625007
+JS       = 1.900E-07           JSW      = 1.00E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+LLC      = -0.0165             
+NOIMOD  = 2
+NOIA     = 2.0E19		NOIB     = 8.0E03	       NOIC	= 5.4E-12
+EM       = 3.0E07		EF       = 1.094               )

.MODEL pch3.6 PMOS	(	LMIN     = '1.200E-06-dxl3'      LMAX     = '1.000E-05-dxl3'      
+WMIN     = '1.2000E-06-dxw3'                                WMAX     = '1.0000E-05-dxw3'      
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp3'           TOXM     = 'toxp3'           XJ       = 1.7000001E-07       
+NCH      = 4.9500000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 3.5000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 2.0000000E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp3'          RSH      = 'rshp3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.6973685+dvthp3'
+LVTH0    = -1.0678359E-08      WVTH0    = 7.1662300E-09       PVTH0    = -1.8765835E-15      
+K1       = 0.8484218           LK1      = 1.9194855E-08       WK1      = 1.1689406E-08       
+PK1      = -1.3614034E-14      K2       = 7.4132180E-02       LK2      = -6.3856390E-09      
+WK2      = -2.8581482E-09      PK2      = 2.9809131E-15       K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 1.5378411E05        LVSAT    = -3.7500340E-02      
+UA       = 1.7025260E-09       LUA      = -1.2934621E-16      WUA      = -1.2229349E-16      
+PUA      = 2.0160552E-22       UB       = 2.9719795E-19       LUB      = 8.6171280E-26       
+WUB      = -2.8674966E-25      PUB      = -9.9958690E-32      UC       = -1.0189776E-10      
+LUC      = 2.0929388E-17       WUC      = -6.3469690E-17      PUC      = -1.5017275E-23      
+RDSW     = 9.0000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 1.3313532E-02       LU0      = -1.5553542E-09      
+WU0      = -8.0194040E-10      PU0      = 2.9944828E-16       A0       = 0.9772012           
+LA0      = -7.7866310E-08      WA0      = 3.5253190E-08       PA0      = -2.6980386E-14      
+KETA     = 2.0953476E-02       LKETA    = -1.1665868E-08      WKETA    = -2.0108260E-09      
+PKETA    = 4.3096390E-16       A1       = 0.00                A2       = 0.9900000           
+AGS      = 2.0000000E-02       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1118283          LVOFF    = -1.0463946E-10      WVOFF    = -7.1421570E-10      
+PVOFF    = -1.3627949E-15      NFACTOR  = 1.0000000           CIT      = 4.4620200E-04       
+LCIT     = 6.6485910E-11       WCIT     = 1.4275149E-11       PCIT     = -6.1355780E-17      
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = 1.0000000E-05       ETAB     = -1.0000000E-05      DSUB     = 0.00                
+PCLM     = 0.4849888           LPCLM    = 1.4876132E-07       WPCLM    = -4.7646440E-09      
+PPCLM    = 4.7216950E-14       PDIBLC1  = 1.0000000E-06       PDIBLC2  = 1.0000000E-05       
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 1.8738640E08        
+LPSCBE1  = 1.2500110E02        PSCBE2   = 5.0000000E-07       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.00                ALPHA1   = 0.143217238         
+BETA0    = 16.10832            KT1      = -0.2907380          LKT1     = -9.2738370E-09      
+WKT1     = 3.0755010E-09       PKT1     = 6.3954390E-15       KT2      = -2.5782341E-02      
+LKT2     = -3.9155450E-10      WKT2     = -8.1155670E-10      PKT2     = 1.2350112E-15       
+AT       = -5.0000000E04       UTE      = -0.8213636          LUTE     = 1.2620113E-07       
+WUTE     = 1.2623275E-07       PUTE     = 5.0573060E-16       UA1      = 2.0310000E-09       
+UB1      = -2.6567511E-18      LUB1     = 1.5021592E-25       WUB1     = 1.9645394E-25       
+PUB1     = -1.3104698E-31      UC1      = 2.3076966E-12       LUC1     = 2.0329014E-17       
+WUC1     = 4.8635520E-17       PUC1     = 1.9059230E-23       KT1L     = 0.00                
+PRT      = 0                   
+CJ       = cjp3                PB       = 0.8049122           MJ       = 0.3954951
+CJSW     = cjswp3              PBSW     = 0.8049122           MJSW     = 0.2573111
+CJSWG    = cjswgp3             PBSWG    = 0.8049122           MJSWG    = 0.2573111
+CGDO     = cgop3               CGSO     = cgop3               TCJ      = 0.0009940197
+TCJSW    = 0.0006908749        TCJSWG   = 0.0006908749        TPB      = 0.001625007
+TPBSW    = 0.001625007         TPBSWG   = 0.001625007
+JS       = 1.900E-07           JSW      = 1.00E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+LLC      = -0.0165             
+NOIMOD  = 2
+NOIA     = 2.0E19		NOIB     = 8.0E03	       NOIC	= 5.4E-12
+EM       = 3.0E07		EF       = 1.094               )

.MODEL pch3.7 PMOS	(	LMIN     = '5.000E-07-dxl3'      LMAX     = '1.200E-06-dxl3'      
+WMIN     = '1.2000E-06-dxw3'                                WMAX     = '1.0000E-05-dxw3'      
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp3'           TOXM     = 'toxp3'           XJ       = 1.7000001E-07       
+NCH      = 4.9500000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 3.5000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 2.0000000E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp3'          RSH      = 'rshp3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.7063123+dvthp3'
+LVTH0    = -7.5076820E-10      WVTH0    = -3.3938940E-09      PVTH0    = 9.8451550E-15       
+K1       = 0.8532185           LK1      = 1.3870451E-08       WK1      = 9.7791290E-09       
+PK1      = -1.1493628E-14      K2       = 7.3774080E-02       LK2      = -5.9881520E-09      
+WK2      = -1.3637474E-09      PK2      = 1.3221279E-15       K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 1.2585714E05        LVSAT    = -6.5014080E-03      
+UA       = 2.0674848E-09       LUA      = -5.3445060E-16      WUA      = -7.0865140E-17      
+PUA      = 1.4452005E-22       UB       = 1.2599716E-19       LUB      = 2.7620414E-25       
+WUB      = -2.5408411E-25      PUB      = -1.3621745E-31      UC       = -1.2225446E-10      
+LUC      = 4.3525310E-17       WUC      = -7.2008350E-17      PUC      = -5.5393540E-24      
+RDSW     = 9.0000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 1.3079622E-02       LU0      = -1.2957146E-09      
+WU0      = -5.9050560E-10      PU0      = 6.4755580E-17       A0       = 0.8879921           
+LA0      = 2.1155756E-08       WA0      = -6.4301090E-09      PA0      = 1.9288072E-14       
+KETA     = 2.0470830E-02       LKETA    = -1.1130130E-08      WKETA    = -6.9703380E-10      
+PKETA    = -1.0273464E-15      A1       = 0.00                A2       = 0.9900000           
+AGS      = 2.0000000E-02       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1170540          LVOFF    = 5.6959450E-09       WVOFF    = 1.6383606E-09       
+PVOFF    = -3.9741550E-15      NFACTOR  = 1.0000000           CIT      = 5.0421500E-04       
+LCIT     = 2.0914730E-12       WCIT     = -4.5587650E-11      PCIT     = 5.0919230E-18       
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = -4.2714280E-05      LETA0    = 5.8512850E-11       ETAB     = 4.2714280E-05       
+LETAB    = -5.8512850E-11      DSUB     = 0.00                PCLM     = 0.5832995           
+LPCLM    = 3.9636520E-08       WPCLM    = 3.2196260E-08       PPCLM    = 6.1903360E-15       
+PDIBLC1  = 1.0000000E-06       PDIBLC2  = -5.6985730E-04      LPDIBLC2 = 6.4364150E-10       
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 2.7071427E08        
+LPSCBE1  = 32.5071400          PSCBE2   = 5.0000000E-07       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.00                ALPHA1   = 0.143217238         
+BETA0    = 16.10832            KT1      = -0.2971400          LKT1     = -2.1676729E-09      
+WKT1     = 9.2162620E-09       PKT1     = -4.2080570E-16      KT2      = -2.4722382E-02      
+LKT2     = -1.5681096E-09      WKT2     = -7.4258340E-11      PKT2     = 4.1660990E-16       
+AT       = -5.0000000E04       UTE      = -0.7553561          LUTE     = 5.2932850E-08       
+WUTE     = 1.0569979E-07       PUTE     = 2.3297301E-14       UA1      = 2.0310000E-09       
+UB1      = -2.7846704E-18      LUB1     = 2.9220633E-25       WUB1     = 1.0055110E-25       
+PUB1     = -2.4594843E-32      UC1      = 1.9397399E-11       LUC1     = 1.3594401E-18       
+WUC1     = 7.6591040E-17       PUC1     = -1.1971389E-23      KT1L     = 0.00                
+PRT      = 0                   
+CJ       = cjp3                PB       = 0.8049122           MJ       = 0.3954951
+CJSW     = cjswp3              PBSW     = 0.8049122           MJSW     = 0.2573111
+CJSWG    = cjswgp3             PBSWG    = 0.8049122           MJSWG    = 0.2573111
+CGDO     = cgop3               CGSO     = cgop3               TCJ      = 0.0009940197
+TCJSW    = 0.0006908749        TCJSWG   = 0.0006908749        TPB      = 0.001625007
+TPBSW    = 0.001625007         TPBSWG   = 0.001625007
+JS       = 1.900E-07           JSW      = 1.00E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+LLC      = -0.0165             
+NOIMOD  = 2
+NOIA     = 2.0E19		NOIB     = 8.0E03	       NOIC	= 5.4E-12
+EM       = 3.0E07		EF       = 1.094               )

.MODEL pch3.8 PMOS	(	LMIN     = 3.0e-007                 LMAX     = '5.000E-07-dxl3'      
+WMIN     = '1.2000E-06-dxw3'                                WMAX     = '1.0000E-05-dxw3'      
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp3'           TOXM     = 'toxp3'           XJ       = 1.7000001E-07       
+NCH      = 4.9500000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 3.5000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 2.0000000E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp3'          RSH      = 'rshp3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.7727100+dvthp3'
+LVTH0    = 2.6472314E-08       WVTH0    = 7.1924870E-08       PVTH0    = -2.1035541E-14      
+K1       = 0.7699419           LK1      = 4.8013860E-08       WK1      = -1.8243896E-09      
+PK1      = -6.7361810E-15      K2       = 0.1315423           LK2      = -2.9673100E-08      
+WK2      = -2.7064845E-08      PK2      = 1.1859575E-14       K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 1.1960348E05        LVSAT    = -3.9374090E-03      
+WVSAT    = 8.9667880E-03       PVSAT    = -3.6763830E-09      UA       = 1.1489469E-09       
+LUA      = -1.5785002E-16      WUA      = 7.2362290E-16       PUA      = -1.8122008E-22      
+UB       = 2.4514955E-19       LUB      = 2.2735166E-25       WUB      = -1.3483237E-24      
+PUB      = 3.1242082E-31       UC       = -7.1838280E-11      LUC      = 2.2854683E-17       
+WUC      = -1.7606797E-16      PUC      = 3.7125090E-23       RDSW     = 9.0000000E02        
+PRWB     = 0.00                PRWG     = 0.00                WR       = 1.0000000           
+U0       = 1.0090719E-02       LU0      = -7.0264360E-11      WU0      = -6.4404460E-10      
+PU0      = 8.6706510E-17       A0       = 1.1409379           LA0      = -8.2552040E-08      
+WA0      = 1.4760643E-07       PA0      = -4.3866910E-14      KETA     = -1.1318877E-02      
+LKETA    = 1.9036506E-09       WKETA    = 1.4257295E-08       PKETA    = -7.1586210E-15      
+A1       = 0.00                A2       = 0.9900000           AGS      = 2.0000000E-02       
+B0       = 0.00                B1       = 0.00                VOFF     = -0.1250223          
+LVOFF    = 8.9629090E-09       WVOFF    = -9.4300550E-10      PVOFF    = -2.9157947E-15      
+NFACTOR  = 1.0000000           CIT      = 5.6188450E-04       LCIT     = -2.1553027E-11      
+WCIT     = -1.5986783E-10      PCIT     = 5.1946790E-17       CDSC     = 0.00                
+CDSCB    = 0.00                CDSCD    = 0.00                ETA0     = -2.8413706E-04      
+LETA0    = 1.5749620E-10       WETA0    = -3.5866790E-10      PETA0    = 1.4705383E-16       
+ETAB     = 8.7586620E-04       LETAB    = -4.0010520E-10      WETAB    = -3.0878400E-10      
+PETAB    = 1.2660141E-16       DSUB     = 0.00                PCLM     = 0.6645077           
+LPCLM    = 6.3411240E-09       WPCLM    = 4.0103030E-08       PPCLM    = 2.9485615E-15       
+PDIBLC1  = 1.0000000E-06       PDIBLC2  = -3.7510620E-03      LPDIBLC2 = 1.9479358E-09       
+WPDIBLC2 = 5.5112340E-09       PPDIBLC2 = -2.2596061E-15      PDIBLCB  = 1.0000000E-02       
+DROUT    = 0.00                PSCBE1   = 3.3079310E08        LPSCBE1  = 7.8748250           
+WPSCBE1  = -17.9333440         PPSCBE1  = 7.3526710E-06       PSCBE2   = 5.0000000E-07       
+PVAG     = 0.00                DELTA    = 1.0000000E-02       ALPHA0   = 0.00                
+ALPHA1   = 0.143217238         BETA0    = 16.10832            KT1      = -0.3349694          
+LKT1     = 1.3342398E-08       WKT1     = 1.7269201E-09       PKT1     = 2.6498244E-15       
+KT2      = -3.0737475E-02      LKT2     = 8.9807820E-10       WKT2     = 7.7649210E-10       
+PKT2     = 6.7802250E-17       AT       = -5.0000000E04       UTE      = -0.1318164          
+LUTE     = -2.0271844E-07      WUTE     = -3.7188310E-07      PUTE     = 2.1910628E-13       
+UA1      = 3.6255330E-09       LUA1     = -6.5375860E-16      WUA1     = -1.8496589E-15      
+PUA1     = 7.5836000E-22       UB1      = -2.5613780E-18      LUB1     = 2.0065643E-25       
+WUB1     = 6.1348050E-25       PUB1     = -2.3489589E-31      UC1      = 4.8751200E-11       
+LUC1     = -1.0675619E-17      WUC1     = 4.7864960E-17       PUC1     = -1.9370043E-25      
+KT1L     = 0.00                PRT      = 0                   
+CJ       = cjp3                PB       = 0.8049122           MJ       = 0.3954951
+CJSW     = cjswp3              PBSW     = 0.8049122           MJSW     = 0.2573111
+CJSWG    = cjswgp3             PBSWG    = 0.8049122           MJSWG    = 0.2573111
+CGDO     = cgop3               CGSO     = cgop3               TCJ      = 0.0009940197
+TCJSW    = 0.0006908749        TCJSWG   = 0.0006908749        TPB      = 0.001625007
+TPBSW    = 0.001625007         TPBSWG   = 0.001625007
+JS       = 1.900E-07           JSW      = 1.00E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+LLC      = -0.0165             
+NOIMOD  = 2
+NOIA     = 2.0E19		NOIB     = 8.0E03	       NOIC	= 5.4E-12
+EM       = 3.0E07		EF       = 1.094               )

.MODEL pch3.9 PMOS	(	LMIN     = '1.000E-05-dxl3'      LMAX     = 20.001e-006              
+WMIN     = '5.0000E-07-dxw3'                                WMAX     = '1.2000E-06-dxw3'      
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp3'           TOXM     = 'toxp3'           XJ       = 1.7000001E-07       
+NCH      = 4.9500000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 3.5000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 2.0000000E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp3'          RSH      = 'rshp3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.6992865+dvthp3'
+WVTH0    = 7.9518050E-09       K1       = 0.8536492           WK1      = 6.4986320E-09       
+K2       = 7.3503040E-02       WK2      = -2.5750040E-09      K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 1.5000002E05        UA       = 2.3221998E-09       
+WUA      = -8.3591190E-16      UB       = 5.0000000E-20       UC       = -1.3989673E-10      
+WUC      = -1.8456393E-17      RDSW     = 9.0000000E02        PRWB     = 0.00                
+PRWG     = 0.00                WR       = 1.0000000           U0       = 1.4610297E-02       
+WU0      = -2.4580307E-09      A0       = 0.9420360           WA0      = 6.4207830E-08       
+KETA     = 1.8767053E-02       WKETA    = -7.9661680E-10      A1       = 0.00                
+A2       = 0.9900000           AGS      = 2.0000001E-02       B0       = 0.00                
+B1       = 0.00                VOFF     = -0.1126554          WVOFF    = 9.5426480E-11       
+NFACTOR  = 1.0000000           CIT      = 4.8056380E-04       WCIT     = -2.3993458E-11      
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = 1.0000000E-05       ETAB     = -1.0000000E-05      DSUB     = 0.00                
+PCLM     = 0.5000000           PDIBLC1  = 1.0000000E-06       PDIBLC2  = 1.0000000E-05       
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 2.0000003E08        
+PSCBE2   = 5.0000000E-07       PVAG     = 0.00                DELTA    = 1.0000000E-02       
+ALPHA0   = 0.00                ALPHA1   = 0.143217238         BETA0    = 16.10832            
+KT1      = -0.2917677          WKT1     = 3.8297360E-09       KT2      = -2.7259111E-02      
+WKT2     = 9.8028660E-10       AT       = -5.0000000E04       UTE      = -0.7662017          
+WUTE     = 7.7068240E-08       UA1      = 2.0309998E-09       UB1      = -2.5738963E-18      
+WUB1     = 1.0470186E-25       UC1      = 4.6204500E-11       WUC1     = 2.0180378E-18       
+KT1L     = 0.00                PRT      = 0                   
+CJ       = cjp3                PB       = 0.8049122           MJ       = 0.3954951
+CJSW     = cjswp3              PBSW     = 0.8049122           MJSW     = 0.2573111
+CJSWG    = cjswgp3             PBSWG    = 0.8049122           MJSWG    = 0.2573111
+CGDO     = cgop3               CGSO     = cgop3               TCJ      = 0.0009940197
+TCJSW    = 0.0006908749        TCJSWG   = 0.0006908749        TPB      = 0.001625007
+TPBSW    = 0.001625007         TPBSWG   = 0.001625007
+JS       = 1.900E-07           JSW      = 1.00E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+LLC      = -0.0165             
+NOIMOD  = 2
+NOIA     = 2.0E19		NOIB     = 8.0E03	       NOIC	= 5.4E-12
+EM       = 3.0E07		EF       = 1.094               )

.MODEL pch3.10 PMOS	(	LMIN     = '1.200E-06-dxl3'      LMAX     = '1.000E-05-dxl3'      
+WMIN     = '5.0000E-07-dxw3'                                WMAX     = '1.2000E-06-dxw3'      
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp3'           TOXM     = 'toxp3'           XJ       = 1.7000001E-07       
+NCH      = 4.9500000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 3.5000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 2.0000000E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp3'          RSH      = 'rshp3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.6977277+dvthp3'
+LVTH0    = -1.5447748E-08      WVTH0    = 7.5828930E-09       PVTH0    = 3.6559090E-15       
+K1       = 0.8533953           LK1      = 2.5154285E-09       WK1      = 5.9200140E-09       
+PK1      = 5.7341030E-15       K2       = 7.3639660E-02       LK2      = -1.3539118E-09      
+WK2      = -2.2868212E-09      PK2      = -2.8558914E-15      K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 1.5378411E05        LVSAT    = -3.7500340E-02      
+UA       = 2.3145617E-09       LUA      = 7.5691840E-17       WUA      = -8.3225500E-16      
+PUA      = -3.6238470E-23      UB       = 5.0000000E-20       UC       = -1.4156483E-10      
+LUC      = 1.6530885E-17       WUC      = -1.7455885E-17      PUC      = -9.9150150E-24      
+RDSW     = 9.0000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 1.4772911E-02       LU0      = -1.6115109E-09      
+WU0      = -2.4948206E-09      PU0      = 3.6459010E-16       A0       = 0.9551688           
+LA0      = -1.3014645E-07      WA0      = 6.0810790E-08       PA0      = 3.3664580E-14       
+KETA     = 1.9918669E-02       LKETA    = -1.1412505E-08      WKETA    = -8.1044770E-10      
+PKETA    = 1.3706199E-16       A1       = 0.00                A2       = 0.9900000           
+AGS      = 1.9607194E-02       LAGS     = 3.8927150E-09       WAGS     = 4.5565450E-10       
+PAGS     = -4.5155490E-15      B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1124224          LVOFF    = -2.3088516E-09      WVOFF    = -2.5067145E-11      
+PVOFF    = 1.1940914E-15       NFACTOR  = 1.0000000           CIT      = 4.8383600E-04       
+LCIT     = -3.2427540E-11      WCIT     = -2.9380325E-11      PCIT     = 5.3383830E-17       
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = 1.0000000E-05       ETAB     = -1.0000000E-05      DSUB     = 0.00                
+PCLM     = 0.4848956           LPCLM    = 1.4968438E-07       WPCLM    = -4.6565580E-09      
+PPCLM    = 4.6146210E-14       PDIBLC1  = 1.0000000E-06       PDIBLC2  = 1.0000000E-05       
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 1.8738640E08        
+LPSCBE1  = 1.2500110E02        PSCBE2   = 5.0000000E-07       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.00                ALPHA1   = 0.143217238         
+BETA0    = 16.10832            KT1      = -0.2911539          LKT1     = -6.0821800E-09      
+WKT1     = 3.5579780E-09       PKT1     = 2.6931163E-15       KT2      = -2.7373781E-02      
+LKT2     = 1.1363845E-09       WKT2     = 1.0345145E-09       PKT2     = -5.3739830E-16      
+AT       = -5.0000000E04       UTE      = -0.7822405          LUTE     = 1.5894491E-07       
+WUTE     = 8.0849990E-08       PUTE     = -3.7477070E-14      UA1      = 2.0253581E-09       
+LUA1     = 5.5907670E-17       WUA1     = 6.5445300E-18       PUA1     = -6.4852900E-23      
+UB1      = -2.5749808E-18      LUB1     = 1.0747389E-26       WUB1     = 1.0160029E-25       
+PUB1     = 3.0736538E-32       UC1      = 4.3742250E-11       LUC1     = 2.4400898E-17       
+WUC1     = 5.7143320E-19       PUC1     = 1.4335845E-23       KT1L     = 0.00                
+PRT      = 0                   
+CJ       = cjp3                PB       = 0.8049122           MJ       = 0.3954951
+CJSW     = cjswp3              PBSW     = 0.8049122           MJSW     = 0.2573111
+CJSWG    = cjswgp3             PBSWG    = 0.8049122           MJSWG    = 0.2573111
+CGDO     = cgop3               CGSO     = cgop3               TCJ      = 0.0009940197
+TCJSW    = 0.0006908749        TCJSWG   = 0.0006908749        TPB      = 0.001625007
+TPBSW    = 0.001625007         TPBSWG   = 0.001625007
+JS       = 1.900E-07           JSW      = 1.00E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+LLC      = -0.0165             
+NOIMOD  = 2
+NOIA     = 2.0E19		NOIB     = 8.0E03	       NOIC	= 5.4E-12
+EM       = 3.0E07		EF       = 1.094               )

.MODEL pch3.11 PMOS	(	LMIN     = '5.000E-07-dxl3'      LMAX     = '1.200E-06-dxl3'      
+WMIN     = '5.0000E-07-dxw3'                                WMAX     = '1.2000E-06-dxw3'      
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp3'           TOXM     = 'toxp3'           XJ       = 1.7000001E-07       
+NCH      = 4.9500000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 3.5000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 2.0000000E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp3'          RSH      = 'rshp3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.7239643+dvthp3'
+LVTH0    = 1.3674838E-08       WVTH0    = 1.7082405E-08       PVTH0    = -6.8885490E-15      
+K1       = 0.8600600           LK1      = -4.8823770E-09      WK1      = 1.8429434E-09       
+PK1      = 1.0259654E-14       K2       = 7.5423550E-02       LK2      = -3.3340390E-09      
+WK2      = -3.2771350E-09      PK2      = -1.7566433E-15      K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 1.2585714E05        LVSAT    = -6.5014090E-03      
+UA       = 2.9925082E-09       LUA      = -6.7682880E-16      WUA      = -1.1438922E-15      
+PUA      = 3.0967882E-22       UB       = -1.8703899E-19      LUB      = 2.6311331E-25       
+WUB      = 1.0903794E-25       PUB      = -1.2103212E-31      UC       = -1.7420571E-10      
+LUC      = 5.2762270E-17       WUC      = -1.1744898E-17      PUC      = -1.6254219E-23      
+RDSW     = 9.0000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 1.5154593E-02       LU0      = -2.0351774E-09      
+WU0      = -2.9974716E-09      PU0      = 9.2253250E-16       A0       = 0.7949075           
+LA0      = 4.7743620E-08       WA0      = 1.0154811E-07       PA0      = -1.1553848E-14      
+KETA     = 2.1075293E-02       LKETA    = -1.2696355E-08      WKETA    = -1.3982078E-09      
+PKETA    = 7.8947390E-16       A1       = 0.00                A2       = 0.9900000           
+AGS      = 2.3456581E-02       LAGS     = -3.8010610E-10      WAGS     = -4.0096360E-09      
+PAGS     = 4.4092310E-16       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1131885          LVOFF    = -1.4584653E-09      WVOFF    = -2.8456701E-09      
+PVOFF    = 4.3249610E-15       NFACTOR  = 1.0000000           CIT      = 4.4694590E-04       
+LCIT     = 8.5205100E-12       WCIT     = 2.0844531E-11       PCIT     = -2.3657607E-18      
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = -4.2714290E-05      LETA0    = 5.8512870E-11       ETAB     = 4.2714290E-05       
+LETAB    = -5.8512870E-11      DSUB     = 0.00                PCLM     = 0.5728803           
+LPCLM    = 5.2021480E-08       WPCLM    = 4.4282560E-08       PPCLM    = -8.1762150E-15      
+PDIBLC1  = 1.0000000E-06       PDIBLC2  = -5.6985730E-04      LPDIBLC2 = 6.4364150E-10       
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 2.7071427E08        
+LPSCBE1  = 32.5071400          PSCBE2   = 5.0000000E-07       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.00                ALPHA1   = 0.143217238         
+BETA0    = 16.10832            KT1      = -0.2933006          LKT1     = -3.6994080E-09      
+WKT1     = 4.7625810E-09       PKT1     = 1.3560070E-15       KT2      = -2.3266830E-02      
+LKT2     = -3.4223340E-09      WKT2     = -1.7626999E-09      PKT2     = 2.5675102E-15       
+AT       = -5.0000000E04       UTE      = -0.7077559          LUTE     = 7.6267040E-08       
+WUTE     = 5.0483580E-08       PUTE     = -3.7703630E-15      UA1      = 2.1019217E-09       
+LUA1     = -2.9077913E-17      WUA1     = -8.2269240E-17      PUA1     = 3.3730390E-23       
+UB1      = -2.8656773E-18      LUB1     = 3.3342050E-25       WUB1     = 1.9451905E-25       
+PUB1     = -7.2403270E-32      UC1      = 7.5798370E-11       LUC1     = -1.1181404E-17      
+WUC1     = 1.1165895E-17       PUC1     = 2.5759914E-24       KT1L     = 0.00                
+PRT      = 0                   
+CJ       = cjp3                PB       = 0.8049122           MJ       = 0.3954951
+CJSW     = cjswp3              PBSW     = 0.8049122           MJSW     = 0.2573111
+CJSWG    = cjswgp3             PBSWG    = 0.8049122           MJSWG    = 0.2573111
+CGDO     = cgop3               CGSO     = cgop3               TCJ      = 0.0009940197
+TCJSW    = 0.0006908749        TCJSWG   = 0.0006908749        TPB      = 0.001625007
+TPBSW    = 0.001625007         TPBSWG   = 0.001625007
+JS       = 1.900E-07           JSW      = 1.00E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+LLC      = -0.0165             
+NOIMOD  = 2
+NOIA     = 2.0E19		NOIB     = 8.0E03	       NOIC	= 5.4E-12
+EM       = 3.0E07		EF       = 1.094               )

.MODEL pch3.12 PMOS	(	LMIN     = 3.0e-007                 LMAX     = '5.000E-07-dxl3'      
+WMIN     = '5.0000E-07-dxw3'                                WMAX     = '1.2000E-06-dxw3'      
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp3'           TOXM     = 'toxp3'           XJ       = 1.7000001E-07       
+NCH      = 4.9500000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 3.5000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 2.0000000E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp3'          RSH      = 'rshp3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.7091326+dvthp3'
+LVTH0    = 7.5938330E-09       WVTH0    = -1.8250328E-09      PVTH0    = 8.6350020E-16       
+K1       = 0.7124246           LK1      = 5.5648150E-08       WK1      = 6.4895670E-08       
+PK1      = -1.5591964E-14      K2       = 0.1203709           LK2      = -2.1762434E-08      
+WK2      = -1.4106020E-08      PK2      = 2.6832007E-15       K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 1.2733347E05        LVSAT    = -7.1067050E-03      
+UA       = 2.6204112E-09       LUA      = -5.2426900E-16      WUA      = -9.8327540E-16      
+PUA      = 2.4382590E-22       UB       = -1.5527859E-18      LUB      = 8.2306960E-25       
+WUB      = 7.3728160E-25       PUB      = -3.7861200E-31      UC       = -2.3368188E-10      
+LUC      = 7.7147500E-17       WUC      = 1.1670629E-17       PUC      = -2.5854586E-23      
+RDSW     = 9.0000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 1.0345819E-02       LU0      = -6.3580270E-11      
+WU0      = -9.3996030E-10      PU0      = 7.8952960E-17       A0       = 1.2442838           
+LA0      = -1.3650067E-07      WA0      = 2.7725269E-08       PA0      = 1.8713521E-14       
+KETA     = 2.4851217E-04       LKETA    = -4.1573760E-09      WKETA    = 8.3911840E-10       
+PKETA    = -1.2782924E-16      A1       = 0.00                A2       = 0.9900000           
+AGS      = 2.2341035E-02       LAGS     = 7.7267680E-11       WAGS     = -2.7156024E-09      
+PAGS     = -8.9630500E-17      B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1428125          LVOFF    = 1.0687391E-08       WVOFF    = 1.9693728E-08       
+PVOFF    = -4.9161920E-15      NFACTOR  = 1.0000000           CIT      = 4.0186070E-04       
+LCIT     = 2.7005427E-11       WCIT     = 2.5759807E-11       PCIT     = -4.3810230E-18      
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = -5.9333350E-04      LETA0    = 2.8426675E-10       ETAB     = 2.7869639E-04       
+LETAB    = -1.5526558E-10      WETAB    = 3.8393310E-10       PETAB    = -1.5741254E-16      
+DSUB     = 0.00                PCLM     = 0.7490969           LPCLM    = -2.0227363E-08      
+WPCLM    = -5.8020430E-08      PPCLM    = 3.3768010E-14       PDIBLC1  = 1.0000000E-06       
+PDIBLC2  = 1.0000000E-03       PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                
+PSCBE1   = 3.1533334E08        LPSCBE1  = 14.2133340          PSCBE2   = 5.0000000E-07       
+PVAG     = 0.00                DELTA    = 1.0000000E-02       ALPHA0   = 0.00                
+ALPHA1   = 0.143217238         BETA0    = 16.10832            KT1      = -0.3549937          
+LKT1     = 2.1594769E-08       WKT1     = 2.4955103E-08       PKT1     = -6.9229260E-15      
+KT2      = -4.3607630E-02      LKT2     = 4.9173970E-09       WKT2     = 1.5705877E-08       
+PKT2     = -4.5946070E-15      AT       = -5.0000000E04       UTE      = -0.4699602          
+LUTE     = -2.1229209E-08      WUTE     = 2.0363800E-08       PUTE     = 8.5787470E-15       
+UA1      = 2.0310000E-09       UB1      = -1.9069588E-18      LUB1     = -5.9654050E-26      
+WUB1     = -1.4564585E-25      PUB1     = 6.7064330E-32       UC1      = 1.1059081E-10       
+LUC1     = -2.5446301E-17      WUC1     = -2.3868988E-17      PUC1     = 1.6940293E-23       
+KT1L     = 0.00                PRT      = 0                   
+CJ       = cjp3                PB       = 0.8049122           MJ       = 0.3954951
+CJSW     = cjswp3              PBSW     = 0.8049122           MJSW     = 0.2573111
+CJSWG    = cjswgp3             PBSWG    = 0.8049122           MJSWG    = 0.2573111
+CGDO     = cgop3               CGSO     = cgop3               TCJ      = 0.0009940197
+TCJSW    = 0.0006908749        TCJSWG   = 0.0006908749        TPB      = 0.001625007
+TPBSW    = 0.001625007         TPBSWG   = 0.001625007
+JS       = 1.900E-07           JSW      = 1.00E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+LLC      = -0.0165             
+NOIMOD  = 2
+NOIA     = 2.0E19		NOIB     = 8.0E03	       NOIC	= 5.4E-12
+EM       = 3.0E07		EF       = 1.094               )

.MODEL pch3.13 PMOS	(	LMIN     = '1.000E-05-dxl3'      LMAX     = 20.001e-006              
+WMIN     = 2.2e-007                                           WMAX     = '5.0000E-07-dxw3'      
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp3'           TOXM     = 'toxp3'           XJ       = 1.7000001E-07       
+NCH      = 4.9500000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 3.5000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 2.0000000E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp3'          RSH      = 'rshp3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.6974285+dvthp3'
+WVTH0    = 7.0971400E-09       K1       = 0.8440637           WK1      = 1.0907958E-08       
+K2       = 7.8954390E-02       WK2      = -5.0826280E-09      K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 1.5000002E05        UA       = 5.0500000E-10       
+UB       = 5.0000000E-20       UC       = -1.3973826E-10      WUC      = -1.8529287E-17      
+RDSW     = 9.0000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 7.9532350E-03       WU0      = 6.0421770E-10       
+A0       = 1.0130361           WA0      = 3.1547767E-08       KETA     = 1.8505057E-02       
+WKETA    = -6.7609830E-10      A1       = 0.00                A2       = 0.9900000           
+AGS      = 1.9999994E-02       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1076706          WVOFF    = -2.1975590E-09      NFACTOR  = 1.0000000           
+CIT      = 1.0026426E-03       WCIT     = -2.6414965E-10      CDSC     = 0.00                
+CDSCB    = 0.00                CDSCD    = 0.00                ETA0     = 1.0000000E-05       
+ETAB     = -1.0000000E-05      DSUB     = 0.00                PCLM     = 0.5000000           
+PDIBLC1  = 1.0000000E-06       PDIBLC2  = 1.0000000E-05       PDIBLCB  = 1.0000000E-02       
+DROUT    = 0.00                PSCBE1   = 2.0000003E08        PSCBE2   = 5.0000000E-07       
+PVAG     = 0.00                DELTA    = 1.0000000E-02       ALPHA0   = 0.00                
+ALPHA1   = 0.143217238         BETA0    = 16.10832            KT1      = -0.2896371          
+WKT1     = 2.8496747E-09       KT2      = -2.7464394E-02      WKT2     = 1.0747162E-09       
+AT       = -5.0000000E04       UTE      = -0.6117741          WUTE     = 6.0315810E-09       
+UA1      = 2.0310005E-09       UB1      = -2.7571342E-18      WUB1     = 1.8899129E-25       
+UC1      = 6.2523140E-11       WUC1     = -5.4885400E-18      KT1L     = 0.00                
+PRT      = 0                   
+CJ       = cjp3                PB       = 0.8049122           MJ       = 0.3954951
+CJSW     = cjswp3              PBSW     = 0.8049122           MJSW     = 0.2573111
+CJSWG    = cjswgp3             PBSWG    = 0.8049122           MJSWG    = 0.2573111
+CGDO     = cgop3               CGSO     = cgop3               TCJ      = 0.0009940197
+TCJSW    = 0.0006908749        TCJSWG   = 0.0006908749        TPB      = 0.001625007
+TPBSW    = 0.001625007         TPBSWG   = 0.001625007
+JS       = 1.900E-07           JSW      = 1.00E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+LLC      = -0.0165             
+NOIMOD  = 2
+NOIA     = 2.0E19		NOIB     = 8.0E03	       NOIC	= 5.4E-12
+EM       = 3.0E07		EF       = 1.094               )

.MODEL pch3.14 PMOS	(	LMIN     = '1.200E-06-dxl3'      LMAX     = '1.000E-05-dxl3'      
+WMIN     = 2.2e-007                                           WMAX     = '5.0000E-07-dxw3'      
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp3'           TOXM     = 'toxp3'           XJ       = 1.7000001E-07       
+NCH      = 4.9500000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 3.5000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 2.0000000E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp3'          RSH      = 'rshp3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.6969150+dvthp3'
+LVTH0    = -5.0894140E-09      WVTH0    = 7.2090390E-09       PVTH0    = -1.1089246E-15      
+K1       = 0.8422616           LK1      = 1.7858284E-08       WK1      = 1.1041521E-08       
+PK1      = -1.3236105E-15      K2       = 7.9876470E-02       LK2      = -9.1377870E-09      
+WK2      = -5.1557550E-09      PK2      = 7.2469200E-16       K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 1.5378411E05        LVSAT    = -3.7500340E-02      
+UA       = 4.9978600E-10       LUA      = 5.1669870E-17       WUA      = 2.5417124E-18       
+PUA      = -2.5188352E-23      UB       = 5.0000000E-20       UC       = -1.4113100E-10      
+LUC      = 1.3801914E-17       WUC      = -1.7655452E-17      PUC      = -8.6596870E-24      
+RDSW     = 9.0000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 8.0030420E-03       LU0      = -4.9358130E-10      
+WU0      = 6.1931930E-10       PU0      = -1.4965751E-16      A0       = 1.0128399           
+LA0      = 1.9441604E-09       WA0      = 3.4282080E-08       PA0      = -2.7097102E-14      
+KETA     = 1.9746628E-02       LKETA    = -1.2303980E-08      WKETA    = -7.3130900E-10      
+PKETA    = 5.4714090E-16       A1       = 0.00                A2       = 0.9900000           
+AGS      = 1.4739780E-02       LAGS     = 5.2128610E-08       WAGS     = 2.6946623E-09       
+PAGS     = -2.6704059E-14      B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1071579          LVOFF    = -5.0809350E-09      WVOFF    = -2.4467264E-09      
+PVOFF    = 2.4692497E-15       NFACTOR  = 1.0000000           CIT      = 1.0682475E-03       
+LCIT     = -6.5014470E-10      WCIT     = -2.9820957E-10      PCIT     = 3.3753370E-16       
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = 1.0000000E-05       ETAB     = -1.0000000E-05      DSUB     = 0.00                
+PCLM     = 0.4747727           LPCLM    = 2.5000222E-07       PDIBLC1  = 1.0000000E-06       
+PDIBLC2  = 1.0000000E-05       PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                
+PSCBE1   = 1.8738640E08        LPSCBE1  = 1.2500110E02        PSCBE2   = 5.0000000E-07       
+PVAG     = 0.00                DELTA    = 1.0000000E-02       ALPHA0   = 0.00                
+ALPHA1   = 0.143217238         BETA0    = 16.10832            KT1      = -0.2892435          
+LKT1     = -3.9008510E-09      WKT1     = 2.6791696E-09       PKT1     = 1.6897048E-15       
+KT2      = -2.7126595E-02      LKT2     = -3.3475660E-09      WKT2     = 9.2080900E-10       
+PKT2     = 1.5252189E-15       AT       = -5.0000000E04       UTE      = -0.6418697          
+LUTE     = 2.9824713E-07       WUTE     = 1.6279429E-08       PUTE     = -1.0155609E-13      
+UA1      = 1.9554529E-09       LUA1     = 7.4867650E-16       WUA1     = 3.8701010E-17       
+PUA1     = -3.8352660E-22      UB1      = -2.7104761E-18      LUB1     = -4.6238050E-25      
+WUB1     = 1.6392816E-25       PUB1     = 2.4837533E-31       UC1      = 6.1648940E-11       
+LUC1     = 8.6633470E-18       WUC1     = -7.6656470E-18      PUC1     = 2.1575117E-23       
+KT1L     = 0.00                PRT      = 0                   
+CJ       = cjp3                PB       = 0.8049122           MJ       = 0.3954951
+CJSW     = cjswp3              PBSW     = 0.8049122           MJSW     = 0.2573111
+CJSWG    = cjswgp3             PBSWG    = 0.8049122           MJSWG    = 0.2573111
+CGDO     = cgop3               CGSO     = cgop3               TCJ      = 0.0009940197
+TCJSW    = 0.0006908749        TCJSWG   = 0.0006908749        TPB      = 0.001625007
+TPBSW    = 0.001625007         TPBSWG   = 0.001625007
+JS       = 1.900E-07           JSW      = 1.00E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+LLC      = -0.0165             
+NOIMOD  = 2
+NOIA     = 2.0E19		NOIB     = 8.0E03	       NOIC	= 5.4E-12
+EM       = 3.0E07		EF       = 1.094               )

.MODEL pch3.15 PMOS	(	LMIN     = '5.000E-07-dxl3'      LMAX     = '1.200E-06-dxl3'      
+WMIN     = 2.2e-007                                           WMAX     = '5.0000E-07-dxw3'      
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp3'           TOXM     = 'toxp3'           XJ       = 1.7000001E-07       
+NCH      = 4.9500000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 3.5000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 2.0000000E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp3'          RSH      = 'rshp3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.6988225+dvthp3'
+LVTH0    = -2.9720428E-09      WVTH0    = 5.5172010E-09       PVTH0    = 7.6901610E-16       
+K1       = 0.8387554           LK1      = 2.1750221E-08       WK1      = 1.1643079E-08       
+PK1      = -1.9913423E-15      K2       = 7.7793220E-02       LK2      = -6.8253770E-09      
+WK2      = -4.3671790E-09      PK2      = -1.5062782E-16      K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 1.2585714E05        LVSAT    = -6.5014080E-03      
+UA       = 5.4351430E-10       LUA      = 3.1315486E-18       WUA      = -1.7355058E-17      
+PUA      = -3.1029357E-24      UB       = 5.0000000E-20       UC       = -1.4399180E-10      
+LUC      = 1.6977412E-17       WUC      = -2.5643291E-17      PUC      = 2.0681470E-25       
+RDSW     = 9.0000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 7.8093810E-03       LU0      = -2.7861857E-10      
+WU0      = 3.8132560E-10       PU0      = 1.1451548E-16       A0       = 1.0642401           
+LA0      = -5.5110040E-08      WA0      = -2.2344880E-08      PA0      = 3.5758840E-14       
+KETA     = 2.3581030E-02       LKETA    = -1.6560170E-08      WKETA    = -2.5508482E-09      
+PKETA    = 2.5668300E-15       A1       = 0.00                A2       = 0.9900000           
+AGS      = 6.6288150E-02       LAGS     = -5.0900910E-09      WAGS     = -2.3712159E-08      
+PAGS     = 2.6075162E-15       B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1186088          LVOFF    = 7.6296080E-09       WVOFF    = -3.5230960E-10      
+PVOFF    = 1.4444692E-16       NFACTOR  = 1.0000000           CIT      = 4.5764680E-04       
+LCIT     = 2.7622016E-11       WCIT     = 1.5922081E-11       PCIT     = -1.1152456E-17      
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = -4.2714270E-05      LETA0    = 5.8512850E-11       ETAB     = 4.2714270E-05       
+LETAB    = -5.8512850E-11      DSUB     = 0.00                PCLM     = 0.6980700           
+LPCLM    = 2.1421234E-09       WPCLM    = -1.3304762E-08      PPCLM    = 1.4768289E-14       
+PDIBLC1  = 1.0000000E-06       PDIBLC2  = -5.6985720E-04      LPDIBLC2 = 6.4364150E-10       
+PDIBLCB  = 1.0000000E-02       DROUT    = 0.00                PSCBE1   = 2.7071427E08        
+LPSCBE1  = 32.5071400          PSCBE2   = 5.0000000E-07       PVAG     = 0.00                
+DELTA    = 1.0000000E-02       ALPHA0   = 0.00                ALPHA1   = 0.143217238         
+BETA0    = 16.10832            KT1      = -0.2975647          LKT1     = 5.3356430E-09       
+WKT1     = 6.7240530E-09       PKT1     = -2.8001169E-15      KT2      = -3.1370852E-02      
+LKT2     = 1.3635577E-09       WKT2     = 1.9651503E-09       PKT2     = 3.6600010E-16       
+AT       = -5.0000000E04       UTE      = -0.3558594          LUTE     = -1.9224409E-08      
+WUTE     = -1.1138885E-07      PUTE     = 4.0155710E-14       UA1      = 2.9807412E-09       
+LUA1     = -3.8939400E-16      WUA1     = -4.8652630E-16      PUA1     = 1.9947582E-22       
+UB1      = -3.6438770E-18      LUB1     = 5.7369460E-25       WUB1     = 5.5249090E-25       
+PUB1     = -1.8292942E-31      UC1      = 5.0477020E-11       LUC1     = 2.1064192E-17       
+WUC1     = 2.2813721E-17       PUC1     = -1.2256985E-23      KT1L     = 0.00                
+PRT      = 0                   
+CJ       = cjp3                PB       = 0.8049122           MJ       = 0.3954951
+CJSW     = cjswp3              PBSW     = 0.8049122           MJSW     = 0.2573111
+CJSWG    = cjswgp3             PBSWG    = 0.8049122           MJSWG    = 0.2573111
+CGDO     = cgop3               CGSO     = cgop3               TCJ      = 0.0009940197
+TCJSW    = 0.0006908749        TCJSWG   = 0.0006908749        TPB      = 0.001625007
+TPBSW    = 0.001625007         TPBSWG   = 0.001625007
+JS       = 1.900E-07           JSW      = 1.00E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+LLC      = -0.0165             
+NOIMOD  = 2
+NOIA     = 2.0E19		NOIB     = 8.0E03	       NOIC	= 5.4E-12
+EM       = 3.0E07		EF       = 1.094               )

.MODEL pch3.16 PMOS	(	LMIN     = 3.0e-007                 LMAX     = '5.000E-07-dxl3'      
+WMIN     = 2.2e-007                                           WMAX     = '5.0000E-07-dxw3'      
+LEVEL    = 49                  TNOM     = 25.0                VERSION  = 3.24                 
+TOX      = 'toxp3'           TOXM     = 'toxp3'           XJ       = 1.7000001E-07       
+NCH      = 4.9500000E17        LLN      = -1                  LWN      = 1.0000000           
+WLN      = 1.0000000           WWN      = 1.0000000           LINT     = 3.5000000E-08       
+LL       = 0.00                LW       = 0.00                LWL      = 0.00                
+WINT     = 2.0000000E-08       WL       = 0.00                WW       = 0.00                
+WWL      = 0.00                MOBMOD   = 1                   BINUNIT  = 2                   
+XL       = '-0.02E-6+dxl3'   XW       = '0.0+dxw3'        DWG      = 0.00                
+DWB      = 0.00                ACM      = 12                  LDIF     = 9.00E-08            
+HDIF     = 'hdifp3'          RSH      = 'rshp3'           RD       = 0                   
+RS       = 0                                      
+VTH0     = '-0.7102714+dvthp3'
+LVTH0    = 1.7220052E-09       WVTH0    = -1.3011513E-09      PVTH0    = 3.5645400E-15       
+K1       = 0.9896178           LK1      = -4.0103360E-08      WK1      = -6.2613200E-08      
+PK1      = 2.8453731E-14       K2       = 5.6198710E-02       LK2      = 2.0283666E-09       
+WK2      = 1.5413164E-08       PK2      = -8.2605680E-15      K3       = 0.00                
+DVT0     = 0.00                DVT1     = 0.00                DVT2     = 0.00                
+DVT0W    = 0.00                DVT1W    = 0.00                DVT2W    = 0.00                
+NLX      = 0.00                W0       = 0.00                K3B      = 0.00                
+VSAT     = 1.2733347E05        LVSAT    = -7.1067050E-03      
+UA       = 5.6070820E-10       LUA      = -3.9179540E-18      WUA      = -3.5812070E-17      
+PUA      = 4.4644360E-24       UB       = 5.0000000E-20       UC       = -2.2165832E-10      
+LUC      = 4.8820680E-17       WUC      = 6.1397940E-18       PUC      = -1.2824250E-23      
+RDSW     = 9.0000000E02        PRWB     = 0.00                PRWG     = 0.00                
+WR       = 1.0000000           U0       = 7.6553440E-03       LU0      = -2.1546345E-10      
+WU0      = 2.9765798E-10       PU0      = 1.4881922E-16       A0       = 1.2717079           
+LA0      = -1.4017188E-07      WA0      = 1.5110158E-08       PA0      = 2.0402271E-14       
+KETA     = -1.1058724E-02      LKETA    = -2.3578717E-09      WKETA    = 6.0404470E-09       
+PKETA    = -9.5560120E-16      A1       = 0.00                A2       = 0.9900000           
+AGS      = 5.1349650E-02       LAGS     = 1.0346969E-09       WAGS     = -1.6059564E-08      
+PAGS     = -5.3004870E-16      B0       = 0.00                B1       = 0.00                
+VOFF     = -0.1000001          NFACTOR  = 1.0000000           CIT      = 5.0953650E-04       
+LCIT     = 6.3472730E-12       WCIT     = -2.3771051E-11      PCIT     = 5.1217290E-18       
+CDSC     = 0.00                CDSCB    = 0.00                CDSCD    = 0.00                
+ETA0     = -5.9333330E-04      LETA0    = 2.8426667E-10       ETAB     = 1.1133335E-03       
+LETAB    = -4.9746670E-10      DSUB     = 0.00                PCLM     = 0.9552779           
+LPCLM    = -1.0331307E-07      WPCLM    = -1.5286366E-07      PPCLM    = 7.1987430E-14       
+PDIBLC1  = 1.0000000E-06       PDIBLC2  = 1.0000000E-03       PDIBLCB  = 1.0000000E-02       
+DROUT    = 0.00                PSCBE1   = 3.1533334E08        LPSCBE1  = 14.2133340          
+PSCBE2   = 5.0000000E-07       PVAG     = 0.00                DELTA    = 1.0000000E-02       
+ALPHA0   = 0.00                ALPHA1   = 0.143217238         BETA0    = 16.10832            
+KT1      = -0.2914546          LKT1     = 2.8305438E-09       WKT1     = -4.2728600E-09      
+PKT1     = 1.7086176E-15       KT2      = -2.2502899E-02      LKT2     = -2.2723026E-09      
+WKT2     = 5.9977000E-09       PKT2     = -1.2873453E-15      AT       = -5.0000000E04       
+UTE      = -0.4071587          LUTE     = 1.8082899E-09       WUTE     = -8.5249080E-09      
+PUTE     = -2.0185026E-15      UA1      = 2.0309998E-09       UB1      = -2.3083980E-18      
+LUB1     = 2.6148351E-26       WUB1     = 3.9016210E-26       PUB1     = 2.7595218E-32       
+UC1      = 1.0124479E-10       LUC1     = 2.4940948E-19       WUC1     = -1.9569818E-17      
+PUC1     = 5.1202650E-24       KT1L     = 0.00                PRT      = 0                   
+CJ       = cjp3                PB       = 0.8049122           MJ       = 0.3954951
+CJSW     = cjswp3              PBSW     = 0.8049122           MJSW     = 0.2573111
+CJSWG    = cjswgp3             PBSWG    = 0.8049122           MJSWG    = 0.2573111
+CGDO     = cgop3               CGSO     = cgop3               TCJ      = 0.0009940197
+TCJSW    = 0.0006908749        TCJSWG   = 0.0006908749        TPB      = 0.001625007
+TPBSW    = 0.001625007         TPBSWG   = 0.001625007
+JS       = 1.900E-07           JSW      = 1.00E-12             N        = 1
+XTI      = 3                   CAPMOD   = 3                   NQSMOD   = 0
+XPART    = 1                   CF       = 0                   TLEV     = 1
+TLEVC    = 1                   CALCACM  = 1                   SFVTFLAG = 0
+LLC      = -0.0165             
+NOIMOD  = 2
+NOIA     = 2.0E19		NOIB     = 8.0E03	       NOIC	= 5.4E-12
+EM       = 3.0E07		EF       = 1.094               )

.ENDL MOS_3V

***************************************************************
*                                                             *
*              1.8V native NMOS DEVICE MODEL                  *
*                                                             *
***************************************************************
*
.LIB MOSNA

.MODEL nanch.1          NMOS   (                    LMIN     = '8.2E-07-dxlna'            
+LMAX    = 2.1E-05        WMIN     = 2.2E-07        WMAX     = 0.000101
+NOIMOD  = 2		  EM       = 4.1E07	    EF       = 0.95
+NOIA    = 2.0E20	  NOIB     = 1.0E04	    NOIC     = 5.0E-13 
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.24
+TOX     = toxna          TOXM     = toxna          XJ       = 2E-07          NCH      = 1.052E+15
+LLN     = -1             LWN      = 1              WLN      = 1
+WWN     = 1              LINT     = 2.675E-08      LL       = 0
+LW      = 0              LWL      = 0              WINT     = 2.6E-08
+WL      = 0              WW       = 0              WWL      = 0
+MOBMOD  = 1              BINUNIT  = 2              XL       = '-2E-08+dxlna'
+XW      = '0+dxwna'      DWG      = 0              DWB      = 0
+ACM     = 12             LDIF     = 9E-08          HDIF     = hdifna
+RSH     = 6.8            RD       = 0              RS       = 0
+VTH0    = '-0.01774261+dvthna' LVTH0    = 6.182923E-08   WVTH0    = -3.753495E-09
+PVTH0   = -5.377128E-15  K1       = 0.11953682     LK1      = -3.977839E-09
+WK1     = 8.240465E-09   PK1      = -1.371659E-15  K2       = -0.0449140425
+LK2     = -8.184622E-10  WK2      = -4.367525E-10  PK2      = 1.205304E-16
+K3      = 0              DVT0     = 0              DVT1     = 0
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0
+DVT2W   = 0              NLX      = 0              W0       = 0
+K3B     = 0              VSAT     = 97603.5        LVSAT    = 0.01646395
+WVSAT   = 0.003378191    PVSAT    = 5.871035E-11   UA       = 9.102442E-11
+LUA     = 2.508072E-19   WUA      = -1.036519E-17  PUA      = -2.537652E-24
+UB      = 2.023123E-18   LUB      = 7.463114E-25   WUB      = -1.589492E-26
+PUB     = -1.60874E-31   UC       = -2.064959E-11  LUC      = 6.691113E-18
+WUC     = -1.462443E-17  PUC      = 5.745368E-24   RDSW     = 68
+PRWB    = 0              PRWG     = 0              WR       = 1
+U0      = 0.0544471      LU0      = 9.232913E-10   WU0      = 2.605018E-09
+PU0     = -1.181193E-15  A0       = 1.318223       LA0      = -3.152826E-07
+WA0     = -2.414332E-07  PA0      = 2.113845E-13   KETA     = -0.007562
+A1      = 0              A2       = 0.99           AGS      = 0.01817691
+LAGS    = 1.359381E-09   WAGS     = 1.844599E-08   PAGS     = -1.375421E-14
+B0      = 0              B1       = 0              VOFF     = -0.1437579
+LVOFF   = -1.670469E-08  WVOFF    = 4.828936E-10   PVOFF    = 5.80468E-15
+NFACTOR = 1              CIT      = 0.0002597791   LCIT     = 4.032749E-10
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0
+ETA0    = 0.003399928    LETA0    = 8.502075E-10   WETA0    = 1.186005E-09
+PETA0   = -1.969099E-16  ETAB     = 0.001011681    LETAB    = -4.725199E-10
+WETAB   = 4.574829E-10   PETAB    = -1.154549E-16  DSUB     = 0
+PCLM    = 0.4528076      LPCLM    = 2.005277E-07   WPCLM    = 2.740156E-07
+PPCLM   = 1.122796E-14   PDIBLC1  = 0.03034016     LPDIBLC1 = -2.539301E-10
+WPDIBLC1= -3.441731E-09  PPDIBLC1 = 2.569253E-15   PDIBLC2  = 0.00225
+PDIBLCB = 0.1804105      LPDIBLCB = -5.115617E-10  WPDIBLCB = 2.114142E-08
+PPDIBLCB= 5.175938E-15   DROUT    = 0              PSCBE1   = 3.030791E+08
+LPSCBE1 = -0.7799484     WPSCBE1  = -0.03412339    PPSCBE1  = 2.05864E-07
+PSCBE2  = 1.5243E-07     PVAG     = 0              DELTA    = 0.003
+ALPHA1  = 1.876E-2       BETA0    = 8.1            KT1      = -0.322786
+LKT1    = 3.214286E-08   WKT1     = -4.367528E-09  PKT1     = 1.205308E-15
+KT2     = -0.002         AT       = 10000          UTE      = -1.570186
+LUTE    = 1.603067E-07   WUTE     = 4.146074E-08   PUTE     = 1.015063E-14
+UA1     = 4E-09          UB1      = -6E-18         UC1      = -2.8E-12
+KT1L    = 0              PRT      = 0              CJ       = cjna
+PB      = 0.5667062      MJ       = 0.3904209      CJSW     = cjswna
+PBSW    = 0.5667062      MJSW     = 0.0428681      CJSWG    = cjswgna
+PBSWG   = 0.5667062      MJSWG    = 0.4305378      CGDO     = cgona
+CGSO    = cgona          TCJ      = 0.001812677    TCJSW    = 0.001103346    TCJSWG   = 0.001103346
+TPB     = 0.001711098    TPBSW    = 0.001711098    TPBSWG   = 0.001711098    JS       = 8.50E-7
+JSW     = 2.50E-12       N        = 1              XTI      = 3
+CAPMOD  = 3              NQSMOD   = 0              XPART    = 1
+CF      = 0              TLEV     = 1              TLEVC    = 1
+CALCACM = 1              SFVTFLAG = 0              ALPHA0   = 0    
+LLC     = -0.03           )


.MODEL nanch.2          NMOS   (                    LMIN     = 5E-07
+LMAX    = '8.2E-07-dxlna'  WMIN     = 2.2E-07        WMAX     = 0.000101
+NOIMOD  = 2		  EM       = 4.1E07	    EF       = 0.95
+NOIA    = 2.0E20	  NOIB     = 1.0E04	    NOIC     = 5.0E-13
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.24
+TOX     = toxna          TOXM     = toxna          XJ       = 2E-07          NCH      = 1.052E+15
+LLN     = -1             LWN      = 1              WLN      = 1
+WWN     = 1              LINT     = 2.675E-08      LL       = 0
+LW      = 0              LWL      = 0              WINT     = 2.6E-08
+WL      = 0              WW       = 0              WWL      = 0
+MOBMOD  = 1              BINUNIT  = 2              XL       = '-2E-08+dxlna'
+XW      = '0+dxwna'      DWG      = 0              DWB      = 0
+ACM     = 12             LDIF     = 9E-08          HDIF     = hdifna
+RSH     = 6.8            RD       = 0              RS       = 0
+VTH0    = '0.02792398+dvthna' LVTH0    = 2.773913E-08   WVTH0    = -1.438199E-08
+PVTH0   = 2.557044E-15   K1       = 0.11404253     LK1      = 1.23647E-10
+WK1     = 8.078899E-09   PK1      = -1.25105E-15   K2       = -0.0444382913
+LK2     = -1.17361E-09   WK2      = -6.966282E-10  PK2      = 3.145276E-16
+K3      = 0              DVT0     = 0              DVT1     = 0
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0
+DVT2W   = 0              NLX      = 0              W0       = 0
+K3B     = 0              VSAT     = 154073         LVSAT    = -0.02569051
+WVSAT   = 0.00243878     PVSAT    = 7.599806E-10   UA       = 9.171293E-11
+LUA     = -2.631544E-19  WUA      = -1.733133E-17  PUA      = 2.662571E-24
+UB      = 2.770609E-18   LUB      = 1.88313E-25    WUB      = -1.480558E-25
+PUB     = -6.221591E-32  UC       = -2.834392E-11  LUC      = 1.243493E-17
+WUC     = -6.156361E-18  PUC      = -5.760438E-25  RDSW     = 68
+PRWB    = 0              PRWG     = 0              WR       = 1
+U0      = 0.05722036     LU0      = -1.146955E-09  WU0      = 9.626542E-10
+PU0     = 4.483137E-17   A0       = 0.6052103      LA0      = 2.169814E-07
+WA0     = -1.144547E-07  PA0      = 1.165951E-13   KETA     = -0.007562
+A1      = 0              A2       = 0.99           AGS      = 0.01999473
+LAGS    = 2.377243E-12   WAGS     = 5.327309E-11   PAGS     = -2.40528E-17
+B0      = 0              B1       = 0              VOFF     = -0.1601644
+LVOFF   = -4.457263E-09  WVOFF    = 2.527387E-08   PVOFF    = -1.270178E-14
+NFACTOR = 1              CIT      = 0.001565254    LCIT     = -5.712622E-10
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0
+ETA0    = -0.002726106   LETA0    = 5.423292E-09   WETA0    = -2.225066E-09
+PETA0   = 2.349455E-15   ETAB     = 0.0003545133   LETAB    = 1.805535E-11
+WETAB   = 5.475407E-10   PETAB    = -1.826831E-16  DSUB     = 0
+PCLM    = 1.5367825      LPCLM    = -6.086595E-07  WPCLM    = 5.564588E-07
+PPCLM   = -1.996159E-13  PDIBLC1  = 0.01805861     LPDIBLC1 = 8.914247E-09
+WPDIBLC1= -3.062515E-09  PPDIBLC1 = 2.286167E-15   PDIBLC2  = 0.00225
+PDIBLCB = 0.1798815      LPDIBLCB = -1.166351E-10  WPDIBLCB = 2.649413E-08
+PPDIBLCB= 1.180139E-15   DROUT    = 0              PSCBE1   = 3.005564E+08
+LPSCBE1 = 1.103308       WPSCBE1  = 0.6114948      PPSCBE1  = -2.760899E-07
+PSCBE2  = 1.5243E-07     PVAG     = 0              DELTA    = 0.003
+ALPHA1  = 1.876E-2       BETA0    = 8.1            KT1      = -0.3252268
+LKT1    = 3.396488E-08   WKT1     = -6.966276E-09  PKT1     = 3.145274E-15
+KT2     = -0.002         AT       = 10000          UTE      = -1.327971
+LUTE    = -2.05067E-08   WUTE     = 8.682543E-08   PUTE     = -2.371411E-14
+UA1     = 4E-09          UB1      = -6E-18         UC1      = -2.8E-12
+KT1L    = 0              PRT      = 0              CJ       = cjna
+PB      = 0.5667062      MJ       = 0.3904209      CJSW     = cjswna
+PBSW    = 0.5667062      MJSW     = 0.0428681      CJSWG    = cjswgna
+PBSWG   = 0.5667062      MJSWG    = 0.4305378      CGDO     = cgona
+CGSO    = cgona          TCJ      = 0.001812677    TCJSW    = 0.001103346    TCJSWG   = 0.001103346
+TPB     = 0.001711098    TPBSW    = 0.001711098    TPBSWG   = 0.001711098    JS       = 8.50E-7
+JSW     = 2.50E-12       N        = 1              XTI      = 3
+CAPMOD  = 3              NQSMOD   = 0              XPART    = 1
+CF      = 0              TLEV     = 1              TLEVC    = 1
+CALCACM = 1              SFVTFLAG = 0              ALPHA0   = 0  
+LLC     = -0.03           )

.ENDL MOSNA

***************************************************************
*                                                             *
*              3.3V native NMOS DEVICE MODEL                  *
*                                                             *
***************************************************************
*
.LIB MOSNA3

.MODEL nanch3.1         NMOS   (                    LMIN     = '1.52E-06-dxlna3'
+LMAX    = 2.1E-05        WMIN     = 2.2E-07        WMAX     = 1.01E-04
+NOIMOD  = 2		  EM       = 4.1E07	    EF       = 1.01
+NOIA    = 1.0E20	  NOIB     = 2.0E04	    NOIC     = 2.0E-13         
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.24
+TOX     = toxna3         TOXM     = toxna3         XJ       = 1.7E-07        NCH      = 5.8E+15
+LLN     = -1             LWN      = 1              WLN      = 1
+WWN     = 1              LINT     = 1.1E-07        LL       = 0
+LW      = 0              LWL      = 0              WINT     = 1.64E-08
+WL      = 0              WW       = 0              WWL      = 0
+MOBMOD  = 1              BINUNIT  = 2              XL       = '-2E-8+dxlna3'
+XW      = '0+dxwna3'     DWG      = 0              DWB      = 0
+ACM     = 12             LDIF     = 9E-08          HDIF     = hdifna3
+RSH     = 6.8            RD       = 0              RS       = 0
+VTH0    = '-0.09478436+dvthna3' LVTH0    = -3.815484E-08  WVTH0    = -1.353864E-08
+PVTH0   = -9.114775E-16  K1       = 0.07518722     LK1      = -2.494324E-08
+WK1     = 3.240441E-08   PK1      = 1.425852E-14   K2       = -0.002
+K3      = 0              DVT0     = 0              DVT1     = 0
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0
+DVT2W   = 0              NLX      = 0              W0       = 0
+K3B     = 0              VSAT     = 103854         LVSAT    = -3.55722E-05
+WVSAT   = 0.001478785    PVSAT    = 3.602473E-10   UA       = 4.923768E-11
+LUA     = 4.496429E-16   WUA      = 6.08351E-17    PUA      = -8.462483E-23
+UB      = 2.081755E-18   LUB      = 7.512439E-25   WUB      = -1.655545E-25
+PUB     = -1.596647E-31  UC       = 3.085943E-13   LUC      = -1.032446E-19
+WUC     = -5.505085E-18  PUC      = 1.045582E-24   RDSW     = 220
+PRWB    = 0              PRWG     = 0              WR       = 1
+U0      = 0.05171998     LU0      = 5.906318E-11   WU0      = 8.10373E-10
+PU0     = -5.98144E-16   A0       = 1              KETA     = -0.01830086
+LKETA   = 4.266525E-11   WKETA    = -1.773655E-09  PKETA    = -4.320807E-16
+A1      = 0              A2       = 1              AGS      = 0.79888
+LAGS    = -4.465664E-07  WAGS     = -4.177232E-08  PAGS     = 5.346858E-14
+B0      = 0              B1       = 0              VOFF     = -0.1081457
+LVOFF   = 2.321209E-09   WVOFF    = 1.475376E-09   PVOFF    = -2.350736E-14
+NFACTOR = 1              CIT      = 0.000162       CDSC     = 0
+CDSCB   = 0              CDSCD    = 0              ETA0     = 0.00172966
+LETA0   = 8.846976E-09   WETA0    = -2.508041E-10  PETA0    = -2.15119E-16
+ETAB    = 0.0009718285   LETAB    = 3.797812E-10   WETAB    = -9.240519E-11
+PETAB   = -1.219557E-16  DSUB     = 0              PCLM     = 0.5239226
+LPCLM   = 2.677888E-06   WPCLM    = -9.599169E-08  PPCLM    = 1.394485E-12
+PDIBLC1 = 9.767E-07      PDIBLC2  = 0.001081524    LPDIBLC2 = 1.821685E-10
+WPDIBLC2= -2.440943E-11  PPDIBLC2 = 2.406769E-16   PDIBLCB  = 0
+DROUT   = 0              PSCBE1   = 5.76E+08       PSCBE2   = 1E-06
+PVAG    = 8              DELTA    = 0.002          ALPHA1   = 1.771E-03
+BETA0   = 7.2            KT1      = -0.2806568     LKT1     = -1.599956E-10
+WKT1    = 6.651208E-09   PKT1     = 1.620303E-15   KT2      = -0.013
+AT      = 10000          UTE      = -1.904673      LUTE     = 1.879744E-07
+WUTE    = 5.345823E-08   PUTE     = 3.291194E-14   UA1      = 8.047672E-10
+LUA1    = -2.766493E-18  WUA1     = -4.82784E-17   PUA1     = 2.801685E-23
+UB1     = -2.512189E-18  LUB1     = -5.333165E-28  WUB1     = 2.217068E-26
+PUB1    = 5.401006E-33   UC1      = -1.3E-11       KT1L     = 0
+PRT     = 0              CJ       = cjna3          PB       = 0.5947797
+MJ      = 0.4342894      CJSW     = cjswna3        PBSW     = 0.5947797
+MJSW    = 0.0158148      CJSWG    = cjswgna3       PBSWG    = 0.5947797
+MJSWG   = 0.541221       CGDO     = cgona3         CGSO     = cgona3
+TCJ     = 0.0046087      TCJSW    = 0.007157987    TCJSWG   = 0.007157987    TPB      = 0.002492415
+TPBSW   = 0.002492415    TPBSWG  = 0.002492415     JS       = 9.80E-7        JSW      = 3.0E-12
+N       = 1              XTI      = 3              CAPMOD   = 3
+NQSMOD  = 0              XPART    = 1              CF       = 0
+TLEV    = 1              TLEVC    = 1              CALCACM  = 1
+SFVTFLAG= 0              ALPHA0   = 0              LLC     = -0.0135                 )


.MODEL nanch3.2          NMOS   (                    LMIN     = 1.2E-06
+LMAX    = '1.52E-06-dxlna3' WMIN     = 2.2E-07     WMAX     = 1.01E-04
+NOIMOD  = 2		  EM       = 4.1E07	    EF       = 1.01
+NOIA    = 1.0E20	  NOIB     = 2.0E04	    NOIC     = 2.0E-13             
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.24
+TOX     = toxna3         TOXM     = toxna3         XJ       = 1.7E-07        NCH      = 5.8E+15
+LLN     = -1             LWN      = 1              WLN      = 1
+WWN     = 1              LINT     = 1.1E-07        LL       = 0
+LW      = 0              LWL      = 0              WINT     = 1.64E-08
+WL      = 0              WW       = 0              WWL      = 0
+MOBMOD  = 1              BINUNIT  = 2              XL       = '-2E-8+dxlna3'
+XW      = '0+dxwna3'     DWG      = 0              DWB      = 0
+ACM     = 12             LDIF     = 9E-08          HDIF     = hdifna3
+RSH     = 6.8            RD       = 0              RS       = 0
+VTH0    = '-0.05361792+dvthna3' LVTH0    = -9.084788E-08  WVTH0    = -5.219657E-09
+PVTH0   = -1.155977E-14  K1       = 0.0548448      LK1      = 1.095044E-09
+WK1     = 5.220765E-08   PK1      = -1.108962E-14  K2       = -0.002
+K3      = 0              DVT0     = 0              DVT1     = 0
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0
+DVT2W   = 0              NLX      = 0              W0       = 0
+K3B     = 0              VSAT     = 118376.8       LVSAT    = -0.01862484
+WVSAT   = -0.002351273   PVSAT    = 5.262721E-09   UA       = 3.333493E-10
+LUA     = 8.597997E-17   WUA      = 1.334063E-17   PUA      = -2.383191E-23
+UB      = 2.656073E-18   LUB      = 1.611759E-26   WUB      = -1.627728E-25
+PUB     = -1.632252E-31  UC       = -9.803229E-14  LUC      = 4.17237E-19
+WUC     = -1.387119E-18  PUC      = -4.225415E-24  RDSW     = 220
+PRWB    = 0              PRWG     = 0              WR       = 1
+U0      = 0.05668826     LU0      = -6.300333E-09  WU0      = 1.190146E-10
+PU0     = 2.867948E-16   A0       = -9.648092      LA0      = 1.362956E-05
+WA0     = 1.972317E-06   PA0      = -2.524565E-12  KETA     = -0.03065319
+LKETA   = 1.585364E-08   WKETA    = -9.007868E-09  PKETA    = 8.827711E-15
+A1      = 0              A2       = 1              AGS      = 0.6133333
+LAGS    = -2.090666E-07  B0       = 0              B1       = 0
+VOFF    = -0.103894      LVOFF    = -3.1209E-09    WVOFF    = -4.158169E-08
+PVOFF   = 3.160569E-14   NFACTOR  = 1              CIT      = 0.000162
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0
+ETA0    = -0.0006868758  LETA0    = 1.194014E-08   WETA0    = -1.888288E-09
+PETA0   = 1.88086E-15    ETAB     = -4.851932E-05  LETAB    = 1.685826E-09
+WETAB   = -8.2514E-11    PETAB    = -1.346164E-16  DSUB     = 0
+PCLM    = -0.7794965     LPCLM    = 4.346263E-06   WPCLM    = 2.298267E-06
+PPCLM   = -1.670166E-12  PDIBLC1  = 9.767E-07      PDIBLC2  = 0.001225951
+LPDIBLC2= -2.697764E-12  WPDIBLC2 = 1.422751E-10   PPDIBLC2 = 2.732071E-17
+PDIBLCB = 0              DROUT    = 0              PSCBE1   = 5.76E+08
+PSCBE2  = 1E-06          PVAG     = 8              DELTA    = 0.002
+ALPHA1  = 1.771E-3       BETA0    = 7.2            KT1      = -0.2833356
+LKT1    = 3.268843E-09   WKT1     = 3.377951E-08   PKT1     = -3.310392E-14
+KT2     = -0.013         AT       = 10000          UTE      = -1.677388
+LUTE    = -1.029496E-07  WUTE     = 2.571094E-07   PUTE     = -2.277616E-13
+UA1     = 1.137785E-09   LUA1     = -4.290296E-16  WUA1     = -1.125984E-16
+PUA1    = 1.103464E-22   UB1      = -2.521118E-18  LUB1     = 1.089613E-26
+WUB1    = 1.125983E-25   PUB1     = -1.103463E-31  UC1      = -1.3E-11
+KT1L    = 0              PRT      = 0              CJ       = cjna3
+PB      = 0.5947797      MJ       = 0.4342894      CJSW     = cjswna3
+PBSW    = 0.5947797      MJSW     = 0.0158148      CJSWG    = cjswgna3
+PBSWG   = 0.5947797      MJSWG    = 0.541221       CGDO     = cgona3
+CGSO    = cgona3         TCJ      = 0.0046087      TCJSW    = 0.007157987    TCJSWG   = 0.007157987
+TPB     = 0.002492415    TPBSW    = 0.002492415    TPBSWG   = 0.002492415    JS       = 9.80E-07
+JSW     = 3.0E-12        N        = 1              XTI      = 3
+CAPMOD  = 3              NQSMOD   = 0              XPART    = 1
+CF      = 0              TLEV     = 1              TLEVC    = 1
+CALCACM = 1              SFVTFLAG = 0              ALPHA0   = 0     
+LLC      = -0.0135           )

.ENDL MOSNA3
*
***************************
*                         *
* 0.18um 1.8V PNP Bipolar *
*                         *
***************************
.LIB TT_BIP
.param
+isa= 1         bfa= 1         nfa= 1         rba= 1         rea= 1         
+rca= 1         rbma= 1        cjea= 1        cjca= 1         
.lib 'log018.l' BIP
.ENDL TT_BIP

.LIB SS_BIP
.param
+isa= 0.70      bfa= 0.85      nfa= 1.005     rba= 1.2       rea=  1.2        
+rca= 1.2       rbma= 1.2      cjea= 1.05     cjca= 1.05      
.lib 'log018.l' BIP
.ENDL SS_BIP

.LIB FF_BIP
.param
+isa= 1.30      bfa= 1.15      nfa= 0.995     rba= 0.8       rea= 0.8        
+rca= 0.8       rbma= 0.8      cjea= 0.95     cjca= 0.95      
.lib 'log018.l' BIP
.ENDL FF_BIP

.LIB BIP
*
.MODEL PNP5 PNP (                                   LEVEL  = 1                  
+ BF     = '2.775*bfa'     NF     = '1.013*nfa'     IS     = '3.5351E-18*isa'         
+ ISE    = '3.5351E-18*isa'  ISC    = '3.5351E-18*isa'  NE     = 1.3977142          
+ RB     = '54.76734*rba'  IRB    = 1.401332E-3     RBM    = '1.0965611*rbma'          
+ RE     = '1.3979963*rea' IKF    = 8.2254E-4       NKF    = 0.477972           
+ VAF    = 372.731         BR     = 4.4013E-3       NR     = 0.993881           
+ NC     = 0.98076         RC     = '20.08*rca'     IKR    = 1.98804E-4         
+ VAR    = 20.84541        XTI    = 3               EG     = 1.17               
+ XTB    = 0               TRB1   = 1.493714E-3     TIRB1  = 1.375303E-5        
+ TRM1   = 1.074565E-5     TRE1   = 1.068665E-4     TIKF1  = -2.512025E-3       
+ TIKR1  = -3.93E-3        TRC1   = 8E-5            TBF1   = 4.9E-3             
+ TBF2   = 1.1E-6          TNF1   = -1.056025E-4    TNE1   = 2.152336E-4        
+ TVAF1  = -4E-5           TBR1   = -1.01E-3        TBR2   = 1.3E-5             
+ TNC1   = 1.122277E-4     TNC2   = 0               TNR1   = -1.026101E-4       
+ TNR2   = 0               CJE    = '3.2987E-14*cjea'  VJE    = 0.895226           
+ MJE    = 0.4345495       FC     = 0               CJC    = '3.965229E-14*cjca'       
+ VJC    = 0.5846489       MJC    = 0.2933243       TLEV   = 0                  
+ TLEVC  = 1               CTE    = 2.0325E-3       CTC    = 8.900197E-4        
+ TVJE   = 1.572025E-3     TVJC   = 2.819E-3        TREF   = 25                 
+ SUBS   = 1               )
*
.MODEL PNP10 PNP (                                  LEVEL  = 1                 
+ BF     = '2.715*bfa'     NF     = '1.01*nfa'      IS     = '1.5353E-17*isa'        
+ ISE    = '1.5353E-17*isa'  ISC    = '1.5353E-17*isa'  NE     = 1.2977142         
+ RB     = '36.063401*rba' IRB    = 1.401332E-3     RBM    = '1.0965611*rbma'         
+ RE     = '1.3979963*rea' IKF    = 1.72254E-3      NKF    = 0.477972          
+ VAF    = 361.145         BR     = 0.0114433       NR     = 0.9908706         
+ NC     = 0.9007513       RC     = '20.08*rca'     IKR    = 1.98804E-4        
+ VAR    = 20.84541        XTI    = 3               EG     = 1.17              
+ XTB    = 0               TRB1   = 1.493714E-3     TIRB1  = 1.375303E-5       
+ TRM1   = 1.074565E-5     TRE1   = 1.068665E-4     TIKF1  = -3.912025E-3      
+ TIKR1  = -3.93E-3        TRC1   = 8E-5            TBF1   = 4.91E-3           
+ TBF2   = 1E-6            TNF1   = -1.0025E-4      TNE1   = 2.00234E-4        
+ TVAF1  = -5E-3           TBR1   = -3.15E-3        TBR2   = 3.5E-5            
+ TNC1   = 8.022278E-5     TNC2   = 0               TNR1   = -2.025978E-4      
+ TNR2   = 0               CJE    = '1.22024E-13*cjea'  VJE    = 0.895226          
+ MJE    = 0.4405495       FC     = 0               CJC    = '6.837658E-14*cjca'      
+ VJC    = 0.5846489       MJC    = 0.3033243       TLEV   = 0                 
+ TLEVC  = 1               CTE    = 9.300197E-4     CTC    = 2.1425E-3         
+ TVJE   = 1.572025E-3     TVJC   = 2.819E-3        TREF   = 25                
+ SUBS   = 1               )
*
.MODEL PNP2 PNP (                                   LEVEL  = 1                 
+ BF     = '2.7551*bfa'    NF     = '1.013*nfa'  IS     = '9.03515E-19*isa'       
+ ISE    = '9.03515E-19*isa'  ISC    = '9.03515E-19*isa'  NE     = 1.2977142         
+ RB     = '102.76734*rba' IRB    = 1.401332E-3     RBM    = '1.0965611*rbma'         
+ RE     = '1.297997*rea'  IKF    = 3.02541E-4      NKF    = 0.427981          
+ VAF    = 126.168         BR     = 1.3713E-3       NR     = 0.993671          
+ NC     = 0.920748        RC     = '20.08*rca'     IKR    = 1.98804E-4        
+ VAR    = 15.6151         XTI    = 3               EG     = 1.17              
+ XTB    = 0               TRB1   = 1.493714E-3     TIRB1  = 1.375303E-5       
+ TRM1   = 1.074565E-5     TRE1   = 1.068665E-4     TIKF1  = -4.31203E-3       
+ TIKR1  = -3.93E-3        TRC1   = 8E-5            TBF1   = 5.85E-3           
+ TBF2   = 3E-6            TNF1   = -1.056025E-4    TNE1   = 2.152336E-4       
+ TVAF1  = -1E-3           TBR1   = -1.5E-3         TBR2   = 1.85E-5           
+ TNC1   = 1.122198E-4     TNC2   = 0               TNR1   = -2.425601E-4      
+ TNR2   = 0               CJE    = '6.4688E-15*cjea'  VJE    = 0.895226          
+ MJE    = 0.4205495       FC     = 0               CJC    = '2.562787E-14*cjca'      
+ VJC    = 0.5846489       MJC    = 0.2833243       TLEV   = 0                 
+ TLEVC  = 1               CTE    = 8.000197E-4     CTC    = 1.9025E-3         
+ TVJE   = 1.572025E-3     TVJC   = 2.819E-3        TREF   = 25                
+ SUBS   = 1               )                                                  
*
.ENDL BIP
*************************
*                       *
* 0.18um   3.3V bipolar *
*                       *
*************************
.LIB TT_BIP3
.param
+isa3= 1         bfa3= 1         nfa3= 1         rba3= 1         rea3= 1         
+rca3= 1         rbma3= 1        cjea3= 1        cjca3= 1         
.lib 'log018.l' BIP3
.ENDL TT_BIP3

.LIB SS_BIP3
.param
+isa3= 0.70      bfa3= 0.85      nfa3= 1.005     rba3= 1.2       rea3=  1.2        
+rca3= 1.2       rbma3= 1.2      cjea3= 1.05     cjca3= 1.05      
.lib 'log018.l' BIP3
.ENDL SS_BIP3

.LIB FF_BIP3
.param
+isa3= 1.30      bfa3= 1.15      nfa3= 0.995     rba3= 0.8       rea3= 0.8        
+rca3= 0.8       rbma3= 0.8      cjea3= 0.95     cjca3= 0.95      
.lib 'log018.l' BIP3
.ENDL FF_BIP3


.LIB BIP3
*
.MODEL PNP10_3 PNP (                                  LEVEL  = 1               
+ BF     = '2.715*bfa3'    NF     = '1.011*nfa3'    IS     = '1.5353E-17*isa3'        
+ ISE    = '1.5353E-17*isa3'  ISC    = '1.5353E-17*isa3'  NE     = 1.2977142         
+ RB     = '33.063401*rba3'  IRB    = 1.401332E-3   RBM    = '1.0965611*rbma3'         
+ RE     = '1.3979963*rea3'  IKF    = 2.05254E-3    NKF    = 0.477972          
+ VAF    = 361.145         BR     = 9.0433E-3       NR     = 0.9908706         
+ NC     = 0.9007513       RC     = '20.08*rca3'    IKR    = 1.98804E-4        
+ VAR    = 27.84541        XTI    = 3               EG     = 1.17              
+ XTB    = 0               TRB1   = 1.493714E-3     TIRB1  = 1.375303E-5       
+ TRM1   = 1.074565E-5     TRE1   = 1.068665E-4     TIKF1  = -3.912025E-3      
+ TIKR1  = -3.93E-3        TRC1   = 8E-5            TBF1   = 5.11E-3           
+ TBF2   = 1E-6            TNF1   = -1.0025E-4      TNE1   = 2.00234E-4        
+ TVAF1  = -5E-3           TBR1   = -1.95E-3        TBR2   = 2.25E-5           
+ TNC1   = 8.022278E-5     TNC2   = 0               TNR1   = -2.025978E-4      
+ TNR2   = 0               CJE    = '1.124556E-13*cjea3'  VJE    = 0.8049122         
+ MJE    = 0.3845495       FC     = 0               CJC    = '6.353976E-14*cjca3'      
+ VJC    = 0.5846489       MJC    = 0.2883243       TLEV   = 0                
+ TLEVC  = 1               CTE    = 9.700197E-4     CTC    = 1.9425E-3        
+ TVJE   = 1.625007E-3     TVJC   = 2.819E-3        TREF   = 25               
+ SUBS   = 1               )                                                  
*
.MODEL PNP5_3 PNP (                                   LEVEL  = 1         
+ BF     = '2.725*bfa3'    NF     = '1.011*nfa3'  IS     = '3.5351E-18*isa3'      
+ ISE    = '3.5351E-18*isa3'  ISC    = '3.5351E-18*isa3'  NE     = 1.3977142       
+ RB     = '54.76734*rba3'  IRB    = 1.401332E-3    RBM    = '1.0965611*rbma3'       
+ RE     = '1.3979963*rea3'  IKF    = 1.1254E-3     NKF    = 0.477972        
+ VAF    = 372.731         BR     = 3.5513E-3       NR     = 0.993881        
+ NC     = 0.98076         RC     = '20.08*rca3'    IKR    = 1.98804E-4      
+ VAR    = 22.44541        XTI    = 3               EG     = 1.17            
+ XTB    = 0               TRB1   = 1.493714E-3     TIRB1  = 1.375303E-5     
+ TRM1   = 1.074565E-5     TRE1   = 1.068665E-4     TIKF1  = -2.752025E-3    
+ TIKR1  = -3.93E-3        TRC1   = 8E-5            TBF1   = 5.2E-3          
+ TBF2   = 1.1E-6          TNF1   = -1.056025E-4    TNE1   = 2.152336E-4     
+ TVAF1  = -4E-5           TBR1   = -1.01E-3        TBR2   = 1.3E-5          
+ TNC1   = 1.122277E-4     TNC2   = 0               TNR1   = -1.026101E-4    
+ TNR2   = 0               CJE    = '3.034505E-14*cjea3'    VJE    = 0.8049122         
+ MJE    = 0.3745495       FC     = 0               CJC    = '3.728498E-14*cjca3'    
+ VJC    = 0.5846489       MJC    = 0.2783243       TLEV   = 0               
+ TLEVC  = 1               CTE    = 9.500197E-4     CTC    = 2.0325E-3      
+ TVJE   = 1.625007E-3     TVJC   = 3.009E-3        TREF   = 25             
+ SUBS   = 1               )                                                 
*
.MODEL PNP2_3 PNP (                                   LEVEL  = 1               
+ BF     = '2.7351*bfa3'   NF     = '1.012*nfa3'   IS     = '8.03515E-19*isa3'     
+ ISE    = '8.03515E-19*isa3'  ISC    = '8.03515E-19*isa3'  NE     = 1.2977142       
+ RB     = '102.76734*rba3'  IRB    = 1.401332E-3   RBM    = '1.0965611*rbma3'       
+ RE     = '1.297997*rea3' IKF    = 4.02541E-4      NKF    = 0.427981        
+ VAF    = 126.168         BR     = 1.1153E-3       NR     = 1.013671        
+ NC     = 0.920748        RC     = '20.08*rca3'    IKR    = 1.98804E-4      
+ VAR    = 20.0151         XTI    = 3               EG     = 1.17            
+ XTB    = 0               TRB1   = 1.493714E-3     TIRB1  = 1.375303E-5     
+ TRM1   = 1.074565E-5     TRE1   = 1.068665E-4     TIKF1  = -4.31203E-3     
+ TIKR1  = -3.93E-3        TRC1   = 8E-5            TBF1   = 5.85E-3         
+ TBF2   = 3E-6            TNF1   = -1.056025E-4    TNE1   = 2.152336E-4     
+ TVAF1  = -1E-3           TBR1   = -1.5E-3         TBR2   = 1.65E-5         
+ TNC1   = 1.122198E-4     TNC2   = 0               TNR1   = -2.425601E-4    
+ TNR2   = 0               CJE    = '5.92616E-15*cjea3'  VJE    = 0.8049122         
+ MJE    = 0.3495495       FC     = 0               CJC    = '2.432423E-14*cjca3'    
+ VJC    = 0.5846489       MJC    = 0.2673243       TLEV   = 0              
+ TLEVC  = 1               CTE    = 9.000197E-4     CTC    = 1.9025E-3      
+ TVJE   = 1.625007E-3     TVJC   = 2.959E-3        TREF   = 25              
+ SUBS   = 1               )                                                 
*                                                                            
.ENDL BIP3
*
*************************
*                       *
* 0.18um   1.8V diode   *
*                       *
*************************
*
.LIB DIO
*
.MODEL NDIO D (                                     LEVEL  = 3
+ IS     = 3.50E-7         RS     = 1.0E-10         N      = 1.03
+ BV     = 11.10           IBV    = 1E-3            IK     = 1E20
+ IKR    = 1E10            JSW    = 4.00E-13        AREA   = 7.5E-8
+ PJ     = 1.1E-3          CJ     = 1.000266E-3     PB     = 0.6882682
+ MJ     = 0.3595262       CJSW   = 2.040547E-10    PHP    = 0.6882682
+ MJSW   = 0.2003879       TLEV   = 1               EG     = 1.17
+ XTI    = 3               TCV    = -9.3E-4         TRS    = 1.62E-3
+ TLEVC  = 1               CTA    = 1.040287E-3     CTP    = 6.45489E-4
+ TPB    = 1.554306E-3     TPHP   = 1.554306E-3     TREF   = 25
+ FC     = 0               FCS    = 0               )
*
.MODEL PDIO D (                                     LEVEL  = 3
+ IS     = 2.50E-7         RS     = 1.0E-10         N      = 1.03
+ BV     = 10.1            IBV    = 1E-3            IK     = 1E20
+ IKR    = 1E10            JSW    = 4.00E-13        AREA   = 7.5E-8
+ PJ     = 1.1E-3          CJ     = 1.121E-3        PB     = 0.895226
+ MJ     = 0.4476          CJSW   = 2.481E-10       PHP    = 0.895226
+ MJSW   = 0.3683619       TLEV   = 1               EG     = 1.17
+ XTI    = 3               TCV    = -8.8E-4         TRS    = 1.2E-4
+ TLEVC  = 1               CTA    = 9.739001E-4     CTP    = 4.130718E-4
+ TPB    = 1.572025E-3     TPHP   = 1.572025E-3     TREF   = 25
+ FC     = 0               FCS    = 0               )
*
.MODEL NWDIO D (                                    LEVEL  = 3
+ IS     = 6.50E-7         RS     = 1.0E-10         N      = 1.03
+ BV     = 14.75           IBV    = 1E-3            IK     = 1E20
+ IKR    = 1E10            JSW    = 9.75E-13        AREA   = 7.5E-8
+ PJ     = 1.1E-3          CJ     = 1.337566E-4     PB     = 0.5846489
+ MJ     = 0.3883243       CJSW   = 5.333577E-10    PHP    = 0.5846489
+ MJSW   = 0.2345684       TLEV   = 1               EG     = 1.17
+ XTI    = 3               TCV    = -9.6E-4         TRS    = 1.125E-3
+ TLEVC  = 1               CTA    = 2.8425E-3       CTP    = 1.5284E-3
+ TPB    = 2.819E-3        TPHP   = 2.819E-3        TREF   = 25
+ FC     = 0               FCS    = 0               )
*
.ENDL DIO
*
*********************************
*                               *
* 0.18um   3.3V and ESD diode   *
*                               *
*********************************
*
.LIB DIO3
*
.MODEL NDIO_3 D (                                     LEVEL  = 3
+ IS     = 3.93E-7         RS     = 1.0E-10         N      = 1.0
+ BV     = 10.84           IBV    = 1E-3            IK     = 1E20
+ IKR    = 1E10            JSW    = 3.54E-13        AREA   = 7.5E-8
+ PJ     = 1.1E-3          CJ     = 8.964788E-4     PB     = 0.7076023
+ MJ     = 0.3259624       CJSW   = 2.50664E-10     PHP    = 0.7076023
+ MJSW   = 0.1513672       TLEV   = 1               EG     = 1.17
+ XTI    = 3               TCV    = -8.33E-4        TRS    = 1.62E-3
+ TLEVC  = 1               CTA    = 9.923959E-4     CTP    = 5.019466E-4
+ TPB    = 1.687207E-3     TPHP   = 1.687207E-3     TREF   = 25
+ FC     = 0               FCS    = 0               )
*
.MODEL PDIO_3 D (                                     LEVEL  = 3
+ IS     = 1.900E-7        RS     = 1.0E-10         N      = 1.0
+ BV     = 10.3            IBV    = 1E-3            IK     = 1E20
+ IKR    = 1E10            JSW    = 5.02E-13        AREA   = 7.5E-8
+ PJ     = 1.1E-3          CJ     = 1.03531E-3      PB     = 0.8049122
+ MJ     = 0.3954951       CJSW   = 2.23115E-10     PHP    = 0.8049122
+ MJSW   = 0.2573111       TLEV   = 1               EG     = 1.17
+ XTI    = 3               TCV    = -8.1E-4         TRS    = 1.2E-4
+ TLEVC  = 1               CTA    = 9.940197E-4     CTP    = 6.908749E-4
+ TPB    = 1.625007E-3     TPHP   = 1.625007E-3     TREF   = 25
+ FC     = 0               FCS    = 0               )
*
.MODEL NWDIO_3 D (                                    LEVEL  = 3
+ IS     = 6.50E-7         RS     = 1.0E-10         N      = 1.03
+ BV     = 14.75           IBV    = 1E-3            IK     = 1E20
+ IKR    = 1E10            JSW    = 9.75E-13        AREA   = 7.5E-8
+ PJ     = 1.1E-3          CJ     = 1.337566E-4     PB     = 0.5846489
+ MJ     = 0.3883243       CJSW   = 5.333577E-10    PHP    = 0.5846489
+ MJSW   = 0.2345684       TLEV   = 1               EG     = 1.17
+ XTI    = 3               TCV    = -9.6E-4         TRS    = 1.125E-3
+ TLEVC  = 1               CTA    = 2.8425E-3       CTP    = 1.5284E-3
+ TPB    = 2.819E-3        TPHP   = 2.819E-3        TREF   = 25
+ FC     = 0               FCS    = 0               )
*
***************************************************************
*                                                             *
*                                                             *
*                      MODEL OF ESD DIODE                     *
*                                                             *
*                                                             *
*                                                             *
***************************************************************
.MODEL ENDIO_3 D (                                   LEVEL  = 3
+ CJ     = 1.416999E-3     PB     = 0.6798575
+ MJ     = 0.3357974       TREF   = 25
+ FC     = 0               FCS    = 0               )
*
.ENDL DIO3
*
********************************
*                              *
*   0.18um  resistor model     *
*                              *
********************************
*
.LIB TT_RES
.param
+r_rnod	    = 6.82    r_rnodw    = 6.82    r_rpod  = 7.76    r_rpodw  = 7.76    
+r_rnodrpo  = 59      r_rpodrpo  = 133     r_rnwod = 440     r_rnwsti = 927    
+r_rnpo1    = 7.89    r_rnpo1w   = 7.89    r_rppo1 = 7.9     r_rppo1w = 7.9
+r_rnpo1rpo = 292     r_rppo1rpo = 311     
+r_rm1      = 0.078   r_rm2      = 0.078   r_rm3   = 0.078   r_rm4    = 0.078
+r_rm5      = 0.078   r_rm6      = 0.036       
.lib 'log018.l' RES
.ENDL TT_RES
*
.LIB SS_RES
.param
+r_rnod	    = '6.82 +2.5'    r_rnodw    = '6.82 +2.5'   r_rpod  = '7.76 +3'     r_rpodw  = '7.76 +3'   
+r_rnodrpo  = '59   +5.8'    r_rpodrpo  = '133  +19'    r_rnwod = '440  +100'   r_rnwsti = '927  +132'  
+r_rnpo1    = '7.89 +2'      r_rnpo1w   = '7.89 +2'     r_rppo1 = '7.9  +2.5'   r_rppo1w = '7.9  +2.5'
+r_rnpo1rpo = '292  +43.8'   r_rppo1rpo = '311  +46.65' 
+r_rm1      = '0.078+0.023'  r_rm2      = '0.078+0.023' r_rm3   = '0.078+0.023' r_rm4    = '0.078+0.023'
+r_rm5      = '0.078+0.023'  r_rm6      = '0.036+0.009'       
.lib 'log018.l' RES
.ENDL SS_RES
*
.LIB FF_RES
.param
+r_rnod	    = '6.82 -2.5'    r_rnodw    = '6.82 -2.5'   r_rpod  = '7.76 -3'     r_rpodw  = '7.76 -3'   
+r_rnodrpo  = '59   -5.8'    r_rpodrpo  = '133  -19'    r_rnwod = '440  -100'   r_rnwsti = '927  -132'  
+r_rnpo1    = '7.89 -2'      r_rnpo1w   = '7.89 -2'     r_rppo1 = '7.9  -2.5'   r_rppo1w = '7.9  -2.5'
+r_rnpo1rpo = '292  -43.8'   r_rppo1rpo = '311  -46.65' 
+r_rm1      = '0.078-0.023'  r_rm2      = '0.078-0.023' r_rm3   = '0.078-0.023' r_rm4    = '0.078-0.023'
+r_rm5      = '0.078-0.023'  r_rm6      = '0.036-0.009'       
.lib 'log018.l' RES
.ENDL FF_RES
*
.LIB RES
**************************************************************************
.subckt rnod n1 n2 l=length w=width mf=1
.param rsh=r_rnod dw=-0.0765u ptc1=3.35e-3 ptc2=4.31e-7 pvc1=7.56e-5 pvc2=1.24e-3 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh/mf*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rnod

.subckt rnodw n1 n2 l=length w=width mf=1
.param rsh=r_rnodw dw=-0.0765u ptc1=3.35e-3 ptc2=4.31e-7 pvc1=7.56e-5 pvc2=1.24e-3 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh/mf*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rnodw

.subckt rpod n1 n2 l=length w=width mf=1
.param rsh=r_rpod dw=-0.08u ptc1=3.44e-3 ptc2=5.02e-7 pvc1=-2.51e-4 pvc2=1.03e-3 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh/mf*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rpod

.subckt rpodw n1 n2 l=length w=width mf=1
.param rsh=r_rpodw dw=-0.08u ptc1=3.44e-3 ptc2=5.02e-7 pvc1=-2.51e-4 pvc2=1.03e-3 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh/mf*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rpodw

.subckt rnodrpo n1 n2 l=length w=width mf=1
.param rsh=r_rnodrpo dw=0.0u ptc1=1.47e-3 ptc2=8.32e-7 pvc1=7.55e-4 pvc2=1.97e-4 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh/mf*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rnodrpo

.subckt rpodrpo n1 n2 l=length w=width mf=1
.param rsh=r_rpodrpo dw=0.00u ptc1=1.43e-3 ptc2=7.82e-7 pvc1=-1.19e-3 pvc2=-1.80e-4 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh/mf*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rpodrpo

.subckt rnwod n1 n2 l=length w=width mf=1
.param rsh=r_rnwod dw=0.141u ptc1=3.68e-3 ptc2=9.54e-6 pvc1=2.77e-3 pvc2=2.49e-4 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh/mf*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rnwod

.subckt rnwsti n1 n2 l=length w=width mf=1
.param rsh=r_rnwsti dw=0.182u ptc1=2.97e-3 ptc2=1.10e-5 pvc1=8.06e-3 pvc2=-3.32e-4 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh/mf*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rnwsti

.subckt rnpo1 n1 n2 l=length w=width mf=1
.param rsh=r_rnpo1 dw=-0.057u ptc1=2.92e-3 ptc2=2.66e-7 pvc1=1.35e-3 pvc2=7.15e-3 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh/mf*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rnpo1

.subckt rnpo1w n1 n2 l=length w=width mf=1
.param rsh=r_rnpo1w dw=-0.057u ptc1=2.92e-3 ptc2=2.66e-7 pvc1=1.35e-3 pvc2=7.15e-3 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh/mf*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rnpo1w

.subckt rppo1 n1 n2 l=length w=width mf=1
.param rsh=r_rppo1 dw=-0.025u ptc1=2.88e-3 ptc2=5.01e-7 pvc1=-7.89e-4 pvc2=6.19e-3 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh/mf*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rppo1

.subckt rppo1w n1 n2 l=length w=width mf=1
.param rsh=r_rppo1w dw=-0.025u ptc1=2.88e-3 ptc2=5.01e-7 pvc1=-7.89e-4 pvc2=6.19e-3 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh/mf*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rppo1w

.subckt rnpo1rpo n1 n2 l=length w=width mf=1
.param Rend0=3.2586e-5 Rsh=r_rnpo1rpo dl=-0.04225e-6 dw=0.091373e-6
.param pt='temper'
.param pvce1=2.7643e3 pvce2=0.0014 pvce3=0.3712 ptce1=-1.372e-3 ptce2=-1.680e-5
.param pvcp1=-0.0187 pvcp2=1.6513e-5 pvcp3=-2.0496 ptcp1=-1.184e-3 ptcp2=1.3835e-6
.param tface='1.0+ptce1*(pt-25.0)+ptce2*(pt-25.0)*(pt-25.0)'
.param tfacp='1.0+ptcp1*(pt-25.0)+ptcp2*(pt-25.0)*(pt-25.0)'
Rend1 n1 3 'Rend0/mf/(w-dw)*tface*(1+pvce1*(tanh(pvce2*abs(v(n1,3))+pvce3)-tanh(pvce3)))'
Rpure 3 4 'Rsh/mf*(l-dl)/(w-dw)*tfacp*(1+pvcp1*(tanh(pvcp2*abs(v(3,4)/(l-dl))+pvcp3)-tanh(pvcp3)))'
Rend2 4 n2 'Rend0/mf/(w-dw)*tface*(1+pvce1*(tanh(pvce2*abs(v(4,n2))+pvce3)-tanh(pvce3)))'
.ends rnpo1rpo

.subckt rppo1rpo n1 n2 l=length w=width mf=1
.param Rend0=7.2135e-5 Rsh=r_rppo1rpo dl=0.0006e-6 dw=0.06165e-6
.param pt='temper'
.param pvce1=-0.0145 pvce2=62.8187 pvce3=-2.2165 ptce1=-1.692e-3 ptce2=-9.616e-6
.param pvcp1=-0.0011 pvcp2=3.2532e-5 pvcp3=-4.3249 ptcp1=-7.541e-5 ptcp2=3.561e-7
.param tface='1.0+ptce1*(pt-25.0)+ptce2*(pt-25.0)*(pt-25.0)'
.param tfacp='1.0+ptcp1*(pt-25.0)+ptcp2*(pt-25.0)*(pt-25.0)'
Rend1 n1 3 'Rend0/mf/(w-dw)*tface*(1+pvce1*(tanh(pvce2*abs(v(n1,3))+pvce3)-tanh(pvce3)))'
Rpure 3 4 'Rsh/mf*(l-dl)/(w-dw)*tfacp*(1+pvcp1*(tanh(pvcp2*abs(v(3,4)/(l-dl))+pvcp3)-tanh(pvcp3)))'
Rend2 4 n2 'Rend0/mf/(w-dw)*tface*(1+pvce1*(tanh(pvce2*abs(v(4,n2))+pvce3)-tanh(pvce3)))'
.ends rppo1rpo

.subckt rm1 n1 n2 l=length w=width mf=1
.param rsh=r_rm1 dw=0.03u ptc1=3.43e-3 ptc2=-1.08e-6 pvc1=0 pvc2=0 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh/mf*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rm1

.subckt rm2 n1 n2 l=length w=width mf=1
.param rsh=r_rm2 dw=0.03u ptc1=3.43e-3 ptc2=-1.08e-6 pvc1=0 pvc2=0 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh/mf*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rm2

.subckt rm3 n1 n2 l=length w=width mf=1
.param rsh=r_rm3 dw=0.03u ptc1=3.43e-3 ptc2=-1.08e-6 pvc1=0 pvc2=0 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh/mf*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rm3

.subckt rm4 n1 n2 l=length w=width mf=1
.param rsh=r_rm4 dw=0.03u ptc1=3.43e-3 ptc2=-1.08e-6 pvc1=0 pvc2=0 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh/mf*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rm4

.subckt rm5 n1 n2 l=length w=width mf=1
.param rsh=r_rm5 dw=0.03u ptc1=3.43e-3 ptc2=-1.08e-6 pvc1=0 pvc2=0 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh/mf*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rm5

.subckt rm6 n1 n2 l=length w=width mf=1
.param rsh=r_rm6 dw=0.04u ptc1=3.60e-3 ptc2=-1.16e-7 pvc1=0 pvc2=0 pt='temper'
.param tfac='1.0+ptc1*(pt-25.0)+ptc2*(pt-25.0)*(pt-25.0)'
r1 n1 n2 'rsh/mf*l/(w-dw)*(1+pvc1*abs(v(n2,n1))+pvc2*v(n2,n1)*v(n2,n1))*tfac'
.ends rm6

.ENDL RES
