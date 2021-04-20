Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F9C365688
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhDTKrR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51682 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhDTKrO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:14 -0400
Date:   Tue, 20 Apr 2021 10:46:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915602;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fXnWYx1oC1inS8jIMWZ8M9ReyYHGqltZ55Wd68D19aI=;
        b=gh2u4k+ctxITS+QqMynxevhb8wO7mw9alA7po1kH6PbjHfgOTvfsdyTITp1+ymjtZHtEA/
        RzcmPwl/YBRO40dyuZEsbA4XUMj5S5tW5V5AQ6p0dGwj4Q3H5wrE6FB4qLjyBc9xgqxS5f
        tgHbhjC835QIvadQc0S0xleXddHBMcOJcb6RTeicoVVwglXwhic+OHIq2qxG6PtuCa4EHX
        yv0IzZkgmIZdgpMPWjCg8UFW4aru/G+mX42ZdmoDvAB9LIExim5l2iByBjI2p6lseKMkpW
        xx8T/ip0HNfxLH6ezXydsz5vPTs/UO5VOs3NtoGojqRvpwzBqiIRwMMWWxbyOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915602;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fXnWYx1oC1inS8jIMWZ8M9ReyYHGqltZ55Wd68D19aI=;
        b=BwFMU6RsxYpBKXQG+3Se6kjjL8cdgAGTVjQ5ODXTOonqSbnIDfRrbfKHXtTnTHp1jzPbHX
        TycInrufZvBLJaAQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618237865-33448-22-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-22-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161891560206.29796.845366321803619606.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     55bcf6ef314ae8ba81bcd74aa760247b635ed47b
Gitweb:        https://git.kernel.org/tip/55bcf6ef314ae8ba81bcd74aa760247b635ed47b
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 12 Apr 2021 07:31:01 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Apr 2021 20:03:29 +02:00

perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE

Current Hardware events and Hardware cache events have special perf
types, PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE. The two types don't
pass the PMU type in the user interface. For a hybrid system, the perf
subsystem doesn't know which PMU the events belong to. The first capable
PMU will always be assigned to the events. The events never get a chance
to run on the other capable PMUs.

Extend the two types to become PMU aware types. The PMU type ID is
stored at attr.config[63:32].

Add a new PMU capability, PERF_PMU_CAP_EXTENDED_HW_TYPE, to indicate a
PMU which supports the extended PERF_TYPE_HARDWARE and
PERF_TYPE_HW_CACHE.

The PMU type is only required when searching a specific PMU. The PMU
specific codes will only be interested in the 'real' config value, which
is stored in the low 32 bit of the event->attr.config. Update the
event->attr.config in the generic code, so the PMU specific codes don't
need to calculate it separately.

If a user specifies a PMU type, but the PMU doesn't support the extended
type, error out.

If an event cannot be initialized in a PMU specified by a user, error
out immediately. Perf should not try to open it on other PMUs.

The new PMU capability is only set for the X86 hybrid PMUs for now.
Other architectures, e.g., ARM, may need it as well. The support on ARM
may be implemented later separately.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1618237865-33448-22-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/core.c          |  1 +
 include/linux/perf_event.h      | 19 ++++++++++---------
 include/uapi/linux/perf_event.h | 15 +++++++++++++++
 kernel/events/core.c            | 19 ++++++++++++++++---
 4 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 4f6595e..3fe66b7 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2173,6 +2173,7 @@ static int __init init_hw_perf_events(void)
 			hybrid_pmu->pmu.type = -1;
 			hybrid_pmu->pmu.attr_update = x86_pmu.attr_update;
 			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_HETEROGENEOUS_CPUS;
+			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_EXTENDED_HW_TYPE;
 
 			err = perf_pmu_register(&hybrid_pmu->pmu, hybrid_pmu->name,
 						(hybrid_pmu->cpu_type == hybrid_big) ? PERF_TYPE_RAW : -1);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 61b3851..a763928 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -260,15 +260,16 @@ struct perf_event;
 /**
  * pmu::capabilities flags
  */
