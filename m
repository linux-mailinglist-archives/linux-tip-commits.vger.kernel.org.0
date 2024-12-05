Return-Path: <linux-tip-commits+bounces-2985-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3409E5E4D
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Dec 2024 19:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B861884F2C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Dec 2024 18:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36689229B00;
	Thu,  5 Dec 2024 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kXAytrDZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U+yU59uw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E99225797;
	Thu,  5 Dec 2024 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733423629; cv=none; b=iEdfso+ILL6uo//ImfKqEjk22RrrBgmJAahu4p9occQRBO2b5DrBDxbHxRiq6kH+GpUW0Z0t3V3j5yv69rOjtklSuk8SFtdWqZZq3AyM/qppsrkwdwkLjsbQXLgR0uYjHNyaIUNO4IJUiMtgkkJn2SCJPdyb5iD5itxW32a5N0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733423629; c=relaxed/simple;
	bh=YcsvTbP2x23VUS82pULw8FIiJug9dDZWkcJLs4kmgpA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=FrCLNe4BiZ+ULXEIyXaqQ8TKrubm3jNtJQebdHHSQOuqexCfPCivNH8zrqXK0gsCixWxKocezSIutbar7Q1927Q/TwKzf3ojkLfjaiZV4VTOd0EgBqRbec8BZ4IVL+QdhrZd3jaS/gCMDfR0V8GEik6hBUfT1hflY3EBxwRwXbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kXAytrDZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U+yU59uw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Dec 2024 18:33:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733423624;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=R4Jd9Gf1+gUxflwcEsKODst6ggyxsSyk4Dc1p3b8T1g=;
	b=kXAytrDZsMp7J/L6nDXc/udKPRbgnq+eKEs2HtiNclY0VhZwGFhK6YuwqssQ/QF7yt1OP4
	8b+eZZ4ly1t7cquYhHMPDxR1EbN1xUyqQcz48r56feWefJoOpt0YIziins1tyz8F41jbgQ
	/6m8xUA8yWTz2vSdwYvwdVu2orhjPsO9s5/hxucq2kjlnKcF67lfXNjQj+K1UVuAhndh7B
	KCiaj+4NaGe48bO6nt/JQGUIge5gUVWBuJ7+TjRTgwemvA7Iespzrtyn3Vi6GMB13Z+wPq
	+GA/sxnz6nJ2RkLPFxGWIL90YiCvDM+AouRC90vmSa3To9WnkEjBwbVsp0fGEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733423624;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=R4Jd9Gf1+gUxflwcEsKODst6ggyxsSyk4Dc1p3b8T1g=;
	b=U+yU59uwn7s5x559VRG4ayBNuAWGI+XN3rhibzKTuajZO593vfhQuMDp14MPf3a95rLbVN
	J7ccxxXGb/aNBfBw==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Dump attributes and TD_CTLS on boot
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173342362358.412.13668414237432627916.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     564ea84c8c14b007d7838bfb1327295b873573be
Gitweb:        https://git.kernel.org/tip/564ea84c8c14b007d7838bfb1327295b873573be
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Mon, 02 Dec 2024 09:24:58 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 05 Dec 2024 10:27:07 -08:00

x86/tdx: Dump attributes and TD_CTLS on boot

Dump TD configuration on boot. Attributes and TD_CTLS define TD
behavior. This information is useful for tracking down bugs.

The output ends up looking like this in practice:

[    0.000000] tdx: Guest detected
[    0.000000] tdx: Attributes: SEPT_VE_DISABLE
[    0.000000] tdx: TD_CTLS: PENDING_VE_DISABLE ENUM_TOPOLOGY VIRT_CPUID2 REDUCE_VE

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/all/20241202072458.447455-1-kirill.shutemov%40linux.intel.com
---
 arch/x86/coco/tdx/Makefile        |  2 +-
 arch/x86/coco/tdx/debug.c         | 69 ++++++++++++++++++++++++++++++-
 arch/x86/coco/tdx/tdx.c           | 27 ++++++++----
 arch/x86/include/asm/shared/tdx.h | 39 +++++++++++++++--
 arch/x86/include/asm/tdx.h        |  3 +-
 5 files changed, 128 insertions(+), 12 deletions(-)
 create mode 100644 arch/x86/coco/tdx/debug.c

