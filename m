Return-Path: <linux-tip-commits+bounces-3177-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA93FA0712C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 10:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4373A8195
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 09:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2402821577E;
	Thu,  9 Jan 2025 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PSzFEXVZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ETbEyO7l"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF47215195;
	Thu,  9 Jan 2025 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736414144; cv=none; b=SPI/jZftUyGb+4G9DfIFnmPECEqWydVpnBEULAGqMukOVbBvyAt+du4mDpyHqgh7aDqXcpTgHOD+x5nAaa87FNClv0TfihDdINYr1NG5QX1kkNNYBvXaMpm2bwN7a7V/fXKkBQHKk+uHuvAGWLPRitUsap45s4018OlIc1RObM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736414144; c=relaxed/simple;
	bh=QuRJz3y7ZxzhMk7+A3m1r71LdYY0X64ECGrrUxGXcEI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Moa36FccMHGwZoSd52PsIlAx8m5pRVWtgBAC99APOrEdhtw0qoisYzaljhY9Fpr+9qRPPkAM0q5gguvZdmTv2Iyd/gOZyQDEDf43Z2uYEKk5EBr7hLSK3TQka7w/pWbSztaqoF9wIY5nc7sWnW4zaG2Ft9vyOLibjVSse7fcJJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PSzFEXVZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ETbEyO7l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 09 Jan 2025 09:15:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736414139;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtjAyN4dSzdLcCekO/0qD8/JScT6w+C2eMXEgWUZ1/I=;
	b=PSzFEXVZAuzw7FXAzk9JY2S8hVs5nTfSvyRKVO/Ez75SGwqGCjoMcsdudVgCoSMnlWGxf4
	/VO6uqnwMTQsYbe1j7stdpeeY8n/HlY6s2CQCjbCJchMdUXUdkbQgV8c0MPiMLvpR/lUca
	7qGlEQfAUCLBSoLPSGD29Fo2Q9lWHZHq9/7+uiMqcnbUFY8i7buiGv5XqAYI7A9OQj4EA0
	EGuB1RdjhKK514S5bKQihnNf8uC8LcyUOvpxtlwkTGnzWf9YLn2bCvPZER7HaST+vV55IK
	j9Lb6PQDjEi4OiuvqwbXnz9c78hlBid+psbuGOUPLnzxytiBKhKD/Gzt4mOYBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736414139;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtjAyN4dSzdLcCekO/0qD8/JScT6w+C2eMXEgWUZ1/I=;
	b=ETbEyO7lWayCKkq+doJNRvNi1mj6+qSt8Xxm9drs3CMI9vrDr+IdbszQffQuL4QDYVg7mD
	/tVOEWPtWG/XxnBw==
From: "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/misc] x86/amd_nb: Move SMN access code to a new amd_node driver
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 ilpo.jarvinen@linux.intel.com, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241206161210.163701-11-yazen.ghannam@amd.com>
References: <20241206161210.163701-11-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173641413926.399.3713213795769629022.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     d6caeafaa324e6aba5ed2ca1a416340c2fd061a2
Gitweb:        https://git.kernel.org/tip/d6caeafaa324e6aba5ed2ca1a416340c2fd=
061a2
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Fri, 06 Dec 2024 16:12:03=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 08 Jan 2025 10:59:44 +01:00

x86/amd_nb: Move SMN access code to a new amd_node driver

SMN access was bolted into amd_nb mostly as convenience.  This has
limitations though that require incurring tech debt to keep it working.

Move SMN access to the newly introduced AMD Node driver.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> # pdx86
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com> # PMF, PMC
Link: https://lore.kernel.org/r/20241206161210.163701-11-yazen.ghannam@amd.com
---
 MAINTAINERS                          |  1 +-
 arch/x86/include/asm/amd_nb.h        |  3 +-
 arch/x86/include/asm/amd_node.h      |  3 +-
 arch/x86/kernel/amd_nb.c             | 89 +---------------------------
 arch/x86/kernel/amd_node.c           | 90 +++++++++++++++++++++++++++-
 arch/x86/pci/fixup.c                 |  4 +-
 drivers/edac/Kconfig                 |  1 +-
 drivers/edac/amd64_edac.c            |  1 +-
 drivers/hwmon/Kconfig                |  2 +-
 drivers/hwmon/k10temp.c              |  2 +-
 drivers/platform/x86/amd/pmc/Kconfig |  2 +-
 drivers/platform/x86/amd/pmc/pmc.c   |  3 +-
 drivers/platform/x86/amd/pmf/Kconfig |  2 +-
 drivers/platform/x86/amd/pmf/core.c  |  2 +-
 drivers/ras/amd/atl/Kconfig          |  1 +-
 drivers/ras/amd/atl/internal.h       |  1 +-
 16 files changed, 107 insertions(+), 100 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 290989a..27a5bc2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1122,6 +1122,7 @@ S:	Supported
 F:	drivers/i2c/busses/i2c-amd-asf-plat.c
