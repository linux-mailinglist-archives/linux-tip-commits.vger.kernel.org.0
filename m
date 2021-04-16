Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980F2361E55
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 12:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbhDPK5P (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 06:57:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56582 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242587AbhDPK5O (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 06:57:14 -0400
Date:   Fri, 16 Apr 2021 10:56:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618570608;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Omz5ck/URBcM76S6VasAW3N7mYXTb4rIsXZtaBctFc=;
        b=Nwydxrf0aMz6n4L4DDB8UDrtlO7vKD5s83RTE2Hvfsps039gCOHsIldLpIUhZiGNlrMqoe
        1YCfbAZ/RGQZuufYX7qN0QeePUQ3cVqsWPOVmEQSNSgdd3Lpl6gQKqP89RAgVb+l+Kc25b
        Cn0B2YUxkkUDJ7V2zOO60CfUbTwTyXVgQum6u1uoIlhZUAOCZco4Sarffpoqa5xQwUC0Vk
        ZsY7BSy4J61mwsSaoNIIWjmE4yLJAmE3G2w2Fl+TjNz364UlFkvc1Qye04tTTyo/8TzyGT
        bcQYuBfOVog51A5+URZAXHlrMZnIipmzMl43g9scQ+Q2BUZ/tZdmS9vKo8SaJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618570608;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Omz5ck/URBcM76S6VasAW3N7mYXTb4rIsXZtaBctFc=;
        b=LSe5SrfTmEuw4xSke9yyOYEXukDCdXdg19PQ/QY8TW5T6tbtYmhzr8oi8yRJcdb6hrjWoE
        CdjC4AqB67QY+5Ag==
From:   "tip-bot2 for Georges Aureau" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Add more to secondary CPU kdump info
Cc:     Georges Aureau <georges.aureau@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Borislav Petkov <bp@suse.de>, Steve Wahl <steve.wahl@hpe.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210311151028.82678-1-mike.travis@hpe.com>
References: <20210311151028.82678-1-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <161857060713.29796.14147227157228896800.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     0b45143b4b9440579e7fa889708cfc4bc7fdb9a3
Gitweb:        https://git.kernel.org/tip/0b45143b4b9440579e7fa889708cfc4bc7fdb9a3
Author:        Georges Aureau <georges.aureau@hpe.com>
AuthorDate:    Thu, 11 Mar 2021 09:10:28 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 16 Apr 2021 12:51:41 +02:00

x86/platform/uv: Add more to secondary CPU kdump info

Add call to run_crash_ipi_callback() to gather more info of what the
secondary CPUs were doing to help with failure analysis.

Excerpt from Georges:

'It is only changing where crash secondaries will be stalling after
having taken care of properly laying down "crash note regs". Please
note that "crash note regs" are a key piece of data used by crash dump
debuggers to provide a reliable backtrace of running processors.'

Secondary change pursuant to

  a5f526ecb075 ("CodingStyle: Inclusive Terminology"):

change master/slave to main/secondary.

 [ bp: Massage commit message. ]

Signed-off-by: Georges Aureau <georges.aureau@hpe.com>
Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lkml.kernel.org/r/20210311151028.82678-1-mike.travis@hpe.com
---
 arch/x86/platform/uv/uv_nmi.c | 39 ++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index eafc530..f83810f 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -24,6 +24,7 @@
 #include <asm/kdebug.h>
 #include <asm/local64.h>
 #include <asm/nmi.h>
+#include <asm/reboot.h>
 #include <asm/traps.h>
 #include <asm/uv/uv.h>
 #include <asm/uv/uv_hub.h>
@@ -834,34 +835,42 @@ static void uv_nmi_touch_watchdogs(void)
 	touch_nmi_watchdog();
 }
 
-static atomic_t uv_nmi_kexec_failed;
-
 #if defined(CONFIG_KEXEC_CORE)
-static void uv_nmi_kdump(int cpu, int master, struct pt_regs *regs)
+static atomic_t uv_nmi_kexec_failed;
+static void uv_nmi_kdump(int cpu, int main, struct pt_regs *regs)
 {
+	/* Check if kdump kernel loaded for both main and secondary CPUs */
+	if (!kexec_crash_image) {
+		if (main)
+			pr_err("UV: NMI error: kdump kernel not loaded\n");
+		return;
+	}
+
 	/* Call crash to dump system state */
-	if (master) {
+	if (main) {
 		pr_emerg("UV: NMI executing crash_kexec on CPU%d\n", cpu);
 		crash_kexec(regs);
 
-		pr_emerg("UV: crash_kexec unexpectedly returned, ");
+		pr_emerg("UV: crash_kexec unexpectedly returned\n");
 		atomic_set(&uv_nmi_kexec_failed, 1);
-		if (!kexec_crash_image) {
-			pr_cont("crash kernel not loaded\n");
-			return;
+
+	} else { /* secondary */
+
+		/* If kdump kernel fails, secondaries will exit this loop */
+		while (atomic_read(&uv_nmi_kexec_failed) == 0) {
+
+			/* Once shootdown cpus starts, they do not return */
+			run_crash_ipi_callback(regs);
+
+			mdelay(10);
 		}
-		pr_cont("kexec busy, stalling cpus while waiting\n");
 	}
-
-	/* If crash exec fails the slaves should return, otherwise stall */
-	while (atomic_read(&uv_nmi_kexec_failed) == 0)
-		mdelay(10);
 }
 
 #else /* !CONFIG_KEXEC_CORE */
-static inline void uv_nmi_kdump(int cpu, int master, struct pt_regs *regs)
+static inline void uv_nmi_kdump(int cpu, int main, struct pt_regs *regs)
 {
-	if (master)
+	if (main)
 		pr_err("UV: NMI kdump: KEXEC not supported in this kernel\n");
 	atomic_set(&uv_nmi_kexec_failed, 1);
 }
