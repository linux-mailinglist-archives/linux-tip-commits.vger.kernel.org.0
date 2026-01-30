Return-Path: <linux-tip-commits+bounces-8147-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHiQDkLcfGkFPAIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8147-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 17:28:50 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C05BC895
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 17:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A280A3001A70
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 16:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8297331A051;
	Fri, 30 Jan 2026 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lGUrGe+p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FFhflUVf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3024F32B992;
	Fri, 30 Jan 2026 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769790525; cv=none; b=mcy3euL2koAe5xsoaTgOpdq0TuqETBu2mLHdLOEsoQdqG01eFRaT1Wt2nfdIGMjkSjNG1WbTnbamfeyZCXT2FqZG6PCKHIorKRpNpcuRo0MRRk37f46ulT+eY3dX5M/luYxr6BG9bHgiZH5eU0ExvNilGABwbquqwIYYVahe3Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769790525; c=relaxed/simple;
	bh=Le0T78bLS+1aK5YkgpciEQ0WJItFX86Mn7vfdUii3Vw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C+UH80+/77fGanpWWg0/5VXABolf9y7/OteJczrMgrKZn0T1dKelre/HPR95iRpez0j+5TCfVjCCdBhmcBXzvwqZuF7DuCdlieckhhXaz5MGFq3yJ3YyP2KxdWuXwiNPN+6GBwiYI29SV1EXIUUDeZgW4cA0xY37mWlU0jTqCQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lGUrGe+p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FFhflUVf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 30 Jan 2026 16:28:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769790522;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EaPdi6ssXiPxfNNcuTYAv/gfTe0oHZoVLA0gVyFcwYI=;
	b=lGUrGe+pFnN+iLH4bLoSwFkhMhbStHh+19nt6qavhUXKEQxyvpkaMYOWSSJanZzF6pflF9
	ErqXamK8VJWt5jZmW6WTi8y6QAhW6g7ZYP5OoS6yQ/ivCrcnVpMMbdpS9g+fGcaz486wtm
	f8vRSUGqaM4JJBVtlho6/GJi1UqzWWnd/rV7B3p1PRPoBE2G8oCCQgbRJLrwL/WMvi92QP
	svbD2h5BmQRmUCZ58obrTDskgOw9QPif3SqV/v39qvV9UIwlRRfOrU76sgt3tut1b2wFkU
	zgX0Tg6Jv4IgsWQdxYhDzhzKseD8SuLwpfjj94DIO9r/qBWh0Qf69WLEF1Lm0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769790522;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EaPdi6ssXiPxfNNcuTYAv/gfTe0oHZoVLA0gVyFcwYI=;
	b=FFhflUVf7k6fQoOMtDPbXP0Hk+Jtb0/XIEVzDuKwhqjJaKtlZ+I9a6sn82qHvLEz/DRiSy
	S3jrgvYUKSIOvjCA==
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
Message-ID: <176979052132.2495410.7439244707384438738.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8147-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 50C05BC895
X-Rspamd-Action: no action

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     9328c0960f22e2499319e4e894abb98aa0f9d222
Gitweb:        https://git.kernel.org/tip/9328c0960f22e2499319e4e894abb98aa0f=
9d222
Author:        Ionut Nechita (Sunlight Linux) <sunlightlinux@gmail.com>
AuthorDate:    Wed, 28 Jan 2026 09:45:43 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Fri, 30 Jan 2026 17:24:31 +01:00

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

