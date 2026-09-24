param(
    [string]$TargetPath = "src"
)

$ErrorActionPreference = "Stop"
$violations = 0

if (Test-Path $TargetPath -PathType Leaf) {
    $files = @(Get-Item $TargetPath)
} else {
    $files = Get-ChildItem -Path $TargetPath -Filter "*.java" -Recurse
}

foreach ($f in $files) {
    $raw = Get-Content -Path $f.FullName -Raw -Encoding UTF8
    $lines = Get-Content -Path $f.FullName -Encoding UTF8
    $isTestFile = $f.FullName -match 'src[\\/]test[\\/]'

    # 1. Check @author wobushi041
    if ($raw -notmatch '@author wobushi041') {
        Write-Output "[MISSING_AUTHOR] $($f.FullName)"
        $violations++
    }

    # 2. Check forbidden Javadoc tags (@date, @since, @createDate, @version, @throws, @exception, @TableName, @Entity)
    if ($raw -match '\*\s*@(date|since|createDate|version|throws|exception|TableName|Entity)\b') {
        Write-Output "[FORBIDDEN_TAG @$($Matches[1])] $($f.FullName)"
        $violations++
    }

    # 3. Check Tab indentation
    if ($raw -match "`t") {
        Write-Output "[HAS_TAB] $($f.FullName)"
        $violations++
    }

    # 4. Check serialVersionUID divider, Domain @TableField(exist = false), and bottom placement
    if ($raw -match 'serialVersionUID') {
        if ($raw -notmatch '///\s*\u5e8f\u5217\u5316\u5b57\u6bb5\s*///') {
            Write-Output "[MISSING_SERIAL_DIVIDER] $($f.FullName)"
            $violations++
        }
        if ($f.FullName -match 'model[\\/]domain[\\/]' -and $raw -notmatch '@TableField\s*\(\s*exist\s*=\s*false\s*\)[\s\S]*?serialVersionUID') {
            Write-Output "[DOMAIN_MISSING_TABLE_FIELD_FALSE] $($f.FullName)"
            $violations++
        }
        # Verify serialVersionUID is placed at the bottom of the class (only whitespace/comments and final '}' after it)
        if ($raw -match 'serialVersionUID\s*=\s*[^;]+;([\s\S]*)$') {
            $afterSerial = $Matches[1]
            $afterClean = $afterSerial -replace '\/\*[\s\S]*?\*\/', '' -replace '\/\/.*', ''
            if ($afterClean -notmatch '^\s*\}\s*$') {
                Write-Output "[SERIAL_NOT_AT_BOTTOM] $($f.Name) -> serialVersionUID must be at the very bottom of the class"
                $violations++
            }
        }
    }

    # 5. Check Enum constants ending with ';' on its own new line
    if ($raw -match '\bpublic\s+enum\s+\w+') {
        for ($i = 0; $i -lt $lines.Count; $i++) {
            $trimLine = $lines[$i].Trim()
            if ($trimLine -match '^[A-Z0-9_]+\s*\(.*\)\s*;$' -or ($trimLine -match '^[A-Z0-9_]+\s*;$' -and $trimLine -notmatch '^(return|break|continue)\b')) {
                Write-Output "[ENUM_SEMICOLON_INLINE] $($f.Name):$($i+1) -> Enum constant ';' must be on its own new line: $trimLine"
                $violations++
            }
        }
    }

    # 6. Line-by-line inspection: comments, trailing comments (URL-safe), multi-@Test scenarios, and missing Javadocs
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]
        $trimLine = $line.Trim()

        # 6a. Extract comment text (full-line comment OR trailing comment after stripping string literals like "http://...")
        $commentText = $null
        $isLineComment = $false
        if ($trimLine -match '^(\/\/|\*)') {
            $commentText = $trimLine
            $isLineComment = $trimLine.StartsWith("//")
        } else {
            $lineWithoutStrings = $trimLine -replace '"(\\.|[^"\\])*"', '""'
            if ($lineWithoutStrings -match '(\/\/.*)$') {
                $commentText = $Matches[1].Trim()
                $isLineComment = $true
            }
        }

        if ($null -ne $commentText) {
            if (-not $isTestFile -and $isLineComment -and $commentText -match '^\/\/\s*\d+\.') {
                Write-Output "[PROD_NUMBERED_COMMENT] $($f.Name):$($i+1) -> $commentText"
                $violations++
            }
            if ($commentText -match '([\u4e00-\u9fa5][a-zA-Z0-9]|[a-zA-Z0-9][\u4e00-\u9fa5])') {
                Write-Output "[COMMENT_MISSING_SPACE] $($f.Name):$($i+1) -> $commentText"
                $violations++
            }
        }

        # 6b. Per-@Test scenario check (every single @Test must have // 场景：测试 within 8 preceding lines)
        if ($isTestFile -and $trimLine -match '^@Test\b') {
            $foundScenario = $false
            $startLook = [Math]::Max(0, $i - 8)
            for ($k = $i - 1; $k -ge $startLook; $k--) {
                if ($lines[$k] -match '//\s*\u573a\u666f[\uff1a:]\s*\u6d4b\u8bd5') {
                    $foundScenario = $true
                    break
                }
                if ($lines[$k].Trim() -match '^\}') {
                    break
                }
            }
            if (-not $foundScenario) {
                Write-Output "[TEST_MISSING_SCENARIO_COMMENT] $($f.Name):$($i+1) -> @Test is missing preceding '// 场景：测试 xxx'"
                $violations++
            }
        }

        # 6c. Method Javadoc coverage check (public/private/protected methods and package-private @Test/@BeforeEach methods)
        $isMethodDecl = ($trimLine -match '^(public|private|protected)\s+(?!class\b|interface\b|enum\b)[\w<>\[\],\s\?]+\s+[a-zA-Z_]\w*\s*\(' -and $trimLine -notmatch ';\s*$' -and $trimLine -notmatch '=')
        if ($isMethodDecl) {
            $hasJavadoc = $false
            for ($k = $i - 1; $k -ge 0; $k--) {
                $prev = $lines[$k].Trim()
                if ($prev -eq '' -or $prev -match '^@' -or $prev -match '^\/\/') {
                    continue
                }
                if ($prev -match '\*\/$') {
                    $hasJavadoc = $true
                }
                break
            }
            if (-not $hasJavadoc) {
                Write-Output "[METHOD_MISSING_JAVADOC] $($f.Name):$($i+1) -> $trimLine"
                $violations++
            }
        }
    }
}

if ($violations -eq 0) {
    Write-Output "VERIFY_PASSED: Checked $($files.Count) file(s), 0 violations found."
    exit 0
} else {
    Write-Output "VERIFY_FAILED: Found $violations violation(s) across $($files.Count) file(s)."
    exit 1
}
