Return-Path: <linux-tip-commits+bounces-8401-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEstLEglr2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8401-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:53:44 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D3F240658
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 490533084137
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2044B4279E4;
	Mon,  9 Mar 2026 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wGHvArEI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zEDS3NdN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549B7426D22;
	Mon,  9 Mar 2026 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085719; cv=none; b=jl6M4iQvPctU1FejFXjWLFPvFtfP2jO8InCV/heGG0f2Hp24R7feYO/Fi/oTLZWgmr7VQfRepfD5rGHtlCFkDOlWUx0/MyHs24gZ1Vs5oYOTNqX4UIvr31ux/aBRNXgE7tDWmjvQ/cfM0yidIXkmZqoGF2jyhlFuSSC0TkIBKGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085719; c=relaxed/simple;
	bh=4b3oGF6TBkoLeLHLQtJlSUgfH2JniUjuDSilAIevxXg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dgobo+9vaLinqrsjVfU0dgDdLL2GKWbIqwMp1EKe/Svkf8RidYG6/7RNEYHf03UigyabE/cRXy5xKaFfHRRx0CCE+VHeJL1VXemspaWux6CoAA9wyXyvtRkFljGlT9f6gHUBqB6PhN+VhsPH6i+b2rDMc7FQkxF7WfUMy7O0YM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wGHvArEI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zEDS3NdN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:48:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773085715;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+hs2C/L/jESLgUSO4vjVYSJWsLVrqEDbVSUOKpLxzg=;
	b=wGHvArEIg8zsyRoClI+xafRE7/pVo6WZNJV8Lzm34vderHaTE3Kaksbmuff6c6IvcjILgp
	OGF45gqhMVVNOPGCNLRYQSar9qxkuuFNDMYEiEj5sSyhG+EwZQhT/tmPvHM4Kf+7QQOOT4
	U29a7ZwT6UoRYg5X3VD829Tv9jAUiaCqCWBLvdy2u+RbwQJ4t2sRZC/dwLSgostl3br9Wk
	K5fXEruqFe4AYHaj2dUaFqCE9y9YHgUhTH+qOs3PI8bVFld2L0a8P6Osmyp7owGCVATNhF
	9dFxFXuDhCayIWhmx9ibWdYecxz7xK9BR7HcQHyYJPmvrNunFuDfUjlQgd1Z0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773085715;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+hs2C/L/jESLgUSO4vjVYSJWsLVrqEDbVSUOKpLxzg=;
	b=zEDS3NdNA4pChlDbvLHuyxJ7/XCIavPf8LqZF7mLuuYlNoQGLmB9dhK8jiLlTW85am0ee9
	dHcSm8PahMdOZhBQ==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: atomic: Remove bound `T: Sync` for
 `Atomic::from_ptr()`
Cc: Boqun Feng <boqun.feng@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260303201701.12204-2-boqun@kernel.org>
References: <20260303201701.12204-2-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308571378.1647592.5306968277923647093.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 33D3F240658
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8401-lists,linux-tip-commits=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,infradead.org,google.com,garyguo.net,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,garyguo.net:email,linutronix.de:dkim,vger.kernel.org:replyto,msgid.link:url]
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     4a5dc632e0b603ec1cbbf87b78de86b4b6359cff
Gitweb:        https://git.kernel.org/tip/4a5dc632e0b603ec1cbbf87b78de86b4b63=
59cff
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Tue, 03 Mar 2026 12:16:49 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 08 Mar 2026 11:06:47 +01:00

rust: sync: atomic: Remove bound `T: Sync` for `Atomic::from_ptr()`

Originally, `Atomic::from_ptr()` requires `T` being a `Sync` because I
thought having the ability to do `from_ptr()` meant multiplle
`&Atomic<T>`s shared by different threads, which was identical (or
similar) to multiple `&T`s shared by different threads. Hence `T` was
required to be `Sync`. However this is not true, since `&Atomic<T>` is
not the same at `&T`. Moreover, having this bound makes `Atomic::<*mut
T>::from_ptr()` impossible, which is definitely not intended. Therefore
remove the `T: Sync` bound.

[boqun: Fix title typo spotted by Alice & Gary]

Fixes: 29c32c405e53 ("rust: sync: atomic: Add generic atomics")
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://patch.msgid.link/20260120115207.55318-2-boqun.feng@gmail.com
Link: https://patch.msgid.link/20260303201701.12204-2-boqun@kernel.org
---
 rust/kernel/sync/atomic.rs | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 4aebeac..296b25e 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -204,10 +204,7 @@ impl<T: AtomicType> Atomic<T> {
     /// // no data race.
     /// unsafe { Atomic::from_ptr(foo_a_ptr) }.store(2, Release);
     /// ```
-    pub unsafe fn from_ptr<'a>(ptr: *mut T) -> &'a Self
-    where
-        T: Sync,
-    {
+    pub unsafe fn from_ptr<'a>(ptr: *mut T) -> &'a Self {
         // CAST: `T` and `Atomic<T>` have the same size, alignment and bit v=
alidity.
         // SAFETY: Per function safety requirement, `ptr` is a valid pointer=
 and the object will
         // live long enough. It's safe to return a `&Atomic<T>` because func=
tion safety requirement

