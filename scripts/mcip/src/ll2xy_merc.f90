SUBROUTINE ll2xy_merc (phi, lambda, lambda0, xx, yy)

!-------------------------------------------------------------------------------
! Name:     Latitude-Longitude to (X,Y) for Mercator Projection
! Purpose:  Calcluates (X,Y) from origin for a given latitude-longitude pair
!           and Mercator projection information.
! Notes:    Equations taken from "Map Projections: Theory and Applications"
!           by Frederick Pearson, II (1990), pp. 190-192.
! Revised:  23 Sep 2009  Original version.  (T. Otte)
!           12 Feb 2010  Removed unused variable FAC.  (T. Otte)
!-------------------------------------------------------------------------------

  USE const, ONLY: rearth

  IMPLICIT NONE

  REAL(8)                      :: deg2rad ! convert degrees to radians
  REAL(8)                      :: drearth ! earth radius [m]
  REAL,          INTENT(IN)    :: lambda0 ! center longitude [deg]
  REAL(8)                      :: lambda0rad ! center longitude [rad]
  REAL,          INTENT(IN)    :: lambda  ! longitude [deg]
  REAL(8)                      :: lambdarad ! longitude [rad]
  REAL,          INTENT(IN)    :: phi     ! latitude [deg]
  REAL(8)                      :: phirad  ! latitude [rad]
  REAL(8)                      :: pi
  REAL(8)                      :: piover4 ! pi/4
  REAL,          INTENT(OUT)   :: xx      ! X-coordinate from origin
  REAL,          INTENT(OUT)   :: yy      ! Y-coordinate from origin

!-------------------------------------------------------------------------------
! Compute constants.
!-------------------------------------------------------------------------------

  piover4 = DATAN(1.0d0)
  pi      = 4.0d0 * piover4
  deg2rad = pi / 1.8d2

  drearth = DBLE(rearth)

!-------------------------------------------------------------------------------
! Compute Cartesian coordinates, XX and YY.
!-------------------------------------------------------------------------------

  phirad     = DBLE(phi)     * deg2rad  ! convert degrees to radians
  lambdarad  = DBLE(lambda)  * deg2rad  ! convert degrees to radians
  lambda0rad = DBLE(lambda0) * deg2rad  ! convert degrees to radians

  xx  = REAL( drearth * (lambdarad - lambda0rad) )
  yy  = REAL( drearth * DLOG( DTAN( piover4 + (phirad/2.0d0) ) ) )

END SUBROUTINE ll2xy_merc