-#define PERF_PMU_CAP_NO_INTERRUPT		0x01
-#define PERF_PMU_CAP_NO_NMI			0x02
-#define PERF_PMU_CAP_AUX_NO_SG			0x04
-#define PERF_PMU_CAP_EXTENDED_REGS		0x08
-#define PERF_PMU_CAP_EXCLUSIVE			0x10
-#define PERF_PMU_CAP_ITRACE			0x20
-#define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x40
-#define PERF_PMU_CAP_NO_EXCLUDE			0x80
-#define PERF_PMU_CAP_AUX_OUTPUT			0x100
+#define PERF_PMU_CAP_NO_INTERRUPT		0x0001
+#define PERF_PMU_CAP_NO_NMI			0x0002
+#define PERF_PMU_CAP_AUX_NO_SG			0x0004
+#define PERF_PMU_CAP_EXTENDED_REGS		0x0008
+#define PERF_PMU_CAP_EXCLUSIVE			0x0010
+#define PERF_PMU_CAP_ITRACE			0x0020
+#define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x0040
+#define PERF_PMU_CAP_NO_EXCLUDE			0x0080
+#define PERF_PMU_CAP_AUX_OUTPUT			0x0100
+#define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0200
 
 struct perf_output_handle;
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 0b58970..e54e639 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -38,6 +38,21 @@ enum perf_type_id {
 };
 
 /*
+ * attr.config layout for type PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
+ * PERF_TYPE_HARDWARE:			0xEEEEEEEE000000AA
+ *					AA: hardware event ID
+ *					EEEEEEEE: PMU type ID
+ * PERF_TYPE_HW_CACHE:			0xEEEEEEEE00DDCCBB
+ *					BB: hardware cache ID
+ *					CC: hardware cache op ID
+ *					DD: hardware cache op result ID
+ *					EEEEEEEE: PMU type ID
+ * If the PMU type ID is 0, the PERF_TYPE_RAW will be applied.
+ */
+#define PERF_PMU_TYPE_SHIFT		32
+#define PERF_HW_EVENT_MASK		0xffffffff
+
+/*
  * Generalized performance event event_id types, used by the
  * attr.event_id parameter of the sys_perf_event_open()
  * syscall:
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6f0723c..928b166 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11220,6 +11220,7 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 
 static struct pmu *perf_init_event(struct perf_event *event)
 {
+	bool extended_type = false;
 	int idx, type, ret;
 	struct pmu *pmu;
 
@@ -11238,16 +11239,27 @@ static struct pmu *perf_init_event(struct perf_event *event)
 	 * are often aliases for PERF_TYPE_RAW.
 	 */
 	type = event->attr.type;
-	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE)
-		type = PERF_TYPE_RAW;
+	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE) {
+		type = event->attr.config >> PERF_PMU_TYPE_SHIFT;
+		if (!type) {
+			type = PERF_TYPE_RAW;
+		} else {
+			extended_type = true;
+			event->attr.config &= PERF_HW_EVENT_MASK;
+		}
+	}
 
 again:
 	rcu_read_lock();
 	pmu = idr_find(&pmu_idr, type);
 	rcu_read_unlock();
 	if (pmu) {
+		if (event->attr.type != type && type != PERF_TYPE_RAW &&
+		    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
+			goto fail;
+
 		ret = perf_try_init_event(pmu, event);
-		if (ret == -ENOENT && event->attr.type != type) {
+		if (ret == -ENOENT && event->attr.type != type && !extended_type) {
 			type = event->attr.type;
 			goto again;
 		}
@@ -11268,6 +11280,7 @@ again:
 			goto unlock;
 		}
 	}
+fail:
 	pmu = ERR_PTR(-ENOENT);
 unlock:
 	srcu_read_unlock(&pmus_srcu, idx);
