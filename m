Return-Path: <linux-tip-commits+bounces-8388-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCJHL/Ikr2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8388-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:52:18 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2855B2405FA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CFAD31066BC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A157941325E;
	Mon,  9 Mar 2026 19:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ums/hV1c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5ZBFLiw2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DF7411607;
	Mon,  9 Mar 2026 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085707; cv=none; b=O0SrisrZc/6j0ZYLVqesKleoD+kn6q40toKyA4ZP4Vg7CzBHtnNCZmDvv7kRHqpRt2R39DdCH+l+9OsOcb4++EqYXQoP/0GFVBQzLFeJ+ntN7CBQM5qDgcLj0vt07kMPe5oQVPw4xFAHlOy/fLWkMdDvPNLHm6N8s7hmC/x3zWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085707; c=relaxed/simple;
	bh=J6s64OlJxuQy1iim3NXGJjSneBEwAAJ/EtbCMZda3z8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A/9zKijbHLhXSg0JMhdW+XZVefySiyV35Flp6PCoKyahrmhOrmUFpUAfYzNLqP1dWERP7rkQZl7HxQIgt3A3tHRvGYBKYU0RjGk5NjBYa3JfRy+ZhammJ9xpaZBMzWOmQV589Hm2ZhuAeuRw9n8P2c7KLw2+chNdppweLQQo/Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ums/hV1c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5ZBFLiw2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:48:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773085701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ura4LSWVzW3KBcYHvIgGZoRbtxc5QWFo1SXpMKg/n4=;
	b=Ums/hV1cVU8MCCTwYyX0soNxvih4sABiQCOHoUFcUXUBjrsl2Z6KGvbQw0eC+jdphMTCkp
	iVu/+ghGgCLeJD7CksYDBZRiVbGaVFT2PZKKsuDdXtjUTxNdIKrY3elZpELJnfdCbzktiC
	o7tc7FWdzFMXKGCbsCqriAvMydjlkTv3hyiPwwmn58awHRR/fT6wL4RaiYZj6yX7z6x0wM
	j2dwavu0mnKgrIrbREJq13EJp/p4inQYkZnZgkVpxVtq32fGGNlehk5pTOPTTYoyzV7na/
	4WnqRUfs0PSSUY3glqEnxhHpQeKIBNQMAwid+EzYwvAZoFfPpq4fWDw6tR5V2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773085701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ura4LSWVzW3KBcYHvIgGZoRbtxc5QWFo1SXpMKg/n4=;
	b=5ZBFLiw2TSjasNKFGS11Y/b29MMQyq1phVNNMRUEiwNiAGiQ/tcqU+AZ8PobAXINq7LRbG
	pMvWnaQWjn5dBiDg==
From: "tip-bot2 for Andreas Hindborg" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: atomic: Update a safety comment in impl of
 `fetch_add()`
Cc: Miguel Ojeda <ojeda@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Alice Ryhl <aliceryhl@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260303201701.12204-14-boqun@kernel.org>
References: <20260303201701.12204-14-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308570028.1647592.4587333804587560119.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2855B2405FA
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
	TAGGED_FROM(0.00)[bounces-8388-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,msgid.link:url,linutronix.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:replyto]
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b91d5d4bcf1266257a9e0199e1b4ad7fa8771baa
Gitweb:        https://git.kernel.org/tip/b91d5d4bcf1266257a9e0199e1b4ad7fa87=
71baa
Author:        Andreas Hindborg <a.hindborg@kernel.org>
AuthorDate:    Tue, 03 Mar 2026 12:17:01 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 08 Mar 2026 11:06:51 +01:00

rust: atomic: Update a safety comment in impl of `fetch_add()`

The safety comment used in the implementation of `fetch_add()` could be
read as just saying something it is true without justifying it. Update
the safety comment to include justification.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://patch.msgid.link/20260220-atomic-sub-v3-3-e63cbed1d2aa@kernel.o=
rg
Link: https://patch.msgid.link/20260303201701.12204-14-boqun@kernel.org
---
 rust/kernel/sync/atomic/internal.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/in=
ternal.rs
index b762dbd..ad810c2 100644
--- a/rust/kernel/sync/atomic/internal.rs
+++ b/rust/kernel/sync/atomic/internal.rs
@@ -337,7 +337,7 @@ declare_and_impl_atomic_methods!(
         /// Atomically updates `*a` to `(*a).wrapping_add(v)`, and returns t=
he value of `*a`
         /// before the update.
         fn fetch_add[acquire, release, relaxed](a: &AtomicRepr<Self>, v: Sel=
f::Delta) -> Self {
-            // SAFETY: `a.as_ptr()` is valid and properly aligned.
+            // SAFETY: `a.as_ptr()` guarantees the returned pointer is valid=
 and properly aligned.
             unsafe { bindings::#call(v, a.as_ptr().cast()) }
         }
=20

