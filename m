Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A981B387B8F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 May 2021 16:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239632AbhEROqB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 18 May 2021 10:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239902AbhEROpv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 18 May 2021 10:45:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403A7C061345;
        Tue, 18 May 2021 07:44:25 -0700 (PDT)
Date:   Tue, 18 May 2021 14:44:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621349063;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G4jXFS36XNjva7s1uuCUM+VgL1rtxNo0s7v2P8R/1G0=;
        b=Ed7WNdUOeVlI44hhNKq08SREBeZmbWgsV31pUQiUaMz96CZ6JMev5m693WBdTuYsgDpSwT
        Xe8k91ykKiNas67TOlzTpG3U/pm3FKse4FM9UnYJogztV4CdKX5IRMgTu06XBKS34nWqSv
        ftUo20QOmcBc47wKfU1MPENTmrtRhJIdCxEW/M/A52iJOXo4rlOBD2RqXcEMCyveLuqACu
        rTLOLRv4Z1fKvAiIWLTx/thuaKTowcue82K26NuN4nMH4J7yDiml2Dum9YqZCKzhbv7ZWQ
        Yj1UT3cIe1wwbmceTO7hYacZjrZsi/ti4yOyDtlPQ7Yj5bKI44fGSUCJ0+vyyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621349063;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G4jXFS36XNjva7s1uuCUM+VgL1rtxNo0s7v2P8R/1G0=;
        b=j42OHLliyTniTQB4uLEybJj0JRJ94uSa6gykQjCyyULajDjhGywTHS1x0mv3REeXt59HOF
        3XyBFb2ULY5FcADg==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/splitlock] x86/bus_lock: Set rate limit for bus lock
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210419214958.4035512-3-fenghua.yu@intel.com>
References: <20210419214958.4035512-3-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <162134906216.29796.4189388167264894172.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/splitlock branch of tip:

Commit-ID:     ef4ae6e4413159d2329a172c12e9274e2cb0a3a8
Gitweb:        https://git.kernel.org/tip/ef4ae6e4413159d2329a172c12e9274e2cb0a3a8
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Mon, 19 Apr 2021 21:49:56 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 May 2021 16:39:31 +02:00

x86/bus_lock: Set rate limit for bus lock

A bus lock can be thousands of cycles slower than atomic operation within
one cache line. It also disrupts performance on other cores. Malicious
users can generate multiple bus locks to degrade the whole system
performance.

The current mitigation is to kill the offending process, but for certain
scenarios it's desired to identify and throttle the offending application.

Add a system wide rate limit for bus locks. When the system detects bus
locks at a rate higher than N/sec (where N can be set by the kernel boot
argument in the range [1..1000]) any task triggering a bus lock will be
forced to sleep for at least 20ms until the overall system rate of bus
locks drops below the threshold.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20210419214958.4035512-3-fenghua.yu@intel.com

---
 arch/x86/kernel/cpu/intel.c | 42 ++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8adffc1..7c23f03 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -10,6 +10,7 @@
 #include <linux/thread_info.h>
 #include <linux/init.h>
 #include <linux/uaccess.h>
+#include <linux/delay.h>
 
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
@@ -41,6 +42,7 @@ enum split_lock_detect_state {
 	sld_off = 0,
 	sld_warn,
 	sld_fatal,
+	sld_ratelimit,
 };
 
 /*
@@ -997,13 +999,30 @@ static const struct {
 	{ "off",	sld_off   },
 	{ "warn",	sld_warn  },
 	{ "fatal",	sld_fatal },
+	{ "ratelimit:", sld_ratelimit },
 };
 
+static struct ratelimit_state bld_ratelimit;
+
 static inline bool match_option(const char *arg, int arglen, const char *opt)
 {
-	int len = strlen(opt);
+	int len = strlen(opt), ratelimit;
+
+	if (strncmp(arg, opt, len))
+		return false;
+
+	/*
+	 * Min ratelimit is 1 bus lock/sec.
+	 * Max ratelimit is 1000 bus locks/sec.
+	 */
+	if (sscanf(arg, "ratelimit:%d", &ratelimit) == 1 &&
+	    ratelimit > 0 && ratelimit <= 1000) {
+		ratelimit_state_init(&bld_ratelimit, HZ, ratelimit);
+		ratelimit_set_flags(&bld_ratelimit, RATELIMIT_MSG_ON_RELEASE);
+		return true;
+	}
 
-	return len == arglen && !strncmp(arg, opt, len);
+	return len == arglen;
 }
 
 static bool split_lock_verify_msr(bool on)
@@ -1082,6 +1101,15 @@ static void sld_update_msr(bool on)
 
 static void split_lock_init(void)
 {
+	/*
+	 * #DB for bus lock handles ratelimit and #AC for split lock is
+	 * disabled.
+	 */
+	if (sld_state == sld_ratelimit) {
+		split_lock_verify_msr(false);
+		return;
+	}
+
 	if (cpu_model_supports_sld)
 		split_lock_verify_msr(sld_state != sld_off);
 }
@@ -1154,6 +1182,12 @@ void handle_bus_lock(struct pt_regs *regs)
 	switch (sld_state) {
 	case sld_off:
 		break;
+	case sld_ratelimit:
+		/* Enforce no more than bld_ratelimit bus locks/sec. */
+		while (!__ratelimit(&bld_ratelimit))
+			msleep(20);
+		/* Warn on the bus lock. */
+		fallthrough;
 	case sld_warn:
 		pr_warn_ratelimited("#DB: %s/%d took a bus_lock trap at address: 0x%lx\n",
 				    current->comm, current->pid, regs->ip);
@@ -1259,6 +1293,10 @@ static void sld_state_show(void)
 				" from non-WB" : "");
 		}
 		break;
+	case sld_ratelimit:
+		if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
+			pr_info("#DB: setting system wide bus lock rate limit to %u/sec\n", bld_ratelimit.burst);
+		break;
 	}
 }
 
