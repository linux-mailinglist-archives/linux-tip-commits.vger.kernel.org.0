Return-Path: <linux-tip-commits+bounces-2772-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759449BE4CA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 11:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8298B229C6
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 10:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290F91E0B61;
	Wed,  6 Nov 2024 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CYA0mAa9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bC84BvKZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E65B1DFE25;
	Wed,  6 Nov 2024 10:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890133; cv=none; b=KqUmCm1K8o518iQnhwqw+YamD5my0ADeyWXXSPP9Gd6P5jLbzZi0OpW0OiDHupZfY+peuQnUkKZCzr0G2SuapRl9TDfuLTVKG9b2qX4+Ov2bZxh58ynTGrYfbavRgYYm+MwDOIOzOI8TMuRgXm/pawATvbmaAc6YNKpqiAoUNgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890133; c=relaxed/simple;
	bh=5Z5pVT4P4ASxtvV7h4wKTJkwfUb66otmDltVC9CwA68=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UpJ345uMRyUEmFu4CkEXvjgSLHuhcbTbJtlYtYVTapJ9nJ025tUdB0GBoO9OI3o9NbWYOChP27hLsruPgwmn0YvVp+oa/6p0us26ZdrNqPZavqsTeDKQAK6BCJ1U4m+Kx5Jxv+N4dnKMnT2iHl1QzFv78XiEbSESYVX3j6Rw6kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CYA0mAa9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bC84BvKZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Nov 2024 10:48:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730890129;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/B8GKO7soKMgTPBUTWGRkb3Z0639KjLnMtQ8efwpLk=;
	b=CYA0mAa9Pz04U/IUdDnvXRUJ42k9hIyT6Q+Ie8jwEmJhHwyEbSSL9kLAqqrClamEXetseD
	5K0D83npdibxERNaKc/0A4Y8eLKCrJzTr1yqQ506QCiuCk/b2g4zJVVNXRxbadHEX4EkYW
	3CQmMeBeCVMVN2ZUDYBiYGRvddN6SwvoYRm8KZyccw1gSSk/uMjQN9Gtk8HmaE/UH96XZr
	cf7B/fUvhVU8TfDwg27YqJYaegT5BtEMnQmd5Q1Oo2taoCaJjbgNI6yh75n/e9kzaCYjOL
	aXqD/2mtE12aFGpKeQ6mUS1ugKiez0RyVWqJYHUyjtJSFbArKJb8SuI3AtLKLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730890129;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/B8GKO7soKMgTPBUTWGRkb3Z0639KjLnMtQ8efwpLk=;
	b=bC84BvKZ5l2iyLltardxzYrlvEVkLQNv7js3DpIhZEnMysSdCjZQ813MH7a9L6x4roCihI
	EXVJUTTb8ODaOxAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/ext: Remove sched_fork() hack
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87ldy82wkc.ffs@tglx>
References: <87ldy82wkc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173089012894.32228.11062780826944350150.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0f0d1b8e5010bfe1feeb4d78d137e41946a5370d
Gitweb:        https://git.kernel.org/tip/0f0d1b8e5010bfe1feeb4d78d137e41946a5370d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 28 Oct 2024 14:20:35 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Nov 2024 12:55:37 +01:00

sched/ext: Remove sched_fork() hack

Instead of solving the underlying problem of the double invocation of
__sched_fork() for idle tasks, sched-ext decided to hack around the issue
by partially clearing out the entity struct to preserve the already
enqueued node. A provided analysis and solution has been ignored for four
months.

Now that someone else has taken care of cleaning it up, remove the
disgusting hack and clear out the full structure. Remove the comment in the
structure declaration as well, as there is no requirement for @node being
the last element anymore.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/87ldy82wkc.ffs@tglx
---
 include/linux/sched/ext.h | 1 -
 kernel/sched/ext.c        | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 1ddbde6..2799e72 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -199,7 +199,6 @@ struct sched_ext_entity {
 #ifdef CONFIG_EXT_GROUP_SCHED
 	struct cgroup		*cgrp_moving_from;
 #endif
-	/* must be the last field, see init_scx_entity() */
 	struct list_head	tasks_node;
 };
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5900b06..f6e9a14 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3548,12 +3548,7 @@ static void scx_ops_exit_task(struct task_struct *p)
 
 void init_scx_entity(struct sched_ext_entity *scx)
 {
-	/*
-	 * init_idle() calls this function again after fork sequence is
-	 * complete. Don't touch ->tasks_node as it's already linked.
-	 */
-	memset(scx, 0, offsetof(struct sched_ext_entity, tasks_node));
-
+	memset(scx, 0, sizeof(*scx));
 	INIT_LIST_HEAD(&scx->dsq_list.node);
 	RB_CLEAR_NODE(&scx->dsq_priq);
 	scx->sticky_cpu = -1;

