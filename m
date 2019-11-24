Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 987E610842C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Nov 2019 17:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfKXQVJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 24 Nov 2019 11:21:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37627 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfKXQVI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 24 Nov 2019 11:21:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iYud8-0000lT-3n; Sun, 24 Nov 2019 17:20:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 802E81C0EDC;
        Sun, 24 Nov 2019 17:20:57 +0100 (CET)
Date:   Sun, 24 Nov 2019 16:20:57 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/pti/32: Calculate the various PTI
 cpu_entry_area sizes correctly, make the CPU_ENTRY_AREA_PAGES assert precise
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, stable@kernel.org,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157461245729.21853.17367017341063798964.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     4d6dd252b80eddbd7425d0b6b07b239f4f070647
Gitweb:        https://git.kernel.org/tip/4d6dd252b80eddbd7425d0b6b07b239f4f070647
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sun, 24 Nov 2019 11:21:44 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 24 Nov 2019 14:22:27 +01:00

x86/pti/32: Calculate the various PTI cpu_entry_area sizes correctly, make the CPU_ENTRY_AREA_PAGES assert precise

When two recent commits that increased the size of the 'struct cpu_entry_area'
were merged in -tip, the 32-bit defconfig build started failing on the following
build time assert:

  ./include/linux/compiler.h:391:38: error: call to ‘__compiletime_assert_189’ declared with attribute error: BUILD_BUG_ON failed: CPU_ENTRY_AREA_PAGES * PAGE_SIZE < CPU_ENTRY_AREA_MAP_SIZE
  arch/x86/mm/cpu_entry_area.c:189:2: note: in expansion of macro ‘BUILD_BUG_ON’
  In function ‘setup_cpu_entry_area_ptes’,

Which corresponds to the following build time assert:

	BUILD_BUG_ON(CPU_ENTRY_AREA_PAGES * PAGE_SIZE < CPU_ENTRY_AREA_MAP_SIZE);

The purpose of this assert is to sanity check the fixed-value definition of
CPU_ENTRY_AREA_PAGES arch/x86/include/asm/pgtable_32_types.h:

	#define CPU_ENTRY_AREA_PAGES    (NR_CPUS * 41)

The '41' is supposed to match sizeof(struct cpu_entry_area)/PAGE_SIZE, which value
we didn't want to define in such a low level header, because it would cause
dependency hell.

Every time the size of cpu_entry_area is changed, we have to adjust CPU_ENTRY_AREA_PAGES
accordingly - and this assert is checking that constraint.

But the assert is both imprecise and buggy, primarily because it doesn't
include the single readonly IDT page that is mapped at CPU_ENTRY_AREA_BASE
(which begins at a PMD boundary).

This bug was hidden by the fact that by accident CPU_ENTRY_AREA_PAGES is defined
too large upstream (v5.4-rc8):

	#define CPU_ENTRY_AREA_PAGES    (NR_CPUS * 40)

While 'struct cpu_entry_area' is 155648 bytes, or 38 pages. So we had two extra
pages, which hid the bug.

The following commit (not yet upstream) increased the size to 40 pages:

  x86/iopl: Restrict iopl() permission scope

... but increased CPU_ENTRY_AREA_PAGES only 41 - i.e. shortening the gap
to just 1 extra page.

Then another not-yet-upstream commit changed the size again:

  880a98c33996: x86/cpu_entry_area: Add guard page for entry stack on 32bit

Which increased the cpu_entry_area size from 38 to 39 pages, but
didn't change CPU_ENTRY_AREA_PAGES (kept it at 40). This worked
fine, because we still had a page left from the accidental 'reserve'.

But when these two commits were merged into the same tree, the
combined size of cpu_entry_area grew from 38 to 40 pages, while
CPU_ENTRY_AREA_PAGES finally caught up to 40 as well.

Which is fine in terms of functionality, but the assert broke:

	BUILD_BUG_ON(CPU_ENTRY_AREA_PAGES * PAGE_SIZE < CPU_ENTRY_AREA_MAP_SIZE);

because CPU_ENTRY_AREA_MAP_SIZE is the total size of the area,
which is 1 page larger due to the IDT page.

To fix all this, change the assert to two precise asserts:

	BUILD_BUG_ON((CPU_ENTRY_AREA_PAGES+1)*PAGE_SIZE != CPU_ENTRY_AREA_MAP_SIZE);
	BUILD_BUG_ON(CPU_ENTRY_AREA_TOTAL_SIZE != CPU_ENTRY_AREA_MAP_SIZE);

This takes the IDT page into account, and also connects the size-based
define of CPU_ENTRY_AREA_TOTAL_SIZE with the address-subtraction based
define of CPU_ENTRY_AREA_MAP_SIZE.

Also clean up some of the names which made it rather confusing:

 - 'CPU_ENTRY_AREA_TOT_SIZE' wasn't actually the 'total' size of
   the cpu-entry-area, but the per-cpu array size, so rename this
   to CPU_ENTRY_AREA_ARRAY_SIZE.

 - Introduce CPU_ENTRY_AREA_TOTAL_SIZE that _is_ the total mapping
   size, with the IDT included.

 - Add comments where '+1' denotes the IDT mapping - it wasn't
   obvious and took me about 3 hours to decode...

Finally, because this particular commit is actually applied after
this patch:

  880a98c33996: x86/cpu_entry_area: Add guard page for entry stack on 32bit

Fix the CPU_ENTRY_AREA_PAGES value from 40 pages to the correct 39 pages.

