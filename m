Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FD440D932
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Sep 2021 14:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbhIPMAu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 16 Sep 2021 08:00:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47526 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbhIPMAs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 16 Sep 2021 08:00:48 -0400
Date:   Thu, 16 Sep 2021 11:59:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631793567;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Xd2HEQWZbCSRLSPj0LYVgooDcE86tK5EDz0S+Ygog2s=;
        b=CWPwVvyWmFa3QaFFXjIVnhLaguvC5SGG0zAXNAVo0WNnbSmF+N3fiukeAs5Usr7+O2ifQC
        xL0jT1OQSQ+Yf2fcvzqj+W6tsSMcUOY5NNTulbQlHbCqfSIjr4UMfqy3Ea8YjGLRcsJF3o
        /02ZoczWujnUiq7h2DU9X7zJ5WElUT1UmF/Ds5bDEVHaB9cqD0pjNp4adC+7WRRzNwVdlQ
        mnB+XD5PMsSwXcWY5TEQxJsnwRqJcI1F23dRF92C9OBW86fEG9jeqo6DzxM0nbKHLH+YcZ
        y9o9y8lJw4pie0/k5PQWAAMyKs6PZ2mamvRymYzDM5X/NB54cDKjJdpbnCC2EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631793567;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Xd2HEQWZbCSRLSPj0LYVgooDcE86tK5EDz0S+Ygog2s=;
        b=oBIWoxNVu9Y8vj5zIgEXwIaA9h+iVo7eIDnN18kCr0Bowqeaeqar1jdqpTJPXkNUM5Vqu/
        EMzcG/HFu2s9/wDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix -Wmissing-prototype
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <163179356649.25758.16036449513954806322.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     98a3270911f7abe2871a60799c20c95c9f991ddb
Gitweb:        https://git.kernel.org/tip/98a3270911f7abe2871a60799c20c95c9f9=
91ddb
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 13 Sep 2021 15:27:44 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 17:49:00 +02:00

sched: Fix -Wmissing-prototype

  kernel/sched/fair.c:5403:6: warning: no previous prototype for =E2=80=98ini=
t_cfs_bandwidth=E2=80=99 [-Wmissing-prototypes]
  kernel/sched/fair.c:11525:6: warning: no previous prototype for =E2=80=98fr=
ee_fair_sched_group=E2=80=99 [-Wmissing-prototypes]
  kernel/sched/fair.c:11527:5: warning: no previous prototype for =E2=80=98al=
loc_fair_sched_group=E2=80=99 [-Wmissing-prototypes]
  kernel/sched/fair.c:11532:6: warning: no previous prototype for =E2=80=98on=
line_fair_sched_group=E2=80=99 [-Wmissing-prototypes]
  kernel/sched/fair.c:11534:6: warning: no previous prototype for =E2=80=98un=
register_fair_sched_group=E2=80=99 [-Wmissing-prototypes]

  kernel/sched/rt.c:253:6: warning: no previous prototype for =E2=80=98free_r=
t_sched_group=E2=80=99 [-Wmissing-prototypes]
  kernel/sched/rt.c:255:5: warning: no previous prototype for =E2=80=98alloc_=
rt_sched_group=E2=80=99 [-Wmissing-prototypes]
  kernel/sched/rt.c:669:6: warning: no previous prototype for =E2=80=98sched_=
rt_bandwidth_account=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/deadline.c |  2 --
 kernel/sched/fair.c     | 15 ---------------
 kernel/sched/rt.c       |  6 ------
 kernel/sched/sched.h    |  2 ++
 4 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d2c072b..29dd188 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1191,8 +1191,6 @@ int dl_runtime_exceeded(struct sched_dl_entity *dl_se)
 	return (dl_se->runtime <=3D 0);
 }
=20
-extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
-
 /*
  * This function implements the GRUB accounting rule:
  * according to the GRUB reclaiming algorithm, the runtime is
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e26d622..9571254 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5408,8 +5408,6 @@ static inline int throttled_lb_pair(struct task_group *=
tg,
 	return 0;
 }
=20
-void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
-
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
 #endif
@@ -11562,19 +11560,6 @@ next_cpu:
 	return 0;
 }
=20
-#else /* CONFIG_FAIR_GROUP_SCHED */
-
-void free_fair_sched_group(struct task_group *tg) { }
-
-int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
-{
-	return 1;
-}
-
-void online_fair_sched_group(struct task_group *tg) { }
-
-void unregister_fair_sched_group(struct task_group *tg) { }
-
 #endif /* CONFIG_FAIR_GROUP_SCHED */
=20
=20
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index bb945f8..929fb37 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -250,12 +250,6 @@ static inline struct rt_rq *rt_rq_of_se(struct sched_rt_=
entity *rt_se)
 	return &rq->rt;
 }
=20
-void free_rt_sched_group(struct task_group *tg) { }
-
-int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
-{
-	return 1;
-}
 #endif /* CONFIG_RT_GROUP_SCHED */
=20
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 094ea86..1d8bc76 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3065,3 +3065,5 @@ extern int sched_dynamic_mode(const char *str);
 extern void sched_dynamic_update(int mode);
 #endif
=20
+extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
+
