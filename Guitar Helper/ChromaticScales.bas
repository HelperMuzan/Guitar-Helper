'Initialization
$Resize:On
$ExeIcon:'.\ico\icon.ico'




_Title "Scales"

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



'On-ready assign variables
Dim Notes(11) As String
Notes(0) = "A "
Notes(1) = "A#"
Notes(2) = "B "
Notes(3) = "C "
Notes(4) = "C#"
Notes(5) = "D "
Notes(6) = "D#"
Notes(7) = "E "
Notes(8) = "F "
Notes(9) = "F#"
Notes(10) = "G "
Notes(11) = "G#"

Dim Accepted_Strings(9) As String
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
        Print "Note("; I; ") = ", Notes(I)
    Next I

    Print "============================================================="
    Do
        Input "Root Note: ", r
        Input "Scale Type (Maj, Min, Min Pentatonic)? ", ScaleType$

        'Checks if the input is correct
        For J = 0 To 9:
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

    If ScaleType$ = "maj" Then
        Print PrintScale$(r, "maj")
        Print "Major keys: I, IV, V"
        Print "Minor keys: II, III, VI"
        Print "Diminished key: VII"
    ElseIf ScaleType$ = "min" Then
        Print PrintScale$(r, "min")
    ElseIf ScaleType$ = "pentatonic" Then
        pass = DisplayScrollingImage(1000, 128, r, img&)

    End If
    Input "", inpt$
Loop Until LCase$(inpt$) = "exit"

'Terminate the system
System

Function PrintScale$ (root, scale$)
    Dim Notes(11) As String
    Notes(0) = "A "
    Notes(1) = "A#"
    Notes(2) = "B "
    Notes(3) = "C "
    Notes(4) = "C#"
    Notes(5) = "D "
    Notes(6) = "D#"
    Notes(7) = "E "
    Notes(8) = "F "
    Notes(9) = "F#"
    Notes(10) = "G "
    Notes(11) = "G#"

    Dim keys(6) As Integer

    If LCase$(scale$) = "maj" Then
        keys(0) = root 'half step
        keys(1) = root + 2 'whole step
        keys(2) = root + 4 'whole step
        keys(3) = root + 5 'half step
        keys(4) = root + 7 'whole step
        keys(5) = root + 9 'whole step
        keys(6) = root + 11 'whole step

        For J = 0 To 6
            If keys(J) > 11 Then
                keys(J) = keys(J) - 12
            End If
        Next J

    ElseIf LCase$(scale$) = "min" Then
        keys(0) = r 'whole step
        keys(1) = r + 2 'whole step
        keys(2) = r + 3 'half step
        keys(3) = r + 5 'whole step
        keys(4) = r + 7 'whole step
        keys(5) = r + 8 'half step
        keys(6) = r + 10 'whole step

        For J = 0 To 6
            If keys(J) > 11 Then
                keys(J) = keys(J) - 12
            End If
        Next J

    End If

    PrintScale$ = "|  " + Notes(keys(0)) + "  |  " + Notes(keys(1)) + "  |  " + Notes(keys(2)) + "  |  " + Notes(keys(3)) + "  |  " + Notes(keys(4)) + "  |  " + Notes(keys(5)) + "  |  " + Notes(keys(6)) + "  |"
End Function

'$Include: '.\res\DisplayScales.bas'
