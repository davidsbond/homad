package main

import (
	"context"
	"fmt"
	"os"
	"os/signal"
	"syscall"

	"github.com/davidsbond/homad/apps/speed-dial/assets"
	"github.com/davidsbond/homad/apps/speed-dial/config"
	"github.com/davidsbond/homad/apps/speed-dial/server"
	"github.com/spf13/cobra"
)

var (
	version string
	commit  string
)

func main() {
	ctx, cancel := signal.NotifyContext(context.Background(), syscall.SIGINT, syscall.SIGTERM, syscall.SIGKILL)

	var (
		configLocation string
	)

	cmd := &cobra.Command{
		Use:     "speed-dial",
		Short:   "A speed dial dashboard for the homelab",
		Version: fmt.Sprintf("%s (%s)", version, commit),
		RunE: func(cmd *cobra.Command, args []string) error {
			configuration, err := config.Load(configLocation)
			if err != nil {
				return fmt.Errorf("failed to load configuration: %w", err)
			}

			templates, err := assets.Templates()
			if err != nil {
				return fmt.Errorf("failed to parse templates: %w", err)
			}

			images, err := assets.Images()
			if err != nil {
				return fmt.Errorf("failed to load images: %w", err)
			}

			stylesheets, err := assets.StyleSheets()
			if err != nil {
				return fmt.Errorf("failed to load style sheets: %w", err)
			}

			return server.Run(cmd.Context(), configuration, templates, images, stylesheets)
		},
	}

	flags := cmd.PersistentFlags()
	flags.StringVar(&configLocation, "config", "./config.yaml", "The location of the configuration file")

	if err := cmd.ExecuteContext(ctx); err != nil {
		cancel()
		os.Exit(1)
	}
}
