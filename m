Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23224313116
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Feb 2021 12:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhBHLkh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 8 Feb 2021 06:40:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36114 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbhBHLiV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 8 Feb 2021 06:38:21 -0500
Date:   Mon, 08 Feb 2021 11:37:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612784256;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jGfAVUYAjVHw8Tm1wOrOSkNHoI9Fdzb9jJHFJAdrnAI=;
        b=I0moMx4KEFNBkjKIF3sMS8AlxjS8oFF9bfRlJxU1+FnXM7V34DRrpmOdSp9uQCq5ia/hDt
        5XcjltGXBLrfPdqQxXVTBO5aGrSNjxtW1jWLKT3ab6aXlMGaPf9SoIXQwAD588TT/MqC0e
        wnw6IYxlRcPGsrym/Vv0L9VAW8piLKlwmed7qjBLFW8jPVs3aHzSemDRmemiKysXzP2v0i
        WTpLws/8LcDwsSzLrPKwjhK9obAriSXvR+7FXiscFCSO2aM4gJ3wja6o1X4Ps6eTDqMGXd
        ze+jef6fUGGi0Hx1+51butFNgTlC2rqgcZY4qb2ISQHPVvXWaaHoR40sMe3Xrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612784256;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jGfAVUYAjVHw8Tm1wOrOSkNHoI9Fdzb9jJHFJAdrnAI=;
        b=rYEEV1xBrk3YedfKsr5wxen/Wass+zGQoiWgGgpsOYbV9IRcPp4+hhQs/Z+E9I6ls/5kwB
        FCXtuDpFYvi+BKBQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Get rid of mcheck_intel_therm_init()
Cc:     Borislav Petkov <bp@suse.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210201142704.12495-2-bp@alien8.de>
References: <20210201142704.12495-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161278425593.23325.17809628034338595071.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     4f432e8bb15b352da72525144da025a46695968f
Gitweb:        https://git.kernel.org/tip/4f432e8bb15b352da72525144da025a46695968f
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 07 Jan 2021 13:23:34 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 08 Feb 2021 11:28:30 +01:00

x86/mce: Get rid of mcheck_intel_therm_init()

Move the APIC_LVTTHMR read which needs to happen on the BSP, to
intel_init_thermal(). One less boot dependency.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://lkml.kernel.org/r/20210201142704.12495-2-bp@alien8.de
---
 arch/x86/include/asm/mce.h            |  6 ------
 arch/x86/kernel/cpu/mce/core.c        |  1 -
 arch/x86/kernel/cpu/mce/therm_throt.c | 15 ++++-----------
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 56cdeaa..def9aa5 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -304,12 +304,6 @@ extern int (*platform_thermal_package_notify)(__u64 msr_val);
  * callback has rate control */
 extern bool (*platform_thermal_package_rate_control)(void);
 
-#ifdef CONFIG_X86_THERMAL_VECTOR
-extern void mcheck_intel_therm_init(void);
-#else
-static inline void mcheck_intel_therm_init(void) { }
-#endif
-
 /*
  * Used by APEI to report memory error via /dev/mcelog
  */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6c81d09..0cb065e 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2189,7 +2189,6 @@ __setup("mce", mcheck_enable);
 
 int __init mcheck_init(void)
 {
-	mcheck_intel_therm_init();
 	mce_register_decode_chain(&early_nb);
 	mce_register_decode_chain(&mce_uc_nb);
 	mce_register_decode_chain(&mce_default_nb);
diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
index a7cd2d2..5b15d7c 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -633,17 +633,6 @@ static int intel_thermal_supported(struct cpuinfo_x86 *c)
 	return 1;
 }
 
-void __init mcheck_intel_therm_init(void)
-{
-	/*
-	 * This function is only called on boot CPU. Save the init thermal
-	 * LVT value on BSP and use that value to restore APs' thermal LVT
-	 * entry BIOS programmed later
-	 */
-	if (intel_thermal_supported(&boot_cpu_data))
-		lvtthmr_init = apic_read(APIC_LVTTHMR);
-}
-
 void intel_init_thermal(struct cpuinfo_x86 *c)
 {
 	unsigned int cpu = smp_processor_id();
@@ -653,6 +642,10 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
 	if (!intel_thermal_supported(c))
 		return;
 
+	/* On the BSP? */
+	if (c == &boot_cpu_data)
+		lvtthmr_init = apic_read(APIC_LVTTHMR);
+
 	/*
 	 * First check if its enabled already, in which case there might
 	 * be some SMM goo which handles it, so we can't even put a handler
