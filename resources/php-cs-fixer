<?php
use Symfony\CS\FixerInterface;

class NewLineAfterParamFixer implements FixerInterface
{
    public function fix(\SplFileInfo $file, $content)
    {
        $lines = explode("\n", $content);
        $lastLine = null;
        $emptyLine = false;
        foreach ($lines as $i => $line) {
            if (trim($line) == '*/') {
                $emptyLine = false;
            }

            if (!preg_match('/^ {5}\* @(return|throws)/', $line)) {
                $lastLine = $line;
                continue;
            }

            if (!$emptyLine && trim($lastLine) != '*') {
                $emptyLine = true;
                $lines[$i] = '     *'."\n".$line;
            }
        }

        return implode("\n", $lines);
    }

    public function getLevel()
    {
        return FixerInterface::ALL_LEVEL;
    }

    public function getPriority()
    {
        return 1;
    }

    public function supports(\SplFileInfo $file)
    {
        return 'php' == pathinfo($file->getFilename(), PATHINFO_EXTENSION);
    }

    public function getName()
    {
        return 'split-param-from-return';
    }

    public function getDescription()
    {
        return 'Splits the @param docs from the @return with a newline.';
    }
}

class SortUseFixer implements FixerInterface
{
    public function fix(\SplFileInfo $file, $content)
    {
        preg_match_all('/^use ([^;]+);/m', $content, $matches);
        $statementCount = count($matches[0]);
        if ($statementCount == 0) {
            return $content;
        }

        $lastMatch = $matches[0][$statementCount-1];
        $lastMatchPos = strpos($content, $lastMatch);

        $start = strpos($content, $matches[0][0]);
        $end = $lastMatchPos+strlen($lastMatch);

        $statements = array();
        foreach ($matches[1] as $key => $classNames) {
            $all = preg_split('/\s*,\s*/', $classNames);
            foreach ($all as $className) {
                $statements[] = 'use '.ltrim($className, '\\').';';
            }
        }

        sort($statements);

        $fixed = substr($content, 0, $start);
        $fixed .= implode("\n", $statements);
        $fixed .= substr($content, $end);

        return $fixed;
    }

    public function getLevel()
    {
        return FixerInterface::ALL_LEVEL;
    }

    public function getPriority()
    {
        return 1001;
    }

    public function supports(\SplFileInfo $file)
    {
        if ('php' !== pathinfo($file->getFilename(), PATHINFO_EXTENSION)) {
            return false;
        }

        // ignore tests/stubs/fixtures, since they are typically containing invalid files for various reasons
        return !preg_match('{[/\\\\](test|stub|fixture)s?[/\\\\]}i', $file->getRealPath());
    }

    public function getName()
    {
        return 'sort-use';
    }

    public function getDescription()
    {
        return 'Sorts the use statements.';
    }
}

$finder = Symfony\CS\Finder\DefaultFinder::create()
    ->notName('.php_cs')
    ->exclude('vendor')
    ->exclude('tests')
    ->exclude('code-completion')
    ->in(__DIR__)
;

$config = Symfony\CS\Config\Config::create();
$config->finder($finder);
$config->addCustomFixer(new SortUseFixer());
$config->addCustomFixer(new NewLineAfterParamFixer());

return $config;

