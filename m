Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAD59D4FFF
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Oct 2019 15:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfJLNTd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Oct 2019 09:19:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34816 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbfJLNTd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Oct 2019 09:19:33 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iJHIl-0000aN-7O; Sat, 12 Oct 2019 15:19:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B0AE41C0440;
        Sat, 12 Oct 2019 15:19:18 +0200 (CEST)
Date:   Sat, 12 Oct 2019 13:19:18 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/cstate: Add Comet Lake CPU support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1570549810-25049-5-git-send-email-kan.liang@linux.intel.com>
References: <1570549810-25049-5-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157088635865.9978.9858710443164832207.tip-bot2@tip-bot2>
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

Commit-ID:     1ffa6c04dae39776a3c222bdf88051e394386c01
Gitweb:        https://git.kernel.org/tip/1ffa6c04dae39776a3c222bdf88051e394386c01
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 08 Oct 2019 08:50:05 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 12 Oct 2019 15:13:08 +02:00

perf/x86/cstate: Add Comet Lake CPU support

Comet Lake is the new 10th Gen Intel processor. From the perspective of
Intel cstate residency counters, there is nothing changed compared with
Kaby Lake.

Share hswult_cstates with Kaby Lake.
Update the comments for Comet Lake.
Kaby Lake is missed in the comments for some Residency Counters. Update
the comments for Kaby Lake as well.

The External Design Specification (EDS) is not published yet. It comes
from an authoritative internal source.

The patch has been tested on real hardware.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1570549810-25049-5-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/cstate.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 9f2f390..21c65e1 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -45,46 +45,48 @@
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,GLM,
-						CNL
+ *						CNL,KBL,CML
  *			       Scope: Core
  *	MSR_CORE_C6_RESIDENCY: CORE C6 Residency Counter
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
- *						SKL,KNL,GLM,CNL
+ *						SKL,KNL,GLM,CNL,KBL,CML
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
- *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL
+ *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML
  *			       Scope: Core
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
- *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL
+ *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
+ *						KBL,CML
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
- *						GLM,CNL
+ *						GLM,CNL,KBL,CML
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW
- *						SKL,KNL,GLM,CNL
+ *						SKL,KNL,GLM,CNL,KBL,CML
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
- *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,CNL
+ *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,CNL,
+ *						KBL,CML
  *			       Scope: Package (physical package)
  *	MSR_PKG_C8_RESIDENCY:  Package C8 Residency Counter.
  *			       perf code: 0x04
- *			       Available model: HSW ULT,KBL,CNL
+ *			       Available model: HSW ULT,KBL,CNL,CML
  *			       Scope: Package (physical package)
  *	MSR_PKG_C9_RESIDENCY:  Package C9 Residency Counter.
  *			       perf code: 0x05
- *			       Available model: HSW ULT,KBL,CNL
+ *			       Available model: HSW ULT,KBL,CNL,CML
  *			       Scope: Package (physical package)
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
- *			       Available model: HSW ULT,KBL,GLM,CNL
+ *			       Available model: HSW ULT,KBL,GLM,CNL,CML
  *			       Scope: Package (physical package)
  *
  */
@@ -614,6 +616,8 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 
 	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_L, hswult_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE,   hswult_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_COMETLAKE_L, hswult_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_COMETLAKE, hswult_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_CANNONLAKE_L, cnl_cstates),
 
