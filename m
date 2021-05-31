Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FB8395918
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 May 2021 12:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhEaKmm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 31 May 2021 06:42:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53622 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhEaKmc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 31 May 2021 06:42:32 -0400
Date:   Mon, 31 May 2021 10:40:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622457652;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CIRc854VS+cnZCDSxweVWicusUNyvHD02sM/xrMvI0I=;
        b=KxTf8veGGiZPa3gvEfpK8g5Bv/l8csJLpfMU8IScPEjeqdbPIW/6ZUh2yiRfDilVWTCUU5
        U8HqDmLSt+6KmOiUnysXVCcVVy+tyPovcg329LlTspII4of/GPHiadERYcVQUkCXYt9f0Q
        fmUpxvAogTKXoPIOn3UQRudaZeijO6O1dBEtaOqG2mpI78wS7uzNIkYkW7hB64lXQr1dsU
        Ym4DI7eZws7ln6kaSKj/rY4IrJ/hxNpsKmNlh6pT3cmO8Jv7QHIA7UvctFaxxaWqGUeMaM
        rYg2K9qlk1qFtUa3/KUIZtl8fr2CT/LWR9edKh7ENLFu9VseY0ggwwuCJKZYsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622457652;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CIRc854VS+cnZCDSxweVWicusUNyvHD02sM/xrMvI0I=;
        b=Oly3otb/VovoC3xHKEOo7UV1v/lR30ddjknqSZTL3UfgqES41ZwkfnlKF62qYFotgtIKSc
        FMov1fRbjQOwnBAQ==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Make sure to update tg contrib for
 blocked load
Cc:     Odin Ugedal <odin@uged.al>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210527122916.27683-3-vincent.guittot@linaro.org>
References: <20210527122916.27683-3-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <162245765196.29796.10346723240274549912.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     02da26ad5ed6ea8680e5d01f20661439611ed776
Gitweb:        https://git.kernel.org/tip/02da26ad5ed6ea8680e5d01f20661439611ed776
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Thu, 27 May 2021 14:29:16 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 31 May 2021 10:14:48 +02:00

sched/fair: Make sure to update tg contrib for blocked load

During the update of fair blocked load (__update_blocked_fair()), we
update the contribution of the cfs in tg->load_avg if cfs_rq's pelt
has decayed.  Nevertheless, the pelt values of a cfs_rq could have
been recently updated while propagating the change of a child. In this
case, cfs_rq's pelt will not decayed because it has already been
updated and we don't update tg->load_avg.

__update_blocked_fair
  ...
  for_each_leaf_cfs_rq_safe: child cfs_rq
    update cfs_rq_load_avg() for child cfs_rq
    ...
    update_load_avg(cfs_rq_of(se), se, 0)
      ...
      update cfs_rq_load_avg() for parent cfs_rq
		-propagation of child's load makes parent cfs_rq->load_sum
		 becoming null
        -UPDATE_TG is not set so it doesn't update parent
		 cfs_rq->tg_load_avg_contrib
  ..
  for_each_leaf_cfs_rq_safe: parent cfs_rq
    update cfs_rq_load_avg() for parent cfs_rq
      - nothing to do because parent cfs_rq has already been updated
		recently so cfs_rq->tg_load_avg_contrib is not updated
    ...
    parent cfs_rq is decayed
      list_del_leaf_cfs_rq parent cfs_rq
	  - but it still contibutes to tg->load_avg

we must set UPDATE_TG flags when propagting pending load to the parent

Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")
Reported-by: Odin Ugedal <odin@uged.al>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Odin Ugedal <odin@uged.al>
Link: https://lkml.kernel.org/r/20210527122916.27683-3-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f4795b8..e7c8277 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8029,7 +8029,7 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
 		/* Propagate pending load changes to the parent, if any: */
 		se = cfs_rq->tg->se[cpu];
 		if (se && !skip_blocked_update(se))
-			update_load_avg(cfs_rq_of(se), se, 0);
+			update_load_avg(cfs_rq_of(se), se, UPDATE_TG);
 
 		/*
 		 * There can be a lot of idle CPU cgroups.  Don't let fully
