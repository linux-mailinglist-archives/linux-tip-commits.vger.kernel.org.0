Return-Path: <linux-tip-commits+bounces-4969-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14503A879F6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 10:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C621890365
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 08:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E8219DFB4;
	Mon, 14 Apr 2025 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F+5hJw5A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pZ9ChVeO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A152580E4;
	Mon, 14 Apr 2025 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744618513; cv=none; b=gX7onkEOdc6dgZ9zDMbaGhof0GArDeJkmMJPFEsns8VoxO0xO/SR1V/lym/F7m3pt9A4FOPpxx54hvmSeljYk3FqGk6du72tTse0/PwJeYIuUytLxBWJvGtYPEYROdNvOGjE1um5kjkjp/MN8f1UV5Nk2gKrWQ3pUt2v8lDMir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744618513; c=relaxed/simple;
	bh=tFVtOp/vCpjyBcejWM8dmw7aqSKhkPSNCkQ5nuBBnXg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TnCMSTGiF4CUDJcEHthxh5xFZFH1KQdU9dSCi+RsltgZs4+xk5d9d5HzxLkaCvBRi856ZnOfjowlGjKbWEIcglSy3l3XG/8ZwASpzFo1Sh1OHGhmQR6lREVlqfTyrobgvq+12qz3TDcL9GmWbli+lGb4ZPbFrKH2Vn1HgR0eH5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F+5hJw5A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pZ9ChVeO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 08:15:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744618510;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XRRSW1MQCwaqqdtCCUZ/JveJw88OxB69vry56mXKx2A=;
	b=F+5hJw5AXH/Gec81dhZQ/0LRrAJXA/YZoIUXWoptIS/lDFroEwmkw8rgFmM3a7IXrlKMm+
	dbG1+AJ71XbejBV9U8q4pAPIxMXlAxrTNuJYz/9WRe2T4b+A9q+Z5D1T+ntJCiImQ3GJVO
	FeUbfTFHmuqL32274B9YwDKop696KNyIeamjIQqmXu//2Nm+ZKI/n0b51X8AFUK9pqTGUq
	isg/rFxpJ8/WdlRQe1stJqsG6/9hA/Qap5v8e+/Q51ElgphpD1+7dq+wYvHoBVenkikZqC
	+8aavDxOb5UJaAxR0sFFHVbHGId1pOLNkNfPrAcPHz1AL4YhHEQJ0cxDCmjYSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744618510;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XRRSW1MQCwaqqdtCCUZ/JveJw88OxB69vry56mXKx2A=;
	b=pZ9ChVeOCxZbVzCy3T22bPhOY9clcdOisQyOKr7mXtMeRTWBOr1mAXWldPQhNPudDgaC3t
	dBTV5AvbUCE+4fAQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/platform/amd: Move the <asm/amd_node.h> header
 to <asm/amd/node.h>
Cc: Ingo Molnar <mingo@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mario Limonciello <superm1@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250413084144.3746608-7-mingo@kernel.org>
References: <20250413084144.3746608-7-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174461850519.31282.4192093382144476566.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     0a35c9280a9105e601cfe23b7c15522a195fa412
Gitweb:        https://git.kernel.org/tip/0a35c9280a9105e601cfe23b7c15522a195fa412
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sun, 13 Apr 2025 10:41:44 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 14 Apr 2025 09:34:17 +02:00

x86/platform/amd: Move the <asm/amd_node.h> header to <asm/amd/node.h>

