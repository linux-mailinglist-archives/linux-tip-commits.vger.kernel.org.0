Return-Path: <linux-tip-commits+bounces-3184-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A0EA07138
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 10:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684DE188A981
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 09:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E9921639C;
	Thu,  9 Jan 2025 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nHwphhJA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GOmzU01w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ACE215F4F;
	Thu,  9 Jan 2025 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736414147; cv=none; b=oqDQBnrbpIm2Xhq2nJInvF6HpmKT6d5EhyFaZjYymCX1iL5f3MMdhtQ2zXiAZ24sUASt8GXgruhp85m86PQ9YWTaYCWUOtH3rYCeiLj+QVygeJ8JGmVbIAd2OzbII5y62dlhgXJoAAQCbuLGDBf6KjP6zsEwBiWLxmalz5/uQPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736414147; c=relaxed/simple;
	bh=ihck12tibfPzu/zxdbmcKoQ/R+dLx+ZinbhdvQ0gI+0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Eb7cSXrhe70H/25+Y7tuLm75aC0eHwUZMk0v0BkTSrzlkf7lTB3JDQtsItnMCIIieoBq8TV6mtEufZkxMpGlMjmfG/AIQgLvwDoWlX0WtYzR7pDGaSEyif0DAmzd8U21RDmdPGGXqdivbWP6gJMm6K9LF7UiqvNYgJcfMHNGIQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nHwphhJA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GOmzU01w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 09 Jan 2025 09:15:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736414143;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6A/i19PbYj4HI6SSCzLIFO/zIH6PzoNm4DdJFvBLp44=;
	b=nHwphhJA3Vq+Hxtwt962HsBMKRF72U4/rg9aJCcDaoWiZMK1QoCjAh6Q45Mpu+Xl59K5oB
	7Dnf2mo4DRS5FDkyCL/HXEEBl83nlhH4EIrSX0Uvo9f90+giM5mJbqsni1Id2516vssUkS
	mj/68CqbiGbI2JVUorfuhX9tAX9ZNbTofn1sm/Z3awnP1n7cEhRdz1YqnUhkn5dXxYLpKP
	mrI6nRUR1fm6/F3yIP7cl98cROXPaeTvGfgyLmPX2j4fwsM/1GWz+mgAked9P/DsiFUHOa
	wAP0Us1IVZe83TOohUmYo8qidbxj4bpMewLeD0MAAaR7vYFAflUq6WWi8fm1qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736414143;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6A/i19PbYj4HI6SSCzLIFO/zIH6PzoNm4DdJFvBLp44=;
	b=GOmzU01wHLxZK9C9IJM5AXYs2THVBSTwzky2eVdoSrFzqzZae+NocTmu8WO6aM3TGu6pcL
	PFsWM4dF4eZHlXCA==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/misc] x86: Start moving AMD node functionality out of AMD_NB
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241206161210.163701-5-yazen.ghannam@amd.com>
References: <20241206161210.163701-5-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173641414292.399.17352713889666759461.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     e6e6e5e85116b8587ab2dff7cd6ab3e082859ce7
Gitweb:        https://git.kernel.org/tip/e6e6e5e85116b8587ab2dff7cd6ab3e082859ce7
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Fri, 06 Dec 2024 16:11:57 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 08 Jan 2025 10:47:36 +01:00

x86: Start moving AMD node functionality out of AMD_NB

The "AMD Node" concept spans many families of systems and applies to
a number of subsystems and drivers.

Currently, the AMD Northbridge code is overloaded with AMD node
functionality. However, the node concept is broader than just
northbridges.

Start files to host common AMD node functions and definitions.  Include
a helper to find an AMD node device function based on the convention
described in AMD documentation.

Anything that needs node functionality should include this rather than
amd_nb.h. The AMD_NB code will be reduced to only northbridge-specific
code needed for legacy systems.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241206161210.163701-5-yazen.ghannam@amd.com
---
 MAINTAINERS                     |  7 +++++++-
 arch/x86/Kconfig                |  4 ++++-
 arch/x86/include/asm/amd_node.h | 27 +++++++++++++++++++++++++-
 arch/x86/kernel/Makefile        |  1 +-
 arch/x86/kernel/amd_node.c      | 34 ++++++++++++++++++++++++++++++++-
 5 files changed, 73 insertions(+)
 create mode 100644 arch/x86/include/asm/amd_node.h
 create mode 100644 arch/x86/kernel/amd_node.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7..290989a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1121,6 +1121,13 @@ L:	linux-i2c@vger.kernel.org
 S:	Supported
 F:	drivers/i2c/busses/i2c-amd-asf-plat.c
 
+AMD NODE DRIVER
+M:	Yazen Ghannam <yazen.ghannam@amd.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	arch/x86/include/asm/amd_node.h
+F:	arch/x86/kernel/amd_node.c
+
 AMD PDS CORE DRIVER
 M:	Shannon Nelson <shannon.nelson@amd.com>
 M:	Brett Creeley <brett.creeley@amd.com>
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9d7bd0a..01a91b2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -3129,6 +3129,10 @@ endif # X86_32
 
 config AMD_NB
 	def_bool y
+	depends on AMD_NODE
+
+config AMD_NODE
+	def_bool y
 	depends on CPU_SUP_AMD && PCI
 
 endmenu
diff --git a/arch/x86/include/asm/amd_node.h b/arch/x86/include/asm/amd_node.h
new file mode 100644
index 0000000..622bd30
--- /dev/null
+++ b/arch/x86/include/asm/amd_node.h
@@ -0,0 +1,27 @@
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
+
+#endif /*_ASM_X86_AMD_NODE_H_*/
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index f791898..b43eb7e 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -119,6 +119,7 @@ obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
 
 obj-$(CONFIG_AMD_NB)		+= amd_nb.o
+obj-$(CONFIG_AMD_NODE)		+= amd_node.o
 obj-$(CONFIG_DEBUG_NMI_SELFTEST) += nmi_selftest.o
 
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvmclock.o
diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
new file mode 100644
index 0000000..e825cd4
--- /dev/null
+++ b/arch/x86/kernel/amd_node.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Node helper functions and common defines
+ *
+ * Copyright (c) 2024, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
+ */
+
+#include <asm/amd_node.h>
+
+/*
+ * AMD Nodes are a physical collection of I/O devices within an SoC. There can be one
+ * or more nodes per package.
+ *
+ * The nodes are software-visible through PCI config space. All nodes are enumerated
+ * on segment 0 bus 0. The device (slot) numbers range from 0x18 to 0x1F (maximum 8
+ * nodes) with 0x18 corresponding to node 0, 0x19 to node 1, etc. Each node can be a
+ * multi-function device.
+ *
+ * On legacy systems, these node devices represent integrated Northbridge functionality.
+ * On Zen-based systems, these node devices represent Data Fabric functionality.
+ *
+ * See "Configuration Space Accesses" section in BKDGs or
+ * "Processor x86 Core" -> "Configuration Space" section in PPRs.
+ */
+struct pci_dev *amd_node_get_func(u16 node, u8 func)
+{
+	if (node >= MAX_AMD_NUM_NODES)
+		return NULL;
+
+	return pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(AMD_NODE0_PCI_SLOT + node, func));
+}

