Return-Path: <linux-tip-commits+bounces-8148-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLXYCA0nfWkGQgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8148-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 22:47:57 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3E4BEE1B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 22:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BDF730094CD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 21:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8232E7637;
	Fri, 30 Jan 2026 21:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gBtjPjOd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WnusIJ0p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896472F656E;
	Fri, 30 Jan 2026 21:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769809674; cv=none; b=F4Ek6Is1FTbgTZ83TfBlhZmuNRqTPzZME+/fRwcs9Uh6Pmlhv9I+swwXygo4+zGVdsjIo0sDqnu5gh4xjxnvNKdR79wha2sQaP9AOmokbwTY+G2fj5MIkJEExVZ5BbYt1oqiYl6wVqSeg2Ws/I7m/u7ivqJQW+ucxU9Tdi5/hes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769809674; c=relaxed/simple;
	bh=VvRYU9fkJBgjn/dxj99cVoDWu4ZogpbtENTyrUTQre4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VRZG8MD9Chg78uSPlfo98opWLoUJ9qxKlYMG94WYdgiyWeAOXNDzy39q0yQCTQASKDU8NqU94kn5gJtqaDevOFkZZACpqXvf+6+4i41OznwD78qX6cuSfIa+htAnucY1wAWi6hvmK/drfH+Rqe53TW4drkraO6SDYQeYTVLtbDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gBtjPjOd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WnusIJ0p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 30 Jan 2026 21:47:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769809671;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fVrr70mL4C4Rjqxd1+jVJRwWfdbbeR5yPTlDjYRtn2o=;
	b=gBtjPjOdNFKeSFzw1VVFiXwhMRqsbAB9ZcdzeiNBr/MHs0y1wy4IwoQ4XJB7acHA/Ayt9U
	OCtfp2T2iIpypIBeyzV5OVVIULRQAzNW0teRbhfU8+/Ya65wmvAIC/pWy+lNdr3or9FiXx
	UTXdsQ2L+LtV2UnXj2uO7T6krFtQB5BuM5pKh4+JVC/ZXUOzI8dz2F796h5qH0jym0Bbha
	flktcOFVHDhgzar3XWOkcBd5Jvib144hnWBrsjAz6PfwZ/OpBDVxP+ssZ3ZV1ZzwBNYEK2
	1uDgtEW+B37e4YM3/gq9hUC6X5BmR0Bzr7X/w34JnNZQRHWvthbnKqqC16xMDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769809671;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fVrr70mL4C4Rjqxd1+jVJRwWfdbbeR5yPTlDjYRtn2o=;
	b=WnusIJ0pT3uxeIbJqzi/Woiy4TGoCI2bkyQ6t7jsVUW90oXSXl01AZ0VZY4lXMANFWo/By
	eGCPmxKbeWO0nKCg==
From: "tip-bot2 for Ionut Nechita (Sunlight Linux)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/nohz: Optimize check_tick_dependency() with
 early return
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260128074558.15433-3-sunlightlinux@gmail.com>
References: <20260128074558.15433-3-sunlightlinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176980966983.2495410.13490237922915334474.tip-bot2@tip-bot2>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8148-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,gmail.com,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 8E3E4BEE1B
X-Rspamd-Action: no action

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     56534673cea7f00d96a64deb58057298fe9f192e
Gitweb:        https://git.kernel.org/tip/56534673cea7f00d96a64deb58057298fe9=
f192e
Author:        Ionut Nechita (Sunlight Linux) <sunlightlinux@gmail.com>
AuthorDate:    Wed, 28 Jan 2026 09:45:43 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Fri, 30 Jan 2026 22:13:13 +01:00

tick/nohz: Optimize check_tick_dependency() with early return

There is no point in iterating through individual tick dependency bits when
the tick_stop tracepoint is disabled, which is the common case.

When the trace point is disabled, return immediately based on the atomic
value being zero or non-zero, skipping the per-bit evaluation.

This optimization improves the hot path performance of tick dependency
checks across all contexts (idle and non-idle), not just nohz_full CPUs.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ionut Nechita (Sunlight Linux) <sunlightlinux@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260128074558.15433-3-sunlightlinux@gmail.com
---
 kernel/time/tick-sched.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 8ddf74e..fd928d3 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -344,6 +344,9 @@ static bool check_tick_dependency(atomic_t *dep)
 {
 	int val =3D atomic_read(dep);
=20
+	if (likely(!tracepoint_enabled(tick_stop)))
+		return !val;
+
 	if (val & TICK_DEP_MASK_POSIX_TIMER) {
 		trace_tick_stop(0, TICK_DEP_MASK_POSIX_TIMER);
 		return true;

