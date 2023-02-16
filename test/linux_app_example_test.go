package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestLinuxAppExample(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/linux-app",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}
