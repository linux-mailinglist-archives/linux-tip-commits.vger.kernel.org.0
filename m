Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811D629E98A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgJ2Kvs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:51:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60776 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgJ2Kvr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:47 -0400
Date:   Thu, 29 Oct 2020 10:51:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603968704;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vTEnZO6SDswi6pmH+1ANehUPs5wxcFKMBoRodJuebn8=;
        b=g4JQHWqu4iA/A9gYXgS9SxuEY2ZqJiJ1nlm8N55bJFv0z6lYy2835NEwhqtFU2vIwV72kB
        GYi6q30TxFqoghmbRPzcb2vkULPZPZNnNTlRKAfEC3ztNpt6l+iPYVGg1YYpa0D4ZuIlOa
        ICs9+iqePkzSYJdJSmwfbMHR3O8dpq7P/gt5NDeiFaWUptejNyFH+AgT9t+T3G99B1eQF6
        4MwN8zW9ci6MaQb7kkug3SngnnWnwwz58OI5FJwx9JeUPiLinJS0dNPAp6IH9DT6wmlehb
        PkLqspoINTXfwKh097VOjjZhwd6Np3RETL94QnlCoAurB1U3B9jBFoEyOYUa1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603968704;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vTEnZO6SDswi6pmH+1ANehUPs5wxcFKMBoRodJuebn8=;
        b=+WnAjqJdJ1lEa52hhRbnU5CvlK4A+1mJW+gWgH7hYSlqrm6P99ZU9ZAiIevvUufjNiez4/
        oN67kBcbwO7yATDw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201001135749.2804-2-kan.liang@linux.intel.com>
References: <20201001135749.2804-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160396870321.397.16750532993540063574.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8d97e71811aaafe4abf611dc24822fd6e73df1a1
Gitweb:        https://git.kernel.org/tip/8d97e71811aaafe4abf611dc24822fd6e73df1a1
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 01 Oct 2020 06:57:46 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Oct 2020 11:00:38 +01:00

perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE

Current perf can report both virtual addresses and physical addresses,
but not the MMU page size. Without the MMU page size information of the
utilized page, users cannot decide whether to promote/demote large pages
to optimize memory usage.

Add a new sample type for the data MMU page size.

Current perf already has a facility to collect data virtual addresses.
A page walker is required to walk the pages tables and calculate the
MMU page size from a given virtual address.

On some platforms, e.g., X86, the page walker is invoked in an NMI
handler. So the page walker must be NMI-safe and low overhead. Besides,
the page walker should work for both user and kernel virtual address.
The existing generic page walker, e.g., walk_page_range_novma(), is a
little bit complex and doesn't guarantee the NMI-safe. The follow_page()
is only for user-virtual address.

Add a new function perf_get_page_size() to walk the page tables and
calculate the MMU page size. In the function:
- Interrupts have to be disabled to prevent any teardown of the page
  tables.
- For user space threads, the current->mm is used for the page walker.
  For kernel threads and the like, the current->mm is NULL. The init_mm
  is used for the page walker. The active_mm is not used here, because
  it can be NULL.
  Quote from Peter Zijlstra,
  "context_switch() can set prev->active_mm to NULL when it transfers it
   to @next. It does this before @current is updated. So an NMI that
   comes in between this active_mm swizzling and updating @current will
   see !active_mm."
- The MMU page size is calculated from the page table level.

The method should work for all architectures, but it has only been
verified on X86. Should there be some architectures, which support perf,
where the method doesn't work, it can be fixed later separately.
Reporting the wrong page size would not be fatal for the architecture.

Some under discussion features may impact the method in the future.
Quote from Dave Hansen,
  "There are lots of weird things folks are trying to do with the page
   tables, like Address Space Isolation.  For instance, if you get a
   perf NMI when running userspace, current->mm->pgd is *different* than
   the PGD that was in use when userspace was running. It's close enough
   today, but it might not stay that way."
