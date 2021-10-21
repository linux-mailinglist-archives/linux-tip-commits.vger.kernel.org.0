Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE6B436890
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 19:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhJURDd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 13:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbhJURDc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 13:03:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFECC061764;
        Thu, 21 Oct 2021 10:01:16 -0700 (PDT)
Date:   Thu, 21 Oct 2021 17:01:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634835674;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y4KXP+7kFTsp1r9qgHCtI86+ZPr0zgBW2ptc8Svkzdo=;
        b=HDFZ1Mg+hcenYEB3lpwCnWAEZH/uqnyvSbiqmjiDyVtiysNtQY/WiOkUnaR67Xq6fzwnMX
        7avnUddrKLxJglYB9FZ63wX4r7MDflLd1F2XdiheQ84kqxApf7Sp8Wp3bThw2BvtHgw9ky
        S9x8HxATzaoTH606eMbKGqEzSVdRdhB2lG3Q/VR1CvcQagIM4PnPoG1yKO6X+Xo7/ZRPX1
        0EabjqAEc2/Z5pTPDGaE40AnbqEnK//dCn/Sfm8m4o06gytGbrAJkXkxsEEj4psmY2SrQD
        n9FXkgxPt4Jko0FIeVuddczFiXHwKuBdRniTuLru92SE22FmHfD3jNSwl4mKDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634835674;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y4KXP+7kFTsp1r9qgHCtI86+ZPr0zgBW2ptc8Svkzdo=;
        b=dpdf9wT+xvVaQHUgZt45mRJBy03eHpdykf2IEMt+i+PMHk9DQfpiwn69DjZMOuXh9SLzor
        jXQk1HtX4Am5/TDg==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Allow #VC exceptions on the VC2 stack
Cc:     Xinyang Ge <xing@microsoft.com>, Joerg Roedel <jroedel@suse.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021080833.30875-3-joro@8bytes.org>
References: <20211021080833.30875-3-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <163483567370.25758.13898594300411975356.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     ce47d0c00ff5621ae5825c9d81722b23b0df395e
Gitweb:        https://git.kernel.org/tip/ce47d0c00ff5621ae5825c9d81722b23b0df395e
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Thu, 21 Oct 2021 10:08:33 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Oct 2021 18:29:36 +02:00

x86/sev: Allow #VC exceptions on the VC2 stack

When code running on the VC2 stack causes a nested VC exception, the
handler will not handle it as expected but goes again into the error
path.

The result is that the panic() call happening when the VC exception
was raised in an invalid context is called recursively. Fix this by
checking the interrupted stack too and only call panic if it is not
the VC2 stack.

 [ bp: Fixup comment. ]

Fixes: 0786138c78e79 ("x86/sev-es: Add a Runtime #VC Exception Handler")
Reported-by: Xinyang Ge <xing@microsoft.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211021080833.30875-3-joro@8bytes.org
---
 arch/x86/kernel/sev.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a6895e4..2de1f36 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1319,13 +1319,26 @@ static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt)
 	}
 }
 
-static __always_inline bool on_vc_fallback_stack(struct pt_regs *regs)
+static __always_inline bool is_vc2_stack(unsigned long sp)
 {
-	unsigned long sp = (unsigned long)regs;
-
 	return (sp >= __this_cpu_ist_bottom_va(VC2) && sp < __this_cpu_ist_top_va(VC2));
 }
 
+static __always_inline bool vc_from_invalid_context(struct pt_regs *regs)
+{
+	unsigned long sp, prev_sp;
+
+	sp      = (unsigned long)regs;
+	prev_sp = regs->sp;
+
+	/*
+	 * If the code was already executing on the VC2 stack when the #VC
+	 * happened, let it proceed to the normal handling routine. This way the
+	 * code executing on the VC2 stack can cause #VC exceptions to get handled.
+	 */
+	return is_vc2_stack(sp) && !is_vc2_stack(prev_sp);
+}
+
 static bool vc_raw_handle_exception(struct pt_regs *regs, unsigned long error_code)
 {
 	struct ghcb_state state;
@@ -1406,7 +1419,7 @@ DEFINE_IDTENTRY_VC_KERNEL(exc_vmm_communication)
 	 * But keep this here in case the noinstr annotations are violated due
 	 * to bug elsewhere.
 	 */
-	if (unlikely(on_vc_fallback_stack(regs))) {
+	if (unlikely(vc_from_invalid_context(regs))) {
 		instrumentation_begin();
 		panic("Can't handle #VC exception from unsupported context\n");
 		instrumentation_end();
