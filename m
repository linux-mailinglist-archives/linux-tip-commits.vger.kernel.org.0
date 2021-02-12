Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A85319E86
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhBLMiR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:38:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhBLMhu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:37:50 -0500
Date:   Fri, 12 Feb 2021 12:37:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133428;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vY/e82WGKoPUQuuTNsF04/iQp5vjAKpRf/dqex5dxk4=;
        b=Em0icHuSrizLKAP4FdUXkHpvXZ52K/LuktDJ2M9jDW5/P7XB7JdAQVRXI0A8wm9+31aOw/
        tc/f9f7CiBOA2ZD4FdzmiN7NH9/8b0bB/CU15GADF5R74xtaqqsPoLhGeN8HufPJ3H7EIp
        ikwrUEsj0AREgie/4ZaIAoPwQQxzI2iU+AaUUsxBvQNKc5GCwx6I7fuSxYQzgKkXTE4wng
        3BUqp7h+A2LhD/2HQA7RvfyswTTvg1R0qaTQJ9PU2gl4etxY6hM6HuP1TtMEaUYNN7Fj79
        RV+YqD/CLEnKXLfgGfNjyuK/Wwf+TZEM5bt+hZ/kdpJCocZt009F1NfvHqEhLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133428;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vY/e82WGKoPUQuuTNsF04/iQp5vjAKpRf/dqex5dxk4=;
        b=7mIcEGS6jOGyz0geu9sMinP3MN5O7e/YhNb/pa7SMaMACeFTTokAGB1SXCuyCKlZzb13MX
        VAJUjGFnMMSrydCg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Make object_debug also double call_rcu()
 heap object
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313342817.23325.17377846139760645930.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     edf7b8417834c89d00ef88355ea507b0b0a630ae
Gitweb:        https://git.kernel.org/tip/edf7b8417834c89d00ef88355ea507b0b0a630ae
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 02 Dec 2020 17:52:07 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:17:21 -08:00

rcutorture: Make object_debug also double call_rcu() heap object

This commit provides a test for call_rcu() printing the allocation address
of a double-freed callback by double-freeing a callback allocated via
kmalloc().  However, this commit does not depend on any other commit.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 007595d..76c8386 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2782,6 +2782,7 @@ static void rcu_test_debug_objects(void)
 #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
 	struct rcu_head rh1;
 	struct rcu_head rh2;
+	struct rcu_head *rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
 
 	init_rcu_head_on_stack(&rh1);
 	init_rcu_head_on_stack(&rh2);
@@ -2794,6 +2795,10 @@ static void rcu_test_debug_objects(void)
 	local_irq_disable(); /* Make it harder to start a new grace period. */
 	call_rcu(&rh2, rcu_torture_leak_cb);
 	call_rcu(&rh2, rcu_torture_err_cb); /* Duplicate callback. */
+	if (rhp) {
+		call_rcu(rhp, rcu_torture_leak_cb);
+		call_rcu(rhp, rcu_torture_err_cb); /* Another duplicate callback. */
+	}
 	local_irq_enable();
 	rcu_read_unlock();
 	preempt_enable();
