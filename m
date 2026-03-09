Return-Path: <linux-tip-commits+bounces-8392-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBmeCFEkr2n6OQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8392-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:49:37 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4F2240527
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 752453047343
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F0D421896;
	Mon,  9 Mar 2026 19:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VGgpd9wU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wQNLy0wE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661C3411615;
	Mon,  9 Mar 2026 19:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085709; cv=none; b=boDc+SW2xvHh9nWizzNtYl9h6l9YZu6ZPIFpdh2Z4CLf2Z/77HPeqHjf9Wy25ElPf1YpaWmQfMPdCktTI7zYtfSxVMbvSlOk2OGmPl4WNwZSYy2E295mZ8X5AKU0k8cn7N5F3PR9YQqVrup5yD64TIbM0cM0OyvwQaVCW653rJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085709; c=relaxed/simple;
	bh=tq8xDAWKiXfbkgwoGeSk1WsJuQymoYFNNjPMfLVsOLQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cVvJuAotS/xyguL5HccCNqWERhB3rH17g40FZ4vdgbuur8VO3ee00fzui73htVqJ7rsjVehsM1m0mxc0bV7jE6ixoPnzbSVZ3gi8NoLnFM/gb0eyxCsIVYgmMLvOvaGUkKkHYoQd5OiwnwY8u1qQCqlMPzCQz0aSu+YYHWfQYrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VGgpd9wU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wQNLy0wE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:48:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773085706;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mtJNraB9WxV5Wx9rvSAuasvQC5dxf84Z8OfoqT+jPLM=;
	b=VGgpd9wUWGJXTZ6LWncwMR4eRqXN23vN4Xg/DzQfQ0J2hpiynY49u6TQQpo2H4zk46pejJ
	GFtnfH2nzXSUSwFipqm/LREO0iKDe7lgyR8OTaEYp0pOTZ9kFxm58q9FfMzoKG/fKoNd9y
	eC/Ka2wot/2gtKMH2pcbfg9H3ksk8dVFYMmQxYOMCncSrUeKytuO79AKCv6xLN3gXqDT4S
	3G/ERIwB7IUbNHJBu/DPe8QBGSAxpXl6jp6puq7vGc7frX2AX++To32PBkM6oBgsu8KGL7
	zTUMCM0tKB75RwQ8fn99Z6GA3pak7DUch6rGWGMrKz0ae6976GZ3uSv2+OXk+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773085706;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mtJNraB9WxV5Wx9rvSAuasvQC5dxf84Z8OfoqT+jPLM=;
	b=wQNLy0wEfNTx6cDCaEe6f+MnrV2IMzd1ND6UcguwqVuM9WOdWSrXj99SpVQmZpE9Tp6pBN
	mQoaHPZP8EJqJ7Cg==
From: "tip-bot2 for FUJITA Tomonori" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: list: Use AtomicFlag in AtomicTracker
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Boqun Feng <boqun@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Gary Guo <gary@garyguo.net>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260303201701.12204-10-boqun@kernel.org>
References: <20260303201701.12204-10-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308570473.1647592.7085311895626426490.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CA4F2240527
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
	TAGGED_FROM(0.00)[bounces-8392-lists,linux-tip-commits=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,infradead.org,garyguo.net,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,infradead.org:email,linutronix.de:dkim,vger.kernel.org:replyto,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     282866207020b15c2afc4d43b1ca0c5d96c9032d
Gitweb:        https://git.kernel.org/tip/282866207020b15c2afc4d43b1ca0c5d96c=
9032d
Author:        FUJITA Tomonori <fujita.tomonori@gmail.com>
AuthorDate:    Tue, 03 Mar 2026 12:16:57 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 08 Mar 2026 11:06:50 +01:00

rust: list: Use AtomicFlag in AtomicTracker

Make AtomicTracker use AtomicFlag instead of Atomic<bool> to avoid
slow byte-sized RMWs on architectures that don't support them.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://patch.msgid.link/20260129122622.3896144-3-tomo@aliasing.net
Link: https://patch.msgid.link/20260303201701.12204-10-boqun@kernel.org
---
 rust/kernel/list/arc.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/list/arc.rs b/rust/kernel/list/arc.rs
index 2282f33..5e84f50 100644
--- a/rust/kernel/list/arc.rs
+++ b/rust/kernel/list/arc.rs
@@ -6,7 +6,7 @@
=20
 use crate::alloc::{AllocError, Flags};
 use crate::prelude::*;
-use crate::sync::atomic::{ordering, Atomic};
+use crate::sync::atomic::{ordering, AtomicFlag};
 use crate::sync::{Arc, ArcBorrow, UniqueArc};
 use core::marker::PhantomPinned;
 use core::ops::Deref;
@@ -469,7 +469,7 @@ where
 /// If the boolean is `false`, then there is no [`ListArc`] for this value.
 #[repr(transparent)]
 pub struct AtomicTracker<const ID: u64 =3D 0> {
-    inner: Atomic<bool>,
+    inner: AtomicFlag,
     // This value needs to be pinned to justify the INVARIANT: comment in `A=
tomicTracker::new`.
     _pin: PhantomPinned,
 }
@@ -480,12 +480,12 @@ impl<const ID: u64> AtomicTracker<ID> {
         // INVARIANT: Pin-init initializers can't be used on an existing `Ar=
c`, so this value will
         // not be constructed in an `Arc` that already has a `ListArc`.
         Self {
-            inner: Atomic::new(false),
+            inner: AtomicFlag::new(false),
             _pin: PhantomPinned,
         }
     }
=20
-    fn project_inner(self: Pin<&mut Self>) -> &mut Atomic<bool> {
+    fn project_inner(self: Pin<&mut Self>) -> &mut AtomicFlag {
         // SAFETY: The `inner` field is not structurally pinned, so we may o=
btain a mutable
         // reference to it even if we only have a pinned reference to `self`.
         unsafe { &mut Pin::into_inner_unchecked(self).inner }

