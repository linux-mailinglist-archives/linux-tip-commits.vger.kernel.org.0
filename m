Return-Path: <linux-tip-commits+bounces-8397-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNepBqwlr2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8397-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:55:24 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 706462406B1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBD32315DB61
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CB2426D09;
	Mon,  9 Mar 2026 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EC1VPKHd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9C40yQNQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD3F426680;
	Mon,  9 Mar 2026 19:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085715; cv=none; b=XaEbhjVGnjD7Lig49nRWKMy8Y5LxHjmmn26+G/uQuk4hXwPwNImZHmObeZdsRvwlKPmW9/rDpVKy95CNQio4FN203EqcdF3QWs4bSu52QfVtZPLXe7rMBhwcnFkflPGb6X9wYApIG0fNWxJp/IczVcEwBMN1ok0QWin9/a70Z3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085715; c=relaxed/simple;
	bh=AREs3syYIkFJZ6qwI1dGivi3r4ZFxyEyGyVOcAqrNNU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LitJWWyYjcn63u/kN+orolqboF9SEotBoMygyNB/gMS7TVzk5bjlmpUNCRCisIfJRFqSS9ofs5S8GfRzKEZM+hwZVIIG05D8jPQ1L9GZb/YYLk/i+GpVCFsXVf0guLy5AAZUKGp2v6Ui3UZBhTpsqQO5t632CMBJVFitDwNn4no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EC1VPKHd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9C40yQNQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:48:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773085711;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K0mq7cv3Npj1hewxrhbW2VV4fpi+ald5B76OlNfc6bI=;
	b=EC1VPKHdW1YmPvgCvCSUnjIiGVmojQaRtRVgjLQL+bHn+teU+ke2tM9G3nYRAuWyr4N1As
	VdtoyiOsEdhKEGr+SzZLpUqR93B6bWhHWniIHM3l/KAdOz4wuHXJ54UKYQjyEgMywc+i2B
	yHzc1O3glN6wmb6TqRp3ZeBRRHeBDxeUCC/2d1f5aZM2oRi/oausHakJ36AI2Oc2QyTjMz
	1U8FZ6bSnFr/6EKOFQJ6OhhYN5zb639MaLmFzWXk94UA0vd9vpzFP7ybD0da7QlgFTlj8q
	vMzV3cbzdtG0ZNXQQjy3OZ8hY3iA9Krlo/c6PupS0/rwdH+OKsSdeqCUUn+FBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773085711;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K0mq7cv3Npj1hewxrhbW2VV4fpi+ald5B76OlNfc6bI=;
	b=9C40yQNQvEvAuCPpsuAGM3dGuJS3yHFCb6IhVXbVIRvN9L/eTz59lZ1K4bhIIpeBdqeavB
	hq0qA3iUn/tcwlCg==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: helpers: Generify the definitions of
 rust_helper_*_xchg*
Cc: Boqun Feng <boqun.feng@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260303201701.12204-5-boqun@kernel.org>
References: <20260303201701.12204-5-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308571037.1647592.9207051302810765638.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 706462406B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8397-lists,linux-tip-commits=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f92d22b00e3f75fad2efd965b20d49b4e763b792
Gitweb:        https://git.kernel.org/tip/f92d22b00e3f75fad2efd965b20d49b4e76=
3b792
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Tue, 03 Mar 2026 12:16:52 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 08 Mar 2026 11:06:48 +01:00

rust: helpers: Generify the definitions of rust_helper_*_xchg*

To support atomic pointers, more xchg helpers will be introduced, hence
define macros to generate these helpers to ease the introduction of the
future helpers.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260117122243.24404-3-boqun.feng@gmail.com
Link: https://patch.msgid.link/20260303201701.12204-5-boqun@kernel.org
---
 rust/helpers/atomic_ext.c | 48 +++++++++-----------------------------
 1 file changed, 12 insertions(+), 36 deletions(-)

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
index f471c1f..c5f665b 100644
--- a/rust/helpers/atomic_ext.c
+++ b/rust/helpers/atomic_ext.c
@@ -44,45 +44,21 @@ GEN_READ_SET_HELPERS(i16, s16)
  * The architectures that currently support Rust (x86_64, armv7,
  * arm64, riscv, and loongarch) satisfy these requirements.
  */
-__rust_helper s8 rust_helper_atomic_i8_xchg(s8 *ptr, s8 new)
-{
-	return xchg(ptr, new);
-}
-
-__rust_helper s16 rust_helper_atomic_i16_xchg(s16 *ptr, s16 new)
-{
-	return xchg(ptr, new);
-}
-
-__rust_helper s8 rust_helper_atomic_i8_xchg_acquire(s8 *ptr, s8 new)
-{
-	return xchg_acquire(ptr, new);
-}
-
-__rust_helper s16 rust_helper_atomic_i16_xchg_acquire(s16 *ptr, s16 new)
-{
-	return xchg_acquire(ptr, new);
-}
-
-__rust_helper s8 rust_helper_atomic_i8_xchg_release(s8 *ptr, s8 new)
-{
-	return xchg_release(ptr, new);
-}
-
-__rust_helper s16 rust_helper_atomic_i16_xchg_release(s16 *ptr, s16 new)
-{
-	return xchg_release(ptr, new);
+#define GEN_XCHG_HELPER(tname, type, suffix)					\
+__rust_helper type								\
+rust_helper_atomic_##tname##_xchg##suffix(type *ptr, type new)			\
+{										\
+	return xchg##suffix(ptr, new);					\
 }
=20
-__rust_helper s8 rust_helper_atomic_i8_xchg_relaxed(s8 *ptr, s8 new)
-{
-	return xchg_relaxed(ptr, new);
-}
+#define GEN_XCHG_HELPERS(tname, type)						\
+	GEN_XCHG_HELPER(tname, type, )						\
+	GEN_XCHG_HELPER(tname, type, _acquire)					\
+	GEN_XCHG_HELPER(tname, type, _release)					\
+	GEN_XCHG_HELPER(tname, type, _relaxed)					\
=20
-__rust_helper s16 rust_helper_atomic_i16_xchg_relaxed(s16 *ptr, s16 new)
-{
-	return xchg_relaxed(ptr, new);
-}
+GEN_XCHG_HELPERS(i8, s8)
+GEN_XCHG_HELPERS(i16, s16)
=20
 /*
  * try_cmpxchg helpers depend on ARCH_SUPPORTS_ATOMIC_RMW and on the

