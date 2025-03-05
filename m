Return-Path: <linux-tip-commits+bounces-4009-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0787A50573
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 17:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E1D176949
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 16:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D341EDA2D;
	Wed,  5 Mar 2025 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bcSZeGq6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N5sKxW3v"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D06D1C700D;
	Wed,  5 Mar 2025 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192934; cv=none; b=f/J+q/mzcIBzObSiqidNbXtE7YsDk9eqDu2mOmdKmjt73oGRIwrelm/WxMoEQr7lxcXC9k/E2XH+PdWxXBLh7VJLDEwCGt+09UJtjBCUKCqppvNgiAhpy39bhqhXEGV0HSMo8I13YxnxI9NUPeR4XUGGUzAcVSQV1/iQP3YyfXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192934; c=relaxed/simple;
	bh=Cl8hbLTCGJL0Np6JYSb1zQZtf4E0VmLTr8Gkq87x/pg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KzRJkn1b5+xkDbK/7Z2jn83+R/VSHy8BBOncQi2bqCV4rO/8UA/rnoxztUkLuioAQ3OYp+Yr449MzmPzEPG166HcXAni1CcKlO67GYbCmCLD2ZEn1dsUl9swRxv/OlEC6l8KYN+4dMrXZczCi0LDv0dAhwmgszt+iSl0zns/xl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bcSZeGq6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N5sKxW3v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Mar 2025 16:42:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741192930;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f2ZjZRfGmB1CePsMKfReuJueqb9bjWC8iQP+m5s108g=;
	b=bcSZeGq6jDTtYhlB03UTvxJpN+fqjpNNdODaE2JlrL7eShbDvSLSK0RRtNaQHdbndqfAol
	/3XOrYfmKYxk65sgS8TfJk+7KmquvsThKoIsdpBk6ZU4qCHp8Ay4e6JPJC15uCZvUHuLBu
	saIlb4dA0EnG4QJhNIlXZNNAKZe3xPsYWeggzYjEratk6ahJG78XWhNrXJ/l1rqswfdp7x
	/7IpVRlk74RvQu8m9VSslkyTCyu+3FgApsClcz3LJ9t/ks12m/pgIfw5QBAMUV5gaw7xCT
	/etbBfZHmnFhoECPfawMktsix+PtOULLJQFBn8byEi0ayyJjHpJMCZAg6JxRAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741192930;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f2ZjZRfGmB1CePsMKfReuJueqb9bjWC8iQP+m5s108g=;
	b=N5sKxW3v0DGP7TpSkCpkzZehnY0r9S/PIGFZ425p+027FT8xh1yGqCtf1YCwKuqYB2bHcS
	ELB8N94JI0mPPrAQ==
From: "tip-bot2 for Zecheng Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix potential memory corruption in
 child_cfs_rq_on_list
Cc: Zecheng Li <zecheng@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250304214031.2882646-1-zecheng@google.com>
References: <20250304214031.2882646-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174119292742.14745.16827644501260146974.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     3b4035ddbfc8e4521f85569998a7569668cccf51
Gitweb:        https://git.kernel.org/tip/3b4035ddbfc8e4521f85569998a7569668cccf51
Author:        Zecheng Li <zecheng@google.com>
AuthorDate:    Tue, 04 Mar 2025 21:40:31 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 05 Mar 2025 17:30:54 +01:00

sched/fair: Fix potential memory corruption in child_cfs_rq_on_list

child_cfs_rq_on_list attempts to convert a 'prev' pointer to a cfs_rq.
This 'prev' pointer can originate from struct rq's leaf_cfs_rq_list,
making the conversion invalid and potentially leading to memory
corruption. Depending on the relative positions of leaf_cfs_rq_list and
the task group (tg) pointer within the struct, this can cause a memory
fault or access garbage data.

The issue arises in list_add_leaf_cfs_rq, where both
cfs_rq->leaf_cfs_rq_list and rq->leaf_cfs_rq_list are added to the same
leaf list. Also, rq->tmp_alone_branch can be set to rq->leaf_cfs_rq_list.

This adds a check `if (prev == &rq->leaf_cfs_rq_list)` after the main
conditional in child_cfs_rq_on_list. This ensures that the container_of
operation will convert a correct cfs_rq struct.

This check is sufficient because only cfs_rqs on the same CPU are added
to the list, so verifying the 'prev' pointer against the current rq's list
head is enough.

Fixes a potential memory corruption issue that due to current struct
layout might not be manifesting as a crash but could lead to unpredictable
behavior when the layout changes.

Fixes: fdaba61ef8a2 ("sched/fair: Ensure that the CFS parent is added after unthrottling")
Signed-off-by: Zecheng Li <zecheng@google.com>
Reviewed-and-tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250304214031.2882646-1-zecheng@google.com
---
 kernel/sched/fair.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1c0ef43..c798d27 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4045,15 +4045,17 @@ static inline bool child_cfs_rq_on_list(struct cfs_rq *cfs_rq)
 {
 	struct cfs_rq *prev_cfs_rq;
 	struct list_head *prev;
+	struct rq *rq = rq_of(cfs_rq);
 
 	if (cfs_rq->on_list) {
 		prev = cfs_rq->leaf_cfs_rq_list.prev;
 	} else {
-		struct rq *rq = rq_of(cfs_rq);
-
 		prev = rq->tmp_alone_branch;
 	}
 
+	if (prev == &rq->leaf_cfs_rq_list)
+		return false;
+
 	prev_cfs_rq = container_of(prev, struct cfs_rq, leaf_cfs_rq_list);
 
 	return (prev_cfs_rq->tg->parent == cfs_rq->tg);

