Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD0D3B039A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jun 2021 14:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhFVMGF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 22 Jun 2021 08:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbhFVMF5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 22 Jun 2021 08:05:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBEBC061760;
        Tue, 22 Jun 2021 05:03:41 -0700 (PDT)
Date:   Tue, 22 Jun 2021 12:03:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624363419;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CxTdZHHmkkvx5PGEN7CF2kt4kMcd+oxgO0fW89SvJ2U=;
        b=qMGwF+3e7cQalwJhyNm6tGKNldQxGcUc54p4rSv7WxABN6ST7P5yzgSJdj+6yrzX854kPu
        53PmUUjaaPlZ+n7rwEUZpyMYrfvvADH11DRqAzXt/AT53btZ2ruBIhybkrc7S7KnkFRpc1
        6cK0J9TibVnxmkALv60gsy6K/A5r3aaFzWQCWsMLobd2Hhq4m1HyfTm7XZVloc/2UvBUYv
        EWFIvJvRW+QGNOxunNdvIRGtbgU3GbmG9evqRz3VK9XcawWfuIwPJgDhmROikSjGutDh8q
        eS5NAxK8F/u63V3A5u4kofYxGtaskTutFnMm3RU9c0x8Rwd7gMH01pneehyooA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624363419;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CxTdZHHmkkvx5PGEN7CF2kt4kMcd+oxgO0fW89SvJ2U=;
        b=ezfGE1FKIUo9qmTXinE5NDkENF2UBO/+/vquPTL5Xw+zxzH5ydPwdWEoHY1O7x9RdgUnFn
        SdboGjN/3HmHZGDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] x86/xen: Fix noinstr fail in xen_pv_evtchn_do_upcall()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210621120120.532960208@infradead.org>
References: <20210621120120.532960208@infradead.org>
MIME-Version: 1.0
Message-ID: <162436341919.395.14240496021165433454.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     84e60065df9ef03759115a7e48c04bbc0d292165
Gitweb:        https://git.kernel.org/tip/84e60065df9ef03759115a7e48c04bbc0d292165
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 21 Jun 2021 13:12:35 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Jun 2021 13:56:42 +02:00

x86/xen: Fix noinstr fail in xen_pv_evtchn_do_upcall()

Fix:

  vmlinux.o: warning: objtool: xen_pv_evtchn_do_upcall()+0x23: call to irq_enter_rcu() leaves .noinstr.text section

Fixes: 359f01d1816f ("x86/entry: Use run_sysvec_on_irqstack_cond() for XEN upcall")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210621120120.532960208@infradead.org
---
 arch/x86/entry/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index a6bf516..04bce95 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -269,15 +269,16 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 	irqentry_state_t state = irqentry_enter(regs);
 	bool inhcall;
 
+	instrumentation_begin();
 	run_sysvec_on_irqstack_cond(__xen_pv_evtchn_do_upcall, regs);
 
 	inhcall = get_and_clear_inhcall();
 	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
-		instrumentation_begin();
 		irqentry_exit_cond_resched();
 		instrumentation_end();
 		restore_inhcall(inhcall);
 	} else {
+		instrumentation_end();
 		irqentry_exit(regs, state);
 	}
 }
