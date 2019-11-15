Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E813FE700
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2019 22:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfKOVMi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Nov 2019 16:12:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44598 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKOVMi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Nov 2019 16:12:38 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVitM-0007Py-OZ; Fri, 15 Nov 2019 22:12:32 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E61B61C18D0;
        Fri, 15 Nov 2019 22:12:29 +0100 (CET)
Date:   Fri, 15 Nov 2019 21:12:29 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/iopl] x86/tss: Move I/O bitmap data into a seperate struct
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191113210104.591976506@linutronix.de>
References: <20191113210104.591976506@linutronix.de>
MIME-Version: 1.0
Message-ID: <157385234991.12247.14441822087629749132.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/iopl branch of tip:

Commit-ID:     98336a94ec192ef45ba66e2c86dd3d7a3ef520a1
Gitweb:        https://git.kernel.org/tip/98336a94ec192ef45ba66e2c86dd3d7a3ef520a1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Nov 2019 21:42:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 14 Nov 2019 20:15:03 +01:00

x86/tss: Move I/O bitmap data into a seperate struct

Move the non hardware portion of I/O bitmap data into a seperate struct for
readability sake.

Originally-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191113210104.591976506@linutronix.de

---
 arch/x86/include/asm/processor.h | 35 ++++++++++++++++++-------------
 arch/x86/kernel/cpu/common.c     |  4 ++--
 arch/x86/kernel/ioport.c         |  4 ++--
 arch/x86/kernel/process.c        |  6 ++---
 4 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 6d0059c..cd7cd7d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -328,11 +328,11 @@ struct x86_hw_tss {
  * IO-bitmap sizes:
  */
 #define IO_BITMAP_BITS			65536
-#define IO_BITMAP_BYTES			(IO_BITMAP_BITS/8)
-#define IO_BITMAP_LONGS			(IO_BITMAP_BYTES/sizeof(long))
+#define IO_BITMAP_BYTES			(IO_BITMAP_BITS / BITS_PER_BYTE)
+#define IO_BITMAP_LONGS			(IO_BITMAP_BYTES / sizeof(long))
 
-#define IO_BITMAP_OFFSET_VALID				\
-	(offsetof(struct tss_struct, io_bitmap) -	\
+#define IO_BITMAP_OFFSET_VALID					\
+	(offsetof(struct tss_struct, io_bitmap.bitmap) -	\
 	 offsetof(struct tss_struct, x86_tss))
 
 /*
@@ -356,14 +356,10 @@ struct entry_stack_page {
 	struct entry_stack stack;
 } __aligned(PAGE_SIZE);
 
-struct tss_struct {
-	/*
-	 * The fixed hardware portion.  This must not cross a page boundary
-	 * at risk of violating the SDM's advice and potentially triggering
-	 * errata.
-	 */
-	struct x86_hw_tss	x86_tss;
-
+/*
+ * All IO bitmap related data stored in the TSS:
+ */
+struct x86_io_bitmap {
 	/*
 	 * Store the dirty size of the last io bitmap offender. The next
 	 * one will have to do the cleanup as the switch out to a non io
@@ -371,7 +367,7 @@ struct tss_struct {
 	 * outside of the TSS limit. So for sane tasks there is no need to
 	 * actually touch the io_bitmap at all.
 	 */
-	unsigned int		io_bitmap_prev_max;
+	unsigned int		prev_max;
 
 	/*
 	 * The extra 1 is there because the CPU will access an
@@ -379,7 +375,18 @@ struct tss_struct {
 	 * bitmap. The extra byte must be all 1 bits, and must
 	 * be within the limit.
 	 */
-	unsigned long		io_bitmap[IO_BITMAP_LONGS + 1];
+	unsigned long		bitmap[IO_BITMAP_LONGS + 1];
+};
+
+struct tss_struct {
+	/*
+	 * The fixed hardware portion.  This must not cross a page boundary
+	 * at risk of violating the SDM's advice and potentially triggering
+	 * errata.
+	 */
+	struct x86_hw_tss	x86_tss;
+
+	struct x86_io_bitmap	io_bitmap;
 } __aligned(PAGE_SIZE);
 
 DECLARE_PER_CPU_PAGE_ALIGNED(struct tss_struct, cpu_tss_rw);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8c1000a..3aee167 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1861,8 +1861,8 @@ void cpu_init(void)
 	/* Initialize the TSS. */
 	tss_setup_ist(tss);
 	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
-	tss->io_bitmap_prev_max = 0;
-	memset(tss->io_bitmap, 0xff, sizeof(tss->io_bitmap));
+	tss->io_bitmap.prev_max = 0;
+	memset(tss->io_bitmap.bitmap, 0xff, sizeof(tss->io_bitmap.bitmap));
 	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
 
 	load_TR_desc();
diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index eed218a..80d99bb 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -81,9 +81,9 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 
 	/* Update the TSS */
 	tss = this_cpu_ptr(&cpu_tss_rw);
-	memcpy(tss->io_bitmap, t->io_bitmap_ptr, bytes_updated);
+	memcpy(tss->io_bitmap.bitmap, t->io_bitmap_ptr, bytes_updated);
 	/* Store the new end of the zero bits */
-	tss->io_bitmap_prev_max = bytes;
+	tss->io_bitmap.prev_max = bytes;
 	/* Make the bitmap base in the TSS valid */
 	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
 	/* Make sure the TSS limit covers the I/O bitmap. */
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 023e7f8..3e2f1aa 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -368,11 +368,11 @@ static inline void switch_to_bitmap(struct thread_struct *next,
 		 * bits permitted, then the copy needs to cover those as
 		 * well so they get turned off.
 		 */
-		memcpy(tss->io_bitmap, next->io_bitmap_ptr,
-		       max(tss->io_bitmap_prev_max, next->io_bitmap_max));
+		memcpy(tss->io_bitmap.bitmap, next->io_bitmap_ptr,
+		       max(tss->io_bitmap.prev_max, next->io_bitmap_max));
 
 		/* Store the new max and set io_bitmap_base valid */
-		tss->io_bitmap_prev_max = next->io_bitmap_max;
+		tss->io_bitmap.prev_max = next->io_bitmap_max;
 		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
 
 		/*
