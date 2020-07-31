Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D07723429D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbgGaJXo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:23:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56642 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732533AbgGaJXm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:42 -0400
Date:   Fri, 31 Jul 2020 09:23:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187421;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9qWS5pWhc3a8udLuVtW5FvcOUvcP3JoDnfC2vjPUg2s=;
        b=iisX2wSomoWY30p4MJohASt8XHWIcDBLHKeqnhfKKR40OmCif3IewpmsudbjKsdKD/AEkl
        eRdht/THXFIlh8zp3Z7wKJMMqP0uEdRi5Q1tVrIvaStwC+e1NmRzvFQBD+QDqGU8+TJ6RQ
        r6zBRaQIDfXTuZMp0CPMRcgLauZafEMvq/m7SkYqkt7p+TaqfR3rRk8Rr15I/YF/16KSwF
        6/r8Pw8u9A2QA2s/q1/qiaHrvAmV1Llm7MAHxCuDmXuvqt3ufzzrmXiEWjOrCH7YXdAIJm
        +3/gKfaC1Cc0i/97bNUDGUGP+a96b3bOonYG7qGtGmFlnLY4h2P3Dsg9pnK7lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187421;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9qWS5pWhc3a8udLuVtW5FvcOUvcP3JoDnfC2vjPUg2s=;
        b=5JiSe5PmX3etTai278Y9V4e7hkNhHmp4hZtEyk0CTxaezR8gpMpcY2QSJxpY7/Ezf0KJMO
        roStEkG+xhU0naDQ==
From:   "tip-bot2 for Wei Yang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Initialize and destroy rcu_synchronize only when
 necessary
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618742069.4006.16122222312681884202.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7ee880b7bf1dea88d0a472b775aebdb4fb6bf860
Gitweb:        https://git.kernel.org/tip/7ee880b7bf1dea88d0a472b775aebdb4fb6bf860
Author:        Wei Yang <richard.weiyang@gmail.com>
AuthorDate:    Wed, 15 Apr 2020 22:26:55 
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:58:49 -07:00

rcu: Initialize and destroy rcu_synchronize only when necessary

The __wait_rcu_gp() function unconditionally initializes and cleans up
each element of rs_array[], whether used or not.  This is slightly
wasteful and rather confusing, so this commit skips both initialization
and cleanup for duplicate callback functions.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 84843ad..f5a82e1 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -390,13 +390,14 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 			might_sleep();
 			continue;
 		}
-		init_rcu_head_on_stack(&rs_array[i].head);
-		init_completion(&rs_array[i].completion);
 		for (j = 0; j < i; j++)
 			if (crcu_array[j] == crcu_array[i])
 				break;
-		if (j == i)
+		if (j == i) {
+			init_rcu_head_on_stack(&rs_array[i].head);
+			init_completion(&rs_array[i].completion);
 			(crcu_array[i])(&rs_array[i].head, wakeme_after_rcu);
+		}
 	}
 
 	/* Wait for all callbacks to be invoked. */
@@ -407,9 +408,10 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 		for (j = 0; j < i; j++)
 			if (crcu_array[j] == crcu_array[i])
 				break;
-		if (j == i)
+		if (j == i) {
 			wait_for_completion(&rs_array[i].completion);
-		destroy_rcu_head_on_stack(&rs_array[i].head);
+			destroy_rcu_head_on_stack(&rs_array[i].head);
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(__wait_rcu_gp);
