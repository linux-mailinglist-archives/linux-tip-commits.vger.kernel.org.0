Return-Path: <linux-tip-commits+bounces-3520-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74C0A39DD5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 14:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0516C1651B8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 13:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660BF2690C0;
	Tue, 18 Feb 2025 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="algkSUgh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H6UYoR06"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5507954738;
	Tue, 18 Feb 2025 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885976; cv=none; b=Bqmd4AAW5lZQmIzVW5gEemq7HRJnNzXXW70N8OfoFHVJI9lKnLyVitInF4eAXhtjj0S/ZJiyq7zoqHQg49eFAqdEbxy2S5/H/iKsMUUd+pNWh8Dxc2mAz7XW/pvxQ6eVOvQk47uzvAAG9WryVG1ecR2rTrh8QERTW6Cr+kYPAM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885976; c=relaxed/simple;
	bh=wjUOXsmopWhzn8EnnSRKrItSMkKjZgyy3pMrSECRptc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PVX8Zblg6kKIbFYb+qkKc2r+pWQxUAr1RYSZXTQaUn/3LPwlKNWSuh+zc8b/A30Ap9zJNR1wLaazwDicmr2pQmOghUsKK9sha3zNg+EFYX6BnviTcV9slrFfsZh9Y31yelPJCrMdI7Rz8Yve5TO2fMf9dDros0Y2m69qDUHjo2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=algkSUgh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H6UYoR06; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 13:39:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739885967;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+/qFEwrcEq526ns6ankpVXuPkBnie2PrlFDO87YHE4=;
	b=algkSUghD3iq8uiVyHX5YcWT+cCNjs3pZI2wQHuV7MnV/ZSEZ8eAM4J4zCiPwtjQvDba6Z
	oj4XBOa9NfLw8H73XWvqJJGGp8uXvupE5pLe366XR4MlkndtWfDM6GDmYtnSFCqUKMRZsF
	c6VpLiuCqtUrwXfp9Kj9t3P/27WXJPoMvxaQnGZQZiQfDzY/Eo68LnWbZQ4ckrb369HpUE
	HfhIV/olGoR7KwnZfaH+qULbfn47yDSEl0kgSPXeKKJPnSyy2xvEWphhInMNAT5XTEMazo
	cha00uFLT40Dt60QAYHXgfjrVMkyL0jBBIO8mc4ztlEZ2Lst12hles2gg4EMjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739885967;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+/qFEwrcEq526ns6ankpVXuPkBnie2PrlFDO87YHE4=;
	b=H6UYoR06b+tPOKj2TcABRwbgr/Yn6OUMZWkUPRiZ9oJHB+omEBh8p4ld6k88lOLzDs8ox2
	tixIzd+CKI4rSpAw==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/amd_node, platform/x86/amd/hsmp: Have HSMP use
 SMN through AMD_NODE
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Carlos Bilbao <carlos.bilbao@kernel.org>, ilpo.jarvinen@linux.intel.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250130-wip-x86-amd-nb-cleanup-v4-1-b5cc997e471b@amd.com>
References: <20250130-wip-x86-amd-nb-cleanup-v4-1-b5cc997e471b@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173988596664.10177.11558429701975031106.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     735049b801cf3d597752017385cfc8768ce44303
Gitweb:        https://git.kernel.org/tip/735049b801cf3d597752017385cfc8768ce=
44303
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Thu, 30 Jan 2025 19:48:55=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Feb 2025 09:47:31 +01:00

x86/amd_node, platform/x86/amd/hsmp: Have HSMP use SMN through AMD_NODE

The HSMP interface is just an SMN interface with different offsets.

Define an HSMP wrapper in the SMN code and have the HSMP platform driver
use that rather than a local solution.

