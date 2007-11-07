!BOP
!
! !MODULE: tetra_internal
!
! !INTERFACE:
      module tetra_internal
       
      integer(4) :: nirkp                 ! Number of irreducible k-points
      
      integer(4) :: ntet                  ! Total number of tetrahedra
      
      integer(4) :: ncore                 ! Maximum number of core states

      integer(4) :: nband                 ! Maximum number of bands.
       
      integer(4), pointer :: tetcorn(:,:) ! Id. numbers of the corner of
!                                           the tetrahedra
 
      integer(4), pointer :: tetweig(:)   ! Weight of each tetrahedron
      
      integer(4), pointer :: qweig(:,:)    ! Weight of each q-point
 
      integer(4), pointer :: tetln(:)     ! linked tetrahedron for q.
       
      real(8) :: vt                       ! Relative volume of the
!                                           tetrahedra      
      
      real(8)   , pointer :: eband(:,:)   ! Band energies

      real(8)   , pointer :: ecore(:)     ! core energies
       
      real(8)  :: omgga                  ! the frequency to be included

      integer(4)  :: sgnfrq              ! a sign to tell which weight to 
!                                          be calculated


      end module tetra_internal
!EOC      

!<sag>
! Copyright (C) 2004-2007 S. Sagmeister and C. Ambrosch-Draxl.
! This file is distributed under the terms of the GNU General Public License.
! See the file COPYING for license details.

module control
  implicit none
  ! interface parameter
  character(32), save :: tetraifc
  ! default to WIEN2k style (corresponding to original version)
  data tetraifc /'wien2k'/
  ! level of debug output
  integer, save :: tetradbglv
  ! high default value to mimic original version that outputs a lot of
  ! information
  data tetradbglv / 1000 /
  ! handling of pointers
  integer, save :: pointerhandling
  ! default is 0 (original version); 1...explicit target assignment in
  ! routine "tetcw"
  data pointerhandling / 0 /
  ! resonance type: 1...resonant term; 2...anti-resonant term; 0...both terms
  integer :: restype
  ! initialize with "0" according to original version
  data restype / 0 /                 
end module control

! set interface parameter
subroutine tetrasetifc(val)
  use control
  implicit none
  ! arguments
  character(*), intent(in) :: val
  ! local variables
  integer :: pass
  tetraifc=trim(adjustl(val))
  select case(trim(tetraifc))
     case('wien2k')
        pass=0
     case('exciting')
        pass=0
     case default
        pass=1
        write(*,*)
        write(*,'(a)') 'Error(libbzint): proper interface parameters are: &
             &"wien2k" and "exciting"'
        stop
  end select
!!$  write(*,*) 'tetraifc: ',val
end subroutine tetrasetifc

! set debug level
subroutine tetrasetdbglv(val)
  use control
  implicit none
  ! arguments
  integer, intent(in) :: val
  tetradbglv=val
!!$  write(*,*) 'tetradbglv: ',val
end subroutine tetrasetdbglv

! set pointer handling
subroutine tetrasetpointerhandling(val)
  use control
  implicit none
  ! arguments
  integer, intent(in) :: val
  ! local variables
  integer :: pass
  select case(val)
     case(0)
        pass=0
     case(1)
        pass=0
     case(2)
        pass=0
     case default
        pass=1
        write(*,*)
        write(*,'(a)') 'Error(libbzint): proper pointer-handling parameters &
             &are: "0" and "1"'
        stop
  end select
  pointerhandling=val
!!$  write(*,*) 'pointerhandling: ',val
end subroutine tetrasetpointerhandling

! set type of response function
subroutine tetrasetresptype(val)
  use control
  implicit none
  ! arguments
  integer, intent(in) :: val
  ! local variables
  integer :: pass
  select case(val)
     case(0)
        pass=0
     case(1)
        pass=0
     case(2)
        pass=0
     case default
        pass=1
        write(*,*)
        write(*,'(a)') 'Error(libbzint): proper response-type parameters are: &
             &"0", "1" and "2"'
        stop
  end select
  restype=val
!!$  write(*,*) 'restype: ',val
end subroutine tetrasetresptype

!</sag>