=20
 AMD NODE DRIVER
+M:	Mario Limonciello <mario.limonciello@amd.com>
 M:	Yazen Ghannam <yazen.ghannam@amd.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 094c3be..5e03335 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -21,9 +21,6 @@ extern int amd_numa_init(void);
 extern int amd_get_subcaches(int);
 extern int amd_set_subcaches(int, unsigned long);
=20
-int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
-int __must_check amd_smn_write(u16 node, u32 address, u32 value);
-
 struct amd_l3_cache {
 	unsigned indices;
 	u8	 subcaches[4];
diff --git a/arch/x86/include/asm/amd_node.h b/arch/x86/include/asm/amd_node.h
index 419a0ad..113ad3e 100644
--- a/arch/x86/include/asm/amd_node.h
+++ b/arch/x86/include/asm/amd_node.h
@@ -30,4 +30,7 @@ static inline u16 amd_num_nodes(void)
 	return topology_amd_nodes_per_pkg() * topology_max_packages();
 }
=20
+int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
+int __must_check amd_smn_write(u16 node, u32 address, u32 value);
+
 #endif /*_ASM_X86_AMD_NODE_H_*/
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index e335d89..11fac09 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -15,9 +15,6 @@
 #include <linux/pci_ids.h>
 #include <asm/amd_nb.h>
=20
-/* Protect the PCI config register pairs used for SMN. */
-static DEFINE_MUTEX(smn_mutex);
-
 static u32 *flush_words;
=20
 static const struct pci_device_id amd_nb_misc_ids[] =3D {
@@ -59,92 +56,6 @@ struct amd_northbridge *node_to_amd_nb(int node)
 }
 EXPORT_SYMBOL_GPL(node_to_amd_nb);