Also, remove the "root" member from AMD_NB, since there are no more
users of it.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Carlos Bilbao <carlos.bilbao@kernel.org>
Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20250130-wip-x86-amd-nb-cleanup-v4-1-b5cc997e=
471b@amd.com
---
 arch/x86/include/asm/amd_nb.h         |  1 +-
 arch/x86/include/asm/amd_node.h       | 13 +++++++++-
 arch/x86/kernel/amd_nb.c              |  1 +-
 arch/x86/kernel/amd_node.c            |  9 +++++++-
 drivers/platform/x86/amd/hsmp/Kconfig |  2 +-
 drivers/platform/x86/amd/hsmp/acpi.c  |  7 ++---
 drivers/platform/x86/amd/hsmp/hsmp.c  |  1 +-
 drivers/platform/x86/amd/hsmp/hsmp.h  |  3 +--
 drivers/platform/x86/amd/hsmp/plat.c  | 36 ++++++++------------------
 9 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 4c4efb9..adfa085 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -27,7 +27,6 @@ struct amd_l3_cache {
 };
=20
 struct amd_northbridge {
-	struct pci_dev *root;
 	struct pci_dev *misc;
 	struct pci_dev *link;
 	struct amd_l3_cache l3_cache;
diff --git a/arch/x86/include/asm/amd_node.h b/arch/x86/include/asm/amd_node.h
index 113ad3e..002c3af 100644
--- a/arch/x86/include/asm/amd_node.h
+++ b/arch/x86/include/asm/amd_node.h
@@ -30,7 +30,20 @@ static inline u16 amd_num_nodes(void)
 	return topology_amd_nodes_per_pkg() * topology_max_packages();
 }
=20
+#ifdef CONFIG_AMD_NODE
 int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
 int __must_check amd_smn_write(u16 node, u32 address, u32 value);
=20
+/* Should only be used by the HSMP driver. */
+int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool w=
rite);
+#else
+static inline int __must_check amd_smn_read(u16 node, u32 address, u32 *valu=
e) { return -ENODEV; }
+static inline int __must_check amd_smn_write(u16 node, u32 address, u32 valu=
e) { return -ENODEV; }
+
+static inline int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 =
*value, bool write)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_AMD_NODE */
+
 #endif /*_ASM_X86_AMD_NODE_H_*/
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 11fac09..24d7a87 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -73,7 +73,6 @@ static int amd_cache_northbridges(void)
 	amd_northbridges.nb =3D nb;
