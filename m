Return-Path: <linux-tip-commits+bounces-4767-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CEDA8157A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837FA1B82CF3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014B62561D5;
	Tue,  8 Apr 2025 19:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ednHus7U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eJe9PbUI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06EB255E31;
	Tue,  8 Apr 2025 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139138; cv=none; b=FCHpUKdD5LgGfLA86FNm/5ajg1lyEmJwD2oxGFe1J/FK9LiU0dTSDGuDeTLYHBq3IrxcdIZnEciyydkx12/irujuQNQHXEfa1diTzgwpCBWgKMzIpHT0XW1Tqsm5WU+aNCJxhjWnqbK0empSefdKGMEo45XzZ2c/3M2/xlYtUK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139138; c=relaxed/simple;
	bh=cmEwMf+CdAFxhyvqEcC9fSt/RQTJ0oU/NZ6SWa5sBdc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aof8M6KlH3pfQiYRRJVROK9zd4rjZz521CyPVZFiQb3SwpjLyGj7XfxwdyH/3KbuMdHm2POyCtqMiGhVWzzZJ9f3SVgInJQB2nM4BaCIoKSZwfUUhBzSOkEm8eZkaDrgnzDep+ogsMI3laC7QjWg1rf0rVieMVe+xYNllZjmOXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ednHus7U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eJe9PbUI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:05:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139135;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6TR6KwGETOnn8HsO6nIa7qZ2S/gYo1n0SOCM68DEK5I=;
	b=ednHus7UZfSpsBulpTzT4OkUHB3SzzvmEBvrLeXPBPfmycwZQdP5oMK7U8J4srjZilVtLy
	V/013ZXx+viAEjCVLPBg8BFmjTVutFlvniyReNyS0GVI1EZzy90mwzBdIcZ0LaX+X38Z65
	wEDyZLGYXiaVSFRVDGrpty0ldGSpPkwDz7x0m+ojeXMojZBijXb4i6yc4llASt8a1hAlV3
	QvOMkGuR2LZEmVP2ZRyf8Rkieypy8W2ysWDjbmL4VyLRtP+801Qz+lc7m0Hxa/slJKQNn/
	6F1uL9xDz3ngcUQnEOxmTXvUzJmHRXC+2L14zSiS/rYff8uUNiKAEIKvdyhh8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139135;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6TR6KwGETOnn8HsO6nIa7qZ2S/gYo1n0SOCM68DEK5I=;
	b=eJe9PbUIIlwwdr29rBsj8WZ+T8OhSTAaHSuwOxWoo6frqwKyKEl1H/b0U3dRDpO9MYUMSX
	kSErdD5c3XBcEpAA==
From: tip-bot2 for Michal =?utf-8?q?Koutn=C3=BD?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Skip non-root task_groups with disabled
 RT_GROUP_SCHED
Cc: mkoutny@suse.com, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250310170442.504716-6-mkoutny@suse.com>
References: <20250310170442.504716-6-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413913474.31282.12084749501873134831.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     61d3164fec2ed283645dc17fcc51959e8f361e18
Gitweb:        https://git.kernel.org/tip/61d3164fec2ed283645dc17fcc51959e8f3=
61e18
Author:        Michal Koutn=C3=BD <mkoutny@suse.com>
AuthorDate:    Mon, 10 Mar 2025 18:04:37 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:53 +02:00

sched: Skip non-root task_groups with disabled RT_GROUP_SCHED

First, we want to prevent placement of RT tasks on non-root rt_rqs which
we achieve in the task migration code that'd fall back to
root_task_group's rt_rq.

Second, we want to work with only root_task_group's rt_rq when iterating
all "real" rt_rqs when RT_GROUP is disabled. To achieve this we keep
root_task_group as the first one on the task_groups and break out
quickly.

Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250310170442.504716-6-mkoutny@suse.com
---
 kernel/sched/core.c  |  2 +-
 kernel/sched/rt.c    |  9 ++++++---
 kernel/sched/sched.h |  7 +++++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 58d093a..32fb4c1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9020,7 +9020,7 @@ void sched_online_group(struct task_group *tg, struct t=
ask_group *parent)
 	unsigned long flags;
=20
 	spin_lock_irqsave(&task_group_lock, flags);
-	list_add_rcu(&tg->list, &task_groups);
+	list_add_tail_rcu(&tg->list, &task_groups);
=20
 	/* Root should already exist: */
 	WARN_ON(!parent);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 1af3996..efa22ba 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -495,6 +495,9 @@ typedef struct task_group *rt_rq_iter_t;
=20
 static inline struct task_group *next_task_group(struct task_group *tg)
 {
+	if (!rt_group_sched_enabled())
+		return NULL;
+
 	do {
 		tg =3D list_entry_rcu(tg->list.next,
 			typeof(struct task_group), list);
@@ -507,9 +510,9 @@ static inline struct task_group *next_task_group(struct t=
ask_group *tg)
 }
=20
 #define for_each_rt_rq(rt_rq, iter, rq)					\
-	for (iter =3D container_of(&task_groups, typeof(*iter), list);	\
-		(iter =3D next_task_group(iter)) &&			\
-		(rt_rq =3D iter->rt_rq[cpu_of(rq)]);)
+	for (iter =3D &root_task_group;					\
+		iter && (rt_rq =3D iter->rt_rq[cpu_of(rq)]);		\
+		iter =3D next_task_group(iter))
=20
 #define for_each_sched_rt_entity(rt_se) \
 	for (; rt_se; rt_se =3D rt_se->parent)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d1e591f..898aab7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2165,6 +2165,13 @@ static inline void set_task_rq(struct task_struct *p, =
unsigned int cpu)
 #endif
=20
 #ifdef CONFIG_RT_GROUP_SCHED
+	/*
+	 * p->rt.rt_rq is NULL initially and it is easier to assign
+	 * root_task_group's rt_rq than switching in rt_rq_of_se()
+	 * Clobbers tg(!)
+	 */
+	if (!rt_group_sched_enabled())
+		tg =3D &root_task_group;
 	p->rt.rt_rq  =3D tg->rt_rq[cpu];
 	p->rt.parent =3D tg->rt_se[cpu];
 #endif

