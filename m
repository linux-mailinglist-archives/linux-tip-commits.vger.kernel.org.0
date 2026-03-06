Return-Path: <linux-tip-commits+bounces-8374-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PQ5FjBmqmlOQwEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8374-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Fri, 06 Mar 2026 06:29:20 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9F321BB73
	for <lists+linux-tip-commits@lfdr.de>; Fri, 06 Mar 2026 06:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90411304AA0E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Mar 2026 05:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC48336E476;
	Fri,  6 Mar 2026 05:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w5dTWpeJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="grZx5/OO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B187B36D508;
	Fri,  6 Mar 2026 05:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772774925; cv=none; b=cA/JgabOdGcHlw+Nl9mW5sfBECkZR1zhVT4CLFQWNhAMWHn/TU+CZH6+4SSS1WN5F1vxCjE+UOQwgyqGIGj4cJftZnRUmdz7tDZLwZF6q1OAmIfpqU+ImCt5Jm0TINxLFARvYg7awKX3ikzdfkNSeQ/73muPryqkDEp3H5aGLno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772774925; c=relaxed/simple;
	bh=Mkvd8Wis3yaMH6s66G20FcilZRyFg/5X0nbrGyT0vRo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=vFzcy8Nf6+6ZRW9pJChXgxy+HtLXlW3z+WY7vjBjZQLkMCBTgQtiRrg+NIQ33yvRWCvhFVZOHTj7qvWqFPfhfSAzE61f42vqXXvY8JssTuzvusnhfJuAgfbdLCdHRMBabe0/flgO5R32wI5Gjo7b65DvYG/8WGiSRipBwH1OwpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w5dTWpeJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=grZx5/OO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Mar 2026 05:28:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772774923;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IHwuGwqyWibKhtxW7z7m071l1Y1Ke5CMbZZtrYtH0vU=;
	b=w5dTWpeJ3pAq47lxs3mf9oZuas98zY2r2YodHRNDe/jWekxAfVgqL65/M1Ms7755rPkG7E
	RLbNoFz7ct8kYExVdeWlIoqL12j0wFIR7MwEtmbHKwvhCPNDxawb6UC02YTpUgwpn4MNCO
	pGH7jvNeFdI1ivn+RGJ6ooEXQEdCNb4n9WZyEjj6hbGG+yqevpXLhqCowf1GqbeB5o4PCV
	vlYC35YHx4O2Fq4OdE4E/LK1tlD0mYeU+/b/fhUluU8clUqcGmZRcR4XgH8dyHq2FyqCbs
	+BmSLaWjO23bdnV8zPxsS61uOFP9/uWShcBUw76CO3ZHT4P9SxHWNSvivgkLLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772774923;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IHwuGwqyWibKhtxW7z7m071l1Y1Ke5CMbZZtrYtH0vU=;
	b=grZx5/OOcZRFV0KFpNv2HGR9uHzCRS2iA6iQLmi8iPQ7LV5ZEett76E4D1CEauLyvZ/TcZ
	d7C2vazqh/BHzOBg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] sched/hrtick: Mark hrtick_clear() as always used
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
Message-ID: <177277492207.1647592.14924771207488449301.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CC9F321BB73
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8374-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:replyto,infradead.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:email];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     eef9f648fb0e92618041f019d4bdcf7ae17cb743
Gitweb:        https://git.kernel.org/tip/eef9f648fb0e92618041f019d4bdcf7ae17=
cb743
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 02 Mar 2026 11:26:12=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2026 06:20:03 +01:00

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
index 49a64b4..a4e7698 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -879,7 +879,7 @@ enum {
 	HRTICK_SCHED_REARM_HRTIMER	=3D BIT(3)
 };
=20
-static void hrtick_clear(struct rq *rq)
+static void __used hrtick_clear(struct rq *rq)
 {
 	if (hrtimer_active(&rq->hrtick_timer))
 		hrtimer_cancel(&rq->hrtick_timer);

