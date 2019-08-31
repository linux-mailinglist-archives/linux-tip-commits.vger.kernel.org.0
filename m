Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94B92A438A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 31 Aug 2019 11:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfHaJGU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 31 Aug 2019 05:06:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54404 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfHaJGU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 31 Aug 2019 05:06:20 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3zKf-0006D2-RA; Sat, 31 Aug 2019 11:06:05 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 713C51C0DCA;
        Sat, 31 Aug 2019 11:06:05 +0200 (CEST)
Date:   Sat, 31 Aug 2019 09:06:05 -0000
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/amd/ibs: Fix sample bias for dispatched micro-ops
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>, <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>,
        Stephane Eranian <eranian@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20190826195730.30614-1-kim.phillips@amd.com>
References: <20190826195730.30614-1-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <156724236532.10782.17844013749559561663.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     0f4cd769c410e2285a4e9873a684d90423f03090
Gitweb:        https://git.kernel.org/tip/0f4cd769c410e2285a4e9873a684d90423f03090
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Mon, 26 Aug 2019 14:57:30 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 30 Aug 2019 14:27:47 +02:00

perf/x86/amd/ibs: Fix sample bias for dispatched micro-ops

When counting dispatched micro-ops with cnt_ctl=1, in order to prevent
sample bias, IBS hardware preloads the least significant 7 bits of
current count (IbsOpCurCnt) with random values, such that, after the
interrupt is handled and counting resumes, the next sample taken
will be slightly perturbed.

The current count bitfield is in the IBS execution control h/w register,
alongside the maximum count field.

Currently, the IBS driver writes that register with the maximum count,
leaving zeroes to fill the current count field, thereby overwriting
the random bits the hardware preloaded for itself.

Fix the driver to actually retain and carry those random bits from the
read of the IBS control register, through to its write, instead of
overwriting the lower current count bits with zeroes.

Tested with:

perf record -c 100001 -e ibs_op/cnt_ctl=1/pp -a -C 0 taskset -c 0 <workload>

'perf annotate' output before:

 15.70  65:   addsd     %xmm0,%xmm1
 17.30        add       $0x1,%rax
 15.88        cmp       %rdx,%rax
              je        82
 17.32  72:   test      $0x1,%al
              jne       7c
  7.52        movapd    %xmm1,%xmm0
  5.90        jmp       65
  8.23  7c:   sqrtsd    %xmm1,%xmm0
 12.15        jmp       65

'perf annotate' output after:

 16.63  65:   addsd     %xmm0,%xmm1
 16.82        add       $0x1,%rax
 16.81        cmp       %rdx,%rax
              je        82
 16.69  72:   test      $0x1,%al
              jne       7c
  8.30        movapd    %xmm1,%xmm0
  8.13        jmp       65
  8.24  7c:   sqrtsd    %xmm1,%xmm0
  8.39        jmp       65

Tested on Family 15h and 17h machines.

Machines prior to family 10h Rev. C don't have the RDWROPCNT capability,
and have the IbsOpCurCnt bitfield reserved, so this patch shouldn't
affect their operation.

It is unknown why commit db98c5faf8cb ("perf/x86: Implement 64-bit
counter support for IBS") ignored the lower 4 bits of the IbsOpCurCnt
field; the number of preloaded random bits has always been 7, AFAICT.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: <x86@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Borislav Petkov" <bp@alien8.de>
Cc: Stephane Eranian <eranian@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: "Namhyung Kim" <namhyung@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20190826195730.30614-1-kim.phillips@amd.com
---
 arch/x86/events/amd/ibs.c         | 13 ++++++++++---
 arch/x86/include/asm/perf_event.h | 12 ++++++++----
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 62f317c..5b35b7e 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -661,10 +661,17 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 
 	throttle = perf_event_overflow(event, &data, &regs);
 out:
-	if (throttle)
+	if (throttle) {
 		perf_ibs_stop(event, 0);
-	else
-		perf_ibs_enable_event(perf_ibs, hwc, period >> 4);
+	} else {
+		period >>= 4;
+
+		if ((ibs_caps & IBS_CAPS_RDWROPCNT) &&
+		    (*config & IBS_OP_CNT_CTL))
+			period |= *config & IBS_OP_CUR_CNT_RAND;
+
+		perf_ibs_enable_event(perf_ibs, hwc, period);
+	}
 
 	perf_event_update_userpage(event);
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 1392d5e..ee26e92 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -252,16 +252,20 @@ struct pebs_lbr {
 #define IBSCTL_LVT_OFFSET_VALID		(1ULL<<8)
 #define IBSCTL_LVT_OFFSET_MASK		0x0F
 
-/* ibs fetch bits/masks */
+/* IBS fetch bits/masks */
 #define IBS_FETCH_RAND_EN	(1ULL<<57)
 #define IBS_FETCH_VAL		(1ULL<<49)
 #define IBS_FETCH_ENABLE	(1ULL<<48)
 #define IBS_FETCH_CNT		0xFFFF0000ULL
 #define IBS_FETCH_MAX_CNT	0x0000FFFFULL
 
-/* ibs op bits/masks */
-/* lower 4 bits of the current count are ignored: */
-#define IBS_OP_CUR_CNT		(0xFFFF0ULL<<32)
+/*
+ * IBS op bits/masks
+ * The lower 7 bits of the current count are random bits
+ * preloaded by hardware and ignored in software
+ */
+#define IBS_OP_CUR_CNT		(0xFFF80ULL<<32)
+#define IBS_OP_CUR_CNT_RAND	(0x0007FULL<<32)
 #define IBS_OP_CNT_CTL		(1ULL<<19)
 #define IBS_OP_VAL		(1ULL<<18)
 #define IBS_OP_ENABLE		(1ULL<<17)
