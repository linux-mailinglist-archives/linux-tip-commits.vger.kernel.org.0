Return-Path: <linux-tip-commits+bounces-8190-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BEFFq/agWlBLQMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8190-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Feb 2026 12:23:27 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EBBD83B2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Feb 2026 12:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2303F3125359
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Feb 2026 11:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C00335073;
	Tue,  3 Feb 2026 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m7ZRdF1y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N8Qahmto"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F304033123F;
	Tue,  3 Feb 2026 11:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117528; cv=none; b=sWetqcuAvrQq7JHK1XqMDdHnkFx/msdHKNOty+wRo2F1SGdTkangZJZCaEHHt8/HXzf06+4NUksfmX35Tx+4cnEy99YkvLJdKPImeYfnOizMLDzCQ76cQiD/zUBSEzmiBEoJKHrG6PmZg07lSJopFgU05ff1Oh/0Mbbfl4cIbrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117528; c=relaxed/simple;
	bh=SquKrKpjQKE+aqb6OVpq5xbrzUnp380JCFkJAHF8uLk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bSX9Y7MPMDNDHdW+C9i/koReOdFOwQw28uLUaMLMwG1bkJcVG/AX+tegVmU+4dNG2MGwnztEM5FBRimVjSU2CLJMPub3h9v7yhDhwq4fKkocIKED3YXENK7DKCyLiuAYfp1s72Syog9X7hGgdNA449uvBudKnODNfzT6hNHR/8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m7ZRdF1y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N8Qahmto; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Feb 2026 11:18:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770117520;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hB7cR4Xwb97TZ3Mp/dEG6a3tluluSqcH+khemtxmaBo=;
	b=m7ZRdF1ydvMkXzjA5+buMIfJ8jV4rYiPNr2v+6atAvcGYv2YQuPnizFHDLkWRlkhWaBMIB
	3hM1DYihTTi/ahv8QBGetAPm7aNCGomQR+bvwFMW6ktIA+hv4mEGW8PgO3Di9T6YWzyalY
	uQ4nR7x9+RewrZ52wtb48F1eOFij8bwfIKZcKOuVXpQPSKtaiZLryrC9DeYjvj/CmZEikV
	pRBOMb6SuVhHyA4Ay1ws65zVvexNddPjWu4zcR6THgxUaOaOdwRj/63oujCNwH2e+ga66o
	QRE8aNTIT6i7ikRtot1wnhOiYl64wRCiBjApD8ICCgkV/3sgRR8aKfN/m1fAJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770117520;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hB7cR4Xwb97TZ3Mp/dEG6a3tluluSqcH+khemtxmaBo=;
	b=N8Qahmto/xhSJ74hbJWIg0A5sUP2Zbw512GMAwlf9sjGyu00a/m7sCQLqP5V0qm3mJ7y2Q
	07RNXjq9smIDGyBA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Fix dl_server (re)start conditions
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260203103407.GK1282955@noisy.programming.kicks-ass.net>
References: <20260203103407.GK1282955@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177011751947.2495410.3933261856532467740.tip-bot2@tip-bot2>
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
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8190-lists,linux-tip-commits=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,msgid.link:url]
X-Rspamd-Queue-Id: E9EBBD83B2
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5a40a9bb56d455e7548ba4b6d7787918323cbaf0
Gitweb:        https://git.kernel.org/tip/5a40a9bb56d455e7548ba4b6d7787918323=
cbaf0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 03 Feb 2026 11:05:12 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Feb 2026 12:04:18 +01:00

sched/debug: Fix dl_server (re)start conditions

There are two problems with sched_server_write_common() that can cause the
dl_server to malfunction upon attempting to change the parameters:

1) when, after having disabled the dl_server by setting runtime=3D0, it is
   enabled again while tasks are already enqueued. In this case is_active wou=
ld
   still be 0 and dl_server_start() would not be called.

2) when dl_server_apply_params() would fail, runtime is not applied and does
   not reflect the new state.

