Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92FF22DF89
	for <lists+linux-tip-commits@lfdr.de>; Sun, 26 Jul 2020 15:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgGZNr3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 26 Jul 2020 09:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGZNr3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 26 Jul 2020 09:47:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6442DC0619D2;
        Sun, 26 Jul 2020 06:47:29 -0700 (PDT)
Date:   Sun, 26 Jul 2020 13:47:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595771247;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0UusRXX6ZBg+JpZT7VKxa3JRwmUsiWNyAmwE9dkKIFs=;
        b=omE5bV67oNtnhxcwNi5LGPfrjz9EHzdGfePXH5bxDKzY8nyaIupQlDwEyGF2N5VR/sxssC
        2J3LKLWurIQJpskiY4RWMCq+3ZQnCqMFKW0F3qVNJ0uu5K/3upX1NZWfQGMgl1KQVEg7KE
        Jb3VeX+QM+M9sv5gYmYfM+Jl67nuXSBHcaHUxyMMntFuv9yoesUXAkyUqgj6TqnPs57FDo
        B+Oh1Qedy32MlpkQ9M0h/qkPj5GQDxVd4PhFInG5irw9/K0ro7+xX1KSaKqw71wA4Y7nNL
        CNfBEhsOjIwHAdFff0lDnBHeWQ6IQHFt4MPOJIIaJSsWE/LqxABaPQklviAFXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595771247;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0UusRXX6ZBg+JpZT7VKxa3JRwmUsiWNyAmwE9dkKIFs=;
        b=/MsuYY38uMq5u3CGG60lQKJSfXQfAbTLaFEAsvOQRNGEKUn4Frq0ml6aZnV0AMiFfAzl7x
        Pvj3tVIP0+rKiqDg==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Correct 'noinstr' attributes
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200725091951.744848-3-mingo@kernel.org>
References: <20200725091951.744848-3-mingo@kernel.org>
MIME-Version: 1.0
Message-ID: <159577124646.4006.6619494523685229492.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     aadfc2f957cb470a5a7e52cc41a2fa86e784bcd2
Gitweb:        https://git.kernel.org/tip/aadfc2f957cb470a5a7e52cc41a2fa86e784bcd2
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sat, 25 Jul 2020 11:19:51 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 26 Jul 2020 15:42:20 +02:00

entry: Correct 'noinstr' attributes

The noinstr attribute is to be specified before the return type in the
same way 'inline' is used.

Similar cases were recently fixed for x86 in commit 7f6fa101dfac ("x86:
Correct noinstr qualifiers"), but the generic entry code was based on the
the original version and did not carry the fix over.

Fixes: a5497bab5f72 ("entry: Provide generic interrupt entry/exit code")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200725091951.744848-3-mingo@kernel.org
---
 kernel/entry/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 495f5c0..9852e0d 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -256,7 +256,7 @@ noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 	exit_to_user_mode();
 }
 
-irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs)
+noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 {
 	irqentry_state_t ret = {
 		.exit_rcu = false,
@@ -333,7 +333,7 @@ void irqentry_exit_cond_resched(void)
 	}
 }
 
-void noinstr irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
+noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 {
 	lockdep_assert_irqs_disabled();
 
