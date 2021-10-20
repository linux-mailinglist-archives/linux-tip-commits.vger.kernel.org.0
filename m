Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDA9434C5E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhJTNqy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:46:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52936 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhJTNqs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:46:48 -0400
Date:   Wed, 20 Oct 2021 13:44:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737473;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2pF3FK9RG1981/UZ2tyGpChNLn8TOWmngCzK4gCmdzI=;
        b=cCG0TXVkGbe9Mh1etazVVAnyv3YieuBpQxvQ4tVvYCYPo9kiOT1SEQTPjUNTf/9/TOSBaA
        GhFsVRn+hp0zOClLof+E/3AOIEGw6YuQh3DjcHcUXuoR450ed7MMPhw0E5C0mOR5ZGWLuH
        ntMz7xLxvA/Oh7Nhe3pwhwsvGRPBkhffoNLThes55Yba2h4a6STpw13xWdQ3N5QoM13Mwb
        QJoqGgv6KTxHEXktC9ENZtxPU+5IfiwWKF06+4/V7D2qXxnYiBFNOn4G65/up21FT5shsm
        7jEERek/P/cdUASzmzvVnsFhHiqICTmoIIxZmUA+foZZt+PXHQrgDkkZSGIU9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737473;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2pF3FK9RG1981/UZ2tyGpChNLn8TOWmngCzK4gCmdzI=;
        b=T9O3kDa2jjnFJyIZQ0fUEwGjoOnnxAFv30sX5MNYU72WsASt1e8MawwqTu70wBFwaSMke4
        mGZsnLkQgMSv0SCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Make WARN_ON_FPU() private
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011539.628516182@linutronix.de>
References: <20211015011539.628516182@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473747276.25758.4406772590918642560.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     cdcb6fa14e1499ff2b2a3f3e0938c7b3b7ef2cd6
Gitweb:        https://git.kernel.org/tip/cdcb6fa14e1499ff2b2a3f3e0938c7b3b7ef2cd6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:16:28 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:28 +02:00

x86/fpu: Make WARN_ON_FPU() private

No point in being in global headers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011539.628516182@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h |  9 ---------
 arch/x86/kernel/fpu/init.c          |  2 ++
 arch/x86/kernel/fpu/internal.h      |  6 ++++++
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 7722aad..f8413a5 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -42,15 +42,6 @@ extern void fpu__init_system(struct cpuinfo_x86 *c);
 extern void fpu__init_check_bugs(void);
 extern void fpu__resume_cpu(void);
 
-/*
- * Debugging facility:
- */
-#ifdef CONFIG_X86_DEBUG_FPU
-# define WARN_ON_FPU(x) WARN_ON_ONCE(x)
-#else
-# define WARN_ON_FPU(x) ({ (void)(x); 0; })
-#endif
-
 extern union fpregs_state init_fpstate;
 extern void fpstate_init_user(union fpregs_state *state);
 
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 545c91c..24873df 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -10,6 +10,8 @@
 #include <linux/sched/task.h>
 #include <linux/init.h>
 
+#include "internal.h"
+
 /*
  * Initialize the registers found in all CPUs, CR0 and CR4:
  */
diff --git a/arch/x86/kernel/fpu/internal.h b/arch/x86/kernel/fpu/internal.h
index a8aac21..5ddc09e 100644
--- a/arch/x86/kernel/fpu/internal.h
+++ b/arch/x86/kernel/fpu/internal.h
@@ -13,6 +13,12 @@ static __always_inline __pure bool use_fxsr(void)
 	return cpu_feature_enabled(X86_FEATURE_FXSR);
 }
 
+#ifdef CONFIG_X86_DEBUG_FPU
+# define WARN_ON_FPU(x) WARN_ON_ONCE(x)
+#else
+# define WARN_ON_FPU(x) ({ (void)(x); 0; })
+#endif
+
 /* Init functions */
 extern void fpu__init_prepare_fx_sw_frame(void);
 
