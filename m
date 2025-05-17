Return-Path: <linux-tip-commits+bounces-5647-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5940FABA957
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 12:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822A9A01CF2
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 10:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BC21F6694;
	Sat, 17 May 2025 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qpfMknk7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="820QJKE5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6A81FE468;
	Sat, 17 May 2025 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476182; cv=none; b=ZCAnyRgqf3MyKHbJV+ddFgtgGsahqQkfWTbyvhyvJMYXSXJLBFOH1Qdts4cFs/wrd1Rg2ztDkiMdmF9zPj07hWLlE09wJ97+bmoBYid04wXtxV6DkSlVb+0KdOkoY0R8vBAWZgKk5ZfroPOgdGVitPyaq/mTMSS/TAZfDWtBLHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476182; c=relaxed/simple;
	bh=/Ar8jPMGanTetMpVW+DpjxrrrEXCgqFHVRIlpRZAZ4Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IW8cIp02rodsygfes4DaYXeTvzyotghh+zpsmBNFHSSnBv4XgJwGibJcSxNAvE9X8GxW99yT4dqL8eSYLr7FrbBn1+I1lM+buCrE4pB4dgFlRaDFp06yR1SQ2Rc63+5iw033x8vWKInqZJnlhV45MeExboVSFshaBeWUUqCRoPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qpfMknk7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=820QJKE5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 10:02:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747476178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pfei7LtZSonQsiYGia/uAbHFJsNC2lgNJWgD1A2TNp4=;
	b=qpfMknk7Ob6o+dy7eFonL5EoCnKbTomY1nx5wymkJJ+IzXMS7/RPn60ZcGhUdHq7/QMxUe
	GTNIBDW6KbLT+XYKuGnM5gJOS6VUhpqTLXOwLD0BvoKHXBWsvrrF0/T7UFO4nTVayVENkk
	0WT+1wugE8pk42WoLZdWFNRVDr7nv3RbxauHI2aYJsCwOss/v45PIMhvjnLKTVakQmuQ2D
	A+9E6o9cRmR53ZHlECUipBEtrULhFFcZ8X/09/5XGYjVHz9jSzLdUpZIvIQry2/OsEHr+8
	eRMo7waBEnjSwpaNhNbAMofuHGX1We1ZUy0dSEd23HPm2tHDoJMT378erXCSBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747476178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pfei7LtZSonQsiYGia/uAbHFJsNC2lgNJWgD1A2TNp4=;
	b=820QJKE5pDWGRSaYoB/RSZ1zeS4h3+dgq274BZbV3MK2K3JoLUPnQGuWXSInsQ9dAGFwIw
	cY6F1yupYmtGSQBw==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Split trace.h
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghuay@nvidia.com>, Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Babu Moger <babu.moger@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515165855.31452-14-james.morse@arm.com>
References: <20250515165855.31452-14-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174747617768.406.11228833029392314714.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     270f00bcc9525c8ba667349ba3e8c4dbcbbf70fb
Gitweb:        https://git.kernel.org/tip/270f00bcc9525c8ba667349ba3e8c4dbcbbf70fb
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Thu, 15 May 2025 16:58:43 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 May 2025 10:47:49 +02:00

x86/resctrl: Split trace.h

trace.h contains all the tracepoints. After the move to /fs/resctrl, some
of these will be left behind. All the pseudo_lock tracepoints remain part
of the architecture. The lone tracepoint in monitor.c moves to /fs/resctrl.

Split trace.h so that each C file includes a different trace header file.
This means the trace header files are not modified when they are moved.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250515165855.31452-14-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/Makefile            |  3 +-
 arch/x86/kernel/cpu/resctrl/monitor.c           |  4 +-
 arch/x86/kernel/cpu/resctrl/monitor_trace.h     | 31 ++++++++-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c       |  2 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock_trace.h | 43 ++++++++++++-
 arch/x86/kernel/cpu/resctrl/trace.h             | 59 +----------------
 6 files changed, 81 insertions(+), 61 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/resctrl/monitor_trace.h
 create mode 100644 arch/x86/kernel/cpu/resctrl/pseudo_lock_trace.h
 delete mode 100644 arch/x86/kernel/cpu/resctrl/trace.h

