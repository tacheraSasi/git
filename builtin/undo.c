#include "builtin.h"
#include "cache.h"
#include "parse-options.h"
#include "run-command.h"

static const char * const undo_usage[] = {
    "git undo [--hard]",
    NULL
};

int cmd_undo(int argc, const char **argv, const char *prefix, struct repository *repo)
{
	(void)repo; // Mark as unused if not used in the function
    int hard = 0;
    struct option options[] = {
        OPT_BOOL(0, "hard", &hard, "Perform a hard reset (discard changes)"),
        OPT_END()
    };

    argc = parse_options(argc, argv, prefix, options, undo_usage, 0);

    if (hard) {
        const char *reset_args[] = { "reset", "--hard", "HEAD~1", NULL };
        struct child_process cmd = CHILD_PROCESS_INIT;
        cmd.argv = reset_args;
        cmd.git_cmd = 1;
        return run_command(&cmd);
    } else {
        const char *reset_args[] = { "reset", "--soft", "HEAD~1", NULL };
        struct child_process cmd = CHILD_PROCESS_INIT;
        cmd.argv = reset_args;
        cmd.git_cmd = 1;
        return run_command(&cmd);
    }
}