diff --git a/arch/x86/coco/tdx/Makefile b/arch/x86/coco/tdx/Makefile
index 2c7dcbf..b3c47d3 100644
--- a/arch/x86/coco/tdx/Makefile
+++ b/arch/x86/coco/tdx/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y += tdx.o tdx-shared.o tdcall.o
+obj-y += debug.o tdcall.o tdx.o tdx-shared.o
diff --git a/arch/x86/coco/tdx/debug.c b/arch/x86/coco/tdx/debug.c
new file mode 100644
index 0000000..cef847c
--- /dev/null
+++ b/arch/x86/coco/tdx/debug.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#undef pr_fmt
+#define pr_fmt(fmt)     "tdx: " fmt
+
+#include <linux/array_size.h>
+#include <linux/printk.h>
+#include <asm/tdx.h>
+
+#define DEF_TDX_ATTR_NAME(_name) [TDX_ATTR_##_name##_BIT] = __stringify(_name)
+
+static __initdata const char *tdx_attributes[] = {
+	DEF_TDX_ATTR_NAME(DEBUG),
+	DEF_TDX_ATTR_NAME(HGS_PLUS_PROF),
+	DEF_TDX_ATTR_NAME(PERF_PROF),
+	DEF_TDX_ATTR_NAME(PMT_PROF),
+	DEF_TDX_ATTR_NAME(ICSSD),
+	DEF_TDX_ATTR_NAME(LASS),
+	DEF_TDX_ATTR_NAME(SEPT_VE_DISABLE),
+	DEF_TDX_ATTR_NAME(MIGRTABLE),
+	DEF_TDX_ATTR_NAME(PKS),
+	DEF_TDX_ATTR_NAME(KL),
+	DEF_TDX_ATTR_NAME(TPA),
+	DEF_TDX_ATTR_NAME(PERFMON),
+};
+
+#define DEF_TD_CTLS_NAME(_name) [TD_CTLS_##_name##_BIT] = __stringify(_name)
+
+static __initdata const char *tdcs_td_ctls[] = {
+	DEF_TD_CTLS_NAME(PENDING_VE_DISABLE),
+	DEF_TD_CTLS_NAME(ENUM_TOPOLOGY),
+	DEF_TD_CTLS_NAME(VIRT_CPUID2),
+	DEF_TD_CTLS_NAME(REDUCE_VE),
+	DEF_TD_CTLS_NAME(LOCK),
+};
+
+void __init tdx_dump_attributes(u64 td_attr)
+{
+	pr_info("Attributes:");
+
+	for (int i = 0; i < ARRAY_SIZE(tdx_attributes); i++) {
+		if (!tdx_attributes[i])
+			continue;
+		if (td_attr & BIT(i))
+			pr_cont(" %s", tdx_attributes[i]);
+		td_attr &= ~BIT(i);
+	}
+
+	if (td_attr)
+		pr_cont(" unknown:%#llx", td_attr);
+	pr_cont("\n");
+
+}
+
+void __init tdx_dump_td_ctls(u64 td_ctls)
+{
+	pr_info("TD_CTLS:");
+
+	for (int i = 0; i < ARRAY_SIZE(tdcs_td_ctls); i++) {
+		if (!tdcs_td_ctls[i])
+			continue;
+		if (td_ctls & BIT(i))
+			pr_cont(" %s", tdcs_td_ctls[i]);
+		td_ctls &= ~BIT(i);
+	}
+	if (td_ctls)
+		pr_cont(" unknown:%#llx", td_ctls);
+	pr_cont("\n");
+}
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index c0ebe8c..32809a0 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -32,9 +32,6 @@
 #define VE_GET_PORT_NUM(e)	((e) >> 16)
 #define VE_IS_IO_STRING(e)	((e) & BIT(4))
 