diff --git a/arch/x86/kernel/cpu/resctrl/Makefile b/arch/x86/kernel/cpu/resctrl/Makefile
index 0c13b0b..909be78 100644
--- a/arch/x86/kernel/cpu/resctrl/Makefile
+++ b/arch/x86/kernel/cpu/resctrl/Makefile
@@ -2,4 +2,7 @@
 obj-$(CONFIG_X86_CPU_RESCTRL)		+= core.o rdtgroup.o monitor.o
 obj-$(CONFIG_X86_CPU_RESCTRL)		+= ctrlmondata.o
 obj-$(CONFIG_RESCTRL_FS_PSEUDO_LOCK)	+= pseudo_lock.o
+
+# To allow define_trace.h's recursive include:
 CFLAGS_pseudo_lock.o = -I$(src)
+CFLAGS_monitor.o = -I$(src)
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 4962ae4..ac1cec6 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -26,7 +26,9 @@
 #include <asm/resctrl.h>
 
 #include "internal.h"
-#include "trace.h"
+
+#define CREATE_TRACE_POINTS
+#include "monitor_trace.h"
 
 /**
  * struct rmid_entry - dirty tracking for all RMID.
diff --git a/arch/x86/kernel/cpu/resctrl/monitor_trace.h b/arch/x86/kernel/cpu/resctrl/monitor_trace.h
new file mode 100644
index 0000000..ade67da
--- /dev/null
+++ b/arch/x86/kernel/cpu/resctrl/monitor_trace.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM resctrl
+
+#if !defined(_FS_RESCTRL_MONITOR_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _FS_RESCTRL_MONITOR_TRACE_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(mon_llc_occupancy_limbo,
+	    TP_PROTO(u32 ctrl_hw_id, u32 mon_hw_id, int domain_id, u64 llc_occupancy_bytes),
+	    TP_ARGS(ctrl_hw_id, mon_hw_id, domain_id, llc_occupancy_bytes),
+	    TP_STRUCT__entry(__field(u32, ctrl_hw_id)
+			     __field(u32, mon_hw_id)
+			     __field(int, domain_id)
+			     __field(u64, llc_occupancy_bytes)),
+	    TP_fast_assign(__entry->ctrl_hw_id = ctrl_hw_id;
+			   __entry->mon_hw_id = mon_hw_id;
+			   __entry->domain_id = domain_id;
+			   __entry->llc_occupancy_bytes = llc_occupancy_bytes;),
+	    TP_printk("ctrl_hw_id=%u mon_hw_id=%u domain_id=%d llc_occupancy_bytes=%llu",
+		      __entry->ctrl_hw_id, __entry->mon_hw_id, __entry->domain_id,
+		      __entry->llc_occupancy_bytes)
+	   );
+
+#endif /* _FS_RESCTRL_MONITOR_TRACE_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE monitor_trace
+#include <trace/define_trace.h>
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 92ea147..f7bb586 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -30,7 +30,7 @@
 #include "internal.h"
 
 #define CREATE_TRACE_POINTS
-#include "trace.h"
+#include "pseudo_lock_trace.h"
 
 /*
  * The bits needed to disable hardware prefetching varies based on the
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock_trace.h b/arch/x86/kernel/cpu/resctrl/pseudo_lock_trace.h
new file mode 100644
index 0000000..5a0fae6
--- /dev/null
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock_trace.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM resctrl
+
+#if !defined(_X86_RESCTRL_PSEUDO_LOCK_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _X86_RESCTRL_PSEUDO_LOCK_TRACE_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(pseudo_lock_mem_latency,
+	    TP_PROTO(u32 latency),
+	    TP_ARGS(latency),
+	    TP_STRUCT__entry(__field(u32, latency)),
+	    TP_fast_assign(__entry->latency = latency),
+	    TP_printk("latency=%u", __entry->latency)
+	   );
+
+TRACE_EVENT(pseudo_lock_l2,
+	    TP_PROTO(u64 l2_hits, u64 l2_miss),
+	    TP_ARGS(l2_hits, l2_miss),
+	    TP_STRUCT__entry(__field(u64, l2_hits)
+			     __field(u64, l2_miss)),
+	    TP_fast_assign(__entry->l2_hits = l2_hits;
+			   __entry->l2_miss = l2_miss;),
+	    TP_printk("hits=%llu miss=%llu",
+		      __entry->l2_hits, __entry->l2_miss));
+
+TRACE_EVENT(pseudo_lock_l3,
+	    TP_PROTO(u64 l3_hits, u64 l3_miss),
+	    TP_ARGS(l3_hits, l3_miss),
+	    TP_STRUCT__entry(__field(u64, l3_hits)
+			     __field(u64, l3_miss)),
+	    TP_fast_assign(__entry->l3_hits = l3_hits;
+			   __entry->l3_miss = l3_miss;),
+	    TP_printk("hits=%llu miss=%llu",
+		      __entry->l3_hits, __entry->l3_miss));
+
+#endif /* _X86_RESCTRL_PSEUDO_LOCK_TRACE_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE pseudo_lock_trace
+#include <trace/define_trace.h>
diff --git a/arch/x86/kernel/cpu/resctrl/trace.h b/arch/x86/kernel/cpu/resctrl/trace.h
deleted file mode 100644
index 2a50631..0000000
--- a/arch/x86/kernel/cpu/resctrl/trace.h
+++ /dev/null
@@ -1,59 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#undef TRACE_SYSTEM
-#define TRACE_SYSTEM resctrl
-
-#if !defined(_TRACE_RESCTRL_H) || defined(TRACE_HEADER_MULTI_READ)
-#define _TRACE_RESCTRL_H
-
-#include <linux/tracepoint.h>
-
-TRACE_EVENT(pseudo_lock_mem_latency,
-	    TP_PROTO(u32 latency),
-	    TP_ARGS(latency),
-	    TP_STRUCT__entry(__field(u32, latency)),
-	    TP_fast_assign(__entry->latency = latency),
-	    TP_printk("latency=%u", __entry->latency)
-	   );
-
-TRACE_EVENT(pseudo_lock_l2,
-	    TP_PROTO(u64 l2_hits, u64 l2_miss),
-	    TP_ARGS(l2_hits, l2_miss),
-	    TP_STRUCT__entry(__field(u64, l2_hits)
-			     __field(u64, l2_miss)),
-	    TP_fast_assign(__entry->l2_hits = l2_hits;
-			   __entry->l2_miss = l2_miss;),
-	    TP_printk("hits=%llu miss=%llu",
-		      __entry->l2_hits, __entry->l2_miss));
-
-TRACE_EVENT(pseudo_lock_l3,
-	    TP_PROTO(u64 l3_hits, u64 l3_miss),
-	    TP_ARGS(l3_hits, l3_miss),
-	    TP_STRUCT__entry(__field(u64, l3_hits)
-			     __field(u64, l3_miss)),
-	    TP_fast_assign(__entry->l3_hits = l3_hits;
-			   __entry->l3_miss = l3_miss;),
-	    TP_printk("hits=%llu miss=%llu",
-		      __entry->l3_hits, __entry->l3_miss));
-
-TRACE_EVENT(mon_llc_occupancy_limbo,
-	    TP_PROTO(u32 ctrl_hw_id, u32 mon_hw_id, int domain_id, u64 llc_occupancy_bytes),
-	    TP_ARGS(ctrl_hw_id, mon_hw_id, domain_id, llc_occupancy_bytes),
-	    TP_STRUCT__entry(__field(u32, ctrl_hw_id)
-			     __field(u32, mon_hw_id)
-			     __field(int, domain_id)
-			     __field(u64, llc_occupancy_bytes)),
-	    TP_fast_assign(__entry->ctrl_hw_id = ctrl_hw_id;
-			   __entry->mon_hw_id = mon_hw_id;
-			   __entry->domain_id = domain_id;
-			   __entry->llc_occupancy_bytes = llc_occupancy_bytes;),
-	    TP_printk("ctrl_hw_id=%u mon_hw_id=%u domain_id=%d llc_occupancy_bytes=%llu",
-		      __entry->ctrl_hw_id, __entry->mon_hw_id, __entry->domain_id,
-		      __entry->llc_occupancy_bytes)
-	   );
-
-#endif /* _TRACE_RESCTRL_H */
-
-#undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH .
-#define TRACE_INCLUDE_FILE trace
-#include <trace/define_trace.h>

