Return-Path: <linux-tip-commits+bounces-8396-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDnJFX4lr2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8396-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:54:38 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EB6240688
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7B763144642
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BA9410D21;
	Mon,  9 Mar 2026 19:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lehdv1it";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zqWaceir"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D50423169;
	Mon,  9 Mar 2026 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085713; cv=none; b=F8TLUMG3wPopy6gLR1vhY0LnsAdQ6QR00DOKiGwFTFM0sORbBh++/r2xlIdAidZCkzH18TMLirAUBuYGfmvRX6Xj7Md4TNA2vu+XuxE90zwx170e1Inm1pO4X8PLZ8Pu7xGtWY60BIZKz6y0GKw8UpC0MeQ4SxJ/gUy5cG+jqCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085713; c=relaxed/simple;
	bh=+r45hsBXOI2bFOM9Ss5wb+tys/APlzPtLfxp+C9gorw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Fxb8svxz+q4WabRBDvD81kRBok5v62wrH2F7siSrl+42J+U3UVommzdGnWVE5XMgSn8aqNPmL3D1ohZbRZqwpFiys3voK78thTI6aNgqhERkxpCk0j0mt9Pq0j+59kuBGP0VvhkpcnhfcYyP0SoXwZGp6beNfdFgg6GG1D3XWz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lehdv1it; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zqWaceir; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:48:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773085710;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jbrF/lm3Rym3fBZiDpeQOLFUi+4nVqUliVpDKEyam2s=;
	b=lehdv1it6/oWMx00sc573f1S2rhx8RoemgZHBfUHa5kyGXSeQ/Xp3jQ3zjMkvDZIaIsStp
	eJKkb5Ts2VyPJKcolP5gdWNIaBJRGDyPkrfdbFXmUFPcfsx1ZwwoxJrg/h/DQhePMR0drB
	wU8KF4/TvwXqboaItYQcEKmSjFsNDObziUnNEm8DVS+S33OikiE/gEqmR3X1seCXgElVOV
	IKalEsYSuhQuDaXANRtZYXmC0Oj/CNUGWQ+ExzCgrCcQDKhODoQvfPrOfGkYlHa6mJx2Io
	+YfTuu5qSKVbg/v5ttV4izjU5u2Ovvs507kp64/Wh9IeTrRaaAwyhHOjQY+Uwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773085710;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jbrF/lm3Rym3fBZiDpeQOLFUi+4nVqUliVpDKEyam2s=;
	b=zqWaceiroxFzqH4iL1/+qKTZsxIpqYI+kyaUAzpj3kJ8lhQPHoEITJ3tecsyW3LV8WOnwW
	yUb6CprSWShjXGAA==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: helpers: Generify the definitions of
 rust_helper_*_cmpxchg*
Cc: Boqun Feng <boqun.feng@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260303201701.12204-6-boqun@kernel.org>
References: <20260303201701.12204-6-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308570908.1647592.15955770289492249022.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 01EB6240688
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8396-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,msgid.link:url,linutronix.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,infradead.org,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a92236bf239cc01fd40d9cbe98fc8b9924c42a82
Gitweb:        https://git.kernel.org/tip/a92236bf239cc01fd40d9cbe98fc8b9924c=
42a82
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Tue, 03 Mar 2026 12:16:53 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 08 Mar 2026 11:06:48 +01:00

rust: helpers: Generify the definitions of rust_helper_*_cmpxchg*

To support atomic pointers, more cmpxchg helpers will be introduced,
hence define macros to generate these helpers to ease the introduction
of the future helpers.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260117122243.24404-4-boqun.feng@gmail.com
Link: https://patch.msgid.link/20260303201701.12204-6-boqun@kernel.org
---
 rust/helpers/atomic_ext.c | 48 +++++++++-----------------------------
 1 file changed, 12 insertions(+), 36 deletions(-)

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
index c5f665b..240218e 100644
--- a/rust/helpers/atomic_ext.c
+++ b/rust/helpers/atomic_ext.c
@@ -67,42 +67,18 @@ GEN_XCHG_HELPERS(i16, s16)
  * The architectures that currently support Rust (x86_64, armv7,
  * arm64, riscv, and loongarch) satisfy these requirements.
  */
-__rust_helper bool rust_helper_atomic_i8_try_cmpxchg(s8 *ptr, s8 *old, s8 ne=
w)
-{
-	return try_cmpxchg(ptr, old, new);
-}
-
-__rust_helper bool rust_helper_atomic_i16_try_cmpxchg(s16 *ptr, s16 *old, s1=
6 new)
-{
-	return try_cmpxchg(ptr, old, new);
-}
-
-__rust_helper bool rust_helper_atomic_i8_try_cmpxchg_acquire(s8 *ptr, s8 *ol=
d, s8 new)
-{
-	return try_cmpxchg_acquire(ptr, old, new);
-}
-
-__rust_helper bool rust_helper_atomic_i16_try_cmpxchg_acquire(s16 *ptr, s16 =
*old, s16 new)
-{
-	return try_cmpxchg_acquire(ptr, old, new);
-}
-
-__rust_helper bool rust_helper_atomic_i8_try_cmpxchg_release(s8 *ptr, s8 *ol=
d, s8 new)
-{
-	return try_cmpxchg_release(ptr, old, new);
-}
-
-__rust_helper bool rust_helper_atomic_i16_try_cmpxchg_release(s16 *ptr, s16 =
*old, s16 new)
-{
-	return try_cmpxchg_release(ptr, old, new);
+#define GEN_TRY_CMPXCHG_HELPER(tname, type, suffix)				\
+__rust_helper bool								\
+rust_helper_atomic_##tname##_try_cmpxchg##suffix(type *ptr, type *old, type =
new)\
+{										\
+	return try_cmpxchg##suffix(ptr, old, new);				\
 }
=20
-__rust_helper bool rust_helper_atomic_i8_try_cmpxchg_relaxed(s8 *ptr, s8 *ol=
d, s8 new)
-{
-	return try_cmpxchg_relaxed(ptr, old, new);
-}
+#define GEN_TRY_CMPXCHG_HELPERS(tname, type)					\
+	GEN_TRY_CMPXCHG_HELPER(tname, type, )					\
+	GEN_TRY_CMPXCHG_HELPER(tname, type, _acquire)				\
+	GEN_TRY_CMPXCHG_HELPER(tname, type, _release)				\
+	GEN_TRY_CMPXCHG_HELPER(tname, type, _relaxed)				\
=20
-__rust_helper bool rust_helper_atomic_i16_try_cmpxchg_relaxed(s16 *ptr, s16 =
*old, s16 new)
-{
-	return try_cmpxchg_relaxed(ptr, old, new);
-}
+GEN_TRY_CMPXCHG_HELPERS(i8, s8)
+GEN_TRY_CMPXCHG_HELPERS(i16, s16)

