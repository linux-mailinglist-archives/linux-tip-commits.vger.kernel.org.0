Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5502F3CD9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Jan 2021 01:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436869AbhALVhV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 Jan 2021 16:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436754AbhALUMy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 Jan 2021 15:12:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F716C061786;
        Tue, 12 Jan 2021 12:12:14 -0800 (PST)
Date:   Tue, 12 Jan 2021 20:12:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610482332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ysm0lcjeQTEkYz8ldt/BGUvyfBNrhwwAE0TSWDrsAg=;
        b=b/QOJYX9jipp+RvVUL9F69+mF0SixwHAJtVqBFa+y4Pf+Vgf2RIVNhs/akG0euEWclgDb9
        LDPxOexRbcxzoMlkjIbEvJZDMBIXLk4ZQ15BJvybCxdpD8phJiMyuhQTNLMTjzPFM5yHPu
        C5KhseO8qGvFf+/IyUkN4efkAUKbh+7ZAITWrOuT6arO9lbQV6oMuyIAnzd1LpXU8i25+w
        UlCIBq5a9mE1+8a7hqaB/pqnJjgEjjXI2+QLgAseVSi/rKGvf4LEmMq9IMDAI/WNyui05Q
        6OWHWIaLhRwnruBI56sdLwX1Ig9sBlqnRTW1E+tvtkhcSPEJfIny/3B/trhtMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610482332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ysm0lcjeQTEkYz8ldt/BGUvyfBNrhwwAE0TSWDrsAg=;
        b=V/RWMpJ257tOrChaV6Eg6B23iKnod1D4dnqL7LslEESZqfc6C9F7F0574uzVwMSuGINfFZ
        NZXir12naUXkCqDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mce: Remove explicit/superfluous tracing
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210106144017.719310466@infradead.org>
References: <20210106144017.719310466@infradead.org>
MIME-Version: 1.0
Message-ID: <161048232974.414.12478202427962876073.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     737495361d4469477ffe45d51e6fc56f44f3cc6a
Gitweb:        https://git.kernel.org/tip/737495361d4469477ffe45d51e6fc56f44f3cc6a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 06 Jan 2021 15:36:24 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Jan 2021 21:10:59 +01:00

x86/mce: Remove explicit/superfluous tracing

There's some explicit tracing left in exc_machine_check_kernel(),
remove it, as it's already implied by irqentry_nmi_enter().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210106144017.719310466@infradead.org

---
 arch/x86/kernel/cpu/mce/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 13d3f1c..e133ce1 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1992,10 +1992,9 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 	 * that out because it's an indirect call. Annotate it.
 	 */
 	instrumentation_begin();
-	trace_hardirqs_off_finish();
+
 	machine_check_vector(regs);
-	if (regs->flags & X86_EFLAGS_IF)
-		trace_hardirqs_on_prepare();
+
 	instrumentation_end();
 	irqentry_nmi_exit(regs, irq_state);
 }
@@ -2004,7 +2003,9 @@ static __always_inline void exc_machine_check_user(struct pt_regs *regs)
 {
 	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
+
 	machine_check_vector(regs);
+
 	instrumentation_end();
 	irqentry_exit_to_user_mode(regs);
 }
