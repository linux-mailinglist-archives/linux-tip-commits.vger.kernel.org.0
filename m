Return-Path: <linux-tip-commits+bounces-8308-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHUnBbINo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8308-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:45:54 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF241C4193
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8CBF3096FC7
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537B547D92B;
	Sat, 28 Feb 2026 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L5yBPHHk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BmNFhJNe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C8C47DD49;
	Sat, 28 Feb 2026 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293003; cv=none; b=M0qmHsofnfKHdCt/oxusD5CeIdJMTRXxDMosJAaGyNxUKRaXkcKgtq4flMVWawoEjFsZeBq3aapxHA95gYwBJvLm2HQ9h7Nt/v55lPUg2zUXjZV/nq5WMbsQ+MK+1y3MswylumgPw0E1HIDwuLwOmMSTnncIciK0XCU0GFoiHgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293003; c=relaxed/simple;
	bh=0rdlmNlEALuHyq+zBF88oenWj//pw+AV3h5cqO4w2/o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NKDGeO2IpeIMP0AGQrEYSIzCRpKxPkSrpVXdDkfsdoAqYeeyGBHI9i4/xrMaC78ntqLc8NEo4qCe7Uxl1/fMR7YJRo/iY1lyZk1j++hwDReSvv9ZOPv9pj/zjajWmjhFn4ls0AjxVDNyQk3QGK18Nr4u0AgK6vPJNOvQb086PX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L5yBPHHk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BmNFhJNe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292994;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eS0i8AcuaK1+JqJ4H/N4yr1ntIeVielAhgtcieQFrUc=;
	b=L5yBPHHk/SvcfRU7Xdk+XIRIgWPwl3RKX6cWVzT563A4RFKBkbtxs6rAKtwdluSGlxR2X7
	8/3ZME/ksLJKx5M1fWyLyDkrUaxjy6WvilOShDzHzB4hD7ybIm93SOhePGDASXrYeuDJfR
	8bWltFp+Rh0lSQGELep9fo2V79R2mvPn7OEE+viEzHmb6Qjj1a/Y0WNhvTVGCM2QOU93y+
	iQdo/KWy+Yp4PuMi/5E2VY/xus5hsgzEMD/fu2TomPpmtU2jfK2dG4bu4lZNan5lkhpq2j
	BELjnW5321zNpKiKLx0ucy7ad3Z3vot1kJUzvHcb5I/811QCBuCM3MA0p4AO0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292994;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eS0i8AcuaK1+JqJ4H/N4yr1ntIeVielAhgtcieQFrUc=;
	b=BmNFhJNeQ1xbQbpOBBIuBFsVs+Rf/kUSSZSsnfJkK7F3zj5D3V2oEjC2/zqk6wfLTjnBFD
	ofzKc/b/TqCdKPBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Use NOHZ information for locality
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163430.673473029@kernel.org>
References: <20260224163430.673473029@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229299289.1647592.10986848186850662678.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8308-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:dkim,infradead.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url];
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
X-Rspamd-Queue-Id: 1EF241C4193
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     c939191457fead7bce2f991fe5bf39d4d5dde90f
Gitweb:        https://git.kernel.org/tip/c939191457fead7bce2f991fe5bf39d4d5d=
de90f
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:37:33 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:11 +01:00

hrtimer: Use NOHZ information for locality

The decision to keep a timer which is associated to the local CPU on that
CPU does not take NOHZ information into account. As a result there are a
lot of hrtimer base switch invocations which end up not switching the base
and stay on the local CPU. That's just work for nothing and can be further
improved.

If the local CPU is part of the NOISE housekeeping mask, then check:

  1) Whether the local CPU has the tick running, which means it is
     either not idle or already expecting a timer soon.

  2) Whether the tick is stopped and need_resched() is set, which
     means the CPU is about to exit idle.

This reduces the amount of hrtimer base switch attempts, which end up on
the local CPU anyway, significantly and prepares for further optimizations.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163430.673473029@kernel.org
---
 kernel/time/hrtimer.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index b87995f..4caf2df 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1231,7 +1231,18 @@ static __always_inline bool hrtimer_prefer_local(bool =
is_local, bool is_first, b
 		 */
 		if (!is_local)
 			return false;
-		return is_first || is_pinned;
+		if (is_first || is_pinned)
+			return true;
+
+		/* Honour the NOHZ full restrictions */
+		if (!housekeeping_cpu(smp_processor_id(), HK_TYPE_KERNEL_NOISE))
+			return false;
+
+		/*
+		 * If the tick is not stopped or need_resched() is set, then
+		 * there is no point in moving the timer somewhere else.
+		 */
+		return !tick_nohz_tick_stopped() || need_resched();
 	}
 	return is_local;
 }

