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


Dim Fretboard(6, 12) As String 'Fretboard(string, fret)

For i = 0 To 11
    Fretboard(5, i) = Notes(i)
    If i < 10 Then
        Fretboard(2, i) = Notes(i + 2)
    Else
        Fretboard(2, i) = Notes(i - 10)
    End If

    If i < 2 Then
        Fretboard(3, i) = Notes(i + 10)
    Else
        Fretboard(3, i) = Notes(i - 2)
    End If

    If i < 7 Then
        Fretboard(4, i) = Notes(i + 5)
    Else
        Fretboard(4, i) = Notes(i - 7)
    End If

    If i < 5 Then
        Fretboard(6, i) = Notes(i + 7)
    Else
        Fretboard(6, i) = Notes(i - 5)
    End If

    Fretboard(1, i) = Fretboard(6, i)

    If i <= 6 Then
        Fretboard(i, 12) = Fretboard(i, 0)
    End If
Next i

'Returns an index that can be fed to the GetNotes() function
Function ProcessScales (scale_name$, root, index) 'index is the position of the note, root = index(0)
    Dim keys(6) As Integer

    If LCase$(scale_name$) = "maj" Then
        keys(0) = root 'half step
        keys(1) = root + 2 'whole step
        keys(2) = root + 4 'whole step
        keys(3) = root + 5 'half step
        keys(4) = root + 7 'whole step
        keys(5) = root + 9 'whole step
        keys(6) = root + 11 'whole step

    ElseIf LCase$(scale_name$) = "min" Then
        keys(0) = r 'whole step
        keys(1) = r + 2 'whole step
        keys(2) = r + 3 'half step
        keys(3) = r + 5 'whole step
        keys(4) = r + 7 'whole step
        keys(5) = r + 8 'half step
        keys(6) = r + 10 'whole step

    ElseIf LCase$(scale_name$) = "pentatonic" Then
        keys(0) = root 'half step
        keys(1) = root + 3 'whole step
        keys(2) = root + 5 'half step
        keys(3) = root + 7 'whole step
        keys(4) = root + 10 'whole step
    End If

    For J = 0 To 6
        If keys(J) > 11 Then
            keys(J) = keys(J) - 12
        End If
    Next J

    ProcessScales = keys(index - 1) 'root = index(n-1) for n = 1, n is the position count

End Function

Function DisplayNotes

End Function

Function PrintScale$ (root, scale$)
    If scale$ = "maj" Or scale$ = "min" Then
        max_notes = 7
    Else
        max_notes = 5
    End If

    For i = 1 To max_notes
        TempVar$ = TempVar$ + " | " + GetNotes$(ProcessScales(scale$, root, i))
    Next i

    PrintScale$ = TempVar$ + " |"
End Function

'Feed an index to the function to return a note (string).
Function GetNotes$ (index)
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

    GetNotes$ = Notes(index)

End Function