=20
-/*
- * SMN accesses may fail in ways that are difficult to detect here in the ca=
lled
- * functions amd_smn_read() and amd_smn_write(). Therefore, callers must do
- * their own checking based on what behavior they expect.
- *
- * For SMN reads, the returned value may be zero if the register is Read-as-=
Zero.
- * Or it may be a "PCI Error Response", e.g. all 0xFFs. The "PCI Error Respo=
nse"
- * can be checked here, and a proper error code can be returned.
- *
- * But the Read-as-Zero response cannot be verified here. A value of 0 may be
- * correct in some cases, so callers must check that this correct is for the
- * register/fields they need.
- *
- * For SMN writes, success can be determined through a "write and read back"
- * However, this is not robust when done here.
- *
- * Possible issues:
- *
- * 1) Bits that are "Write-1-to-Clear". In this case, the read value should
- *    *not* match the write value.
- *
- * 2) Bits that are "Read-as-Zero"/"Writes-Ignored". This information cannot=
 be
- *    known here.
- *
- * 3) Bits that are "Reserved / Set to 1". Ditto above.
- *
- * Callers of amd_smn_write() should do the "write and read back" check
- * themselves, if needed.
- *
- * For #1, they can see if their target bits got cleared.
- *
- * For #2 and #3, they can check if their target bits got set as intended.
- *
- * This matches what is done for RDMSR/WRMSR. As long as there's no #GP, then
- * the operation is considered a success, and the caller does their own
- * checking.
- */
-static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
-{
-	struct pci_dev *root;
-	int err =3D -ENODEV;
-
-	if (node >=3D amd_northbridges.num)
-		goto out;
-
-	root =3D node_to_amd_nb(node)->root;
-	if (!root)
-		goto out;
-
-	mutex_lock(&smn_mutex);
-
-	err =3D pci_write_config_dword(root, 0x60, address);
-	if (err) {
-		pr_warn("Error programming SMN address 0x%x.\n", address);
-		goto out_unlock;
-	}
-
-	err =3D (write ? pci_write_config_dword(root, 0x64, *value)
-		     : pci_read_config_dword(root, 0x64, value));
-
-out_unlock:
-	mutex_unlock(&smn_mutex);
-
-out:
-	return err;
-}
-
-int __must_check amd_smn_read(u16 node, u32 address, u32 *value)
-{
-	int err =3D __amd_smn_rw(node, address, value, false);
-
-	if (PCI_POSSIBLE_ERROR(*value)) {
-		err =3D -ENODEV;
-		*value =3D 0;
-	}
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(amd_smn_read);
-
-int __must_check amd_smn_write(u16 node, u32 address, u32 value)
-{
-	return __amd_smn_rw(node, address, &value, true);
-}
-EXPORT_SYMBOL_GPL(amd_smn_write);
-
 static int amd_cache_northbridges(void)
 {
 	struct amd_northbridge *nb;
diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index 4eea8c7..95e5ca0 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -8,6 +8,7 @@
  * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
  */
=20
+#include <asm/amd_nb.h>
 #include <asm/amd_node.h>
=20
 /*
@@ -88,3 +89,92 @@ struct pci_dev *amd_node_get_root(u16 node)
 	pci_dbg(root, "is root for AMD node %u\n", node);
 	return root;
 }
+
+/* Protect the PCI config register pairs used for SMN. */
+static DEFINE_MUTEX(smn_mutex);
+
+/*
+ * SMN accesses may fail in ways that are difficult to detect here in the ca=
lled
+ * functions amd_smn_read() and amd_smn_write(). Therefore, callers must do
+ * their own checking based on what behavior they expect.
+ *
+ * For SMN reads, the returned value may be zero if the register is Read-as-=
Zero.
+ * Or it may be a "PCI Error Response", e.g. all 0xFFs. The "PCI Error Respo=
nse"
+ * can be checked here, and a proper error code can be returned.
+ *
+ * But the Read-as-Zero response cannot be verified here. A value of 0 may be
+ * correct in some cases, so callers must check that this correct is for the
+ * register/fields they need.
+ *
+ * For SMN writes, success can be determined through a "write and read back"
+ * However, this is not robust when done here.
+ *
+ * Possible issues:
+ *
+ * 1) Bits that are "Write-1-to-Clear". In this case, the read value should
+ *    *not* match the write value.
+ *
+ * 2) Bits that are "Read-as-Zero"/"Writes-Ignored". This information cannot=
 be
+ *    known here.
+ *
+ * 3) Bits that are "Reserved / Set to 1". Ditto above.
+ *
+ * Callers of amd_smn_write() should do the "write and read back" check
+ * themselves, if needed.
+ *
+ * For #1, they can see if their target bits got cleared.
+ *
+ * For #2 and #3, they can check if their target bits got set as intended.
+ *
+ * This matches what is done for RDMSR/WRMSR. As long as there's no #GP, then
+ * the operation is considered a success, and the caller does their own
+ * checking.
+ */
+static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
+{
+	struct pci_dev *root;
+	int err =3D -ENODEV;
+
+	if (node >=3D amd_nb_num())
+		goto out;
+
+	root =3D node_to_amd_nb(node)->root;
+	if (!root)
+		goto out;
+
+	mutex_lock(&smn_mutex);
+
+	err =3D pci_write_config_dword(root, 0x60, address);
+	if (err) {
+		pr_warn("Error programming SMN address 0x%x.\n", address);
+		goto out_unlock;
+	}
+
+	err =3D (write ? pci_write_config_dword(root, 0x64, *value)
+		     : pci_read_config_dword(root, 0x64, value));
+
+out_unlock:
+	mutex_unlock(&smn_mutex);
+
+out:
+	return err;
+}
+
+int __must_check amd_smn_read(u16 node, u32 address, u32 *value)
+{
+	int err =3D __amd_smn_rw(node, address, value, false);
+
+	if (PCI_POSSIBLE_ERROR(*value)) {
+		err =3D -ENODEV;
+		*value =3D 0;
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(amd_smn_read);
+
+int __must_check amd_smn_write(u16 node, u32 address, u32 value)
+{
+	return __amd_smn_rw(node, address, &value, true);
+}
+EXPORT_SYMBOL_GPL(amd_smn_write);
diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 0681ecf..592fb9d 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -9,7 +9,7 @@
 #include <linux/pci.h>
 #include <linux/suspend.h>
 #include <linux/vgaarb.h>
-#include <asm/amd_nb.h>
+#include <asm/amd_node.h>
 #include <asm/hpet.h>
 #include <asm/pci_x86.h>
=20
@@ -828,7 +828,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7910, rs690_=
fix_64bit_dma);
=20
 #endif
=20
-#ifdef CONFIG_AMD_NB
+#ifdef CONFIG_AMD_NODE
=20
 #define AMD_15B8_RCC_DEV2_EPF0_STRAP2                                  0x101=
36008
 #define AMD_15B8_RCC_DEV2_EPF0_STRAP2_NO_SOFT_RESET_DEV2_F0_MASK       0x000=
00080L
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 06f7b43..cb97d7b 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -78,6 +78,7 @@ config EDAC_GHES
 config EDAC_AMD64
 	tristate "AMD64 (Opteron, Athlon64)"
 	depends on AMD_NB && EDAC_DECODE_MCE
+	depends on AMD_NODE
 	imply AMD_ATL
 	help
 	  Support for error detection and correction of DRAM ECC errors on
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index ddfbdb6..2946508 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2,6 +2,7 @@
 #include <linux/ras.h>
 #include "amd64_edac.h"
 #include <asm/amd_nb.h>
+#include <asm/amd_node.h>
=20
 static struct edac_pci_ctl_info *pci_ctl;
=20
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index dd37660..ea13ea4 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -324,7 +324,7 @@ config SENSORS_K8TEMP
=20
 config SENSORS_K10TEMP
 	tristate "AMD Family 10h+ temperature sensor"
-	depends on X86 && PCI && AMD_NB
+	depends on X86 && PCI && AMD_NODE
 	help
 	  If you say yes here you get support for the temperature
 	  sensor(s) inside your CPU. Supported are later revisions of
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index cefa8cd..d0b4cc9 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -20,7 +20,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
-#include <asm/amd_nb.h>
+#include <asm/amd_node.h>
 #include <asm/processor.h>
=20
 MODULE_DESCRIPTION("AMD Family 10h+ CPU core temperature monitor");
diff --git a/drivers/platform/x86/amd/pmc/Kconfig b/drivers/platform/x86/amd/=
pmc/Kconfig
index 94f9563..eeffdaf 100644
--- a/drivers/platform/x86/amd/pmc/Kconfig
+++ b/drivers/platform/x86/amd/pmc/Kconfig
@@ -5,7 +5,7 @@
=20
 config AMD_PMC
 	tristate "AMD SoC PMC driver"
-	depends on ACPI && PCI && RTC_CLASS && AMD_NB
+	depends on ACPI && PCI && RTC_CLASS && AMD_NODE
 	depends on SUSPEND
 	select SERIO
 	help
diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pm=
c/pmc.c
index 26b878e..941b775 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -10,7 +10,6 @@
=20
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
=20
-#include <asm/amd_nb.h>
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
@@ -28,6 +27,8 @@
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
=20
+#include <asm/amd_node.h>
+
 #include "pmc.h"
=20
 /* SMU communication registers */
diff --git a/drivers/platform/x86/amd/pmf/Kconfig b/drivers/platform/x86/amd/=
pmf/Kconfig
index 99d67cd..25b8f7a 100644
--- a/drivers/platform/x86/amd/pmf/Kconfig
+++ b/drivers/platform/x86/amd/pmf/Kconfig
@@ -7,7 +7,7 @@ config AMD_PMF
 	tristate "AMD Platform Management Framework"
 	depends on ACPI && PCI
 	depends on POWER_SUPPLY
-	depends on AMD_NB
+	depends on AMD_NODE
 	select ACPI_PLATFORM_PROFILE
 	depends on TEE && AMDTEE
 	depends on AMD_SFH_HID
diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/p=
mf/core.c
index 06a97c5..7f88f31 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -8,13 +8,13 @@
  * Author: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
  */
=20
-#include <asm/amd_nb.h>
 #include <linux/debugfs.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
+#include <asm/amd_node.h>
 #include "pmf.h"
=20
 /* PMF-SMU communication registers */
diff --git a/drivers/ras/amd/atl/Kconfig b/drivers/ras/amd/atl/Kconfig
index 5516800..6e03942 100644
--- a/drivers/ras/amd/atl/Kconfig
+++ b/drivers/ras/amd/atl/Kconfig
@@ -10,6 +10,7 @@
 config AMD_ATL
 	tristate "AMD Address Translation Library"
 	depends on AMD_NB && X86_64 && RAS
+	depends on AMD_NODE
 	depends on MEMORY_FAILURE
 	default N
 	help
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index 143d04c..f9be26d 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -18,6 +18,7 @@
 #include <linux/ras.h>
=20
 #include <asm/amd_nb.h>
+#include <asm/amd_node.h>
=20
 #include "reg_fields.h"
=20

