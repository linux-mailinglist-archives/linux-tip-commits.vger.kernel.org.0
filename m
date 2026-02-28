Return-Path: <linux-tip-commits+bounces-8310-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFzQN/MNo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8310-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:46:59 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 838031C41C8
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78FDD313514C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DB147F2C9;
	Sat, 28 Feb 2026 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e9AzzT78";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZxV7ReZ4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5417147ECF3;
	Sat, 28 Feb 2026 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293004; cv=none; b=teAAULL7HH4NT0wNOvHYc5Zx7zz4o3IOuGIokPTlbqH0qZJ2G4uvGpneXJ2WqbVyt0jphM0UhsAUWta57WCxpWRS1Z1bjZ/37Q4cjAwCtxHGbCznck5NhGd//O5QG8Rm/6bS6dvIa+10+OTt3zntm69Zhgk37VXfAlWCrQ7C+v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293004; c=relaxed/simple;
	bh=IXQpp7FFNLHioRl8/ddKvLd+/cZUqVyx4DBL4FVjGcI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A36CdyeoN4Ojd47oFLwhl4TknTmq6qkFFSTB6bZhZ4J+3ecFPXPd4u/Rwn6DBjwIETkLdgstWbB04zUylvV19Sv8MflOQtMMKX49vetA8K1diHDjkin35awE2aB42c+s6EduOHVlRnnvZZSqy2TWeoaYj1H6/hgdNQxpwcmIhyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e9AzzT78; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZxV7ReZ4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hTtwOII+ZKS92tIvqmz0kxiJKSSIQDiga+RHqfdESA=;
	b=e9AzzT78L3P7ivvnlyXh/ObUDG9sUtHMYTZZmXpx/W+sPrOs4hRhE7v2J+pW9zgaCgugJg
	CMxQMtC1x/cor9ZFTFH0/J72Psrc4aLtX5ZsUKDSQRF4yFZvOguyN041ib2NFhjc7ewnPw
	1ML3cqVnljq7j/U7hgR6GIDIZZIgYWPf5j2+qB3SNr5DCGS9+GM6M2+zckfRKGLOaYXehF
	rp6e/9IswFosPv06xO0ccblmMH+nmYxSqyaf3riWWpjajjHw1goLZb6gb5Q2FVf564FEPV
	nedWLNSno6Pyy4fhcnyJm0ZEbj2tbuxg6IYDfcQZFTF7a3vPxkyszR+GyCM7gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hTtwOII+ZKS92tIvqmz0kxiJKSSIQDiga+RHqfdESA=;
	b=ZxV7ReZ4vABeQkZ+pkVkIM+lruUfF/jIu3RZlPVqnPnNWoG+A3Nn1Jkmxlg7E7j/3j88BF
	H3gGtEOLkKwuLLBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Evaluate timer expiry only once
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163430.409352042@kernel.org>
References: <20260224163430.409352042@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229299738.1647592.3772050290305889924.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8310-lists,linux-tip-commits=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 838031C41C8
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     8ffc9ea88136903812448a04127e1ee2c0460f24
Gitweb:        https://git.kernel.org/tip/8ffc9ea88136903812448a04127e1ee2c04=
60f24
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:37:14 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:10 +01:00

hrtimer: Evaluate timer expiry only once

No point in accessing the timer twice.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163430.409352042@kernel.org
---
 kernel/time/hrtimer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 0448ba9..e6f02e9 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -810,10 +810,11 @@ static void hrtimer_reprogram(struct hrtimer *timer, bo=
ol reprogram)
 {
 	struct hrtimer_cpu_base *cpu_base =3D this_cpu_ptr(&hrtimer_bases);
 	struct hrtimer_clock_base *base =3D timer->base;
-	ktime_t expires =3D ktime_sub(hrtimer_get_expires(timer), base->offset);
+	ktime_t expires =3D hrtimer_get_expires(timer);
=20
-	WARN_ON_ONCE(hrtimer_get_expires(timer) < 0);
+	WARN_ON_ONCE(expires < 0);
=20
+	expires =3D ktime_sub(expires, base->offset);
 	/*
 	 * CLOCK_REALTIME timer might be requested with an absolute
 	 * expiry time which is less than base->offset. Set it to 0.