-#define ATTR_DEBUG		BIT(0)
-#define ATTR_SEPT_VE_DISABLE	BIT(28)
-
 /* TDX Module call error codes */
 #define TDCALL_RETURN_CODE(a)	((a) >> 32)
 #define TDCALL_INVALID_OPERAND	0xc0000100
@@ -200,14 +197,14 @@ static void __noreturn tdx_panic(const char *msg)
  *
  * TDX 1.0 does not allow the guest to disable SEPT #VE on its own. The VMM
  * controls if the guest will receive such #VE with TD attribute
- * ATTR_SEPT_VE_DISABLE.
+ * TDX_ATTR_SEPT_VE_DISABLE.
  *
  * Newer TDX modules allow the guest to control if it wants to receive SEPT
  * violation #VEs.
  *
  * Check if the feature is available and disable SEPT #VE if possible.
  *
- * If the TD is allowed to disable/enable SEPT #VEs, the ATTR_SEPT_VE_DISABLE
+ * If the TD is allowed to disable/enable SEPT #VEs, the TDX_ATTR_SEPT_VE_DISABLE
  * attribute is no longer reliable. It reflects the initial state of the
  * control for the TD, but it will not be updated if someone (e.g. bootloader)
  * changes it before the kernel starts. Kernel must check TDCS_TD_CTLS bit to
@@ -216,14 +213,14 @@ static void __noreturn tdx_panic(const char *msg)
 static void disable_sept_ve(u64 td_attr)
 {
 	const char *msg = "TD misconfiguration: SEPT #VE has to be disabled";
-	bool debug = td_attr & ATTR_DEBUG;
+	bool debug = td_attr & TDX_ATTR_DEBUG;
 	u64 config, controls;
 
 	/* Is this TD allowed to disable SEPT #VE */
 	tdg_vm_rd(TDCS_CONFIG_FLAGS, &config);
 	if (!(config & TDCS_CONFIG_FLEXIBLE_PENDING_VE)) {
 		/* No SEPT #VE controls for the guest: check the attribute */
-		if (td_attr & ATTR_SEPT_VE_DISABLE)
+		if (td_attr & TDX_ATTR_SEPT_VE_DISABLE)
 			return;
 
 		/* Relax SEPT_VE_DISABLE check for debug TD for backtraces */
@@ -1040,6 +1037,20 @@ static void tdx_kexec_finish(void)
 	}
 }
 
+static __init void tdx_announce(void)
+{
+	struct tdx_module_args args = {};
+	u64 controls;
+
+	pr_info("Guest detected\n");
+
+	tdcall(TDG_VP_INFO, &args);
+	tdx_dump_attributes(args.rdx);
+
+	tdg_vm_rd(TDCS_TD_CTLS, &controls);
+	tdx_dump_td_ctls(controls);
+}
+
 void __init tdx_early_init(void)
 {
 	u64 cc_mask;
@@ -1109,5 +1120,5 @@ void __init tdx_early_init(void)
 	 */
 	x86_cpuinit.parallel_bringup = false;
 
-	pr_info("Guest detected\n");
+	tdx_announce();
 }
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index a878c7e..fcbbef4 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -19,6 +19,32 @@
 #define TDG_VM_RD			7
 #define TDG_VM_WR			8
 
