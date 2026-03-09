Return-Path: <linux-tip-commits+bounces-8390-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPvfBQ4lr2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8390-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:52:46 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 681F8240617
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93B47311702E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5714641C0D5;
	Mon,  9 Mar 2026 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="db2iguJt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/wDtze6l"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E55410D29;
	Mon,  9 Mar 2026 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085708; cv=none; b=uMZ9GNQdK/1IEYzi4Ft6Ow0qR8jKPYS1T8m3BOWWLr0OfZrxARCVFbly+kZFy17UltEvKwNEgTXZMxOkQ57Or3SMAen+Q46sGKa72f/TsLV+N6csJMwP6uBJmJeScrVNrCxXkoFfXCIx8cHBfQ0HTFxjxJytWGczbu52V8FvONI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085708; c=relaxed/simple;
	bh=p6jARRMrEMsSvKmTYc7yLPwDwVl4J4zeu4XeMFEkNdo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dsgnso0FtFIJLBeKt3Vqd9YxdhbZA8Qe9B0ydc9InqiMIdYhIe+kQAO4Js/NgZH564rif12YcYvyod5qWfJA2qXpWq1mmdkXT4h/ZY5s6V+1OFX/Ha+r1UsDAOHaRi1MHrI7uo8L1y8UJw8InLMT2FDvRWwNToObthOaffePYZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=db2iguJt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/wDtze6l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:48:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773085703;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XtSdtX1X5Bg6sg0pkHGFH8Wni5zJTFho+pJ64lpLpLg=;
	b=db2iguJtNBHGlf4wdJSYA3PgGrrYRehNLlR+tgUIORIilCF6YtSyFLs7qxNeyvJ1OqIZ2v
	jCwpQ4pD9Q3txoYPTx+Ppap6EVF9PcUkmsf1LKBJsgLuINIvYETIxv6qV8z9VgXisBU8fk
	hBtIAufHDrIWE1MqLwF5fdekiijykXJI7cfO1tn1anmhCdQ0p+kKKUk3uljyn6m6fgIKx2
	HyDfn6+NeJCJVCrdQIekYGfjia7q2wIredEWwW5Z/FEBNyJG/wLs2sV9s3/6/9Q5CnDGLs
	iUyWzvSL7Rwij0pl9610NPMHh90fh8eCz889um8mwge9kqKPL8Ls468Y/ucPog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773085703;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XtSdtX1X5Bg6sg0pkHGFH8Wni5zJTFho+pJ64lpLpLg=;
	b=/wDtze6lB/PU7/y9EA0yPC5PlMi9ktBaYt5Ka9jFo260qDKsT0ra6kMc3oZhuSDzipGhi0
	/5fR01eRkt9ploBQ==
From: "tip-bot2 for Andreas Hindborg" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: atomic: Add fetch_sub()
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Alice Ryhl <aliceryhl@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260303201701.12204-12-boqun@kernel.org>
References: <20260303201701.12204-12-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308570254.1647592.17376121921024730034.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 681F8240617
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8390-lists,linux-tip-commits=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,msgid.link:url,linutronix.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:replyto]
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c49cf341090b53d2afa4dc7c8007ddeefbb3b37f
Gitweb:        https://git.kernel.org/tip/c49cf341090b53d2afa4dc7c8007ddeefbb=
3b37f
Author:        Andreas Hindborg <a.hindborg@kernel.org>
AuthorDate:    Tue, 03 Mar 2026 12:16:59 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 08 Mar 2026 11:06:50 +01:00

rust: sync: atomic: Add fetch_sub()

Add `Atomic::fetch_sub()` with implementation and documentation in line
with existing `Atomic::fetch_add()` implementation.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://patch.msgid.link/20260220-atomic-sub-v3-1-e63cbed1d2aa@kernel.o=
rg
Link: https://patch.msgid.link/20260303201701.12204-12-boqun@kernel.org
---
 rust/kernel/sync/atomic.rs          | 43 ++++++++++++++++++++++++++++-
 rust/kernel/sync/atomic/internal.rs |  5 +++-
 2 files changed, 48 insertions(+)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 1bb1fc2..545a8d3 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -577,6 +577,49 @@ where
         // SAFETY: `ret` comes from reading `self.0`, which is a valid `T` p=
er type invariants.
         unsafe { from_repr(ret) }
     }
+
+    /// Atomic fetch and subtract.
+    ///
+    /// Atomically updates `*self` to `(*self).wrapping_sub(v)`, and returns=
 the value of `*self`
+    /// before the update.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::sync::atomic::{Atomic, Acquire, Full, Relaxed};
+    ///
+    /// let x =3D Atomic::new(42);
+    /// assert_eq!(42, x.load(Relaxed));
+    /// assert_eq!(42, x.fetch_sub(12, Acquire));
+    /// assert_eq!(30, x.load(Relaxed));
+    ///
+    /// let x =3D Atomic::new(42);
+    /// assert_eq!(42, x.load(Relaxed));
+    /// assert_eq!(42, x.fetch_sub(12, Full));
+    /// assert_eq!(30, x.load(Relaxed));
+    /// ```
+    #[inline(always)]
+    pub fn fetch_sub<Rhs, Ordering: ordering::Ordering>(&self, v: Rhs, _: Or=
dering) -> T
+    where
+        // Types that support addition also support subtraction.
+        T: AtomicAdd<Rhs>,
+    {
+        let v =3D T::rhs_into_delta(v);
+
+        // INVARIANT: `self.0` is a valid `T` after `atomic_fetch_sub*()` du=
e to safety requirement
+        // of `AtomicAdd`.
+        let ret =3D {
+            match Ordering::TYPE {
+                OrderingType::Full =3D> T::Repr::atomic_fetch_sub(&self.0, v=
),
+                OrderingType::Acquire =3D> T::Repr::atomic_fetch_sub_acquire=
(&self.0, v),
+                OrderingType::Release =3D> T::Repr::atomic_fetch_sub_release=
(&self.0, v),
+                OrderingType::Relaxed =3D> T::Repr::atomic_fetch_sub_relaxed=
(&self.0, v),
+            }
+        };
+
+        // SAFETY: `ret` comes from reading `self.0`, which is a valid `T` p=
er type invariants.
+        unsafe { from_repr(ret) }
+    }
 }
=20
 #[cfg(any(CONFIG_X86_64, CONFIG_UML, CONFIG_ARM, CONFIG_ARM64))]
diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/in=
ternal.rs
index e301db4..b762dbd 100644
--- a/rust/kernel/sync/atomic/internal.rs
+++ b/rust/kernel/sync/atomic/internal.rs
@@ -340,5 +340,10 @@ declare_and_impl_atomic_methods!(
             // SAFETY: `a.as_ptr()` is valid and properly aligned.
             unsafe { bindings::#call(v, a.as_ptr().cast()) }
         }
+
+        fn fetch_sub[acquire, release, relaxed](a: &AtomicRepr<Self>, v: Sel=
f::Delta) -> Self {
+            // SAFETY: `a.as_ptr()` guarantees the returned pointer is valid=
 and properly aligned.
+            unsafe { bindings::#call(v, a.as_ptr().cast()) }
+        }
     }
 );

