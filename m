Return-Path: <linux-tip-commits+bounces-7658-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 071D4CBB79B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DD6A30088BD
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 07:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651B92BEFE1;
	Sun, 14 Dec 2025 07:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PdnTgrF2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b/VhTabb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7042BD035;
	Sun, 14 Dec 2025 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765698410; cv=none; b=UivACLYJ3bSrF1rHjPLT8YPJKjKlqlflrX3452r7M4oXxx13vxUvsDYgitI5KVVMR1x6yAN5bRVlocx7Zw4P6EhMiELt+iMD3BY6Vy/lmSXA83ol1I2exj/hTgDmUXqsu9GUKfi4dpSn0VXUeBN52fy47x718yNXT3ztyTXi0Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765698410; c=relaxed/simple;
	bh=qRNtTcb4w6M/P+XU1+ccpQf+q8tCQDz+3+JTgZqv6oo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bwxztGRct3hFYzS0iqXi2G49ZMIqm260Fer0BdI78Z5wQkNm0F6BZYvqG2qEp4o9p6JPEOUqBFP0h6TtqoztaFC7WY5aQUWUcrGpdprAIJe+kGRZyMvFBRrVjV/SXRTsjaM53iemJ989v5ZDE+UJmpXgdQTIZAowAcc6KbynZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PdnTgrF2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b/VhTabb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 07:46:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765698403;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eCZNl4JfnvXOotziFELX1xCW9D7qwOUEBxpQm1sVtes=;
	b=PdnTgrF2zmt3yUSbj2+Unf0xT9VBNmNyMYRRpkTINCOAsVACh+W26V1fOHKfV07W4CPDJ0
	Xqvy7/5ef2g9IoGN+HDoluhGIQA82Lympk0Ty7/Sf4uz7KlN4Dq2M51w5QjIdDO3jNIE0y
	STxgaBV41DhR3wFar1v3oZa6R1BLRGrgXYioXLkIXyNr7eLA9l23XLBRIRzRdltvduo4BT
	oVL0LsttQe5wOccOkRzdJMJog0amyXQu3wkdEon6yZ949L4qQKvaumrVkbBtFPQJmHxfgF
	UmhwhVUPjbzaL1nQj9KiLO6JPK4X6j83BjR60glThYH9L/jpAZOzj/0OniwtUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765698403;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eCZNl4JfnvXOotziFELX1xCW9D7qwOUEBxpQm1sVtes=;
	b=b/VhTabbP6KO+oLBo3VFmCf72ekkkMQDMSLrJEIfitbFhxTc82AsRG/ESLD92ueunT7tR8
	SK4ykbKLPuzncVAg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Add assertions to QUEUE_CLASS
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251127154725.771691954@infradead.org>
References: <20251127154725.771691954@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176569840215.498.1024118342410459931.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     47efe2ddccb1f285a02bfcf1e079f49bf7a9ccb3
Gitweb:        https://git.kernel.org/tip/47efe2ddccb1f285a02bfcf1e079f49bf7a=
9ccb3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 30 Oct 2025 12:56:34 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 08:25:02 +01:00

sched/core: Add assertions to QUEUE_CLASS

Add some checks to the sched_change pattern to validate assumptions
around changing classes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/20251127154725.771691954@infradead.org
---
 kernel/sched/core.c  | 13 +++++++++++++
 kernel/sched/sched.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 41ba0be..4479f7d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10782,6 +10782,7 @@ struct sched_change_ctx *sched_change_begin(struct ta=
sk_struct *p, unsigned int=20
=20
 	*ctx =3D (struct sched_change_ctx){
 		.p =3D p,
+		.class =3D p->sched_class,
 		.flags =3D flags,
 		.queued =3D task_on_rq_queued(p),
 		.running =3D task_current_donor(rq, p),
@@ -10812,6 +10813,11 @@ void sched_change_end(struct sched_change_ctx *ctx)
=20
 	lockdep_assert_rq_held(rq);
=20
+	/*
+	 * Changing class without *QUEUE_CLASS is bad.
+	 */
+	WARN_ON_ONCE(p->sched_class !=3D ctx->class && !(ctx->flags & ENQUEUE_CLASS=
));
+
 	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to)
 		p->sched_class->switching_to(rq, p);
=20
@@ -10823,6 +10829,13 @@ void sched_change_end(struct sched_change_ctx *ctx)
 	if (ctx->flags & ENQUEUE_CLASS) {
 		if (p->sched_class->switched_to)
 			p->sched_class->switched_to(rq, p);
+
+		/*
+		 * If this was a degradation in class someone should have set
+		 * need_resched by now.
+		 */
+		WARN_ON_ONCE(sched_class_above(ctx->class, p->sched_class) &&
+			     !test_tsk_need_resched(p));
 	} else {
 		p->sched_class->prio_changed(rq, p, ctx->prio);
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 67cff7d..a40582d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3968,6 +3968,7 @@ extern void balance_callbacks(struct rq *rq, struct bal=
ance_callback *head);
 struct sched_change_ctx {
 	u64			prio;
 	struct task_struct	*p;
+	const struct sched_class *class;
 	int			flags;
 	bool			queued;
 	bool			running;

