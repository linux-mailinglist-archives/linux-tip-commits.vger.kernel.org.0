Return-Path: <linux-tip-commits+bounces-6027-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F99AFC7D2
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 12:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242B8564911
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 10:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4697A26D4EF;
	Tue,  8 Jul 2025 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bcz8Xxhq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ff4neNYw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F0226B09F;
	Tue,  8 Jul 2025 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969045; cv=none; b=Nv85R0x8QZfvCP6x9sYB+DyVzKxxRWTlUveQtzKIODyfLfXVzd1M3GLb0V9wkx0zlW9cDn23/4tTqtVIEZFJOY1h79gyfV1mreNaN5n+YG4lMCwr9Tw2OR0yDrBgGMFCDqZw+fkSYTHAgCb/b2Id85IO7re3gBsWz1A0sdY4fpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969045; c=relaxed/simple;
	bh=z6NJPyffNO+6XQ79PjCh3JWo1ZuG3GiaeLOFQlhCKuQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WWZsGbhbLaXUVLDwCUPGZqIYnqMYvUQu66NgEb4ZzyD03L0XuGztWUPUvs57texNcoK1zGVS6EAiSO4XCnNEN/f/n1BsAhMI9bG+wZ64TQS9fWuhKFuL4+DbYXFjtpm1v+F4PobVJKWZ7NQG9YMRDecuCuJxqxKgmluoPJQ63K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bcz8Xxhq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ff4neNYw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 10:03:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751969040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L02ihxc4pcqMedi19iomVeZUY/VTkcwqGfI4T8yRKoE=;
	b=Bcz8XxhqSFSFODP36n/1vH5z1g+jbF/+ZRmMLhFEzrr5ZFvZP4mvD24qsyFEuvObSQKHob
	Bek+zOQKcDiiqTNsf7OMM5DpJs/5GHjC4bHdSTVMWaUxJ2fkJVFy/Djgk5AgNo9N1Pqm+S
	NiVOYUP6LHEAgoYMc4NJMEpCaC0u5oiY3+SAE/g0tS7vDpWz27JV3B+z7Iq2ZwKvzm+69R
	XzHP1y74NHOWvKbxb+sXzg1MccKTZ20TVXWSWuxr5tJo9fuw64GNNsT8zxGqyeAQH0Hw7Y
	Gm5tr0ZP2NgvSY7axPnR80ptOjC/+siUl1eGRZuKWQZyQ6+nDpoh9jy/HBMgMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751969040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L02ihxc4pcqMedi19iomVeZUY/VTkcwqGfI4T8yRKoE=;
	b=Ff4neNYw4gOtMuER/fc3to85CakTRE7+Tbs7wHot5lKSEKsQnmeQxUGkQ2h/t5x3pudvYq
	mdek+ZyDhIeolkCA==
From: "tip-bot2 for Perry Yuan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] platform/x86: hfi: Introduce AMD Hardware
 Feedback Interface Driver
Cc: Perry Yuan <perry.yuan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, ilpo.jarvinen@linux.intel.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250609200518.3616080-5-superm1@kernel.org>
References: <20250609200518.3616080-5-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175196903993.406.17070843389912388679.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     5d902ee5609a299748dc1f9eb56cf36ad3275ea9
Gitweb:        https://git.kernel.org/tip/5d902ee5609a299748dc1f9eb56cf36ad32=
75ea9
Author:        Perry Yuan <Perry.Yuan@amd.com>
AuthorDate:    Mon, 09 Jun 2025 15:05:09 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Jul 2025 19:28:19 +02:00

platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver

The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
provide behavioral classification and a dynamically updated ranking table
for the scheduler to use when choosing cores for tasks.

There are two CPU core types defined: Classic and Dense. Classic cores are
the standard performance cores, while Dense cores are optimized for area and
efficiency.

Heterogeneous compute refers to CPU implementations that are comprised
of more than one architectural class, each with two capabilities. This
means each CPU reports two separate capabilities: "perf" and "eff".

Each capability lists all core ranking numbers between 0 and 255, where
a higher number represents a higher capability.

Heterogeneous systems can also extend to more than two architectural
classes.

