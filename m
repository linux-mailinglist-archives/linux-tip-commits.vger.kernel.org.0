Return-Path: <linux-tip-commits+bounces-8287-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGaKIHMLo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8287-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:36:19 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E03521C3FD1
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 534D330CC7B5
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E957847AF75;
	Sat, 28 Feb 2026 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ut2wvG1s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6LxU/9Yg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC79F32ED2E;
	Sat, 28 Feb 2026 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292976; cv=none; b=nuuFrpGwYtvOIWp/pvU8uiWYp89kQdtJ6DghMuNG/52Jfgjo9LlJHnAQWXntU7IpAYOFv+a+fB9e41cx/L2pRlCXFHJ4i6Gh536JvimbdxsXvOEaNhrWmKFrnDMRq+zyX5CUSpgNYSXRBu2pQ9bv6I6MsNAUJ3vaxCgqPsLLBz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292976; c=relaxed/simple;
	bh=Gee+FCAqn67/flbWP2SeQWmEuKdL3wdVYy4WZixJZhU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cMSNr+/n+FKH7e/lsxCav8GtgPKRK1S5P+NvTZr4RFhu3SJUpGacbjse5/lI1/Rdu/915Czvwi+GW9fRQTVDn7Za3rQQEk3+lTZuUwljCTvG6e8KmSnkR1AG7Bq5jRl+IfIfpG1XJVh5HAuCTBzzeaa+p57mlSeJnRgBpGQQhu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ut2wvG1s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6LxU/9Yg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292973;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMa8PRMYo9qFPU5LKR35CpPA+sDcxIdl28As8q4EiOg=;
	b=ut2wvG1shA3u2jZS+h5QiEPYzP9I3I50HbKf7sXC7GC6K8KgfM4C35/pAfa+3fFxVRpVGc
	LBxY5v939S/38c3A5Lhon7fcHNNbhaB5RHZNcCQvz33k9Qs6M3DNIcwB4EZxyOeM/mGMjK
	Mi2EsVQ/48IcInv6/2rIs1ytew9kr1u015LfY7i/U/7ijgVpfeLZdzk+5RrKBd4tATvlQ1
	oLBH+RAYBaF5z46FUnHF3UbXxPSjQpmrHzM0hPNFIQSA5PssdibgwS6Ypzh97VJ4wB7VgA
	MBGNa7rccdpClhi8JdBvsGqCKh96W4KF9K3VYPEf9Dhm8M8Eo+pbC/KGnVdHaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292973;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMa8PRMYo9qFPU5LKR35CpPA+sDcxIdl28As8q4EiOg=;
	b=6LxU/9YgJmSzZ5hazE8UyGVI3mLIL9aQ2HZ4aTIQfnisHxwO5ZJnWNq/4paJrxn3/iCAnn
	VbiCdr3q32laaDDw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] sched: Default enable HRTICK when deferred
 rearming is enabled
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163431.937531564@kernel.org>
References: <20260224163431.937531564@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229297171.1647592.1629528576553596315.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8287-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,linutronix.de:dkim];
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
X-Rspamd-Queue-Id: E03521C3FD1
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     9213aa4784cf4e63e6d8d30ba71fd61c3d110247
Gitweb:        https://git.kernel.org/tip/9213aa4784cf4e63e6d8d30ba71fd61c3d1=
10247
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 24 Feb 2026 17:39:08 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:17 +01:00

sched: Default enable HRTICK when deferred rearming is enabled

The deferred rearm of the clock event device after an interrupt and and
other hrtimer optimizations allow now to enable HRTICK for generic entry
architectures.

This decouples preemption from CONFIG_HZ, leaving only the periodic
load-balancer and various accounting things relying on the tick.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163431.937531564@kernel.org
---
 kernel/sched/features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 136a658..d062284 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -63,8 +63,13 @@ SCHED_FEAT(DELAY_ZERO, true)
  */
 SCHED_FEAT(WAKEUP_PREEMPTION, true)
=20
+#ifdef CONFIG_HRTIMER_REARM_DEFERRED
+SCHED_FEAT(HRTICK, true)
+SCHED_FEAT(HRTICK_DL, true)
+#else
 SCHED_FEAT(HRTICK, false)
 SCHED_FEAT(HRTICK_DL, false)
+#endif
=20
 /*
  * Decrement CPU capacity based on time not spent running tasks