Collect AMD specific platform header files in <asm/amd/*.h>.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mario Limonciello <superm1@kernel.org>
Link: https://lore.kernel.org/r/20250413084144.3746608-7-mingo@kernel.org
---
 MAINTAINERS                          |  2 +-
 arch/x86/include/asm/amd/nb.h        |  2 +-
 arch/x86/include/asm/amd/node.h      | 60 +++++++++++++++++++++++++++-
 arch/x86/include/asm/amd_node.h      | 60 +---------------------------
 arch/x86/kernel/amd_node.c           |  2 +-
 arch/x86/pci/fixup.c                 |  2 +-
 drivers/edac/amd64_edac.c            |  2 +-
 drivers/hwmon/k10temp.c              |  2 +-
 drivers/platform/x86/amd/hsmp/acpi.c |  2 +-
 drivers/platform/x86/amd/hsmp/plat.c |  2 +-
 drivers/platform/x86/amd/pmc/pmc.c   |  2 +-
 drivers/platform/x86/amd/pmf/core.c  |  2 +-
 drivers/ras/amd/atl/internal.h       |  2 +-
 sound/soc/amd/acp/acp-rembrandt.c    |  2 +-
 sound/soc/amd/acp/acp63.c            |  2 +-
 sound/soc/amd/acp/acp70.c            |  2 +-
 sound/soc/sof/amd/acp.c              |  2 +-
 17 files changed, 75 insertions(+), 75 deletions(-)
 create mode 100644 arch/x86/include/asm/amd/node.h
 delete mode 100644 arch/x86/include/asm/amd_node.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d4ea6d7..14bbb43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1142,7 +1142,7 @@ M:	Mario Limonciello <mario.limonciello@amd.com>
 M:	Yazen Ghannam <yazen.ghannam@amd.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
-F:	arch/x86/include/asm/amd_node.h
+F:	arch/x86/include/asm/amd/node.h
 F:	arch/x86/kernel/amd_node.c
 
 AMD PDS CORE DRIVER
diff --git a/arch/x86/include/asm/amd/nb.h b/arch/x86/include/asm/amd/nb.h
index adfa085..ddb5108 100644
--- a/arch/x86/include/asm/amd/nb.h
+++ b/arch/x86/include/asm/amd/nb.h
@@ -4,7 +4,7 @@
 
 #include <linux/ioport.h>
 #include <linux/pci.h>
-#include <asm/amd_node.h>
+#include <asm/amd/node.h>
 
 struct amd_nb_bus_dev_range {
 	u8 bus;
diff --git a/arch/x86/include/asm/amd/node.h b/arch/x86/include/asm/amd/node.h
new file mode 100644
index 0000000..23fe617
--- /dev/null
+++ b/arch/x86/include/asm/amd/node.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD Node helper functions and common defines
+ *
+ * Copyright (c) 2024, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
+ *
+ * Note:
+ * Items in this file may only be used in a single place.
+ * However, it's prudent to keep all AMD Node functionality
+ * in a unified place rather than spreading throughout the
+ * kernel.
+ */
+
+#ifndef _ASM_X86_AMD_NODE_H_
+#define _ASM_X86_AMD_NODE_H_
+
+#include <linux/pci.h>
+
+#define MAX_AMD_NUM_NODES	8
+#define AMD_NODE0_PCI_SLOT	0x18
+
+struct pci_dev *amd_node_get_func(u16 node, u8 func);
+struct pci_dev *amd_node_get_root(u16 node);
+
+static inline u16 amd_num_nodes(void)
+{
+	return topology_amd_nodes_per_pkg() * topology_max_packages();
+}
+
+#ifdef CONFIG_AMD_NODE
+int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
+int __must_check amd_smn_write(u16 node, u32 address, u32 value);
+
+/* Should only be used by the HSMP driver. */
+int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool write);
+#else
+static inline int __must_check amd_smn_read(u16 node, u32 address, u32 *value) { return -ENODEV; }
+static inline int __must_check amd_smn_write(u16 node, u32 address, u32 value) { return -ENODEV; }
+
+static inline int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool write)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_AMD_NODE */
+
+/* helper for use with read_poll_timeout */
+static inline int smn_read_register(u32 reg)
+{
+	int data, rc;
+
+	rc = amd_smn_read(0, reg, &data);
+	if (rc)
+		return rc;
+
+	return data;
+}
+#endif /*_ASM_X86_AMD_NODE_H_*/
diff --git a/arch/x86/include/asm/amd_node.h b/arch/x86/include/asm/amd_node.h
deleted file mode 100644
index 23fe617..0000000
--- a/arch/x86/include/asm/amd_node.h
+++ /dev/null
@@ -1,60 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * AMD Node helper functions and common defines
- *
- * Copyright (c) 2024, Advanced Micro Devices, Inc.
- * All Rights Reserved.
- *
- * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
- *
- * Note:
- * Items in this file may only be used in a single place.
- * However, it's prudent to keep all AMD Node functionality
- * in a unified place rather than spreading throughout the
- * kernel.
- */
-
-#ifndef _ASM_X86_AMD_NODE_H_
-#define _ASM_X86_AMD_NODE_H_
-
-#include <linux/pci.h>
-
-#define MAX_AMD_NUM_NODES	8
-#define AMD_NODE0_PCI_SLOT	0x18
-
-struct pci_dev *amd_node_get_func(u16 node, u8 func);
-struct pci_dev *amd_node_get_root(u16 node);
-
-static inline u16 amd_num_nodes(void)
-{
-	return topology_amd_nodes_per_pkg() * topology_max_packages();
-}
-
-#ifdef CONFIG_AMD_NODE
-int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
-int __must_check amd_smn_write(u16 node, u32 address, u32 value);
-
-/* Should only be used by the HSMP driver. */
-int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool write);
-#else
-static inline int __must_check amd_smn_read(u16 node, u32 address, u32 *value) { return -ENODEV; }
-static inline int __must_check amd_smn_write(u16 node, u32 address, u32 value) { return -ENODEV; }
-
-static inline int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool write)
-{
-	return -ENODEV;
-}
-#endif /* CONFIG_AMD_NODE */
-
-/* helper for use with read_poll_timeout */
-static inline int smn_read_register(u32 reg)
-{
-	int data, rc;
-
-	rc = amd_smn_read(0, reg, &data);
-	if (rc)
-		return rc;
-
-	return data;
-}
-#endif /*_ASM_X86_AMD_NODE_H_*/
diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index b670fa8..a40176b 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -9,7 +9,7 @@
  */
 
 #include <linux/debugfs.h>
