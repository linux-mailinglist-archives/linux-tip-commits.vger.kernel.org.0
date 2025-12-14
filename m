Return-Path: <linux-tip-commits+bounces-7652-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47244CBB762
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51A7430057A7
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 07:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE6F2C0275;
	Sun, 14 Dec 2025 07:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JoOjeoyR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T5dGe7Hq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D3829D28F;
	Sun, 14 Dec 2025 07:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765698407; cv=none; b=R/BrI/LTkfRg0adgOkYjFFZNxUj0+MAVaSOwXr0J4CzuTc/U29pixRceMTl7d13DAOsVzlyYgnKbU+YRUEVxq1SNooIb9QnjsfcQbszrX5tZT7pGUDkHXfLEY1OYngTCLwc+e+aro8bQM6FqRwVSIteAshmy/Obd/uNu3C+TXg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765698407; c=relaxed/simple;
	bh=fSvbRd7XhKsLrxHxMPrraaJ+FqJm4AS9rQA7TgAvrok=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rw7oyPmJNBOTC8r8FoNksihPZVU4oqs4z/XVKO3QuFPYmGQ/wS6jSEbLpFZ0QqzWTaMukKOMSvtmO/2sx/VBs8EyNIhzeLlQTAB+ZaEsJkGw3AQlr0mLz+oHKAEgxtxBFexRTZuRbYckdF1uM1OJlO1pZg9o7v1T/3ks0ro0IBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JoOjeoyR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T5dGe7Hq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 07:46:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765698400;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X2b5pQNONlfbAgNC3oyEcnM5/hXvdD5ioIT2t3OHBRs=;
	b=JoOjeoyR4LrNirXdMxfh7x2+9Z82dCeGstG6kYt2MVwp3RwCtQWRltTxfCCpbYADLCDijn
	XVJG0dd7UZ/K12fqr7TgFLgxlWu4KGqm5VEm/sM2HtkcAmrvRKfXDKTP1FeCUtuEZqGBJJ
	Ra/YpIrirV1XdEfrP9QE6lVBkRRKRWnOkH6sNyMKc+OqruEDDC2MgMuhzEIwUEZUHPwvfA
	aZUu1OX/xO6XbWeuyPssbtYuL+tv+LbtF0CHyUcNyCLyEADD2q8XygtKOdBAIPvAbpL/Kq
	u2YpHkSXYf3fQ7mtu0R7g+aeNjl5FKySDD26MPpoVKiSlvo0QUTlBZdYTiJ93g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765698400;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X2b5pQNONlfbAgNC3oyEcnM5/hXvdD5ioIT2t3OHBRs=;
	b=T5dGe7Hqpe0Sb7GzYHMfjMEBhFuJq7Yb1mRpTEWmrwfwGHcDeSnH70Mz3cH34GLCkVZZLn
	TvgHo8bLBiqaX1CA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Clean up comments in 'struct cfs_rq'
Cc:
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251201064647.1851919-3-mingo@kernel.org>
References: <20251201064647.1851919-3-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176569839885.498.10168395044251356417.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3dbcec53616803b71e00084a94426a017f0ef04f
Gitweb:        https://git.kernel.org/tip/3dbcec53616803b71e00084a94426a017f0=
ef04f
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 26 Nov 2025 11:29:18 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 08:25:02 +01:00

sched/fair: Clean up comments in 'struct cfs_rq'

 - Fix vertical alignment
 - Fix typos
 - Fix capitalization

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/20251201064647.1851919-3-mingo@kernel.org
---
 kernel/sched/sched.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f751ac3..4ddb755 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -670,13 +670,13 @@ struct balance_callback {
 	void (*func)(struct rq *rq);
 };
=20
-/* CFS-related fields in a runqueue */
+/* Fair scheduling SCHED_{NORMAL,BATCH,IDLE} related fields in a runqueue: */
 struct cfs_rq {
 	struct load_weight	load;
 	unsigned int		nr_queued;
-	unsigned int		h_nr_queued;       /* SCHED_{NORMAL,BATCH,IDLE} */
-	unsigned int		h_nr_runnable;     /* SCHED_{NORMAL,BATCH,IDLE} */
-	unsigned int		h_nr_idle; /* SCHED_IDLE */
+	unsigned int		h_nr_queued;		/* SCHED_{NORMAL,BATCH,IDLE} */
+	unsigned int		h_nr_runnable;		/* SCHED_{NORMAL,BATCH,IDLE} */
+	unsigned int		h_nr_idle;		/* SCHED_IDLE */
=20
 	s64			avg_vruntime;
 	u64			avg_load;
@@ -690,7 +690,7 @@ struct cfs_rq {
 	struct rb_root_cached	tasks_timeline;
=20
 	/*
-	 * 'curr' points to currently running entity on this cfs_rq.
+	 * 'curr' points to the currently running entity on this cfs_rq.
 	 * It is set to NULL otherwise (i.e when none are currently running).
 	 */
 	struct sched_entity	*curr;
@@ -739,7 +739,7 @@ struct cfs_rq {
 	 */
 	int			on_list;
 	struct list_head	leaf_cfs_rq_list;
-	struct task_group	*tg;	/* group that "owns" this runqueue */
+	struct task_group	*tg;	/* Group that "owns" this runqueue */
=20
 	/* Locally cached copy of our task_group's idle value */
 	int			idle;

