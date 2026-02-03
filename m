Return-Path: <linux-tip-commits+bounces-8196-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PGvHf/agWlBLQMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8196-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Feb 2026 12:24:47 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C90C2D8459
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Feb 2026 12:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAD57314AB4F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Feb 2026 11:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9983385B1;
	Tue,  3 Feb 2026 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EnpEQ0GA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3FuQDZOO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C2F331A57;
	Tue,  3 Feb 2026 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117530; cv=none; b=REprmuODnBX3OX6qcM1eBy9G7//XDvjsMt4joST3+n/mYDOpR2SAZTB192f9mNx7AGmGj4bg092PQq1XPnXxD0+4DDXoHi1VcHRClhm4tlkugwNxoEmb8bASPDbzH0hgmwV7B+VEmryXmBveu+Obe++MEV4X9+aiqQL1ANwpVE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117530; c=relaxed/simple;
	bh=cRXL2vREg1PGvGr6WOyRe6eqRdasRC795GYTG6HJPDU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AOUeXGJ1nxufT+5c1259U/GJZx0a3bthoKAyGUcCae8yLiEoNXdRaEsmy0i6we8wMmtl05LKb97NkWr7COv9mZkQGUN95/tc9sstrpk9cqWL5IMj+IBacyU0vr1klU6NuV/L+PNtTW3/ECxHQkewPSkDvT1xMMtqAgWiT2ysrTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EnpEQ0GA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3FuQDZOO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Feb 2026 11:18:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770117524;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzA3++tFugSkLbNszWxH8/NherrzncWtxD6IDhC0OmU=;
	b=EnpEQ0GA40XjLyMYNt9Q08ivIkdiUed5469ChPmjGhyb1m0a1DLfx5HGBkzM2n1UMega2i
	tMHcw7c8pOAppfx4U9QFu8I+NVtivPP0r5/uMtgi5jDriO6Ub+R/8pm83o866bNtJzYp1V
	OjiTADelifJZrJQH97luVAtIm7sZhVi/a2VgsFlNImxxrV1cO1iBWrN8PYZC6+PQNyQAVY
	qW5AGcjJPy7ZeAp9B+PjgrOlS+oFpmwJd7Rtz6C+RtrzWVpmNuwf0Z57jQBpxrV+Qvg0HT
	3Mv4ASUw9GUy7pw7I5g88RYPXsIIkU7k0H28aZcplErK83sFxuJI3PAX2OWIKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770117524;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzA3++tFugSkLbNszWxH8/NherrzncWtxD6IDhC0OmU=;
	b=3FuQDZOO5DpRPZ5QIc22uSL2cUVUiCStd31Spc2WIwILZN1pFLkjMLHcLuDdlTgF3K1eaR
	poHz9UESdZyaveCg==
From: "tip-bot2 for Joel Fernandes" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Stop and start server based on if it
 was active
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Andrea Righi <arighi@nvidia.com>,
 Tejun Heo <tj@kernel.org>, Christian Loehle <christian.loehle@arm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260126100050.3854740-4-arighi@nvidia.com>
References: <20260126100050.3854740-4-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177011752267.2495410.8100864761622080821.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8196-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,arm.com:email,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,vger.kernel.org:replyto,linutronix.de:dkim]
X-Rspamd-Queue-Id: C90C2D8459
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     68ec89d0e99156803bdea3c986c0198624e40ea2
Gitweb:        https://git.kernel.org/tip/68ec89d0e99156803bdea3c986c0198624e=
40ea2
Author:        Joel Fernandes <joelagnelf@nvidia.com>
AuthorDate:    Mon, 26 Jan 2026 10:59:01 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Feb 2026 12:04:17 +01:00

sched/debug: Stop and start server based on if it was active

Currently the DL server interface for applying parameters checks
CFS-internals to identify if the server is active. This is error-prone
and makes it difficult when adding new servers in the future.

Fix it, by using dl_server_active() which is also used by the DL server
code to determine if the DL server was started.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Acked-by: Tejun Heo <tj@kernel.org>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/20260126100050.3854740-4-arighi@nvidia.com
---
 kernel/sched/debug.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index ed9254d..41e3895 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -348,6 +348,8 @@ static ssize_t sched_fair_server_write(struct file *filp,=
 const char __user *ubu
 		return err;
=20
 	scoped_guard (rq_lock_irqsave, rq) {
+		bool is_active;
+
 		runtime  =3D rq->fair_server.dl_runtime;
 		period =3D rq->fair_server.dl_period;
=20
@@ -370,8 +372,11 @@ static ssize_t sched_fair_server_write(struct file *filp=
, const char __user *ubu
 			return  -EINVAL;
 		}
=20
-		update_rq_clock(rq);
-		dl_server_stop(&rq->fair_server);
+		is_active =3D dl_server_active(&rq->fair_server);
+		if (is_active) {
+			update_rq_clock(rq);
+			dl_server_stop(&rq->fair_server);
+		}
=20
 		retval =3D dl_server_apply_params(&rq->fair_server, runtime, period, 0);
=20
@@ -379,7 +384,7 @@ static ssize_t sched_fair_server_write(struct file *filp,=
 const char __user *ubu
 			printk_deferred("Fair server disabled in CPU %d, system may crash due to =
starvation.\n",
 					cpu_of(rq));
=20
-		if (rq->cfs.h_nr_queued)
+		if (is_active && runtime)
 			dl_server_start(&rq->fair_server);
=20
 		if (retval < 0)

