Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930F12CD23B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 10:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbgLCJOD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 04:14:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39464 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgLCJOC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 04:14:02 -0500
Date:   Thu, 03 Dec 2020 09:13:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606986800;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rzWn3uEdMEDvvpHEeHD+v3yXwwyQZIPn9+plbZteZLk=;
        b=YWimje4KSOOnJNlnpzrqboeC8Y1+pHHgeK3xm87bjvmzSplUd/hoNUQBi1LRFRTY6R5LKM
        WsQe3qchcl5TlCFexy6jXqLcqLK+qfGGwWMeB6cWO4v3zzLpcj1ZIVgTNGarTb6X5hWQgA
        aTDIk6gRGw+S+89of6enA07bT7FsEhVGkWzuFnQf9IfDQgr4UwBmBek5cmGhsGpcg0WY7J
        X3LhbFBSueAxvsuUKK4++XcMDVCACG6jO//3aE1yB2RGdR87dsMoVn1uMgQFoZ08z6heMB
        S4QTxUXjXRe2xZ9ulrbwKWFvLS1kgWpwkEFhpw61Nnf53XvJN3/CSM67eYqgdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606986800;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rzWn3uEdMEDvvpHEeHD+v3yXwwyQZIPn9+plbZteZLk=;
        b=U4Pnmo+n/5ITAsuq72Yq3Ava4loEsvYNfLzkuRJJObH6lYjb7XZE9P3OMdkk2wFpcWsoQA
        57lkbktOhuZhw1BQ==
From:   "tip-bot2 for Barry Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Trivial correction of the
 newidle_balance() comment
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201202220641.22752-1-song.bao.hua@hisilicon.com>
References: <20201202220641.22752-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Message-ID: <160698680003.3364.8425205570764425010.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     21bf7cbd1b100758cc82f5340576028d3d83119b
Gitweb:        https://git.kernel.org/tip/21bf7cbd1b100758cc82f5340576028d3d83119b
Author:        Barry Song <song.bao.hua@hisilicon.com>
AuthorDate:    Thu, 03 Dec 2020 11:06:41 +13:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Dec 2020 10:00:36 +01:00

sched/fair: Trivial correction of the newidle_balance() comment

idle_balance() has been renamed to newidle_balance(). To differentiate
with nohz_idle_balance, it seems refining the comment will be helpful
for the readers of the code.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201202220641.22752-1-song.bao.hua@hisilicon.com
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index efac224..04a3ce2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10550,7 +10550,7 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
 #endif /* CONFIG_NO_HZ_COMMON */
 
 /*
- * idle_balance is called by schedule() if this_cpu is about to become
+ * newidle_balance is called by schedule() if this_cpu is about to become
  * idle. Attempts to pull tasks from other CPUs.
  *
  * Returns:
