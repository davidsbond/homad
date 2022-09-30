package cmd

import (
	"github.com/davidsbond/homad/apps/homadctl/internal/nomad"
	"github.com/spf13/cobra"
)

// GC returns a cobra command that triggers all periodic garbage collection jobs.
func GC() *cobra.Command {
	return &cobra.Command{
		Use:   "gc",
		Short: "Trigger all garbage collection jobs available",
		RunE: func(cmd *cobra.Command, args []string) error {
			client, err := nomad.NewClient()
			if err != nil {
				return err
			}

			return nomad.GarbageCollect(cmd.Context(), client)
		},
	}
}
