Return-Path: <linux-tip-commits+bounces-8393-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMZLE5Ykr2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8393-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:50:46 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB378240581
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81D933028C15
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F44421F01;
	Mon,  9 Mar 2026 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l8GDlsVn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eGXfUpXy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E4A413226;
	Mon,  9 Mar 2026 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085711; cv=none; b=b4RNVGJgl6AHtJ37/fKw0iIv1mTEdCxwzhx6h8mOxbqCPPGlSVBy7sNZ5qvUvgMVbeM01NSMEAMfgs5aUrE4CL0046UJZnk2OCQqxnXk+L4kJgAflYWjhYsv77ZPGpqGVSEjbEvRevX/IwQfS9nnoHfzY0bjrwrw4V8j3haBgAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085711; c=relaxed/simple;
	bh=e24x4AXqb6lZiX0qwPsK4r93ZI67ZvLMEXzkYKD310A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=as0Nw6vOCBaHXbNh3FUPYZTkPBuZkTuIcUTtWB3l2yCOa27wCUflIuV5VwmWhof1k+fClmpMzP1JMeoi8QsNGQQBW8n77o/cAlgzggq8fToQkpU0F2SHhIUmmS4Te1oV2AoSQLZnKxSwtoFczHoApdpNlk+3t8kizmhBLMZYUq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l8GDlsVn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eGXfUpXy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:48:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773085707;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gMOYxMv9Xfi98v21oLP+qBHG9Xapy616tp1sKDhnOlA=;
	b=l8GDlsVnyjBiM4h9Z2zSyFPa6V9gSq9nkvC9iOf1N0yvBLdLVPTwaP5j2wxnmnkevqZRXv
	g6kc5gD7EUju6lbtW0PxKUu8uCnS0Hiltew+IARm0V/Er6QqO/yvBRbfIgoDg2xSFVePDr
	Xxo3y1kS3znRWJRYKCx5d1VPIuBlf766Y7CIGz8dbJ8bJ5CIPkbmme9waotVguvWm5J0ua
	uGXNRySNw+8Lmc13P4SlKU6tjGDn30ZSiCjGDxADTUy1KOHKit2cKFGmxAUugX/mwm/mOx
	gJHSAAnowUzIh07MZYyyGiHI+aGfImGXYhV3oRO+o2nv5eoaFQV7h6Z9lHERig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773085707;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gMOYxMv9Xfi98v21oLP+qBHG9Xapy616tp1sKDhnOlA=;
	b=eGXfUpXy0zrlzmHdvu6GpuIuXfWYdODnPHdRk31SvedOTF/byTwGK+K4HBtA2aZCpygdyB
	r8E/f0j1VJVYlYAQ==
From: "tip-bot2 for FUJITA Tomonori" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: atomic: Add performance-optimal Flag
 type for atomic booleans
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Boqun Feng <boqun@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Gary Guo <gary@garyguo.net>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260303201701.12204-9-boqun@kernel.org>
References: <20260303201701.12204-9-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308570583.1647592.7698949895096043794.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BB378240581
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
	TAGGED_FROM(0.00)[bounces-8393-lists,linux-tip-commits=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,infradead.org:email,msgid.link:url,linutronix.de:dkim,vger.kernel.org:replyto,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ec6fc66ac39b1a6c0b06a828eff8d21928e56b60
Gitweb:        https://git.kernel.org/tip/ec6fc66ac39b1a6c0b06a828eff8d21928e=
56b60
Author:        FUJITA Tomonori <fujita.tomonori@gmail.com>
AuthorDate:    Tue, 03 Mar 2026 12:16:56 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 08 Mar 2026 11:06:49 +01:00

rust: sync: atomic: Add performance-optimal Flag type for atomic booleans

Add AtomicFlag type for boolean flags.

Document when AtomicFlag is generally preferable to Atomic<bool>: in
particular, when RMW operations such as xchg()/cmpxchg() may be used
and minimizing memory usage is not the top priority. On some
architectures without byte-sized RMW instructions, Atomic<bool> can be
slower for RMW operations.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://patch.msgid.link/20260129122622.3896144-2-tomo@aliasing.net
Link: https://patch.msgid.link/20260303201701.12204-9-boqun@kernel.org
---
 rust/kernel/sync/atomic.rs           | 125 ++++++++++++++++++++++++++-
 rust/kernel/sync/atomic/predefine.rs |  17 ++++-
 2 files changed, 142 insertions(+)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index f4c3ab1..f80cebc 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -578,3 +578,128 @@ where
         unsafe { from_repr(ret) }
     }
 }
+
+#[cfg(any(CONFIG_X86_64, CONFIG_UML, CONFIG_ARM, CONFIG_ARM64))]
+#[repr(C)]
+#[derive(Clone, Copy)]
+struct Flag {
+    bool_field: bool,
+}
+
+/// # Invariants
+///
+/// `padding` must be all zeroes.
+#[cfg(not(any(CONFIG_X86_64, CONFIG_UML, CONFIG_ARM, CONFIG_ARM64)))]
+#[repr(C, align(4))]
+#[derive(Clone, Copy)]
+struct Flag {
+    #[cfg(target_endian =3D "big")]
+    padding: [u8; 3],
+    bool_field: bool,
+    #[cfg(target_endian =3D "little")]
+    padding: [u8; 3],
+}
+
+impl Flag {
+    #[inline(always)]
+    const fn new(b: bool) -> Self {
+        // INVARIANT: `padding` is all zeroes.
+        Self {
+            bool_field: b,
+            #[cfg(not(any(CONFIG_X86_64, CONFIG_UML, CONFIG_ARM, CONFIG_ARM6=
4)))]
+            padding: [0; 3],
+        }
+    }
+}
+
+// SAFETY: `Flag` and `Repr` have the same size and alignment, and `Flag` is=
 round-trip
