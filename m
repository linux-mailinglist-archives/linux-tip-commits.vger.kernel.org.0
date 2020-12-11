Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9612D72E4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Dec 2020 10:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437439AbgLKJfa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 11 Dec 2020 04:35:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33370 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405655AbgLKJfV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 11 Dec 2020 04:35:21 -0500
Date:   Fri, 11 Dec 2020 09:34:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607679278;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gUuQQtK0hH5SjR+STpZ8Xe2W+JkSJ/MYwCfXkMh+Uu4=;
        b=LMGG0uLcpPKQGs/FGS70cy/pWXy1g71Dwkq+IYeccRwkvxmn99pzQ/tR9u+hpE/gORmVnK
        VJCRldk/QWMRXFiWjXYTm/cW7fP/peonH43Dfa4J3Wpe4Iy6xIQymNMVv4jOSPRK7Ja1hV
        gSxV8TPLw8ZXK67xDIjpTWGDmTCbsx5z5IoNaoDygr8nDpAD670QfGZoodGAaprjO8PTIe
        4B8Orch7xo5VDO+MZyQHXaEuy95ZhyaSc1xj2dofw452VlMTwFfBSt28oE7gcI3qmqqd5L
        LaiCvhlFYcH4Q6YTePJhj4rPRIeczI0HClhqimYbRouI6ycsZnTItQiRDy36hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607679278;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gUuQQtK0hH5SjR+STpZ8Xe2W+JkSJ/MYwCfXkMh+Uu4=;
        b=LOHdCHgdrR2wnG+EcclvNgdoUMs2wMmUa5IQlSug0/o+KjZUiNA7u9P/9EXV09jReSVEy+
        mKpIVbvkwoXC4hCg==
From:   "tip-bot2 for Barry Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Trivial correction of the
 newidle_balance() comment
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201202220641.22752-1-song.bao.hua@hisilicon.com>
References: <20201202220641.22752-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Message-ID: <160767927760.3364.12152783613892271821.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5b78f2dc315354c05300795064f587366a02c6ff
Gitweb:        https://git.kernel.org/tip/5b78f2dc315354c05300795064f587366a02c6ff
Author:        Barry Song <song.bao.hua@hisilicon.com>
AuthorDate:    Thu, 03 Dec 2020 11:06:41 +13:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Dec 2020 10:30:44 +01:00

sched/fair: Trivial correction of the newidle_balance() comment

idle_balance() has been renamed to newidle_balance(). To differentiate
with nohz_idle_balance, it seems refining the comment will be helpful
for the readers of the code.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
