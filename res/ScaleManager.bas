Function GetFretboardNote$ (x, y)
    Dim Fretboard(6, 12) As String 'Fretboard(string, fret)

    For i = 0 To 11
        Fretboard(5, i) = GetNotes$(i)
        If i < 10 Then
            Fretboard(2, i) = GetNotes$(i + 2)
        Else
            Fretboard(2, i) = GetNotes$(i - 10)
        End If

        If i < 2 Then
            Fretboard(3, i) = GetNotes$(i + 10)
        Else
            Fretboard(3, i) = GetNotes$(i - 2)
        End If

        If i < 7 Then
            Fretboard(4, i) = GetNotes$(i + 5)
        Else
            Fretboard(4, i) = GetNotes$(i - 7)
        End If

        If i < 5 Then
            Fretboard(6, i) = GetNotes$(i + 7)
        Else
            Fretboard(6, i) = GetNotes$(i - 5)
        End If

        Fretboard(1, i) = Fretboard(6, i)

        If i <= 6 Then
            Fretboard(i, 12) = Fretboard(i, 0)
        End If
    Next i
    GetFretboardNote$ = Fretboard(x, y)

End Function

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

Function GetScaleNoteCount (scale$)
    If scale$ = "maj" Or scale$ = "min" Then
        GetScaleNoteCount = 7
    ElseIf scale$ = "pentatonic" Then
        GetScaleNoteCount = 5
    End If
End Function

Function DisplayScrollingImage (x, y, index, image&)
    index_a = index Mod 11

    _PutImage ((x - 25) + (34 * index_a), y - 8), image&, , (0, 0)-(447 - (34 * index_a), 120)
    _PutImage (x + 7, y - 9), image&, , (447 - (34 * index_a), 0)-(447, 120)
    DisplayScrollingImage = 1
End Function

'Displays scales in graphics
Function DisplayScales (x, y, w, h, dot_img&, rdot_img&, scale$, root)
    ax = x - 16
    ay = y
    aw = w + 32
    ah = h + 16
    For i = 1 To 13
        bx = ax + (i - 1) * aw / 13
        For j = 1 To 6
            by = ay + (j - 1) * ah / 6
            For k = 1 To GetScaleNoteCount(scale$)
                If GetNotes$(ProcessScales(scale$, root, k)) = GetFretboardNote$(j, i - 1) Then
                    If k = 1 Then
                        _PutImage (bx - 8, by - 8), rdot_img&
                    Else
                        _PutImage (bx - 8, by - 8), dot_img&
                    End If
                End If
            Next k
        Next j
    Next i
    DisplayScales = 1
End Function