+// transmutable to the selected representation (`i8` or `i32`).
+unsafe impl AtomicType for Flag {
+    #[cfg(any(CONFIG_X86_64, CONFIG_UML, CONFIG_ARM, CONFIG_ARM64))]
+    type Repr =3D i8;
+    #[cfg(not(any(CONFIG_X86_64, CONFIG_UML, CONFIG_ARM, CONFIG_ARM64)))]
+    type Repr =3D i32;
+}
+
+/// An atomic flag type intended to be backed by performance-optimal integer=
 type.
+///
+/// The backing integer type is an implementation detail; it may vary by arc=
hitecture and change
+/// in the future.
+///
+/// [`AtomicFlag`] is generally preferable to [`Atomic<bool>`] when you need=
 read-modify-write
+/// (RMW) operations (e.g. [`Atomic::xchg()`]/[`Atomic::cmpxchg()`]) or when=
 [`Atomic<bool>`] does
+/// not save memory due to padding. On some architectures that do not suppor=
t byte-sized atomic
+/// RMW operations, RMW operations on [`Atomic<bool>`] are slower.
+///
+/// If you only use [`Atomic::load()`]/[`Atomic::store()`], [`Atomic<bool>`]=
 is fine.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::sync::atomic::{AtomicFlag, Relaxed};
+///
+/// let flag =3D AtomicFlag::new(false);
+/// assert_eq!(false, flag.load(Relaxed));
+/// flag.store(true, Relaxed);
+/// assert_eq!(true, flag.load(Relaxed));
+/// ```
+pub struct AtomicFlag(Atomic<Flag>);
+
+impl AtomicFlag {
+    /// Creates a new atomic flag.
+    #[inline(always)]
+    pub const fn new(b: bool) -> Self {
+        Self(Atomic::new(Flag::new(b)))
+    }
+
+    /// Returns a mutable reference to the underlying flag as a [`bool`].
+    ///
+    /// This is safe because the mutable reference of the atomic flag guaran=
tees exclusive access.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::sync::atomic::{AtomicFlag, Relaxed};
+    ///
+    /// let mut atomic_flag =3D AtomicFlag::new(false);
+    /// assert_eq!(false, atomic_flag.load(Relaxed));
+    /// *atomic_flag.get_mut() =3D true;
+    /// assert_eq!(true, atomic_flag.load(Relaxed));
+    /// ```
+    #[inline(always)]
+    pub fn get_mut(&mut self) -> &mut bool {
+        &mut self.0.get_mut().bool_field
+    }
+
+    /// Loads the value from the atomic flag.
+    #[inline(always)]
+    pub fn load<Ordering: ordering::AcquireOrRelaxed>(&self, o: Ordering) ->=
 bool {
+        self.0.load(o).bool_field
+    }
+
+    /// Stores a value to the atomic flag.
+    #[inline(always)]
+    pub fn store<Ordering: ordering::ReleaseOrRelaxed>(&self, v: bool, o: Or=
dering) {
+        self.0.store(Flag::new(v), o);
+    }
+
+    /// Stores a value to the atomic flag and returns the previous value.
+    #[inline(always)]
+    pub fn xchg<Ordering: ordering::Ordering>(&self, new: bool, o: Ordering)=
 -> bool {
+        self.0.xchg(Flag::new(new), o).bool_field
+    }
+
+    /// Store a value to the atomic flag if the current value is equal to `o=
ld`.
+    #[inline(always)]
+    pub fn cmpxchg<Ordering: ordering::Ordering>(
+        &self,
+        old: bool,
+        new: bool,
+        o: Ordering,
+    ) -> Result<bool, bool> {
+        match self.0.cmpxchg(Flag::new(old), Flag::new(new), o) {
+            Ok(_) =3D> Ok(old),
+            Err(f) =3D> Err(f.bool_field),
+        }
+    }
+}
diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/p=
redefine.rs
index 6f2c605..ceb3cae 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -272,4 +272,21 @@ mod tests {
         );
         assert_eq!(x.load(Relaxed), &raw const u);
     }
+
+    #[test]
+    fn atomic_flag_tests() {
+        let mut flag =3D AtomicFlag::new(false);
+
+        assert_eq!(false, flag.load(Relaxed));
+
+        *flag.get_mut() =3D true;
+        assert_eq!(true, flag.load(Relaxed));
+
+        assert_eq!(true, flag.xchg(false, Relaxed));
+        assert_eq!(false, flag.load(Relaxed));
+
+        *flag.get_mut() =3D true;
+        assert_eq!(Ok(true), flag.cmpxchg(true, false, Full));
+        assert_eq!(false, flag.load(Relaxed));
+    }
 }

