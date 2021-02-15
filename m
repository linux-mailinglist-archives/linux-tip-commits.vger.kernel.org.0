Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BFC31BB9A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhBOO5M (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhBOO5H (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:57:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2DBC0617AA;
        Mon, 15 Feb 2021 06:55:48 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:55:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400946;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=t62MexzwjP8aJxEiWC7oSt1uQO1gMxlt1PcCTuC2dCY=;
        b=WrRBIHKgnhASeCsvdLdWDg2eFjdc7W31A0WfiqdBb8n/IrB5o7s/PcihvE9thJDFgs6PE6
        +e8aGVBi3gnZsj23NvEFtdqaLLs83IIw3nWeuiEkQh9HlLOmZEFYzsn6pQ21vWhCZ3Z1Sy
        yo43pQ4Hfv+wSm6eS3jIrEbvXlVBQPzGZyu8eFKmxZKqh55X0ezIYNkczarTDn3n5aIAU9
        Q+5wZlqJW2+2wGRoZZup9h5JtvCS2/S81hmyn9WTOuX94+smg/Jj96BhT5rsHNis64rz9+
        XwAtOrdDkjn0VSemGdyb/XMc/6Lyl41XxHgZJ9EpRu49mTwPYCHk+QKPu6yB4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400946;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=t62MexzwjP8aJxEiWC7oSt1uQO1gMxlt1PcCTuC2dCY=;
        b=GoN5YyCoh57Y4fhzGNnXCKIvdnOl9nlobXFbD7XIjB0GNAQ6GepH3ooVDXEItrblZZtTN7
        f37eCWu3A8O8Y7AQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Make RCU_BOOST default on CONFIG_PREEMPT_RT
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094648.20312.9982784477144874498.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     2341bc4a0311e4319ced6c2828bb19309dee74fd
Gitweb:        https://git.kernel.org/tip/2341bc4a0311e4319ced6c2828bb19309dee74fd
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 15 Dec 2020 15:16:45 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:43:50 -08:00

rcu: Make RCU_BOOST default on CONFIG_PREEMPT_RT

On PREEMPT_RT kernels, RCU callbacks are deferred to the `rcuc' kthread.
This can stall RCU grace periods due to lengthy preemption not only of RCU
readers but also of 'rcuc' kthreads, either of which prevent grace periods
from completing, which can in turn result in OOM.  Because PREEMPT_RT
kernels have more kthreads that can block grace periods, it is more
important for such kernels to enable RCU_BOOST.

This commit therefore makes RCU_BOOST the default on PREEMPT_RT.
RCU_BOOST can still be manually disabled if need be.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index cdc57b4..aa8cc8c 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -188,8 +188,8 @@ config RCU_FAST_NO_HZ
 
 config RCU_BOOST
 	bool "Enable RCU priority boosting"
-	depends on RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT
-	default n
+	depends on (RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT) || PREEMPT_RT
+	default y if PREEMPT_RT
 	help
 	  This option boosts the priority of preempted RCU readers that
 	  block the current preemptible RCU grace period for too long.
