Return-Path: <linux-tip-commits+bounces-8247-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WN3qIMdrnWnhPwQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8247-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 10:13:43 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB09184588
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 10:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 567CE3022F4B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 09:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E74436A025;
	Tue, 24 Feb 2026 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mSv6cEJW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2W2Sv0tr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B811369961;
	Tue, 24 Feb 2026 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924404; cv=none; b=caCYXNVgGWugZZfWERPULzfW3t+8CbofzhBrcxNFizLxrl3J6L61kp6mtFVoySUaqZ4Ri1A7Vuwl/VDkhvqu4hD8k8mP2ygkqsn6fdUN37QcNzkAXdiHrF+Tjj3QTuWtT6HSJCTEZeXIOIqyysFPC36BEfsrQqml+KVO6YLt8+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924404; c=relaxed/simple;
	bh=KuVYNikS8k7Jt4yfESvQVEjuHDgUBn9GeK+pA9pjfXE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pheSf5UF3/HLrP5V4KZI1R4JCQWWeNdYlhYdhFmbkjlnnqQM91HhNjk8JOKB0Q/CG8REhUraxMeW3cFQkQmist/WQaHL6JjsGEYiHnNmu1nH5V3YLvOoL9fSM1ZqUx0hKVueXoHsO//1E8reIimwkogIIbIWyjjOemBxR33cRTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mSv6cEJW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2W2Sv0tr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Feb 2026 09:13:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771924399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nw/RQJN1dYC8NGS9Ny5JsfBxdf0dOQtXMX/699FE2EY=;
	b=mSv6cEJW+bfZJ0L3AK0eKk9CgYdD+RR+1C71zLhdHdtOCpP3IVIvi73z+42l6uRjBrDmMX
	m5+P4mU8fvlk0rWTwcigHzTXbh/iATkqBqwlqi+8KCby8e6vcGRObpwuqToS8JtrDqf6Gx
	BoDr2JSflg/fDZg2UQ/0jbZDwYZR+0FQmkiy7tW07Oqi8qjx42dg1Be7kQKZQh5ZRouJoh
	qnt0POle9UAWyggVe39Sasseew4HFXNYrdk2uj/PlZz7bSpq1HZqTckti3rOcqNyHH6o8H
	7nZXQtUse43SK8qCw/8l2JCwBfbUED8Fx2ecCuSBUS2/Lrm/3bJNmg1SiJnpqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771924399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nw/RQJN1dYC8NGS9Ny5JsfBxdf0dOQtXMX/699FE2EY=;
	b=2W2Sv0trPdZlBxJ/wsJc4lV1Psv31a1Vf220M5PPN7KT1MOb6RuBXhRrY3odU+g185LQ5n
	98+/OJzKlmC9pVDg==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Update overutilized detection
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Qais Yousef <qyousef@layalina.io>,
 Christian Loehle <christian.loehle@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260213101751.3121899-1-vincent.guittot@linaro.org>
References: <20260213101751.3121899-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177192439878.1647592.12684081681566840926.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8247-lists,linux-tip-commits=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:replyto,layalina.io:email,msgid.link:url,arm.com:email]
X-Rspamd-Queue-Id: DCB09184588
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9264758066061e660c86e48cff1bac4a58a7324a
Gitweb:        https://git.kernel.org/tip/9264758066061e660c86e48cff1bac4a58a=
7324a
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Fri, 13 Feb 2026 11:17:51 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 18:04:11 +01:00

sched/fair: Update overutilized detection

Checking uclamp_min is useless and counterproductive for overutilized state
as misfit can now happen without being in overutilized state.

Since commit e5ed0550c04c ("sched/fair: unlink misfit task from cpu overutili=
zed")
util_fits_cpu returns -1 when uclamp_min is above capacity which is not
considered as cpu overutilized.

Remove the useless rq_util_min parameter.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/20260213101751.3121899-1-vincent.guittot@linar=
o.org
---
 kernel/sched/fair.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 23315c2..b8b052b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7018,16 +7018,15 @@ static inline void hrtick_update(struct rq *rq)
=20
 static inline bool cpu_overutilized(int cpu)
 {
-	unsigned long  rq_util_min, rq_util_max;
+	unsigned long rq_util_max;
=20
 	if (!sched_energy_enabled())
 		return false;
=20
-	rq_util_min =3D uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
 	rq_util_max =3D uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
=20
 	/* Return true only if the utilization doesn't fit CPU's capacity */
-	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
+	return !util_fits_cpu(cpu_util_cfs(cpu), 0, rq_util_max, cpu);
 }
=20
 /*

