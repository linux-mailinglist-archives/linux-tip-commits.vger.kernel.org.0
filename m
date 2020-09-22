Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F81273E81
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Sep 2020 11:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgIVJZ6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 22 Sep 2020 05:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgIVJZ5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 22 Sep 2020 05:25:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA8FC061755;
        Tue, 22 Sep 2020 02:25:57 -0700 (PDT)
Date:   Tue, 22 Sep 2020 09:25:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600766755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ixjuw1XFDPLcizWawh34SFjvcPywEDOscfH4W7tXDl8=;
        b=BeZg3vpch3xrhWaIeoQ425qBfQSaOQLJpqARWSh9DEHK3f6tSYgMrS4ccQUOxx3Rr2nBTN
        oG8G1lrx9xcUB8FP9Hdy1YB4Lfalr9lgOpLkxq1vgMEfHREtjTbojDDX3gGMXzewukB89a
        zdRTj8YrzOlmIPAkDw2M0z/eNk8P3K2acqxoBGVMZhUppY1xEFVbbW8kn94YXpssKPcrir
        +iCOGZv2WSscCICyt3EP+oDidW8O9S+htuIS0URng07q1KaOJlP9XF5/rJh705eg4KFDZV
        9iFc2MHNnMRPKZ72a2XG6As8YSkemCGH/mMrvIIklXtOYHYuxhpY/kYN1A1DtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600766755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ixjuw1XFDPLcizWawh34SFjvcPywEDOscfH4W7tXDl8=;
        b=c/IXmH15Gs5DFJ1tLHnFyAD0keVSzXKdcgvV2smvuL3jgw+dqCJO02kAmy6GKCb4fknQWJ
        4aFj0lZ8FyfJpVDw==
From:   "tip-bot2 for Mike Hommey" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Handle FPU-related and clearcpuid command
 line arguments earlier
Cc:     Mike Hommey <mh@glandium.org>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200921215638.37980-1-mh@glandium.org>
References: <20200921215638.37980-1-mh@glandium.org>
MIME-Version: 1.0
Message-ID: <160076675453.15536.12823133077636708676.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     1ef5423a55c2ac6f1361811efe75b6e46d1023ed
Gitweb:        https://git.kernel.org/tip/1ef5423a55c2ac6f1361811efe75b6e46d1023ed
Author:        Mike Hommey <mh@glandium.org>
AuthorDate:    Tue, 22 Sep 2020 06:56:38 +09:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 22 Sep 2020 00:24:27 +02:00

x86/fpu: Handle FPU-related and clearcpuid command line arguments earlier

FPU initialization handles them currently. However, in the case
of clearcpuid=, some other early initialization code may check for
features before the FPU initialization code is called. Handling the
argument earlier allows the command line to influence those early
initializations.

Signed-off-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200921215638.37980-1-mh@glandium.org
---
 arch/x86/kernel/cpu/common.c | 55 +++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/fpu/init.c   | 55 +-----------------------------------
 2 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c5d6f17..3c75193 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -23,6 +23,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/pgtable.h>
 
+#include <asm/cmdline.h>
 #include <asm/stackprotector.h>
 #include <asm/perf_event.h>
 #include <asm/mmu_context.h>
