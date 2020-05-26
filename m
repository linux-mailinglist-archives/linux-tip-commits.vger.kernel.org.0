Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9D61C8E22
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 May 2020 16:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgEGONc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 7 May 2020 10:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgEGONb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 7 May 2020 10:13:31 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679BBC05BD09;
        Thu,  7 May 2020 07:13:31 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWhHD-0002c2-EQ; Thu, 07 May 2020 16:13:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EA21C1C03AB;
        Thu,  7 May 2020 16:13:26 +0200 (CEST)
Date:   Thu, 07 May 2020 14:13:26 -0000
From:   "tip-bot2 for Kyung Min Park" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/timers] x86/delay: Refactor delay_mwaitx() for TPAUSE support
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1587757076-30337-3-git-send-email-kyung.min.park@intel.com>
References: <1587757076-30337-3-git-send-email-kyung.min.park@intel.com>
MIME-Version: 1.0
Message-ID: <158886080690.8414.16414662834297433879.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/timers branch of tip:

Commit-ID:     46f90c7aad62be1af76588108c730d826308a801
Gitweb:        https://git.kernel.org/tip/46f90c7aad62be1af76588108c730d826308a801
Author:        Kyung Min Park <kyung.min.park@intel.com>
AuthorDate:    Fri, 24 Apr 2020 12:37:55 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 May 2020 16:06:19 +02:00

x86/delay: Refactor delay_mwaitx() for TPAUSE support

Refactor code to make it easier to add a new model specific function to
delay for a number of cycles.

No functional change.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/1587757076-30337-3-git-send-email-kyung.min.park@intel.com

---
 arch/x86/lib/delay.c | 48 ++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
index 887d52d..fe91dc1 100644
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -34,6 +34,7 @@ static void delay_loop(u64 __loops);
  * during boot.
  */
 static void (*delay_fn)(u64) __ro_after_init = delay_loop;
+static void (*delay_halt_fn)(u64 start, u64 cycles) __ro_after_init;
 
 /* simple loop based delay: */
 static void delay_loop(u64 __loops)
@@ -100,9 +101,33 @@ static void delay_tsc(u64 cycles)
  * counts with TSC frequency. The input value is the number of TSC cycles
  * to wait. MWAITX will also exit when the timer expires.
  */
-static void delay_mwaitx(u64 cycles)
+static void delay_halt_mwaitx(u64 unused, u64 cycles)
 {
-	u64 start, end, delay;
+	u64 delay;
+
+	delay = min_t(u64, MWAITX_MAX_WAIT_CYCLES, cycles);
+	/*
+	 * Use cpu_tss_rw as a cacheline-aligned, seldomly accessed per-cpu
+	 * variable as the monitor target.
+	 */
+	 __monitorx(raw_cpu_ptr(&cpu_tss_rw), 0, 0);
+
+	/*
+	 * AMD, like Intel, supports the EAX hint and EAX=0xf means, do not
+	 * enter any deep C-state and we use it here in delay() to minimize
+	 * wakeup latency.
+	 */
+	__mwaitx(MWAITX_DISABLE_CSTATES, delay, MWAITX_ECX_TIMER_ENABLE);
+}
+
+/*
+ * Call a vendor specific function to delay for a given amount of time. Because
+ * these functions may return earlier than requested, check for actual elapsed
+ * time and call again until done.
+ */
+static void delay_halt(u64 __cycles)
+{
+	u64 start, end, cycles = __cycles;
 
 	/*
 	 * Timer value of 0 causes MWAITX to wait indefinitely, unless there
@@ -114,21 +139,7 @@ static void delay_mwaitx(u64 cycles)
 	start = rdtsc_ordered();
 
 	for (;;) {
-		delay = min_t(u64, MWAITX_MAX_WAIT_CYCLES, cycles);
-
-		/*
-		 * Use cpu_tss_rw as a cacheline-aligned, seldomly
-		 * accessed per-cpu variable as the monitor target.
-		 */
-		__monitorx(raw_cpu_ptr(&cpu_tss_rw), 0, 0);
-
-		/*
-		 * AMD, like Intel's MWAIT version, supports the EAX hint and
-		 * EAX=0xf0 means, do not enter any deep C-state and we use it
-		 * here in delay() to minimize wakeup latency.
-		 */
-		__mwaitx(MWAITX_DISABLE_CSTATES, delay, MWAITX_ECX_TIMER_ENABLE);
-
+		delay_halt_fn(start, cycles);
 		end = rdtsc_ordered();
 
 		if (cycles <= end - start)
@@ -147,7 +158,8 @@ void __init use_tsc_delay(void)
 
 void use_mwaitx_delay(void)
 {
-	delay_fn = delay_mwaitx;
+	delay_halt_fn = delay_halt_mwaitx;
+	delay_fn = delay_halt;
 }
 
 int read_current_timer(unsigned long *timer_val)
