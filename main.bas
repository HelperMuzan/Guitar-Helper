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
HelveticaFont_L& = _LoadFont(_CWD$ + "\res\HelveticaNeueLight.ttf", 38)

GuitarNeck& = _LoadImage(_CWD$ + "\img\g2910.png")
dot& = _LoadImage(_CWD$ + "\img\dot.png")
rdot& = _LoadImage(_CWD$ + "\img\rdot.png")

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

Do
    Cls
    Line (800, -100)-(800, 900), _RGB32(255)
    _PutImage (1000, 128), GuitarNeck&

    _Font HelveticaFont&

    Print "============================================================="
    Print , "    Guitar Helper By Helper Muzan"
    Print "============================================================="
    For I = 0 To 11
        Print "Note("; I; ") = ", GetNotes$(I)
    Next I

    Print "============================================================="

    Input "", inp$
    SplitInput inp$, r, scaletype$

    StringAccepted = 0

    For J = 0 To 11:
        If LCase$(scaletype$) = Accepted_Strings(J) Then
            StringAccepted = 1
            Select Case J
                Case Is < 3
                    scaletype$ = "maj"
                Case Is > 6
                    scaletype$ = "pentatonic"
                Case Else
                    scaletype$ = "min"
            End Select
        End If
    Next

    'For input given:
    If r > 11 Or StringAccepted = 0 Then
        Print Chr$(34); inp$; Chr$(34); " is not recognized as a valid input."
        Select Case r
            Case Not 0 TO 11
                Print "Enter a valid root number. Use the given list to select a valid root number."
        End Select
        If StringAccepted = 0 Then
            Print "Enter a valid scale type. Type "; Chr$(34); "help"; Chr$(34); " for more details."
        End If
    Else
        Print PrintScale$(r, scaletype$)
        DisplayScales 1000, 128, 423, 104, dot&, rdot&, scaletype$, r
    End If

    If scaletype$ = "maj" Then
        Print "Major keys: I, IV, V"
        Print "Minor keys: II, III, VI"
        Print "Diminished key: VII"
        _Font HelveticaFont_L&
        _PrintString (1100, 16), "Major Scale"
    ElseIf scaletype$ = "min" Then
        _Font HelveticaFont_L&
        _PrintString (1100, 16), "Minor Scale"
    ElseIf scaletype$ = "pentatonic" Then
        _Font HelveticaFont_L&
        _PrintString (1025, 16), "Minor Pentatonic Scale"
    End If

    Sleep

Loop Until LCase$(inpt$) = "exit"

'Terminate the system
System

'$include: '.\res\ScaleManager.bas'
'$Include: '.\res\InputProcessor.bas'
