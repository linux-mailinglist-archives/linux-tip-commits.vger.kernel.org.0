Return-Path: <linux-tip-commits+bounces-8292-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG3WHdALo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8292-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:37:52 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D84461C4039
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57FA2312E4FE
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660AB47D926;
	Sat, 28 Feb 2026 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KHRmS9ht";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zjk4rIKj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AA047CC6D;
	Sat, 28 Feb 2026 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292981; cv=none; b=kuqDZfWinLrimAluwQq6DnfAtUwR2h3XgiuqhgAWoMVxXxU33JHAVo27T9LcU+kY9AJJW3eBI49YfzgsppskXJcwmxdPVS2f8swpRIZo2Rn7qcN6GAyDNkYGl1cmlhdGs9/foDwql4QEXwcq+83XeZgFk+/atd292RF6XkG4R80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292981; c=relaxed/simple;
	bh=WYki//3bX58Bfd/sSLQ4daoh6NdQ+OYHfiOeBMOp+6A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nlxR+C5/wzNCSHse2/5wzx0qvl9F9bBNem0r8TBKwyLH3mf4eLT2bseLgcTsBqF6T2g9xg1//mv3VmmpT8hp77Q5a3amLSxrWejxnPtytiTGX70fgnMqP2j5ClN6KyMDoWG2OFaDj9BxDlhFOzC+RICuOK+QQ1QppPOcZ72GsDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KHRmS9ht; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zjk4rIKj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292978;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PPC0il8z5BiB8AFB2V4+FpIk2fzA7Zs/iC2bgMpncYw=;
	b=KHRmS9htNQLDWMz3f9Yw7cYhh+ipbF4i/9NDKkSqKJN4lGMi12O9cqB5Q3kyNGsoOlEr6g
	zvXIdQEesG6o3VOSY7jKRwSj5YL28JkIYRAjsUGMgCc73gDq29oC+IdSiDwgQdKpoddQzI
	l1ICG4W4jJ98pwOQEHlA8zQtf+Fdf5rcv5OxP/7RfG109NeDIE7Sl+XkS8+SU2AEALbfQe
	e39RepQvoGfITtNrOj82aPcmdDWMaQ6X+Zie1sQRpETINRp8vKSogLSkPvHum/qNsId8bG
	10DVdzJIe0vR9R9L5Qs2EXblb71fzzgPDzvmcrbJBzepLeg1D4GfBFv6hlVeIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292978;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PPC0il8z5BiB8AFB2V4+FpIk2fzA7Zs/iC2bgMpncYw=;
	b=zjk4rIKjj9kwHWQZ0DV4lB9PI3QHkXIDj4nxwLeqGlZcScj1tSN3diUCLP2tI4+rVhetqU
	FnLTexW9hY/9HACA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Optimize for_each_active_base()
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163431.599804894@kernel.org>
References: <20260224163431.599804894@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229297742.1647592.13635675831795556188.tip-bot2@tip-bot2>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8292-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:dkim,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: D84461C4039
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     3601a1d85028d7d479e1571419174fc3334f58f5
Gitweb:        https://git.kernel.org/tip/3601a1d85028d7d479e1571419174fc3334=
f58f5
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:38:42 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:15 +01:00

hrtimer: Optimize for_each_active_base()

Give the compiler some help to emit way better code.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163431.599804894@kernel.org
---
 kernel/time/hrtimer.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index b0e7e29..d1e5848 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -529,22 +529,10 @@ static inline void debug_activate(struct hrtimer *timer=
, enum hrtimer_mode mode,
 	trace_hrtimer_start(timer, mode, was_armed);
 }
=20
-static struct hrtimer_clock_base *
-__next_base(struct hrtimer_cpu_base *cpu_base, unsigned int *active)
-{
-	unsigned int idx;
-
-	if (!*active)
-		return NULL;
-
-	idx =3D __ffs(*active);
-	*active &=3D ~(1U << idx);
-
-	return &cpu_base->clock_base[idx];
-}
-
-#define for_each_active_base(base, cpu_base, active)		\
-	while ((base =3D __next_base((cpu_base), &(active))))
+#define for_each_active_base(base, cpu_base, active)					\
+	for (unsigned int idx =3D ffs(active); idx--; idx =3D ffs((active)))		\
+		for (bool done =3D false; !done; active &=3D ~(1U << idx))			\
+			for (base =3D &cpu_base->clock_base[idx]; !done; done =3D true)
=20
 #if defined(CONFIG_NO_HZ_COMMON)
 /*