The purpose of the scheduling feedback mechanism is to provide information
to the operating system scheduler in real time, allowing the scheduler to
direct threads to the optimal core during task scheduling.

All core ranking data are provided by the PMFW via a shared memory ranking
table, which the driver reads and uses to update core capabilities to the
scheduler. When the hardware updates the table, it generates a platform
interrupt to notify the OS to read the new ranking table.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537
Link: https://lore.kernel.org/20250609200518.3616080-5-superm1@kernel.org
---
 drivers/platform/x86/amd/Kconfig      |   1 +-
 drivers/platform/x86/amd/Makefile     |   1 +-
 drivers/platform/x86/amd/hfi/Kconfig  |  17 +++-
 drivers/platform/x86/amd/hfi/Makefile |   7 +-
 drivers/platform/x86/amd/hfi/hfi.c    | 158 +++++++++++++++++++++++++-
 5 files changed, 184 insertions(+)
 create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
 create mode 100644 drivers/platform/x86/amd/hfi/Makefile
 create mode 100644 drivers/platform/x86/amd/hfi/hfi.c

diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kcon=
fig
index 63e4bd9..b813f92 100644
--- a/drivers/platform/x86/amd/Kconfig
+++ b/drivers/platform/x86/amd/Kconfig
@@ -6,6 +6,7 @@
 source "drivers/platform/x86/amd/hsmp/Kconfig"
 source "drivers/platform/x86/amd/pmf/Kconfig"
 source "drivers/platform/x86/amd/pmc/Kconfig"
+source "drivers/platform/x86/amd/hfi/Kconfig"
=20
 config AMD_3D_VCACHE
 	tristate "AMD 3D V-Cache Performance Optimizer Driver"
diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Mak=
efile
index b0e284b..f6ff0c8 100644
--- a/drivers/platform/x86/amd/Makefile
+++ b/drivers/platform/x86/amd/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_AMD_HSMP)		+=3D hsmp/
 obj-$(CONFIG_AMD_PMF)		+=3D pmf/
 obj-$(CONFIG_AMD_WBRF)		+=3D wbrf.o
 obj-$(CONFIG_AMD_ISP_PLATFORM)	+=3D amd_isp4.o