@@ -1221,6 +1222,59 @@ static void detect_nopl(void)
 }
 
 /*
+ * We parse cpu parameters early because fpu__init_system() is executed
+ * before parse_early_param().
+ */
+static void __init cpu_parse_early_param(void)
+{
+	char arg[128];
+	char *argptr = arg;
+	int arglen, res, bit;
+
+#ifdef CONFIG_X86_32
+	if (cmdline_find_option_bool(boot_command_line, "no387"))
+#ifdef CONFIG_MATH_EMULATION
+		setup_clear_cpu_cap(X86_FEATURE_FPU);
+#else
+		pr_err("Option 'no387' required CONFIG_MATH_EMULATION enabled.\n");
+#endif
+
+	if (cmdline_find_option_bool(boot_command_line, "nofxsr"))
+		setup_clear_cpu_cap(X86_FEATURE_FXSR);
+#endif
+
+	if (cmdline_find_option_bool(boot_command_line, "noxsave"))
+		setup_clear_cpu_cap(X86_FEATURE_XSAVE);
+
+	if (cmdline_find_option_bool(boot_command_line, "noxsaveopt"))
+		setup_clear_cpu_cap(X86_FEATURE_XSAVEOPT);
+
+	if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
+		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
+
+	arglen = cmdline_find_option(boot_command_line, "clearcpuid", arg, sizeof(arg));
+	if (arglen <= 0)
+		return;
+
+	pr_info("Clearing CPUID bits:");
+	do {
+		res = get_option(&argptr, &bit);
+		if (res == 0 || res == 3)
+			break;
+
+		/* If the argument was too long, the last bit may be cut off */
+		if (res == 1 && arglen >= sizeof(arg))
+			break;
+
+		if (bit >= 0 && bit < NCAPINTS * 32) {
+			pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
+			setup_clear_cpu_cap(bit);
+		}
+	} while (res == 2);
+	pr_cont("\n");
+}
+
+/*
  * Do minimum CPU detection early.
  * Fields really needed: vendor, cpuid_level, family, model, mask,
  * cache alignment.
@@ -1255,6 +1309,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 		get_cpu_cap(c);
 		get_cpu_address_sizes(c);
 		setup_force_cpu_cap(X86_FEATURE_CPUID);
+		cpu_parse_early_param();
 
 		if (this_cpu->c_early_init)
 			this_cpu->c_early_init(c);
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index f8ff895..701f196 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -5,7 +5,6 @@
 #include <asm/fpu/internal.h>
 #include <asm/tlbflush.h>
 #include <asm/setup.h>
-#include <asm/cmdline.h>
 
 #include <linux/sched.h>
 #include <linux/sched/task.h>
@@ -238,65 +237,11 @@ static void __init fpu__init_system_ctx_switch(void)
 }
 
 /*
- * We parse fpu parameters early because fpu__init_system() is executed
- * before parse_early_param().
- */
-static void __init fpu__init_parse_early_param(void)
-{
-	char arg[128];
-	char *argptr = arg;
-	int arglen, res, bit;
-
-#ifdef CONFIG_X86_32
-	if (cmdline_find_option_bool(boot_command_line, "no387"))
-#ifdef CONFIG_MATH_EMULATION
-		setup_clear_cpu_cap(X86_FEATURE_FPU);
-#else
-		pr_err("Option 'no387' required CONFIG_MATH_EMULATION enabled.\n");
-#endif
-
-	if (cmdline_find_option_bool(boot_command_line, "nofxsr"))
-		setup_clear_cpu_cap(X86_FEATURE_FXSR);
-#endif
-
-	if (cmdline_find_option_bool(boot_command_line, "noxsave"))
-		setup_clear_cpu_cap(X86_FEATURE_XSAVE);
-
-	if (cmdline_find_option_bool(boot_command_line, "noxsaveopt"))
-		setup_clear_cpu_cap(X86_FEATURE_XSAVEOPT);
-
-	if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
-		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
-
-	arglen = cmdline_find_option(boot_command_line, "clearcpuid", arg, sizeof(arg));
-	if (arglen <= 0)
-		return;
-
-	pr_info("Clearing CPUID bits:");
-	do {
-		res = get_option(&argptr, &bit);
-		if (res == 0 || res == 3)
-			break;
-
-		/* If the argument was too long, the last bit may be cut off */
-		if (res == 1 && arglen >= sizeof(arg))
-			break;
-
-		if (bit >= 0 && bit < NCAPINTS * 32) {
-			pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
-			setup_clear_cpu_cap(bit);
-		}
-	} while (res == 2);
-	pr_cont("\n");
-}
-
-/*
  * Called on the boot CPU once per system bootup, to set up the initial
  * FPU state that is later cloned into all processes:
  */
 void __init fpu__init_system(struct cpuinfo_x86 *c)
 {
-	fpu__init_parse_early_param();
 	fpu__init_system_early_generic(c);
 
 	/*
