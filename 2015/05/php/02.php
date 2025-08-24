<?php

declare(strict_types=1);

require_once("./common.php");

function main()
{
    $input = get_input_content();
    $niceCount = 0;

    foreach ($input as $s) {
        $result = check_model2($s);
        if ($result["result"] === "Nice") {
            $niceCount++;
        }
    }

    if ($niceCount !== 53) {
        throw new \Exception("Unexpected result: $niceCount");
    }
}

main();
