Return-Path: <linux-tip-commits+bounces-8192-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEKRFK/ZgWlYKgMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8192-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Feb 2026 12:19:11 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 29250D82AA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Feb 2026 12:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA6BD3007B1F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Feb 2026 11:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155BC335559;
	Tue,  3 Feb 2026 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4FiySW4J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vSCYKwyz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E0B3321A6;
	Tue,  3 Feb 2026 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117529; cv=none; b=ekUCb1Ua7j4DbarIgpjGx89P20Tbyhvp77Ql4Un00zMRFiTzghKCbAJ3t8aUtuGtIoS6L4MBrG3zoyvPbJrjyniGfRYEonxJYsg/+tHksIR+GmO+yl9XnLYlwq9dvpUrVuZn2yxNa71TEWy12oh8BT6gMJXWaC3OF+FNWTwfvfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117529; c=relaxed/simple;
	bh=nnzVJmWe1og/8I5MwWd/t22nwl2hlcM+VICmRBwm4SM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=t49j3XjeGEU7ifY6WoQL0aiWiP8PB2JxC0OInNmWo5IBX+s73VScp4OmKijlc8no7yB7PhbrwkNbC+dXqS0o6RSndzV3j1du8OAN2ee/AFGMti1gD3zgtOrX9RIFahpLhKxclQYORQvsjF/Zd034IzDkl+bvXtDsvT82ETFHrIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4FiySW4J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vSCYKwyz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Feb 2026 11:18:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770117525;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pyHP80ktnjl0/UyGPnuVq4BBwT64GclcMS6Mpyws2ic=;
	b=4FiySW4JGMe95R3uyfyck07IpvN5vdAA82kkaYGXHQTTyk0CPL5Qz5aF4BZzi54i6rxSL4
	XK57fbTwxw2q/8eHzYSRuksMvapK49rKyoAARzwy8ApBabJWkJPK+Kvd3wnrtapLxqrcdX
	14pr3wn/oq7PZJd+iNa/XvLuczvnQJrubNz/IacdJRhlZbT2DUAB0flUAdxo7x+wh/fr+S
	PKCoAvsRxLBDZhzNmFvlFqF5eG/45QWFYlumGo2NcsyzF34zYBK/KE5N1lymvFC+fdWFYN
	IXqxWcY2zTcKIlWdbn/smPKdFVMUxT3hG5vhu30E8Xd9tQe/topJI2IboquqVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770117525;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pyHP80ktnjl0/UyGPnuVq4BBwT64GclcMS6Mpyws2ic=;
	b=vSCYKwyzF0H4cvV0WOyWgPWKg6Z+pUIg4WDKX5MvsUDEwI03jgbMqUqH577Txp4GoyS4Ec
	tYU6FeoAKmzE5fDg==
From: "tip-bot2 for Joel Fernandes" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/debug: Fix updating of ppos on server write ops
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Andrea Righi <arighi@nvidia.com>,
 Tejun Heo <tj@kernel.org>, Christian Loehle <christian.loehle@arm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260126100050.3854740-3-arighi@nvidia.com>
References: <20260126100050.3854740-3-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177011752387.2495410.9792559304780287128.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8192-lists,linux-tip-commits=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,msgid.link:url,linutronix.de:dkim,infradead.org:email,vger.kernel.org:replyto,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 29250D82AA
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6080fb211672aec6ce8f2f5a2e0b4eae736f2027
Gitweb:        https://git.kernel.org/tip/6080fb211672aec6ce8f2f5a2e0b4eae736=
f2027
Author:        Joel Fernandes <joelagnelf@nvidia.com>
AuthorDate:    Mon, 26 Jan 2026 10:59:00 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Feb 2026 12:04:16 +01:00

sched/debug: Fix updating of ppos on server write ops

Updating "ppos" on error conditions does not make much sense. The pattern
is to return the error code directly without modifying the position, or
modify the position on success and return the number of bytes written.

Since on success, the return value of apply is 0, there is no point in
modifying ppos either. Fix it by removing all this and just returning
error code or number of bytes written on success.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Acked-by: Tejun Heo <tj@kernel.org>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/20260126100050.3854740-3-arighi@nvidia.com
---
 kernel/sched/debug.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 929fdf0..ed9254d 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -339,8 +339,8 @@ static ssize_t sched_fair_server_write(struct file *filp,=
 const char __user *ubu
 	long cpu =3D (long) ((struct seq_file *) filp->private_data)->private;
 	struct rq *rq =3D cpu_rq(cpu);
 	u64 runtime, period;
+	int retval =3D 0;
 	size_t err;
-	int retval;
 	u64 value;
=20
 	err =3D kstrtoull_from_user(ubuf, cnt, 10, &value);
@@ -374,8 +374,6 @@ static ssize_t sched_fair_server_write(struct file *filp,=
 const char __user *ubu
 		dl_server_stop(&rq->fair_server);
=20
 		retval =3D dl_server_apply_params(&rq->fair_server, runtime, period, 0);
-		if (retval)
-			cnt =3D retval;
=20
 		if (!runtime)
 			printk_deferred("Fair server disabled in CPU %d, system may crash due to =
starvation.\n",
@@ -383,6 +381,9 @@ static ssize_t sched_fair_server_write(struct file *filp,=
 const char __user *ubu
=20
 		if (rq->cfs.h_nr_queued)
 			dl_server_start(&rq->fair_server);
+
+		if (retval < 0)
+			return retval;
 	}
=20
 	*ppos +=3D cnt;

