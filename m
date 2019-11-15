Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67115FE6FE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2019 22:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfKOVMj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Nov 2019 16:12:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44611 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfKOVMj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Nov 2019 16:12:39 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVitN-0007Ou-8w; Fri, 15 Nov 2019 22:12:33 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AEEAD1C18CF;
        Fri, 15 Nov 2019 22:12:29 +0100 (CET)
Date:   Fri, 15 Nov 2019 21:12:29 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/iopl] x86/ioperm: Add bitmap sequence number
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191113210104.790774205@linutronix.de>
References: <20191113210104.790774205@linutronix.de>
MIME-Version: 1.0
Message-ID: <157385234967.12247.10518024307495865043.tip-bot2@tip-bot2>
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

Commit-ID:     209c34d3c2de01a5dfe428b8b79fdb913dd76334
Gitweb:        https://git.kernel.org/tip/209c34d3c2de01a5dfe428b8b79fdb913dd76334
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Nov 2019 21:42:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 14 Nov 2019 20:15:04 +01:00

x86/ioperm: Add bitmap sequence number

Add a globally unique sequence number which is incremented when ioperm() is
changing the I/O bitmap of a task. Store the new sequence number in the
io_bitmap structure and compare it with the sequence number of the I/O
bitmap which was last loaded on a CPU. Only update the bitmap if the
sequence is different.

That should further reduce the overhead of I/O bitmap scheduling when there
are only a few I/O bitmap users on the system.

The 64bit sequence counter is sufficient. A wraparound of the sequence
counter assuming an ioperm() call every nanosecond would require about 584
years of uptime.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191113210104.790774205@linutronix.de


---
 arch/x86/include/asm/io_bitmap.h |  1 +-
 arch/x86/include/asm/processor.h |  3 ++-
 arch/x86/kernel/cpu/common.c     |  1 +-
 arch/x86/kernel/ioport.c         |  5 ++++-
 arch/x86/kernel/process.c        | 38 ++++++++++++++++++++++---------
 5 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/io_bitmap.h b/arch/x86/include/asm/io_bitmap.h
index 1a12b9f..d63bd5a 100644
--- a/arch/x86/include/asm/io_bitmap.h
+++ b/arch/x86/include/asm/io_bitmap.h
@@ -5,6 +5,7 @@
 #include <asm/processor.h>
 
 struct io_bitmap {
+	u64		sequence;
 	/* The maximum number of bytes to copy so all zero bits are covered */
 	unsigned int	max;
 	unsigned long	bitmap[IO_BITMAP_LONGS];
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c949e0e..40bb0f7 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -361,6 +361,9 @@ struct entry_stack_page {
  * All IO bitmap related data stored in the TSS:
  */
 struct x86_io_bitmap {
+	/* The sequence number of the last active bitmap. */
+	u64			prev_sequence;
+
 	/*
 	 * Store the dirty size of the last io bitmap offender. The next
 	 * one will have to do the cleanup as the switch out to a non io
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3aee167..79dd544 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1862,6 +1862,7 @@ void cpu_init(void)
 	tss_setup_ist(tss);
 	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
 	tss->io_bitmap.prev_max = 0;
+	tss->io_bitmap.prev_sequence = 0;
 	memset(tss->io_bitmap.bitmap, 0xff, sizeof(tss->io_bitmap.bitmap));
 	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
 
diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index 05f77f3..7c1ab5c 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -14,6 +14,8 @@
 #include <asm/io_bitmap.h>
 #include <asm/desc.h>
 
+static atomic64_t io_bitmap_sequence;
+
 /*
  * this changes the io permissions bitmap in the current task.
  */
@@ -72,6 +74,9 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 
 	/* Update the thread data */
 	iobm->max = bytes;
+	/* Update the sequence number to force an update in switch_to() */
+	iobm->sequence = atomic64_add_return(1, &io_bitmap_sequence);
+
 	/*
 	 * Store the bitmap pointer (might be the same if the task already
 	 * head one). Set the TIF flag, just in case this is the first
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 39c495d..eec7987 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -354,6 +354,28 @@ void arch_setup_new_exec(void)
 	}
 }
 
+static void switch_to_update_io_bitmap(struct tss_struct *tss,
+				       struct io_bitmap *iobm)
+{
+	/*
+	 * Copy at least the byte range of the incoming tasks bitmap which
+	 * covers the permitted I/O ports.
+	 *
+	 * If the previous task which used an I/O bitmap had more bits
+	 * permitted, then the copy needs to cover those as well so they
+	 * get turned off.
+	 */
+	memcpy(tss->io_bitmap.bitmap, iobm->bitmap,
+	       max(tss->io_bitmap.prev_max, iobm->max));
+
+	/*
+	 * Store the new max and the sequence number of this bitmap
+	 * and a pointer to the bitmap itself.
+	 */
+	tss->io_bitmap.prev_max = iobm->max;
+	tss->io_bitmap.prev_sequence = iobm->sequence;
+}
+
 static inline void switch_to_bitmap(struct thread_struct *next,
 				    unsigned long tifp, unsigned long tifn)
 {
@@ -363,18 +385,14 @@ static inline void switch_to_bitmap(struct thread_struct *next,
 		struct io_bitmap *iobm = next->io_bitmap;
 
 		/*
-		 * Copy at least the size of the incoming tasks bitmap
-		 * which covers the last permitted I/O port.
-		 *
-		 * If the previous task which used an io bitmap had more
-		 * bits permitted, then the copy needs to cover those as
-		 * well so they get turned off.
+		 * Only copy bitmap data when the sequence number
+		 * differs. The update time is accounted to the incoming
+		 * task.
 		 */
-		memcpy(tss->io_bitmap.bitmap, next->io_bitmap->bitmap,
-		       max(tss->io_bitmap.prev_max, next->io_bitmap->max));
+		if (tss->io_bitmap.prev_sequence != iobm->sequence)
+			switch_to_update_io_bitmap(tss, iobm);
 
-		/* Store the new max and set io_bitmap_base valid */
-		tss->io_bitmap.prev_max = next->io_bitmap->max;
+		/* Enable the bitmap */
 		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
 
 		/*