=20
 	for (i =3D 0; i < amd_northbridges.num; i++) {
-		node_to_amd_nb(i)->root =3D amd_node_get_root(i);
 		node_to_amd_nb(i)->misc =3D amd_node_get_func(i, 3);
=20
 		/*
diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index d2ec7fd..65045f2 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -97,6 +97,9 @@ static DEFINE_MUTEX(smn_mutex);
 #define SMN_INDEX_OFFSET	0x60
 #define SMN_DATA_OFFSET		0x64
=20
+#define HSMP_INDEX_OFFSET	0xc4
+#define HSMP_DATA_OFFSET	0xc8
+
 /*
  * SMN accesses may fail in ways that are difficult to detect here in the ca=
lled
  * functions amd_smn_read() and amd_smn_write(). Therefore, callers must do
@@ -179,6 +182,12 @@ int __must_check amd_smn_write(u16 node, u32 address, u3=
2 value)
 }
 EXPORT_SYMBOL_GPL(amd_smn_write);
=20
+int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool w=
rite)
+{
+	return __amd_smn_rw(HSMP_INDEX_OFFSET, HSMP_DATA_OFFSET, node, address, val=
ue, write);
+}
+EXPORT_SYMBOL_GPL(amd_smn_hsmp_rdwr);
+
 static int amd_cache_roots(void)
 {
 	u16 node, num_nodes =3D amd_num_nodes();
diff --git a/drivers/platform/x86/amd/hsmp/Kconfig b/drivers/platform/x86/amd=
/hsmp/Kconfig
index 7d10d44..d6f7a62 100644
--- a/drivers/platform/x86/amd/hsmp/Kconfig
+++ b/drivers/platform/x86/amd/hsmp/Kconfig
@@ -7,7 +7,7 @@ config AMD_HSMP
 	tristate
=20
 menu "AMD HSMP Driver"
-	depends on AMD_NB || COMPILE_TEST
+	depends on AMD_NODE || COMPILE_TEST
=20
 config AMD_HSMP_ACPI
 	tristate "AMD HSMP ACPI device driver"
diff --git a/drivers/platform/x86/amd/hsmp/acpi.c b/drivers/platform/x86/amd/=
hsmp/acpi.c
index 444b43b..c1eccb3 100644
--- a/drivers/platform/x86/amd/hsmp/acpi.c
+++ b/drivers/platform/x86/amd/hsmp/acpi.c
@@ -10,7 +10,6 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
=20
 #include <asm/amd_hsmp.h>
-#include <asm/amd_nb.h>
=20
 #include <linux/acpi.h>
 #include <linux/device.h>
@@ -24,6 +23,8 @@
=20
 #include <uapi/asm-generic/errno-base.h>
=20
+#include <asm/amd_node.h>
+
 #include "hsmp.h"
=20
 #define DRIVER_NAME		"amd_hsmp"
@@ -321,8 +322,8 @@ static int hsmp_acpi_probe(struct platform_device *pdev)
 		return -ENOMEM;
=20
 	if (!hsmp_pdev->is_probed) {
-		hsmp_pdev->num_sockets =3D amd_nb_num();
-		if (hsmp_pdev->num_sockets =3D=3D 0 || hsmp_pdev->num_sockets > MAX_AMD_SO=
CKETS)
+		hsmp_pdev->num_sockets =3D amd_num_nodes();
+		if (hsmp_pdev->num_sockets =3D=3D 0 || hsmp_pdev->num_sockets > MAX_AMD_NU=
M_NODES)
 			return -ENODEV;
=20
 		hsmp_pdev->sock =3D devm_kcalloc(&pdev->dev, hsmp_pdev->num_sockets,
diff --git a/drivers/platform/x86/amd/hsmp/hsmp.c b/drivers/platform/x86/amd/=
hsmp/hsmp.c
index 03164e3..a3ac09a 100644
--- a/drivers/platform/x86/amd/hsmp/hsmp.c
+++ b/drivers/platform/x86/amd/hsmp/hsmp.c
@@ -8,7 +8,6 @@
  */
=20
 #include <asm/amd_hsmp.h>
-#include <asm/amd_nb.h>
=20
 #include <linux/acpi.h>
 #include <linux/delay.h>
diff --git a/drivers/platform/x86/amd/hsmp/hsmp.h b/drivers/platform/x86/amd/=
hsmp/hsmp.h
index e852f0a..af8b21f 100644
--- a/drivers/platform/x86/amd/hsmp/hsmp.h
+++ b/drivers/platform/x86/amd/hsmp/hsmp.h
@@ -21,8 +21,6 @@
=20
 #define HSMP_ATTR_GRP_NAME_SIZE	10
=20
-#define MAX_AMD_SOCKETS 8
-
 #define HSMP_CDEV_NAME		"hsmp_cdev"
 #define HSMP_DEVNODE_NAME	"hsmp"
=20
@@ -41,7 +39,6 @@ struct hsmp_socket {
 	void __iomem *virt_base_addr;
 	struct semaphore hsmp_sem;
 	char name[HSMP_ATTR_GRP_NAME_SIZE];
-	struct pci_dev *root;
 	struct device *dev;
 	u16 sock_ind;
 	int (*amd_hsmp_rdwr)(struct hsmp_socket *sock, u32 off, u32 *val, bool rw);
diff --git a/drivers/platform/x86/amd/hsmp/plat.c b/drivers/platform/x86/amd/=
hsmp/plat.c
index 02ca857..b9782a0 100644
--- a/drivers/platform/x86/amd/hsmp/plat.c
+++ b/drivers/platform/x86/amd/hsmp/plat.c
@@ -10,14 +10,16 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
=20
 #include <asm/amd_hsmp.h>
-#include <asm/amd_nb.h>
=20
+#include <linux/build_bug.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/sysfs.h>
=20
+#include <asm/amd_node.h>
+
 #include "hsmp.h"
=20
 #define DRIVER_NAME		"amd_hsmp"
@@ -34,28 +36,12 @@
 #define SMN_HSMP_MSG_RESP	0x0010980
 #define SMN_HSMP_MSG_DATA	0x00109E0
=20
-#define HSMP_INDEX_REG		0xc4
-#define HSMP_DATA_REG		0xc8
-
 static struct hsmp_plat_device *hsmp_pdev;
=20
 static int amd_hsmp_pci_rdwr(struct hsmp_socket *sock, u32 offset,
 			     u32 *value, bool write)
 {
-	int ret;
-
-	if (!sock->root)
-		return -ENODEV;
-
-	ret =3D pci_write_config_dword(sock->root, HSMP_INDEX_REG,
-				     sock->mbinfo.base_addr + offset);
-	if (ret)
-		return ret;
-
-	ret =3D (write ? pci_write_config_dword(sock->root, HSMP_DATA_REG, *value)
-		     : pci_read_config_dword(sock->root, HSMP_DATA_REG, value));
-
-	return ret;
+	return amd_smn_hsmp_rdwr(sock->sock_ind, sock->mbinfo.base_addr + offset, v=
alue, write);
 }
=20
 static ssize_t hsmp_metric_tbl_plat_read(struct file *filp, struct kobject *=
kobj,
@@ -95,7 +81,12 @@ static umode_t hsmp_is_sock_attr_visible(struct kobject *k=
obj,
  * Static array of 8 + 1(for NULL) elements is created below
  * to create sysfs groups for sockets.
  * is_bin_visible function is used to show / hide the necessary groups.
+ *
+ * Validate the maximum number against MAX_AMD_NUM_NODES. If this changes,
+ * then the attributes and groups below must be adjusted.
  */
+static_assert(MAX_AMD_NUM_NODES =3D=3D 8);
+
 #define HSMP_BIN_ATTR(index, _list)					\
 static const struct bin_attribute attr##index =3D {			\
 	.attr =3D { .name =3D HSMP_METRICS_TABLE_NAME, .mode =3D 0444},	\
@@ -159,10 +150,7 @@ static int init_platform_device(struct device *dev)
 	int ret, i;
=20
 	for (i =3D 0; i < hsmp_pdev->num_sockets; i++) {
-		if (!node_to_amd_nb(i))
-			return -ENODEV;
 		sock =3D &hsmp_pdev->sock[i];
-		sock->root			=3D node_to_amd_nb(i)->root;
 		sock->sock_ind			=3D i;
 		sock->dev			=3D dev;
 		sock->mbinfo.base_addr		=3D SMN_HSMP_BASE;
@@ -305,11 +293,11 @@ static int __init hsmp_plt_init(void)
 		return -ENOMEM;
=20
 	/*
-	 * amd_nb_num() returns number of SMN/DF interfaces present in the system
+	 * amd_num_nodes() returns number of SMN/DF interfaces present in the system
 	 * if we have N SMN/DF interfaces that ideally means N sockets
 	 */
-	hsmp_pdev->num_sockets =3D amd_nb_num();
-	if (hsmp_pdev->num_sockets =3D=3D 0 || hsmp_pdev->num_sockets > MAX_AMD_SOC=
KETS)
+	hsmp_pdev->num_sockets =3D amd_num_nodes();
+	if (hsmp_pdev->num_sockets =3D=3D 0 || hsmp_pdev->num_sockets > MAX_AMD_NUM=
_NODES)
 		return ret;
=20
 	ret =3D platform_driver_register(&amd_hsmp_driver);

