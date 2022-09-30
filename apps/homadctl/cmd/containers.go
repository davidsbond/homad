package cmd

import (
	"encoding/json"
	"fmt"
	"os"

	"github.com/davidsbond/homad/apps/homadctl/internal/nomad"
	"github.com/spf13/cobra"
)

// Containers is the root command for tasks that manage container images within the homelab.
func Containers() *cobra.Command {
	cmd := &cobra.Command{
		Use:     "containers",
		Aliases: []string{"container"},
		Args:    cobra.NoArgs,
		Short:   "Subcommands for managing containers running in the homelab",
	}

	cmd.AddCommand(
		containersList(),
	)

	return cmd
}

func containersList() *cobra.Command {
	var jsonOut bool

	cmd := &cobra.Command{
		Use:     "list",
		Aliases: []string{"ls"},
		Args:    cobra.NoArgs,
		Short:   "List all containers running in the homelab",
		RunE: func(cmd *cobra.Command, args []string) error {
			client, err := nomad.NewClient()
			if err != nil {
				return err
			}

			images, err := nomad.Images(cmd.Context(), client)
			if err != nil {
				return err
			}

			if jsonOut {
				return json.NewEncoder(os.Stdout).Encode(images)
			}

			for _, image := range images {
				fmt.Println(image)
			}

			return nil
		},
	}

	flags := cmd.PersistentFlags()
	flags.BoolVar(&jsonOut, "json", false, "Output containers in JSON format")

	return cmd
}