All future commits that change cpu_entry_area will have to adjust
this value precisely.

As a side note, we should probably attempt to remove CPU_ENTRY_AREA_PAGES
and derive its value directly from the structure, without causing
header hell - but that is an adventure for another day! :-)

Fixes: 880a98c33996: x86/cpu_entry_area: Add guard page for entry stack on 32bit
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: stable@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/cpu_entry_area.h   | 12 +++++++-----
 arch/x86/include/asm/pgtable_32_types.h |  8 ++++----
 arch/x86/mm/cpu_entry_area.c            |  4 +++-
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 905d89c..ea866c7 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -98,7 +98,6 @@ struct cpu_entry_area {
 	 */
 	struct cea_exception_stacks estacks;
 #endif
-#ifdef CONFIG_CPU_SUP_INTEL
 	/*
 	 * Per CPU debug store for Intel performance monitoring. Wastes a
 	 * full page at the moment.
@@ -109,11 +108,13 @@ struct cpu_entry_area {
 	 * Reserve enough fixmap PTEs.
 	 */
 	struct debug_store_buffers cpu_debug_buffers;
-#endif
 };
 
-#define CPU_ENTRY_AREA_SIZE	(sizeof(struct cpu_entry_area))
-#define CPU_ENTRY_AREA_TOT_SIZE	(CPU_ENTRY_AREA_SIZE * NR_CPUS)
+#define CPU_ENTRY_AREA_SIZE		(sizeof(struct cpu_entry_area))
+#define CPU_ENTRY_AREA_ARRAY_SIZE	(CPU_ENTRY_AREA_SIZE * NR_CPUS)
+
+/* Total size includes the readonly IDT mapping page as well: */
+#define CPU_ENTRY_AREA_TOTAL_SIZE	(CPU_ENTRY_AREA_ARRAY_SIZE + PAGE_SIZE)
 
 DECLARE_PER_CPU(struct cpu_entry_area *, cpu_entry_area);
 DECLARE_PER_CPU(struct cea_exception_stacks *, cea_exception_stacks);
@@ -121,13 +122,14 @@ DECLARE_PER_CPU(struct cea_exception_stacks *, cea_exception_stacks);
 extern void setup_cpu_entry_areas(void);
 extern void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags);
 
+/* Single page reserved for the readonly IDT mapping: */
 #define	CPU_ENTRY_AREA_RO_IDT		CPU_ENTRY_AREA_BASE
 #define CPU_ENTRY_AREA_PER_CPU		(CPU_ENTRY_AREA_RO_IDT + PAGE_SIZE)
 
 #define CPU_ENTRY_AREA_RO_IDT_VADDR	((void *)CPU_ENTRY_AREA_RO_IDT)
 
 #define CPU_ENTRY_AREA_MAP_SIZE			\
-	(CPU_ENTRY_AREA_PER_CPU + CPU_ENTRY_AREA_TOT_SIZE - CPU_ENTRY_AREA_BASE)
+	(CPU_ENTRY_AREA_PER_CPU + CPU_ENTRY_AREA_ARRAY_SIZE - CPU_ENTRY_AREA_BASE)
 
 extern struct cpu_entry_area *get_cpu_entry_area(int cpu);
 
diff --git a/arch/x86/include/asm/pgtable_32_types.h b/arch/x86/include/asm/pgtable_32_types.h
index b0bc0ff..1636eb8 100644
--- a/arch/x86/include/asm/pgtable_32_types.h
+++ b/arch/x86/include/asm/pgtable_32_types.h
@@ -44,11 +44,11 @@ extern bool __vmalloc_start_set; /* set once high_memory is set */
  * Define this here and validate with BUILD_BUG_ON() in pgtable_32.c
  * to avoid include recursion hell
  */
-#define CPU_ENTRY_AREA_PAGES	(NR_CPUS * 40)
+#define CPU_ENTRY_AREA_PAGES	(NR_CPUS * 39)
 
-#define CPU_ENTRY_AREA_BASE						\
-	((FIXADDR_TOT_START - PAGE_SIZE * (CPU_ENTRY_AREA_PAGES + 1))   \
-	 & PMD_MASK)
+/* The +1 is for the readonly IDT page: */
+#define CPU_ENTRY_AREA_BASE	\
+	((FIXADDR_TOT_START - PAGE_SIZE*(CPU_ENTRY_AREA_PAGES+1)) & PMD_MASK)
 
 #define LDT_BASE_ADDR		\
 	((CPU_ENTRY_AREA_BASE - PAGE_SIZE) & PMD_MASK)
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 752ad11..d964364 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -178,7 +178,9 @@ static __init void setup_cpu_entry_area_ptes(void)
 #ifdef CONFIG_X86_32
 	unsigned long start, end;
 
-	BUILD_BUG_ON(CPU_ENTRY_AREA_PAGES * PAGE_SIZE < CPU_ENTRY_AREA_MAP_SIZE);
+	/* The +1 is for the readonly IDT: */
+	BUILD_BUG_ON((CPU_ENTRY_AREA_PAGES+1)*PAGE_SIZE != CPU_ENTRY_AREA_MAP_SIZE);
+	BUILD_BUG_ON(CPU_ENTRY_AREA_TOTAL_SIZE != CPU_ENTRY_AREA_MAP_SIZE);
 	BUG_ON(CPU_ENTRY_AREA_BASE & ~PMD_MASK);
 
 	start = CPU_ENTRY_AREA_BASE;
