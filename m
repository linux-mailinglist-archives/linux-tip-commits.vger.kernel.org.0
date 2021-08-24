Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E331A3F59FD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Aug 2021 10:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbhHXIpp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Aug 2021 04:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbhHXIpo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Aug 2021 04:45:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27388C061757;
        Tue, 24 Aug 2021 01:45:00 -0700 (PDT)
Date:   Tue, 24 Aug 2021 08:44:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629794696;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rrFaOxYVVG7V2TCw0YOncQAAUO9yzBIGwqHSLqakzr8=;
        b=RcVMOQXHQRDqJD+V8wE8YNs72fgPoB1nIxoHgSeKjdMuOw+iwLEFx1pmGlpIqu3hZMC7sU
        aconNc9aOHo+IZeNiq7us3DmBvYS85O4U82Q7EaQXLIiVazFhl74l/IWdsTI4b6YmbBBFC
        4ghk+q7c3Vbmy5hJ5PxFeOj+pojsdMXAa49SsFxFeI8k4pSzhz044dPRoBlLvR7QaJ46gF
        XJBSBIOR3blp1MO+FaoRDhnXMgwoJ58vGv0984DQxzLRPb4AfmSsUXGF266BBBXrvJGOLO
        8EMLc5FLCduzU2Cc+qKFiIAxvKlQxRYDyBxZveuS9qk2QrjAJhG1dYqSknz5bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629794696;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rrFaOxYVVG7V2TCw0YOncQAAUO9yzBIGwqHSLqakzr8=;
        b=Zf/olNzxZdbu4K8KRi+ApQ4YTEuk6V07NUqkcYyfmHqgPLUOTKW9Kich2Eb4ueVCM+pfHc
        4d27qJkL/Tp4AeAg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Defer processing of early errors
Cc:     Sumanth Kamatala <skamatala@juniper.net>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210824003129.GA1642753@agluck-desk2.amr.corp.intel.com>
References: <20210824003129.GA1642753@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Message-ID: <162979469521.25758.12563962635907560846.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     3bff147b187d5dfccfca1ee231b0761a89f1eff5
Gitweb:        https://git.kernel.org/tip/3bff147b187d5dfccfca1ee231b0761a89f1eff5
Author:        Borislav Petkov <bp@alien8.de>
AuthorDate:    Mon, 23 Aug 2021 17:31:29 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Aug 2021 10:40:58 +02:00

x86/mce: Defer processing of early errors

When a fatal machine check results in a system reset, Linux does not
clear the error(s) from machine check bank(s) - hardware preserves the
machine check banks across a warm reset.

During initialization of the kernel after the reboot, Linux reads, logs,
and clears all machine check banks.

But there is a problem. In:

  5de97c9f6d85 ("x86/mce: Factor out and deprecate the /dev/mcelog driver")

the call to mce_register_decode_chain() moved later in the boot
sequence. This means that /dev/mcelog doesn't see those early error
logs.

This was partially fixed by:

  cd9c57cad3fe ("x86/MCE: Dump MCE to dmesg if no consumers")

which made sure that the logs were not lost completely by printing
to the console. But parsing console logs is error prone. Users of
/dev/mcelog should expect to find any early errors logged to standard
places.

Add a new flag MCP_QUEUE_LOG to machine_check_poll() to be used in early
machine check initialization to indicate that any errors found should
just be queued to genpool. When mcheck_late_init() is called it will
call mce_schedule_work() to actually log and flush any errors queued in
the genpool.

 [ Based on an original patch, commit message by and completely
   productized by Tony Luck. ]

Fixes: 5de97c9f6d85 ("x86/mce: Factor out and deprecate the /dev/mcelog driver")
Reported-by: Sumanth Kamatala <skamatala@juniper.net>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210824003129.GA1642753@agluck-desk2.amr.corp.intel.com
---
 arch/x86/include/asm/mce.h     |  1 +
 arch/x86/kernel/cpu/mce/core.c | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 0607ec4..da93215 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -265,6 +265,7 @@ enum mcp_flags {
 	MCP_TIMESTAMP	= BIT(0),	/* log time stamp */
 	MCP_UC		= BIT(1),	/* log uncorrected errors */
 	MCP_DONTLOG	= BIT(2),	/* only clear, don't log */
+	MCP_QUEUE_LOG	= BIT(3),	/* only queue to genpool */
 };
 bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 22791aa..8cb7816 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -817,7 +817,10 @@ log_it:
 		if (mca_cfg.dont_log_ce && !mce_usable_address(&m))
 			goto clear_it;
 
-		mce_log(&m);
+		if (flags & MCP_QUEUE_LOG)
+			mce_gen_pool_add(&m);
+		else
+			mce_log(&m);
 
 clear_it:
 		/*
@@ -1639,10 +1642,12 @@ static void __mcheck_cpu_init_generic(void)
 		m_fl = MCP_DONTLOG;
 
 	/*
-	 * Log the machine checks left over from the previous reset.
+	 * Log the machine checks left over from the previous reset. Log them
+	 * only, do not start processing them. That will happen in mcheck_late_init()
+	 * when all consumers have been registered on the notifier chain.
 	 */
 	bitmap_fill(all_banks, MAX_NR_BANKS);
-	machine_check_poll(MCP_UC | m_fl, &all_banks);
+	machine_check_poll(MCP_UC | MCP_QUEUE_LOG | m_fl, &all_banks);
 
 	cr4_set_bits(X86_CR4_MCE);
 
