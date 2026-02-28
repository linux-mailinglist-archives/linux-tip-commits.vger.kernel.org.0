Return-Path: <linux-tip-commits+bounces-8330-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPaCBgwRo2kf9gQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8330-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 17:00:12 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7C21C431F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 17:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2079030D80D6
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F66E481247;
	Sat, 28 Feb 2026 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rgt14YBC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9orCZU2G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D17481640;
	Sat, 28 Feb 2026 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293028; cv=none; b=fhJEgWRfN7eJubRk+aICgEF1CN2icONDBM+Ay56l0ISZjhM6GWSyuUU2b6bLtWcDVRTEuKsiZPhoN5W+kt90S72SsyLKpcTtfg5SR/XeKr4HxoMbxImAmn6lB5KuW12FOQ+M0pM5LpOLYf8HDLv1fdsIAaG1FUnepcY4OJ0St8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293028; c=relaxed/simple;
	bh=qjcSv+34ShrU3bzBmfL/PVHYCU3dA9SThgACPLLL8mc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=imdVkz73nITZq3CoesM09YiPTdme1eyjjvgoSsG/X4ABSvve5Cmp4JX0r0MN+rMvIi9LJjL+gvxpYeIkT3x+BagIX01OlYGwfJ4Haxj3GBKgZcPD/fvtbL1AeAi2Wt4XPg0VoAygHG7V1YJivTTWm2Ik8IF1RMwtKTlC6bp+huc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rgt14YBC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9orCZU2G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:37:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772293022;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCVmTPSNP6iEJWka88ryjsDw09cQdoAcmMioRfH1T8E=;
	b=Rgt14YBCuRgExr9zC7++n3TFUHcru1Kkj4c7wicXMjrdu2r7f7TbtUYCPo9Q9uVNlx269z
	bO513YciC+7wZ2lykskhcZx2Qk6J/ehyc5aLeXUONgM0OrcqeqDriErbtSF9i736JHhG8V
	aWZqZTVvkzHn1ebTenPOWAlYypitaioeY+4JCtciDaG1PrJZsENke0LswjyBwTqDDgWxrt
	sLq2Hrw77HQYOBrO7KjBji30Ldj8gwgyMfU94WCcSXkeRNWxNfr37zWprRg4bUf9T3zpyB
	S361mDvlI3CgVYJL7l1ZLWedUYlbguPEMwE/xaYdB65ykOcrXB2DAfQ7pQzvtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772293022;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCVmTPSNP6iEJWka88ryjsDw09cQdoAcmMioRfH1T8E=;
	b=9orCZU2GT575G29lKwVnEkd4iJX9GKUXkXWJZySr8VZIu351Ojvplv+ay8qACr1Mq52Y/8
	sppSNcVCIy4ClZBg==
From: "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] sched/fair: Make hrtick resched hard
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163428.933894105@kernel.org>
References: <20260224163428.933894105@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229302120.1647592.15901387229341207962.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8330-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,infradead.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:replyto,msgid.link:url];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 2E7C21C431F
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     5d88e424ec1b3ea7f552bd14d932f510146c45c7
Gitweb:        https://git.kernel.org/tip/5d88e424ec1b3ea7f552bd14d932f510146=
c45c7
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Tue, 24 Feb 2026 17:35:27 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:04 +01:00

sched/fair: Make hrtick resched hard

Since the tick causes hard preemption, the hrtick should too.

Letting the hrtick do lazy preemption completely defeats the purpose, since
it will then still be delayed until a old tick and be dependent on
CONFIG_HZ.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163428.933894105@kernel.org
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0b6ce88..e9e5fe4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5530,7 +5530,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity =
*curr, int queued)
 	 * validating it and just reschedule.
 	 */
 	if (queued) {
-		resched_curr_lazy(rq_of(cfs_rq));
+		resched_curr(rq_of(cfs_rq));
 		return;
 	}
 #endif