Instead have dl_server_start() check its actual dl_runtime, and have
sched_server_write_common() unconditionally (re)start the dl_server. It will
automatically stop if there isn't anything to do, so spurious activation is
harmless -- while failing to start it is a problem.

While there, move the printk out of the locked region and make it symmetric,
also printing on enable.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260203103407.GK1282955@noisy.programming.kic=
ks-ass.net
---
 kernel/sched/deadline.c |  5 ++---
 kernel/sched/debug.c    | 32 ++++++++++++++------------------
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index eae14e5..d08b004 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1799,7 +1799,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	struct rq *rq =3D dl_se->rq;
=20
 	dl_se->dl_defer_idle =3D 0;
-	if (!dl_server(dl_se) || dl_se->dl_server_active)
+	if (!dl_server(dl_se) || dl_se->dl_server_active || !dl_se->dl_runtime)
 		return;
=20
 	/*
@@ -1898,7 +1898,6 @@ int dl_server_apply_params(struct sched_dl_entity *dl_s=
e, u64 runtime, u64 perio
 	int cpu =3D cpu_of(rq);
 	struct dl_bw *dl_b;
 	unsigned long cap;
-	int retval =3D 0;
 	int cpus;
=20
 	dl_b =3D dl_bw_of(cpu);
@@ -1930,7 +1929,7 @@ int dl_server_apply_params(struct sched_dl_entity *dl_s=
e, u64 runtime, u64 perio
 	dl_se->dl_bw =3D to_ratio(dl_se->dl_period, dl_se->dl_runtime);
 	dl_se->dl_density =3D to_ratio(dl_se->dl_deadline, dl_se->dl_runtime);
=20
-	return retval;
+	return 0;
 }
=20
 /*
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 59e650f..b24f40f 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -338,9 +338,9 @@ static ssize_t sched_server_write_common(struct file *fil=
p, const char __user *u
 					 void *server)
 {
 	long cpu =3D (long) ((struct seq_file *) filp->private_data)->private;
-	struct rq *rq =3D cpu_rq(cpu);
 	struct sched_dl_entity *dl_se =3D (struct sched_dl_entity *)server;
-	u64 runtime, period;
+	u64 old_runtime, runtime, period;
+	struct rq *rq =3D cpu_rq(cpu);
 	int retval =3D 0;
 	size_t err;
 	u64 value;
@@ -350,9 +350,7 @@ static ssize_t sched_server_write_common(struct file *fil=
p, const char __user *u
 		return err;
=20
 	scoped_guard (rq_lock_irqsave, rq) {
-		bool is_active;
-
-		runtime =3D dl_se->dl_runtime;
+		old_runtime =3D runtime =3D dl_se->dl_runtime;
 		period =3D dl_se->dl_period;
=20
 		switch (param) {
@@ -374,25 +372,23 @@ static ssize_t sched_server_write_common(struct file *f=
ilp, const char __user *u
 			return  -EINVAL;
 		}
=20
-		is_active =3D dl_server_active(dl_se);
-		if (is_active) {
-			update_rq_clock(rq);
-			dl_server_stop(dl_se);
-		}
-
+		update_rq_clock(rq);
+		dl_server_stop(dl_se);
 		retval =3D dl_server_apply_params(dl_se, runtime, period, 0);
-
-		if (!runtime)
-			printk_deferred("%s server disabled in CPU %d, system may crash due to st=
arvation.\n",
-					server =3D=3D &rq->fair_server ? "Fair" : "Ext", cpu_of(rq));
-
-		if (is_active && runtime)
-			dl_server_start(dl_se);
+		dl_server_start(dl_se);
=20
 		if (retval < 0)
 			return retval;
 	}
=20
+	if (!!old_runtime ^ !!runtime) {
+		pr_info("%s server %sabled on CPU %d%s.\n",
+			server =3D=3D &rq->fair_server ? "Fair" : "Ext",
+			runtime ? "en" : "dis",
+			cpu_of(rq),
+			runtime ? "" : ", system may malfunction due to starvation");
+	}
+
 	*ppos +=3D cnt;
 	return cnt;
 }

