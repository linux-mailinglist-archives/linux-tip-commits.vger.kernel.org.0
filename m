Return-Path: <linux-tip-commits+bounces-8399-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAqoOfglr2kTOwIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8399-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:56:40 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 613CF240711
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9CC531668AC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CAD426EAA;
	Mon,  9 Mar 2026 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2rT3f33x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="saFEePYW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768364266BA;
	Mon,  9 Mar 2026 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085717; cv=none; b=X/W/Zl4DyGVH8AWeiNLnuHVemb55n3hXJ6fYJFWcpFxfM6kBB94Rc5gSOoaAvj6Q9BaIe0EpZJxKdCfZg7/y+LO0/S16uiXarGkjOElXaon4J6LsLUaRB7QgRqsjEI+NntsJb9oXzb7FDXYXKOLUPua+aUW4mN4A7FLgeIKSJIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085717; c=relaxed/simple;
	bh=UZ41rReP60lHFu64ualLhET4wR2YdRXPmz/MeaHhpCk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aqpbV6J7qz1PsiupkPAOg8+94Ya6myOYLufelgq/CfMpLAuW+IdJ4DlwAb++cMQ7rRf9cOLskQMJpRJeNoCmzmzURVg2Dmgo8Fc7i3yxeiDw7r889s6CP0UvqMcFgU3hM3JwuWCb+Yu7rlgv27w63PZzqsoVh7TYrnxjiHCFhA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2rT3f33x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=saFEePYW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:48:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773085713;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bYlbLrzUqD4DSzmS4z+KbvYkRsITfh0Zi1jq1FLf/W4=;
	b=2rT3f33xamJvvG9YOkegU6DxTaEqq70ElN+eUVg4bR67LJZZiZ9wuL1YC52AmQFCqTgGXq
	I/jxRxOqfqAhZzW4F4o20XXU5Zt7vYrHjb8h29+FKraj9/JJ/7g8csUXe8D9eXd2AW+K9Q
	OArntUddOkIOQP8QXUoKWtlB3nadxQ9nExUOZhAw4CnbvCTKZSME5/PtApoDMJeiG90Ssy
	jgqe5jzc3ihWlA6AOcYUNEDgdIAYN4ftidZMzl+q2NT/efPDkNuPtcRebFbEajPKyxlorQ
	zfdMetgUTzMGpK7TPg+TfRoAj3BId3pKbcEbtYTSsJmLlGr8S5Hj8oVCZdhNhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773085713;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bYlbLrzUqD4DSzmS4z+KbvYkRsITfh0Zi1jq1FLf/W4=;
	b=saFEePYWYHD6xdW99/7lXQTLhC2qHe8F4PbLV6GBN59OnUbtkNVcrkFBsKvRteblfzaLk6
	3es/vBU2SX5271Dw==
From: "tip-bot2 for FUJITA Tomonori" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] rust: sync: atomic: Add example for Atomic::get_mut()
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Boqun Feng <boqun@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260303201701.12204-3-boqun@kernel.org>
References: <20260303201701.12204-3-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308571262.1647592.2748788578411271647.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 613CF240711
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8399-lists,linux-tip-commits=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,infradead.org,google.com,garyguo.net,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:replyto,linutronix.de:dkim,infradead.org:email]
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     bebf7bdc62537b9ef4700c6402f1c2aa206a9b50
Gitweb:        https://git.kernel.org/tip/bebf7bdc62537b9ef4700c6402f1c2aa206=
a9b50
Author:        FUJITA Tomonori <fujita.tomonori@gmail.com>
AuthorDate:    Tue, 03 Mar 2026 12:16:50 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 08 Mar 2026 11:06:48 +01:00

rust: sync: atomic: Add example for Atomic::get_mut()

Add an example for Atomic::get_mut(). No functional change.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://patch.msgid.link/20260128123313.3850604-1-tomo@aliasing.net
Link: https://patch.msgid.link/20260303201701.12204-3-boqun@kernel.org
---
 rust/kernel/sync/atomic.rs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 296b25e..e262b0c 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -232,6 +232,17 @@ impl<T: AtomicType> Atomic<T> {
     /// Returns a mutable reference to the underlying atomic `T`.
     ///
     /// This is safe because the mutable reference of the atomic `T` guarant=
ees exclusive access.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::sync::atomic::{Atomic, Relaxed};
+    ///
+    /// let mut atomic_val =3D Atomic::new(0u32);
+    /// let val_mut =3D atomic_val.get_mut();
+    /// *val_mut =3D 101;
+    /// assert_eq!(101, atomic_val.load(Relaxed));
+    /// ```
     pub fn get_mut(&mut self) -> &mut T {
         // CAST: `T` and `T::Repr` has the same size and alignment per the s=
afety requirement of
         // `AtomicType`, and per the type invariants `self.0` is a valid `T`=
, therefore the casting

