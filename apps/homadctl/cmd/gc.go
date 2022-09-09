package cmd

import (
	"strings"

	"github.com/davidsbond/homad/apps/homadctl/internal/nomad"
	"github.com/hashicorp/nomad/api"
	"github.com/spf13/cobra"
)

// GC returns a cobra command that triggers all periodic jobs in the maintenance namespace that have a suffix of
// "gc". This is how garbage-collection tasks are typically named.
func GC() *cobra.Command {
	return &cobra.Command{
		Use:   "gc",
		Short: "Trigger all garbage collection jobs available",
		RunE: func(cmd *cobra.Command, args []string) error {
			const namespace = "maintenance"

			client, err := nomad.NewClient()
			if err != nil {
				return err
			}

			client.SetNamespace(namespace)
			jobs, _, err := client.Jobs().List(&api.QueryOptions{})
			switch {
			case err != nil:
				return err
			case len(jobs) == 0:
				return nil
			}

			jobIDs := make([]string, 0)
			for _, job := range jobs {
				if !strings.HasSuffix(job.Name, "gc") {
					continue
				}

				jobIDs = append(jobIDs, job.ID)
			}

			if len(jobIDs) == 0 {
				return nil
			}

			for _, jobID := range jobIDs {
				_, _, err = client.Jobs().PeriodicForce(jobID, &api.WriteOptions{})
				if err != nil {
					return err
				}
			}

			return nil
		},
	}
}
