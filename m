Return-Path: <linux-tip-commits+bounces-4155-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18565A5E295
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436223BC4FF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A107F25DAE2;
	Wed, 12 Mar 2025 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wCRUFV6W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KBLsC+IB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F69025D209;
	Wed, 12 Mar 2025 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800035; cv=none; b=sIyUTBHIMuI0VZgwkgA9pkm5aaPLjUCmGUAeyAcSQq35MsKvS+6E+zQRqcphMKJ7isHQChIS/yPXSrpU48gIYxkF86uC/jljM3DhvYDMK0LRuCfKuPaTzRvhSoqkmVQv+TZbYy+xeO7EIbFuU1QYOd0NViat2HJfHPyGQ0YD5ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800035; c=relaxed/simple;
	bh=4orXo2inF4y8R5uwILa65aMLpQo25HQzXT6Q27Q1h34=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bZiAVzkzl36hKp2kmNqRRQ36vXkJHTRLUL58/9kW3J/UpPNW/iSSgRbZB3CxfgRvApNQGyP9cbdHEM2//N9LlLqnMGqk7dsgi/CIVNxK0mqLuo7oMvCBd7piZqAkiFiFKXdo+GMJdj8XymTM9lTAfvvYJtqKTqS5EruTkPph1Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wCRUFV6W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KBLsC+IB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dui/5SHkVURY9gC4mvXjW6PpOGrWOFgSyUycTotglMc=;
	b=wCRUFV6W8XT3Hk9mQz5u53yFZef76WXlGb2Wa1fe2PcJ0r69qAlc+6bs+gDoeJUu+LQnmT
	gHd5kFHD22LYTgm8O4EyN3/L7vW+gAvdlcPe06Tv4jG7pSzoRNeKN3n7Qli01pu3XaPHLI
	heXlYA3f3NCvtnHn2zcgMMtE889vHFiVswAhGzPpuZYgRdiS2GhhRDAVvUKojne528mgoa
	WFposc5wyvZz80ngF+ilHEoTEJAefXjbbN8mT3qTtSixswWcurtJ0sJjS4Z36NHH6G1T5q
	2fv9oJbI/ypwyW/EESLZCVCb/O1xr++7FL/wVCFbujKau9wWlmWWeptiH1E+aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dui/5SHkVURY9gC4mvXjW6PpOGrWOFgSyUycTotglMc=;
	b=KBLsC+IByISQaTmYjK54TCOMhEBrc5IuVAtNIJyEQm0+6YyxZpjZ9tTXYZ3iLlh9sn84tR
	7/A/h8N4SlA9dkBg==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Move resctrl types to a separate header
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Babu Moger <babu.moger@amd.com>, Carl Worth <carl@os.amperecomputing.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-14-james.morse@arm.com>
References: <20250311183715.16445-14-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180003096.14745.762106599659100204.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     f16adbaf9272ea7ed5d7bf8b261be8a9be949c31
Gitweb:        https://git.kernel.org/tip/f16adbaf9272ea7ed5d7bf8b261be8a9be949c31
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:36:58 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:23:00 +01:00

x86/resctrl: Move resctrl types to a separate header

When resctrl is fully factored into core and per-arch code, each arch will
need to use some resctrl common definitions in order to define its own
specializations and helpers.  Following conventional practice, it would be
desirable to put the dependent arch definitions in an <asm/resctrl.h> header
that is included by the common <linux/resctrl.h> header.  However, this can
make it awkward to avoid a circular dependency between <linux/resctrl.h> and
the arch header.

To avoid such dependencies, move the affected common types and constants into
a new header that does not need to depend on <linux/resctrl.h> or on the arch
headers.

The same logic applies to the monitor-configuration defines, move these too.

Some kind of enumeration for events is needed between the filesystem and
architecture code. Take the x86 definition as its convenient for x86.

The definition of enum resctrl_event_id is needed to allow the architecture
code to define resctrl_arch_mon_ctx_alloc() and resctrl_arch_mon_ctx_free().

The definition of enum resctrl_res_level is needed to allow the architecture
code to define resctrl_arch_set_cdp_enabled() and
resctrl_arch_get_cdp_enabled().

The bits for mbm_local_bytes_config et al are ABI, and must be the same on all
architectures. These are documented in Documentation/arch/x86/resctrl.rst

The maintainers entry for these headers was missed when resctrl.h was created.
Add a wildcard entry to match both resctrl.h and resctrl_types.h.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20250311183715.16445-14-james.morse@arm.com
---
 MAINTAINERS                            |  1 +-
 arch/x86/include/asm/resctrl.h         |  1 +-
 arch/x86/kernel/cpu/resctrl/internal.h | 24 +-----------
 include/linux/resctrl.h                | 21 +----------
 include/linux/resctrl_types.h          | 54 +++++++++++++++++++++++++-
 5 files changed, 57 insertions(+), 44 deletions(-)
 create mode 100644 include/linux/resctrl_types.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ed7aa68..2d0b669 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19894,6 +19894,7 @@ S:	Supported
 F:	Documentation/arch/x86/resctrl*
 F:	arch/x86/include/asm/resctrl.h
 F:	arch/x86/kernel/cpu/resctrl/