If the case happens later, lots of consecutive page walk errors will
happen. The worst case is that lots of page-size '0' are returned, which
would not be fatal.
In the perf tool, a check is implemented to detect this case. Once it
happens, a kernel patch could be implemented accordingly then.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201001135749.2804-2-kan.liang@linux.intel.com
---
 include/linux/perf_event.h      |   1 +-
 include/uapi/linux/perf_event.h |   4 +-
 kernel/events/core.c            | 103 +++++++++++++++++++++++++++++++-
 3 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0c19d27..7e3785d 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1034,6 +1034,7 @@ struct perf_sample_data {
 
 	u64				phys_addr;
 	u64				cgroup;
+	u64				data_page_size;
 } ____cacheline_aligned;
 
 /* default value for data source */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 077e7ee..cc6ea34 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -143,8 +143,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 	PERF_SAMPLE_AUX				= 1U << 20,
 	PERF_SAMPLE_CGROUP			= 1U << 21,
+	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
 
-	PERF_SAMPLE_MAX = 1U << 22,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 23,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
@@ -896,6 +897,7 @@ enum perf_event_type {
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
 	 *	{ u64			size;
 	 *	  char			data[size]; } && PERF_SAMPLE_AUX
+	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index fb662eb..a796db2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -51,6 +51,7 @@
 #include <linux/proc_ns.h>
 #include <linux/mount.h>
 #include <linux/min_heap.h>
+#include <linux/highmem.h>
 
 #include "internal.h"
 
@@ -1894,6 +1895,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
 	if (sample_type & PERF_SAMPLE_CGROUP)
 		size += sizeof(data->cgroup);
 
+	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
+		size += sizeof(data->data_page_size);
+
 	event->header_size = size;
 }
 
@@ -6938,6 +6942,9 @@ void perf_output_sample(struct perf_output_handle *handle,
 	if (sample_type & PERF_SAMPLE_CGROUP)
 		perf_output_put(handle, data->cgroup);
 
+	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
+		perf_output_put(handle, data->data_page_size);
+
 	if (sample_type & PERF_SAMPLE_AUX) {
 		perf_output_put(handle, data->aux_size);
 
@@ -6995,6 +7002,94 @@ static u64 perf_virt_to_phys(u64 virt)
 	return phys_addr;
 }
 
+#ifdef CONFIG_MMU
+
+/*
+ * Return the MMU page size of a given virtual address
+ */
+static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	pgd = pgd_offset(mm, addr);
+	if (pgd_none(*pgd))
+		return 0;
+
+	p4d = p4d_offset(pgd, addr);
+	if (!p4d_present(*p4d))
+		return 0;
+
+	if (p4d_leaf(*p4d))
+		return 1ULL << P4D_SHIFT;
+
+	pud = pud_offset(p4d, addr);
+	if (!pud_present(*pud))
+		return 0;
+
+	if (pud_leaf(*pud))
+		return 1ULL << PUD_SHIFT;
+
+	pmd = pmd_offset(pud, addr);
+	if (!pmd_present(*pmd))
+		return 0;
+
+	if (pmd_leaf(*pmd))
+		return 1ULL << PMD_SHIFT;
+
+	pte = pte_offset_map(pmd, addr);
+	if (!pte_present(*pte)) {
+		pte_unmap(pte);
+		return 0;
+	}
+
+	pte_unmap(pte);
+	return PAGE_SIZE;
+}
+
+#else
+
+static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
+{
+	return 0;
+}
+
+#endif
+
+static u64 perf_get_page_size(unsigned long addr)
+{
+	struct mm_struct *mm;
+	unsigned long flags;
+	u64 size;
+
+	if (!addr)
+		return 0;
+
+	/*
+	 * Software page-table walkers must disable IRQs,
+	 * which prevents any tear down of the page tables.
+	 */
+	local_irq_save(flags);
+
+	mm = current->mm;
+	if (!mm) {
+		/*
+		 * For kernel threads and the like, use init_mm so that
+		 * we can find kernel memory.
+		 */
+		mm = &init_mm;
+	}
+
+	size = __perf_get_page_size(mm, addr);
+
+	local_irq_restore(flags);
+
+	return size;
+}
+
 static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
 
 struct perf_callchain_entry *
@@ -7150,6 +7245,14 @@ void perf_prepare_sample(struct perf_event_header *header,
 	}
 #endif
 
+	/*
+	 * PERF_DATA_PAGE_SIZE requires PERF_SAMPLE_ADDR. If the user doesn't
+	 * require PERF_SAMPLE_ADDR, kernel implicitly retrieve the data->addr,
+	 * but the value will not dump to the userspace.
+	 */
+	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
+		data->data_page_size = perf_get_page_size(data->addr);
+
 	if (sample_type & PERF_SAMPLE_AUX) {
 		u64 size;
 
