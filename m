Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD26288F6A
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 19:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390006AbgJIRBn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 13:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389969AbgJIRBb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 13:01:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8F9C0613D6;
        Fri,  9 Oct 2020 10:01:30 -0700 (PDT)
Date:   Fri, 09 Oct 2020 17:01:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602262889;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XzG/VJ/wBWTfygtSwUZc9phblyLmB/v5SKSJmnX8If0=;
        b=h94zFaTntDV+9efccfKEKpBgmuqHL84T8XPc2eJLgpVnsPPrKEzMdS0ELHl5R8pb6Z/pt2
        9a0mDbUvTbfve+zzF6vfcP4EtxM/2NQRbSx79EvcPvo5LLm0/N8tXRtjFlUKnkK2fxhSIF
        KGf+wfb5NI3bpnZRj194PO50uPJBl+9SC5sj+byWjRZ+mdawlWNBfETyDu82XohDCAu3WC
        G40XNMf0IuQZVCoSjtTXcfMDjt4rJuNkzZO5c9DeKLws9l44eMzwDDW/PXzA+MAVnP9e2u
        zjQ2UDbeyyjY3AnWH4Zlly4iiw4/m32rU420jTlHDqw0JeCjtHmG4zik7aAnIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602262889;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XzG/VJ/wBWTfygtSwUZc9phblyLmB/v5SKSJmnX8If0=;
        b=rhwITZDpP3xsWlab3rj0ICIHPsQhhQoN2pCNW5U+cGyvCx9t9oVg4aPGz1DFPs7rZuDeIE
        5QKZ8VuVOvRih0Bg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] preempt: Make preempt count unconditional
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160226288864.7002.5923312832863889974.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7681205ba49d8b0dcb3a0f55d97f71e1da93e972
Gitweb:        https://git.kernel.org/tip/7681205ba49d8b0dcb3a0f55d97f71e1da93e972
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Sep 2020 19:18:06 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 28 Sep 2020 16:02:49 -07:00

preempt: Make preempt count unconditional

The handling of preempt_count() is inconsistent across kernel
configurations. On kernels which have PREEMPT_COUNT=n
preempt_disable/enable() and the lock/unlock functions are not affecting
the preempt count, only local_bh_disable/enable() and _bh variants of
locking, soft interrupt delivery, hard interrupt and NMI context affect it.

It's therefore impossible to have a consistent set of checks which provide
information about the context in which a function is called. In many cases
it makes sense to have separate functions for separate contexts, but there
are valid reasons to avoid that and handle different calling contexts
conditionally.

The lack of such indicators which work on all kernel configuratios is a
constant source of trouble because developers either do not understand the
implications or try to work around this inconsistency in weird
ways. Neither seem these issues be catched by reviewers and testing.

Recently merged code does:

	 gfp = preemptible() ? GFP_KERNEL : GFP_ATOMIC;

Looks obviously correct, except for the fact that preemptible() is
unconditionally false for CONFIF_PREEMPT_COUNT=n, i.e. all allocations in
that code use GFP_ATOMIC on such kernels.

Attempts to make preempt count unconditional and consistent have been
rejected in the past with handwaving performance arguments.

Freshly conducted benchmarks did not reveal any measurable impact from
enabling preempt count unconditionally. On kernels with CONFIG_PREEMPT_NONE
or CONFIG_PREEMPT_VOLUNTARY the preempt count is only incremented and
decremented but the result of the decrement is not tested. Contrary to that
enabling CONFIG_PREEMPT which tests the result has a small but measurable
impact due to the conditional branch/call.

It's about time to make essential functionality of the kernel consistent
across the various preemption models.

Enable CONFIG_PREEMPT_COUNT unconditionally. Follow up changes will remove
the #ifdeffery and remove the config option at the end.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/Kconfig.preempt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index bf82259..3f4712f 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -75,8 +75,7 @@ config PREEMPT_RT
 endchoice
 
 config PREEMPT_COUNT
-       bool
+       def_bool y
 
 config PREEMPTION
        bool
-       select PREEMPT_COUNT
