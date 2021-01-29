Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0056308C42
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Jan 2021 19:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhA2STN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 29 Jan 2021 13:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhA2SSt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 29 Jan 2021 13:18:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB5EC061574;
        Fri, 29 Jan 2021 10:18:09 -0800 (PST)
Date:   Fri, 29 Jan 2021 18:18:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611944287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iyX25YG4h/mqVFDSMSZk8OOBkx5/ND6wozZGhoLV5bA=;
        b=gdwrreCqqZ6qqCyr657qY2ad1AvjLk9WqesoAdnmh0K2LXviW1pKsRZmZyzK0Tmhx7yjcH
        0/v6OLKJjRNUyVcDlUiRS7qzppYGLBfqkcVwZItb0WT1UW7zZllTw2SozwxQPZBs2Rn4sf
        +yd6lH9R4/n+Mq0qslWPuaqmJ17biLz4Usz2IvJd++F5KE7vp3dtnTViwgPnpPiG08FG/H
        QKQmnXp6VG5p1OdqiznVb+8fhK7iqWkOJiXiBaX+XPT0Xh9uOkZZj04EdgQDjCrjm37OYE
        bjglfSDwSiazC+jHHV3loxal/L653PWQ0pPZwYp7HBgf43mmuJFt7OyemtmpHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611944287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iyX25YG4h/mqVFDSMSZk8OOBkx5/ND6wozZGhoLV5bA=;
        b=t38vqSEM/pjQH0OLu7nly5tso7xUIS8hjk5sk5r+lgiwKEoAFzbG0qZZy6wGnETeFgoGV4
        mmWu/UpRLaa/UXCQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Get rid of mcheck_intel_therm_init()
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210125130533.19938-2-bp@alien8.de>
References: <20210125130533.19938-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161194428731.23325.16226976370470259248.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     b4e530ac40f25dbf07cbd37796bfcef3ec86fba8
Gitweb:        https://git.kernel.org/tip/b4e530ac40f25dbf07cbd37796bfcef3ec86fba8
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 07 Jan 2021 13:23:34 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 29 Jan 2021 17:33:05 +01:00

x86/mce: Get rid of mcheck_intel_therm_init()

Move the APIC_LVTTHMR read which needs to happen on the BSP, to
intel_init_thermal(). One less boot dependency.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210125130533.19938-2-bp@alien8.de
---
 arch/x86/include/asm/mce.h            |  6 ------
 arch/x86/kernel/cpu/mce/core.c        |  1 -
 arch/x86/kernel/cpu/mce/therm_throt.c | 14 +++-----------
 3 files changed, 3 insertions(+), 18 deletions(-)

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
index a7cd2d2..5b1aa0f 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -633,23 +633,15 @@ static int intel_thermal_supported(struct cpuinfo_x86 *c)
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
 	int tm2 = 0;
 	u32 l, h;
 
+	if ((c == &boot_cpu_data) && intel_thermal_supported(c))
+		lvtthmr_init = apic_read(APIC_LVTTHMR);
+
 	if (!intel_thermal_supported(c))
 		return;
 
