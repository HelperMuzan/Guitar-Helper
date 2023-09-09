'Initialization
$Resize:On
$ExeIcon:'.\ico\icon.ico'

_Title "Guitar Helper by Helper Muzan"

MainScreen = _NewImage(1600, 900, 32)
Screen MainScreen

'Load essentials
iconIMG& = _LoadImage("icon16.png")
If iconIMG& < -1 Then
    _Icon iconIMG&
    _FreeImage iconIMG&
End If

HelveticaFont& = _LoadFont(_CWD$ + "\res\HelveticaNeueLight.ttf", 20)
GuitarNeck& = _LoadImage(_CWD$ + "\img\g2910.png")
img& = _LoadImage(_CWD$ + "\img\g3827.png")

Dim Accepted_Strings(11) As String
Accepted_Strings(0) = "maj"
Accepted_Strings(1) = "major"
Accepted_Strings(2) = "major scale"
Accepted_Strings(3) = "min"
Accepted_Strings(4) = "minor"
Accepted_Strings(5) = "minor scale"
Accepted_Strings(6) = "min pentatonic"
Accepted_Strings(7) = "minor pentatonic"
Accepted_Strings(8) = "pentatonic"
Accepted_Strings(9) = "min pent"
Accepted_Strings(10) = "pent"
Accepted_Strings(11) = "pentatonic"

_Font HelveticaFont&

'Program Loop
Do
    Cls
    Line (800, -100)-(800, 900), _RGB32(255)
    _PutImage (1000, 128), GuitarNeck&


    StringAccepted = 0
    Print "============================================================="
    Print , "    Guitar Helper By Helper Muzan"
    Print "============================================================="
    For I = 0 To 11
        Print "Note("; I; ") = ", GetNotes$(I)
    Next I

    Print "============================================================="
    Do
        Input "Root Note: ", r
        Input "Scale Type (Maj, Min, Min Pentatonic)? ", ScaleType$

        'Checks if the input is correct
        For J = 0 To 11:
            If LCase$(ScaleType$) = Accepted_Strings(J) Then
                StringAccepted = 1
                If J < 6 Then
                    If J < 3 Then
                        ScaleType$ = "maj"
                    Else
                        ScaleType$ = "min"
                    End If
                End If
                If J > 6 Then
                    ScaleType$ = "pentatonic"
                End If
            End If
        Next

        'For input incorrect:
        If r > 11 Or StringAccepted = 0 Then
            Print "Input invalid. Please try again."
        End If

    Loop Until r <= 11 And StringAccepted = 1

    Print PrintScale$(r, ScaleType$)

    If ScaleType$ = "maj" Then
        Print "Major keys: I, IV, V"
        Print "Minor keys: II, III, VI"
        Print "Diminished key: VII"

    ElseIf ScaleType$ = "pentatonic" Then
        pass = DisplayScrollingImage(1000, 128, r + 5, img&)
    End If

    Input "", inpt$
Loop Until LCase$(inpt$) = "exit"

'Terminate the system
System

'$include: '.\res\NotePointer.bas'
'$Include: '.\res\DisplayScales.bas'
