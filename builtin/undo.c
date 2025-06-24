#include "builtin.h"
#include "cache.h"
#include "parse-options.h"
#include "run-command.h"

static const char * const undo_usage[] = {
    "git undo [--hard]",
    NULL
};

int cmd_undo(int argc, const char **argv, const char *prefix)
{
    int hard = 0;
    struct option options[] = {
        OPT_BOOL(0, "hard", &hard, "Perform a hard reset (discard changes)"),
        OPT_END()
    };

    argc = parse_options(argc, argv, prefix, options, undo_usage, 0);

    if (hard) {
        const char *reset_args[] = { "reset", "--hard", "HEAD~1", NULL };
        return run_command_v_opt(reset_args, RUN_GIT_CMD);
    } else {
        const char *reset_args[] = { "reset", "--soft", "HEAD~1", NULL };
        return run_command_v_opt(reset_args, RUN_GIT_CMD);
    }
}
