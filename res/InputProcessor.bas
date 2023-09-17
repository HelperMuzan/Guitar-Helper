Sub SplitInput (inp$, r, scale$)
    r = Val(Left$(inp$, InStr(inp$, " ")))
    scale$ = Right$(inp$, Len(inp$) - InStr(inp$, " "))
End Sub