+obj-$(CONFIG_AMD_HFI)		+=3D hfi/
diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/=
hfi/Kconfig
new file mode 100644
index 0000000..0196380
--- /dev/null
+++ b/drivers/platform/x86/amd/hfi/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# AMD Hardware Feedback Interface Driver
+#
+
+config AMD_HFI
+	bool "AMD Hetero Core Hardware Feedback Driver"
+	depends on ACPI
+	depends on CPU_SUP_AMD
+	help
+	  Select this option to enable the AMD Heterogeneous Core Hardware
+	  Feedback Interface. If selected, hardware provides runtime thread
+	  classification guidance to the operating system on the performance and
+	  energy efficiency capabilities of each heterogeneous CPU core. These
+	  capabilities may vary due to the inherent differences in the core types
+	  and can also change as a result of variations in the operating
+	  conditions of the system such as power and thermal limits.
diff --git a/drivers/platform/x86/amd/hfi/Makefile b/drivers/platform/x86/amd=
/hfi/Makefile
new file mode 100644
index 0000000..672c6ac
--- /dev/null
+++ b/drivers/platform/x86/amd/hfi/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# AMD Hardware Feedback Interface Driver
+#
+
+obj-$(CONFIG_AMD_HFI) +=3D amd_hfi.o
+amd_hfi-objs :=3D hfi.o
diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hf=
i/hfi.c
new file mode 100644
index 0000000..9fac918
--- /dev/null
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Hardware Feedback Interface Driver
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc. All Rights Reserved.
+ *
+ * Authors: Perry Yuan <Perry.Yuan@amd.com>
+ *          Mario Limonciello <mario.limonciello@amd.com>
+ */
+
+#define pr_fmt(fmt)  "amd-hfi: " fmt
+
+#include <linux/acpi.h>
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/gfp.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/smp.h>
+
+#define AMD_HFI_DRIVER		"amd_hfi"
+
+#define AMD_HETERO_CPUID_27	0x80000027
+
+static struct platform_device *device;
+
+struct amd_hfi_data {
+	const char	*name;
+	struct device	*dev;
+};
+
+struct amd_hfi_classes {
+	u32	perf;
+	u32	eff;
+};
+
+/**
+ * struct amd_hfi_cpuinfo - HFI workload class info per CPU
+ * @cpu:		CPU index
+ * @class_index:	workload class ID index
+ * @nr_class:		max number of workload class supported
+ * @amd_hfi_classes:	current CPU workload class ranking data
+ *
+ * Parameters of a logical processor linked with hardware feedback class.
+ */
+struct amd_hfi_cpuinfo {
+	int		cpu;
+	s16		class_index;
+	u8		nr_class;
+	struct amd_hfi_classes	*amd_hfi_classes;
+};
+
+static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) =3D {.class_i=
ndex =3D -1};
+
+static int amd_hfi_alloc_class_data(struct platform_device *pdev)
+{
+	struct amd_hfi_cpuinfo *hfi_cpuinfo;
+	struct device *dev =3D &pdev->dev;
+	u32 nr_class_id;
+	int idx;
+
+	nr_class_id =3D cpuid_eax(AMD_HETERO_CPUID_27);
+	if (nr_class_id > 255) {
+		dev_err(dev, "number of supported classes too large: %d\n",
+			nr_class_id);
+		return -EINVAL;
+	}
+
+	for_each_possible_cpu(idx) {
+		struct amd_hfi_classes *classes;
+
+		classes =3D devm_kcalloc(dev,
+				       nr_class_id,
+				       sizeof(struct amd_hfi_classes),
+				       GFP_KERNEL);
+		if (!classes)
+			return -ENOMEM;
+		hfi_cpuinfo =3D per_cpu_ptr(&amd_hfi_cpuinfo, idx);
+		hfi_cpuinfo->amd_hfi_classes =3D classes;
+		hfi_cpuinfo->nr_class =3D nr_class_id;
+	}
+
+	return 0;
+}
+
+static const struct acpi_device_id amd_hfi_platform_match[] =3D {
+	{"AMDI0104", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, amd_hfi_platform_match);
+
+static int amd_hfi_probe(struct platform_device *pdev)
+{
+	struct amd_hfi_data *amd_hfi_data;
+	int ret;
+
+	if (!acpi_match_device(amd_hfi_platform_match, &pdev->dev))
+		return -ENODEV;
+
+	amd_hfi_data =3D devm_kzalloc(&pdev->dev, sizeof(*amd_hfi_data), GFP_KERNEL=
);
+	if (!amd_hfi_data)
+		return -ENOMEM;
+
+	amd_hfi_data->dev =3D &pdev->dev;
+	platform_set_drvdata(pdev, amd_hfi_data);
+
+	ret =3D amd_hfi_alloc_class_data(pdev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static struct platform_driver amd_hfi_driver =3D {
+	.driver =3D {
+		.name =3D AMD_HFI_DRIVER,
+		.owner =3D THIS_MODULE,
+		.acpi_match_table =3D ACPI_PTR(amd_hfi_platform_match),
+	},
+	.probe =3D amd_hfi_probe,
+};
+
+static int __init amd_hfi_init(void)
+{
+	int ret;
+
+	if (acpi_disabled ||
+	    !cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES) ||
+	    !cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
+		return -ENODEV;
+
+	device =3D platform_device_register_simple(AMD_HFI_DRIVER, -1, NULL, 0);
+	if (IS_ERR(device)) {
+		pr_err("unable to register HFI platform device\n");
+		return PTR_ERR(device);
+	}
+
+	ret =3D platform_driver_register(&amd_hfi_driver);
+	if (ret)
+		pr_err("failed to register HFI driver\n");
+
+	return ret;
+}
+
+static __exit void amd_hfi_exit(void)
+{
+	platform_driver_unregister(&amd_hfi_driver);
+	platform_device_unregister(device);
+}
+module_init(amd_hfi_init);
+module_exit(amd_hfi_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("AMD Hardware Feedback Interface Driver");

