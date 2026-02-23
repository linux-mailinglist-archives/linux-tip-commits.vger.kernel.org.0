Return-Path: <linux-tip-commits+bounces-8235-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCmrNnUsnGkKAgQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8235-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:31:17 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F5E174EAE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7497E30266EC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 10:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C2A36074B;
	Mon, 23 Feb 2026 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gOhC4y2w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="frnrnAGt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C10835CB60;
	Mon, 23 Feb 2026 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842656; cv=none; b=dCVYvW5CuHQJggx7YyMoHQjBNdgnpr+yObuI/x/KztRYoLafFr2fDHs0NeWr+DcHG8AKNCvhLrzTrAHH2IDHvUDnMT/5TAmJ7pC+LXP7ahupyw+x2mlkKz/ip24tLjzqPsbExvIjCZBVZmS60p2MfB/CZuGH8S+SQdfnhks3HJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842656; c=relaxed/simple;
	bh=XwY+a8U2DTHObsPo89bVZq8GowZRgs812v3poie4sWI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YwLAwKnCjnFfNucDXfV/QjyEt50yGY4LDPIHDNEM9ApLYeMoqC2FsGl2nDFn537g1Kyv9FXhG9zojWx1bmIRG7067yrLML52YcDN8OWYtAAlnXxsaeBe61xdow5kU6pycpM/ZGmmBFFdKj5UtIrUbgOzkM1AWu7xj/0UF1CQwAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gOhC4y2w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=frnrnAGt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 23 Feb 2026 10:30:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771842653;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X0w23o/jjoWieMUKcFCeQp2nJ+QZjZvYZj+VoRTRzB4=;
	b=gOhC4y2wTVjKN8fIBtic4lqvaLry3S0FTp34X8g41bzGF5b698UOLrfDOxNcsp4iJeHv0S
	gxFC6TzYon1zi9xGhpckyZ3ME+slZv2lD3fRdO1gOdsKGzKrA01e1JAUkMyVtc4gab+Kny
	F6Yj9X9rgXSgdtj/tToehiePj4VSmBRH/BkuoLCGD2qBxKI08dV49PlalUnKGnWf5NFf87
	TwbUZbyKv94Efis2cbNDsdxUP5ES6MwMiXKrho+L1muOf5mSD71AuS7iizM0ExTRw9NCGR
	SOli4DBGH/U1WqtT2MZLVQ0FqProN6ohbW98Yb0s91UY6ijOT+o89xNk42w+uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771842653;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X0w23o/jjoWieMUKcFCeQp2nJ+QZjZvYZj+VoRTRzB4=;
	b=frnrnAGtPwM9c/DpJZbiBTfAVD6iCkxtFnwkIu1Nzu5Bi3pyNuka4giTziAF4Ot0tLTBEQ
	PRzZBs7Dl7GfuSAA==
From: "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf/core: Fix invalid wait context in ctx_sched_in()
Cc: "Lai, Yi" <yi1.lai@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250603045105.1731451-1-namhyung@kernel.org>
References: <20250603045105.1731451-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177184265243.1647592.11634164712578683062.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8235-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linutronix.de:dkim,intel.com:email,msgid.link:url,vger.kernel.org:replyto];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 86F5E174EAE
X-Rspamd-Action: no action

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     486ff5ad49bc50315bcaf6d45f04a33ef0a45ced
Gitweb:        https://git.kernel.org/tip/486ff5ad49bc50315bcaf6d45f04a33ef0a=
45ced
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Mon, 02 Jun 2025 21:51:05 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 11:19:25 +01:00

perf/core: Fix invalid wait context in ctx_sched_in()

Lockdep found a bug in the event scheduling when a pinned event was
failed and wakes up the threads in the ring buffer like below.

It seems it should not grab a wait-queue lock under perf-context lock.
Let's do it with irq_work.

  [   39.913691] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
  [   39.914157] [ BUG: Invalid wait context ]
  [   39.914623] 6.15.0-next-20250530-next-2025053 #1 Not tainted
  [   39.915271] -----------------------------
  [   39.915731] repro/837 is trying to lock:
  [   39.916191] ffff88801acfabd8 (&event->waitq){....}-{3:3}, at: __wake_up+=
0x26/0x60
  [   39.917182] other info that might help us debug this:
  [   39.917761] context-{5:5}
  [   39.918079] 4 locks held by repro/837:
  [   39.918530]  #0: ffffffff8725cd00 (rcu_read_lock){....}-{1:3}, at: __per=
f_event_task_sched_in+0xd1/0xbc0
  [   39.919612]  #1: ffff88806ca3c6f8 (&cpuctx_lock){....}-{2:2}, at: __perf=
_event_task_sched_in+0x1a7/0xbc0
  [   39.920748]  #2: ffff88800d91fc18 (&ctx->lock){....}-{2:2}, at: __perf_e=
vent_task_sched_in+0x1f9/0xbc0
  [   39.921819]  #3: ffffffff8725cd00 (rcu_read_lock){....}-{1:3}, at: perf_=
event_wakeup+0x6c/0x470

Fixes: f4b07fd62d4d ("perf/core: Use POLLHUP for a pinned event in error")
Closes: https://lore.kernel.org/lkml/aD2w50VDvGIH95Pf@ly-workstation
Reported-by: "Lai, Yi" <yi1.lai@linux.intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: "Lai, Yi" <yi1.lai@linux.intel.com>
Link: https://patch.msgid.link/20250603045105.1731451-1-namhyung@kernel.org
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ac70d68..4f86d22 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4138,7 +4138,8 @@ static int merge_sched_in(struct perf_event *event, voi=
d *data)
 			if (*perf_event_fasync(event))
 				event->pending_kill =3D POLL_ERR;
=20
-			perf_event_wakeup(event);
+			event->pending_wakeup =3D 1;
+			irq_work_queue(&event->pending_irq);
 		} else {
 			struct perf_cpu_pmu_context *cpc =3D this_cpc(event->pmu_ctx->pmu);
=20