+F:	include/linux/resctrl*.h
 F:	tools/testing/selftests/resctrl/
 
 READ-COPY UPDATE (RCU)
diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 6908cd0..52f2326 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -6,6 +6,7 @@
 
 #include <linux/jump_label.h>
 #include <linux/percpu.h>
+#include <linux/resctrl_types.h>
 #include <linux/sched.h>
 
 /*
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index da73404..5f3713f 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -32,30 +32,6 @@
  */
 #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
 
-/* Reads to Local DRAM Memory */
-#define READS_TO_LOCAL_MEM		BIT(0)
-
-/* Reads to Remote DRAM Memory */
-#define READS_TO_REMOTE_MEM		BIT(1)
-
-/* Non-Temporal Writes to Local Memory */
-#define NON_TEMP_WRITE_TO_LOCAL_MEM	BIT(2)
-
-/* Non-Temporal Writes to Remote Memory */
-#define NON_TEMP_WRITE_TO_REMOTE_MEM	BIT(3)
-
-/* Reads to Local Memory the system identifies as "Slow Memory" */
-#define READS_TO_LOCAL_S_MEM		BIT(4)
-
-/* Reads to Remote Memory the system identifies as "Slow Memory" */
-#define READS_TO_REMOTE_S_MEM		BIT(5)
-
-/* Dirty Victims to All Types of Memory */
-#define DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)
-
-/* Max event bits supported */
-#define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
-
 /**
  * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
  *			        aren't marked nohz_full
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 93d9a43..326f7ba 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/pid.h>
+#include <linux/resctrl_types.h>
 
 /* CLOSID, RMID value used by the default control group */
 #define RESCTRL_RESERVED_CLOSID		0
@@ -37,28 +38,8 @@ enum resctrl_conf_type {
 	CDP_DATA,
 };
 
-enum resctrl_res_level {
-	RDT_RESOURCE_L3,
-	RDT_RESOURCE_L2,
-	RDT_RESOURCE_MBA,
-	RDT_RESOURCE_SMBA,
-
-	/* Must be the last */
-	RDT_NUM_RESOURCES,
-};
-
 #define CDP_NUM_TYPES	(CDP_DATA + 1)
 
-/*
- * Event IDs, the values match those used to program IA32_QM_EVTSEL before
- * reading IA32_QM_CTR on RDT systems.
- */
-enum resctrl_event_id {
-	QOS_L3_OCCUP_EVENT_ID		= 0x01,
-	QOS_L3_MBM_TOTAL_EVENT_ID	= 0x02,
-	QOS_L3_MBM_LOCAL_EVENT_ID	= 0x03,
-};
-
 /**
  * struct resctrl_staged_config - parsed configuration to be applied
  * @new_ctrl:		new ctrl value to be loaded
diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
new file mode 100644
index 0000000..f26450b
--- /dev/null
+++ b/include/linux/resctrl_types.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025 Arm Ltd.
+ * Based on arch/x86/kernel/cpu/resctrl/internal.h
+ */
+
+#ifndef __LINUX_RESCTRL_TYPES_H
+#define __LINUX_RESCTRL_TYPES_H
+
+/* Reads to Local DRAM Memory */
+#define READS_TO_LOCAL_MEM		BIT(0)
+
+/* Reads to Remote DRAM Memory */
+#define READS_TO_REMOTE_MEM		BIT(1)
+
+/* Non-Temporal Writes to Local Memory */
+#define NON_TEMP_WRITE_TO_LOCAL_MEM	BIT(2)
+
+/* Non-Temporal Writes to Remote Memory */
+#define NON_TEMP_WRITE_TO_REMOTE_MEM	BIT(3)
+
+/* Reads to Local Memory the system identifies as "Slow Memory" */
+#define READS_TO_LOCAL_S_MEM		BIT(4)
+
+/* Reads to Remote Memory the system identifies as "Slow Memory" */
+#define READS_TO_REMOTE_S_MEM		BIT(5)
+
+/* Dirty Victims to All Types of Memory */
+#define DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)
+
+/* Max event bits supported */
+#define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
+
+enum resctrl_res_level {
+	RDT_RESOURCE_L3,
+	RDT_RESOURCE_L2,
+	RDT_RESOURCE_MBA,
+	RDT_RESOURCE_SMBA,
+
+	/* Must be the last */
+	RDT_NUM_RESOURCES,
+};
+
+/*
+ * Event IDs, the values match those used to program IA32_QM_EVTSEL before
+ * reading IA32_QM_CTR on RDT systems.
+ */
+enum resctrl_event_id {
+	QOS_L3_OCCUP_EVENT_ID		= 0x01,
+	QOS_L3_MBM_TOTAL_EVENT_ID	= 0x02,
+	QOS_L3_MBM_LOCAL_EVENT_ID	= 0x03,
+};
+
+#endif /* __LINUX_RESCTRL_TYPES_H */