-#include <asm/amd_node.h>
+#include <asm/amd/node.h>
 
 /*
  * AMD Nodes are a physical collection of I/O devices within an SoC. There can be one
diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index efefeb8..3633629 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -9,7 +9,7 @@
 #include <linux/pci.h>
 #include <linux/suspend.h>
 #include <linux/vgaarb.h>
-#include <asm/amd_node.h>
+#include <asm/amd/node.h>
 #include <asm/hpet.h>
 #include <asm/pci_x86.h>
 
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 417940f..2518016 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3,7 +3,7 @@
 #include <linux/string_choices.h>
 #include "amd64_edac.h"
 #include <asm/amd/nb.h>
-#include <asm/amd_node.h>
+#include <asm/amd/node.h>
 
 static struct edac_pci_ctl_info *pci_ctl;
 
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 3685906..472bcf6 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -20,7 +20,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
-#include <asm/amd_node.h>
+#include <asm/amd/node.h>
 #include <asm/processor.h>
 
 MODULE_DESCRIPTION("AMD Family 10h+ CPU core temperature monitor");
diff --git a/drivers/platform/x86/amd/hsmp/acpi.c b/drivers/platform/x86/amd/hsmp/acpi.c
index 3c7acb9..02e22c1 100644
--- a/drivers/platform/x86/amd/hsmp/acpi.c
+++ b/drivers/platform/x86/amd/hsmp/acpi.c
@@ -23,7 +23,7 @@
 
 #include <uapi/asm-generic/errno-base.h>
 
-#include <asm/amd_node.h>
+#include <asm/amd/node.h>
 
 #include "hsmp.h"
 
diff --git a/drivers/platform/x86/amd/hsmp/plat.c b/drivers/platform/x86/amd/hsmp/plat.c
index 0eb73fc..c9a1b1e 100644
--- a/drivers/platform/x86/amd/hsmp/plat.c
+++ b/drivers/platform/x86/amd/hsmp/plat.c
@@ -18,7 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/sysfs.h>
 
-#include <asm/amd_node.h>
+#include <asm/amd/node.h>
 
 #include "hsmp.h"
 
diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index d789d6c..e5c4e6b 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -28,7 +28,7 @@
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 
-#include <asm/amd_node.h>
+#include <asm/amd/node.h>
 
 #include "pmc.h"
 
diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index a2cb2d5..cecadae 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -14,7 +14,7 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
-#include <asm/amd_node.h>
+#include <asm/amd/node.h>
 #include "pmf.h"
 
 /* PMF-SMU communication registers */
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index c63fee3..05bbee2 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -18,7 +18,7 @@
 #include <linux/ras.h>
 
 #include <asm/amd/nb.h>
-#include <asm/amd_node.h>
+#include <asm/amd/node.h>
 
 #include "reg_fields.h"
 
diff --git a/sound/soc/amd/acp/acp-rembrandt.c b/sound/soc/amd/acp/acp-rembrandt.c
index 746b6ed..c30a7b5 100644
--- a/sound/soc/amd/acp/acp-rembrandt.c
+++ b/sound/soc/amd/acp/acp-rembrandt.c
@@ -22,7 +22,7 @@
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 
-#include <asm/amd_node.h>
+#include <asm/amd/node.h>
 
 #include "amd.h"
 #include "../mach-config.h"
diff --git a/sound/soc/amd/acp/acp63.c b/sound/soc/amd/acp/acp63.c
index 52d895e..0ddde14 100644
--- a/sound/soc/amd/acp/acp63.c
+++ b/sound/soc/amd/acp/acp63.c
@@ -21,7 +21,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pci.h>
 
-#include <asm/amd_node.h>
+#include <asm/amd/node.h>
 
 #include "amd.h"
 #include "acp-mach.h"
diff --git a/sound/soc/amd/acp/acp70.c b/sound/soc/amd/acp/acp70.c
index 6d5f5ad..7f4a25b 100644
--- a/sound/soc/amd/acp/acp70.c
+++ b/sound/soc/amd/acp/acp70.c
@@ -23,7 +23,7 @@
 #include "amd.h"
 #include "acp-mach.h"
 
-#include <asm/amd_node.h>
+#include <asm/amd/node.h>
 
 #define DRV_NAME "acp_asoc_acp70"
 
diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 7c6d647..7e6f107 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -16,7 +16,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
-#include <asm/amd_node.h>
+#include <asm/amd/node.h>
 
 #include "../ops.h"
 #include "acp.h"

