Return-Path: <linux-tip-commits+bounces-8341-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ar2MAqSpmnxRAAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8341-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Mar 2026 08:47:22 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3401EA563
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Mar 2026 08:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0DF6B300381B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Mar 2026 07:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA4825F7A9;
	Tue,  3 Mar 2026 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eo9vYJr9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X7Miwzqk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E95E19ADB0;
	Tue,  3 Mar 2026 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772524029; cv=none; b=XTMrR3TEHTQD1cnDO30sE0LivHHQANLbUhMeSTS06fVcv9TrI0ga5RVNp6AT2dA7WI4P4ygL+85Po6WKEihPgin+MCdmkhXm9bZo8O3utqURXa/UwggULHTq6zSdx1w+eRfTFgJFvGExrJB4YW68wFzdZVTb4nuuX1dv6Gsd7o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772524029; c=relaxed/simple;
	bh=rzPCKFSh3ojf/lEAss3se8NDbn9UYY67+Idcv+MUqZg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mWpOyOGD8XwfmKrZbIo5hUbZR1RN1Uuvt9QzFiougfmJllNPgLekKEMFjExADxGwZBaMD0/EoTYnrZ7GPchu4YVhOgl26iZJ9yQNioay0FeXgpKws1kmTS8a4fnIBGJBK8eEmJFXpkRqLU4wvjq8JjTt78FnPTyTquKDQ83hxt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eo9vYJr9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X7Miwzqk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Mar 2026 07:47:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772524025;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LdPbB9/s+Ua2VcbUXDv84xd22HjSqsyLPi1rqG5DGcI=;
	b=eo9vYJr9jl5SVX8QLIK1AoKNTMnIxJjOOqpYxvmkRzPq9lTJ1QHwWV3k2EUDH2xXvcz60r
	TwokomaHLHuksSFE9gNxSXJZaz+7+BAURZWK8C4Y4/KxQhFXoGrk5bT1AgkWGmuudnzusU
	hmCLlluKXwMWEIIZpWidDrJ+o85Ks9GPxuyJgTU9VQi/MnluIUCVoLYxcykgQyPzbOTaPn
	rfR2uPdJvzS2wfkwigSOwWGic183h4JTkQ1URpo+ItB2zxZi/9OZYM2ibI+6jva7eVQEiQ
	F2WnZYrJxjPkkWUm8n59oai0ZiHXqsl50rrMZXHoUDasRF6/JE5yMgtT3iL/zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772524025;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LdPbB9/s+Ua2VcbUXDv84xd22HjSqsyLPi1rqG5DGcI=;
	b=X7MiwzqkS+3pkWj30UjMgN+IiCQVMNNWkzQ6UXIa3z9C9DpAbjd2cnhXD59w7cvIeY+CU6
	3ByWwFFrkUMEcgDA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/hrtick: Mark hrtick_clear() as always used
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <177245077226.1647592.1821545206171336606.tip-bot2@tip-bot2>
References: <177245077226.1647592.1821545206171336606.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177252402437.1647592.5089126278951532693.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9E3401EA563
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8341-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,infradead.org:email,linutronix.de:dkim,linutronix.de:email,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f74d204baf9febf96237af6c1d7eff57fba7de36
Gitweb:        https://git.kernel.org/tip/f74d204baf9febf96237af6c1d7eff57fba=
7de36
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 02 Mar 2026 11:26:12=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Mar 2026 08:41:10 +01:00

sched/hrtick: Mark hrtick_clear() as always used

This recent commit:

  96d1610e0b20b ("sched: Optimize hrtimer handling")

introduced a new build warning when !CONFIG_HOTPLUG_CPU
while SCHED_HRTIMERS=3Dy [ =3D=3D HIGH_RES_TIMERS=3Dy ]:

  /tip.testing/kernel/sched/core.c:882:13: warning: =E2=80=98hrtick_clear=E2=
=80=99 defined but not used [-Wunused-function]

Mark this helper function as always-used, instead of complicating
the code with another obscure #ifdef.

Fixes: 96d1610e0b20b ("sched: Optimize hrtimer handling")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/177245077226.1647592.1821545206171336606.tip-b=
ot2@tip-bot2
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c39e9b4..2b571e6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -874,7 +874,7 @@ enum {
 	HRTICK_SCHED_REARM_HRTIMER	=3D BIT(3)
 };
=20
-static void hrtick_clear(struct rq *rq)
+static void __used hrtick_clear(struct rq *rq)
 {
 	if (hrtimer_active(&rq->hrtick_timer))
 		hrtimer_cancel(&rq->hrtick_timer);

