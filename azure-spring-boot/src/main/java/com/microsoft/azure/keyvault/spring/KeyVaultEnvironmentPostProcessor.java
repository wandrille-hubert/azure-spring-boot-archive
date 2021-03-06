/**
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See LICENSE in the project root for
 * license information.
 */

package com.microsoft.azure.keyvault.spring;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.context.config.ConfigFileApplicationListener;
import org.springframework.boot.env.EnvironmentPostProcessor;
import org.springframework.core.Ordered;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.util.ClassUtils;

public class KeyVaultEnvironmentPostProcessor implements EnvironmentPostProcessor, Ordered {
    public static final int DEFAULT_ORDER = ConfigFileApplicationListener.DEFAULT_ORDER + 1;
    private int order = DEFAULT_ORDER;

    @Override
    public void postProcessEnvironment(ConfigurableEnvironment environment, SpringApplication application) {

        if (isKeyVaultEnabled(environment)) {
            final KeyVaultEnvironmentPostProcessorHelper helper =
                    new KeyVaultEnvironmentPostProcessorHelper(environment);
            helper.addKeyVaultPropertySource();
        }
    }

    private boolean isKeyVaultEnabled(ConfigurableEnvironment environment) {
        if (environment.getProperty(Constants.AZURE_KEYVAULT_VAULT_URI) == null) {
            // User doesn't want to enable Key Vault property initializer.
            return false;
        }
        return environment.getProperty(Constants.AZURE_KEYVAULT_ENABLED, Boolean.class, true)
                && isKeyVaultClientAvailable();
    }

    private boolean isKeyVaultClientAvailable() {
        return ClassUtils.isPresent("com.microsoft.azure.keyvault.KeyVaultClient",
                KeyVaultEnvironmentPostProcessor.class.getClassLoader());
    }

    @Override
    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }
}