+/* TDX attributes */
+#define TDX_ATTR_DEBUG_BIT		0
+#define TDX_ATTR_DEBUG			BIT_ULL(TDX_ATTR_DEBUG_BIT)
+#define TDX_ATTR_HGS_PLUS_PROF_BIT	4
+#define TDX_ATTR_HGS_PLUS_PROF		BIT_ULL(TDX_ATTR_HGS_PLUS_PROF_BIT)
+#define TDX_ATTR_PERF_PROF_BIT		5
+#define TDX_ATTR_PERF_PROF		BIT_ULL(TDX_ATTR_PERF_PROF_BIT)
+#define TDX_ATTR_PMT_PROF_BIT		6
+#define TDX_ATTR_PMT_PROF		BIT_ULL(TDX_ATTR_PMT_PROF_BIT)
+#define TDX_ATTR_ICSSD_BIT		16
+#define TDX_ATTR_ICSSD			BIT_ULL(TDX_ATTR_ICSSD_BIT)
+#define TDX_ATTR_LASS_BIT		27
+#define TDX_ATTR_LASS			BIT_ULL(TDX_ATTR_LASS_BIT)
+#define TDX_ATTR_SEPT_VE_DISABLE_BIT	28
+#define TDX_ATTR_SEPT_VE_DISABLE	BIT_ULL(TDX_ATTR_SEPT_VE_DISABLE_BIT)
+#define TDX_ATTR_MIGRTABLE_BIT		29
+#define TDX_ATTR_MIGRTABLE		BIT_ULL(TDX_ATTR_MIGRTABLE_BIT)
+#define TDX_ATTR_PKS_BIT		30
+#define TDX_ATTR_PKS			BIT_ULL(TDX_ATTR_PKS_BIT)
+#define TDX_ATTR_KL_BIT			31
+#define TDX_ATTR_KL			BIT_ULL(TDX_ATTR_KL_BIT)
+#define TDX_ATTR_TPA_BIT		62
+#define TDX_ATTR_TPA			BIT_ULL(TDX_ATTR_TPA_BIT)
+#define TDX_ATTR_PERFMON_BIT		63
+#define TDX_ATTR_PERFMON		BIT_ULL(TDX_ATTR_PERFMON_BIT)
+
 /* TDX TD-Scope Metadata. To be used by TDG.VM.WR and TDG.VM.RD */
 #define TDCS_CONFIG_FLAGS		0x1110000300000016
 #define TDCS_TD_CTLS			0x1110000300000017
@@ -29,9 +55,16 @@
 #define TDCS_CONFIG_FLEXIBLE_PENDING_VE	BIT_ULL(1)
 
 /* TDCS_TD_CTLS bits */
-#define TD_CTLS_PENDING_VE_DISABLE	BIT_ULL(0)
-#define TD_CTLS_ENUM_TOPOLOGY		BIT_ULL(1)
-#define TD_CTLS_REDUCE_VE		BIT_ULL(3)
+#define TD_CTLS_PENDING_VE_DISABLE_BIT	0
+#define TD_CTLS_PENDING_VE_DISABLE	BIT_ULL(TD_CTLS_PENDING_VE_DISABLE_BIT)
+#define TD_CTLS_ENUM_TOPOLOGY_BIT	1
+#define TD_CTLS_ENUM_TOPOLOGY		BIT_ULL(TD_CTLS_ENUM_TOPOLOGY_BIT)
+#define TD_CTLS_VIRT_CPUID2_BIT		2
+#define TD_CTLS_VIRT_CPUID2		BIT_ULL(TD_CTLS_VIRT_CPUID2_BIT)
+#define TD_CTLS_REDUCE_VE_BIT		3
+#define TD_CTLS_REDUCE_VE		BIT_ULL(TD_CTLS_REDUCE_VE_BIT)
+#define TD_CTLS_LOCK_BIT		63
+#define TD_CTLS_LOCK			BIT_ULL(TD_CTLS_LOCK_BIT)
 
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index eba1789..b4b16da 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -66,6 +66,9 @@ int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport);
 
 u64 tdx_hcall_get_quote(u8 *buf, size_t size);
 
+void __init tdx_dump_attributes(u64 td_attr);
+void __init tdx_dump_td_ctls(u64 td_ctls);
+
 #else
 
 static inline void tdx_early_init(void) { };

