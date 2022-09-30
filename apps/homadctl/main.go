package main

import (
	"context"
	"fmt"
	"os"
	"os/signal"
	"syscall"

	"github.com/davidsbond/homad/apps/homadctl/cmd"
	"github.com/spf13/cobra"
)

var (
	version string
	commit  string
)

func main() {
	ctx, cancel := signal.NotifyContext(context.Background(), syscall.SIGINT, syscall.SIGTERM, syscall.SIGKILL)

	root := &cobra.Command{
		Use:     "homadctl",
		Short:   "A command-line tool for automating homelab tasks",
		Version: fmt.Sprintf("%s (%s)", version, commit),
	}

	root.AddCommand(
		cmd.GC(),
		cmd.Containers(),
	)

	if err := root.ExecuteContext(ctx); err != nil {
		cancel()
		os.Exit(1)
	}
}
