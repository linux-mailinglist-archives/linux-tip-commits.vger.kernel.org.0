Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDF135CFC7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Apr 2021 19:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243300AbhDLRtV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 12 Apr 2021 13:49:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40704 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238145AbhDLRtV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 12 Apr 2021 13:49:21 -0400
Date:   Mon, 12 Apr 2021 17:48:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618249741;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EgHC46tfyol7OQrQeY7G9ik6yWtC2dKCb/lnBOMVffQ=;
        b=a9gS0M+CzwcUWv2mRu5SCNaIOPv2PqEsXVysB+cFr1UNoIis1Lm1uBKXlWC31sBOK41SrF
        FMv2I2B37QzfmK4GDMjXGT2wCIyo46srNqcAbY9+hXU8HmGKX6UI2Akz0dNepdpZGL8HvY
        Z/EN9WH2nSBLuyRmo2NkEKgkjOfHHSAjIyI2HBJjDcAOl+EDvcvGkxrfNOijwBi8806hy2
        K78XSskebHTSaTzAOU9DFOuWMTav692QS4SHN0uIdU498GW/hjxLtcK7L4RejGV9/2viqG
        HhkVgoW5e1fs0MhgK9kqtgdGx9766mBwNXJq+D2mISzT//fpTNsszorvnCYfWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618249741;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EgHC46tfyol7OQrQeY7G9ik6yWtC2dKCb/lnBOMVffQ=;
        b=UKG4MAuYY6VxKAHTUIf5AiJ5iDFvwIQhya6NksGBRZjCTG3wAEG9SM4sb8Iwho9Dxys9da
        Qm33JmC/PsnOhHCA==
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
Message-ID: <161824973989.29796.1475506377197380962.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     8f2aca40dd077f74e62982cd2669845f41ed0ac6
Gitweb:        https://git.kernel.org/tip/8f2aca40dd077f74e62982cd2669845f41ed0ac6
Author:        Georges Aureau <georges.aureau@hpe.com>
AuthorDate:    Thu, 11 Mar 2021 09:10:28 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 12 Apr 2021 19:42:10 +02:00

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
