Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573473182C4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Feb 2021 01:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhBKAv0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 19:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhBKAvO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 19:51:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030A0C06178A;
        Wed, 10 Feb 2021 16:50:28 -0800 (PST)
Date:   Thu, 11 Feb 2021 00:50:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613004625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q3nBlPR6td5OpMB4NLRSe/4anBUASNZ+WxTcmk6iUgk=;
        b=h2Lcw1BLW06b9AgNmFSlp2LmVJsA+laKXcbtS7cqRY++iDoLkOOYpsG4uvOPaeOhiCWxgR
        nBV8oFwyhRrxDfC7vMXMI7pUeKlRAerbdminTN1R121ePxlm7vrkndaJFuZsjzsWbo6cU4
        DI53oJDNCWKxyaqWCh4vwKge6iW1ONAlPmdQsC+bjwU3eZ6GnmJHoDMresBkrRR8/unr5Z
        WHUkjIh/FopO1WxjAkpGqga+1kH0y6c2kXidVT8DYOpWxqIiR7mR0mCelAq21JBFpUMucb
        pxZNv2qkzSwDWq3TEdtzjlk6yBg0NMM8nfWohw1Igp+dEROsyCAoAkDm8MIW2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613004625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q3nBlPR6td5OpMB4NLRSe/4anBUASNZ+WxTcmk6iUgk=;
        b=0R3oZsX9v88x+byhXuetXDp+T08+Rs577sQ5h89fQ8J7D48tJkSY+oxVP8QBSdHy8ICZMf
        q3xqM+u+G2pgiPCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Use run_sysvec_on_irqstack_cond() for XEN upcall
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210210002512.869753106@linutronix.de>
References: <20210210002512.869753106@linutronix.de>
MIME-Version: 1.0
Message-ID: <161300462512.23325.10628839019834903861.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     359f01d1816fc1ea0161e6c30722bef1ed6b8abb
Gitweb:        https://git.kernel.org/tip/359f01d1816fc1ea0161e6c30722bef1ed6b8abb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 10 Feb 2021 00:40:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Feb 2021 23:34:15 +01:00

x86/entry: Use run_sysvec_on_irqstack_cond() for XEN upcall

To avoid yet another macro implementation reuse the existing
run_sysvec_on_irqstack_cond() and move the set_irq_regs() handling into the
called function. Makes the code even simpler.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20210210002512.869753106@linutronix.de


---
 arch/x86/entry/common.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index c4efffb..60a5fc4 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -245,30 +245,23 @@ static __always_inline bool get_and_clear_inhcall(void) { return false; }
 static __always_inline void restore_inhcall(bool inhcall) { }
 #endif
 
-static void __xen_pv_evtchn_do_upcall(void)
+static void __xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 {
-	irq_enter_rcu();
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
 	inc_irq_stat(irq_hv_callback_count);
 
 	xen_hvm_evtchn_do_upcall();
 
-	irq_exit_rcu();
+	set_irq_regs(old_regs);
 }
 
 __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 {
-	struct pt_regs *old_regs;
+	irqentry_state_t state = irqentry_enter(regs);
 	bool inhcall;
-	irqentry_state_t state;
 
-	state = irqentry_enter(regs);
-	old_regs = set_irq_regs(regs);
-
-	instrumentation_begin();
-	run_on_irqstack_cond(__xen_pv_evtchn_do_upcall, regs);
-	instrumentation_end();
-
-	set_irq_regs(old_regs);
+	run_sysvec_on_irqstack_cond(__xen_pv_evtchn_do_upcall, regs);
 
 	inhcall = get_and_clear_inhcall();
 	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
