Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DB92CAA7A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Dec 2020 19:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbgLASGh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Dec 2020 13:06:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56990 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731200AbgLASGg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Dec 2020 13:06:36 -0500
Date:   Tue, 01 Dec 2020 18:05:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606845955;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b5EDvSPHvskDxUgyAC2Rw9tH9IB/qoZKyzedWH6Khf4=;
        b=LIOLsPOCe9NY2Uh9MOrAVLaomZ6jEh4/CxMavZ9RIe419hqua+xkX7Aw+mT8AcZwJx7wEd
        dLMLavo867OG9AnF+NwTZ/R/RZCiJQAg8+9Xi0MsU+DFFO4jDQDqgIMcKyTGi373SqsWcU
        onl1ErA78rqNRwZwugN2BHtTuA9OADeNwoB7yoNfhr7X3OvRksukEs1Fqh8P0pMmw5+bYZ
        7lU1ZJUFocx78eJ1Su7q/5gb+FvMRSkA+9I2RgYkt5K5qb1g7T2/VgNyE/Pf24wQ81rtMk
        VwtloacV/bW5c2AwFknRDX2PdBw+obQulwiOaVNwRikArHqCWDNKYQvPeR7JAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606845955;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b5EDvSPHvskDxUgyAC2Rw9tH9IB/qoZKyzedWH6Khf4=;
        b=5BFZps99XGvuzvtdE9oPyA8LlAo9/e7oLAp+X3bZEYFHe8BdOl74wc0yfQVch8uSanpupX
        ByU1N5AbZGQ3CvDg==
From:   "tip-bot2 for Gabriele Paoloni" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Move the mce_panic() call and 'kill_it'
 assignments to the right places
Cc:     Gabriele Paoloni <gabriele.paoloni@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201127161819.3106432-3-gabriele.paoloni@intel.com>
References: <20201127161819.3106432-3-gabriele.paoloni@intel.com>
MIME-Version: 1.0
Message-ID: <160684595453.3364.1024480763721674702.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     e273e6e12ab1db3eb57712bd60655744d0091fa3
Gitweb:        https://git.kernel.org/tip/e273e6e12ab1db3eb57712bd60655744d0091fa3
Author:        Gabriele Paoloni <gabriele.paoloni@intel.com>
AuthorDate:    Fri, 27 Nov 2020 16:18:16 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Dec 2020 18:45:56 +01:00

x86/mce: Move the mce_panic() call and 'kill_it' assignments to the right places

Right now, for local MCEs the machine calls panic(), if needed, right
after lmce is set. For MCE broadcasting, mce_reign() takes care of
calling mce_panic().

Hence:
- improve readability by moving the conditional evaluation of
tolerant up to when kill_it is set first;
- move the mce_panic() call up into the statement where mce_end()
fails.

 [ bp: Massage, remove comment in the mce_end() failure case because it
   is superfluous; use local ptr 'cfg' in both tests. ]

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20201127161819.3106432-3-gabriele.paoloni@intel.com
---
 arch/x86/kernel/cpu/mce/core.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f319bed..ebaa52a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1351,8 +1351,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 * severity is MCE_AR_SEVERITY we have other options.
 	 */
 	if (!(m.mcgstatus & MCG_STATUS_RIPV))
-		kill_it = 1;
-
+		kill_it = (cfg->tolerant == 3) ? 0 : 1;
 	/*
 	 * Check if this MCE is signaled to only this logical processor,
 	 * on Intel, Zhaoxin only.
@@ -1388,6 +1387,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		if (mce_end(order) < 0) {
 			if (!no_way_out)
 				no_way_out = worst >= MCE_PANIC_SEVERITY;
+
+			if (no_way_out && cfg->tolerant < 3)
+				mce_panic("Fatal machine check on current CPU", &m, msg);
 		}
 	} else {
 		/*
@@ -1404,15 +1406,6 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		}
 	}
 
-	/*
-	 * If tolerant is at an insane level we drop requests to kill
-	 * processes and continue even when there is no way out.
-	 */
-	if (cfg->tolerant == 3)
-		kill_it = 0;
-	else if (no_way_out)
-		mce_panic("Fatal machine check on current CPU", &m, msg);
-
 	if (worst > 0)
 		irq_work_queue(&mce_irq_work);
 
