Return-Path: <linux-tip-commits+bounces-7921-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE392D18364
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D9D030158E3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545F238E126;
	Tue, 13 Jan 2026 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K3Dlg1kK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HzHD38CH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E589F2C0F89;
	Tue, 13 Jan 2026 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301402; cv=none; b=Za14xXxvSteSoiVOmQMKYWWiASHg/BB6zy3pOujyu+vLfTInlCku+1zwUN0GE9C0CkrVNozC6DZFd3Ax+aOAy9Xa5VFuo6V2dZft670VfpX6gmfrWZIa316A+7F9HOqTVfENYpa0JO22zYqNSm5zLqQg2fdjn1j5jOVLhIx9YcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301402; c=relaxed/simple;
	bh=FFovcMVJuGjFlovVpzsjKd/DBtLXAdT05uHqmTC3MjI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EA5yzjGUebSji3tfMxf8XgjDX90IhLjydz1hcxFNVYtlO8fP8RWkhpb0dQvTbGXUfvw4KQBHhNWABDgnM+eu0KedO5PKrFa6wZLqNcBDI9EYgqXKIUJAtiyVfnH4bZ3Az33rJxPXdd2ZQWM6ZCeU4CWBnayOeGX+JAROmGMIKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K3Dlg1kK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HzHD38CH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:49:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301394;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U6RpocjAoqmHsSC4HcpGL++lrYIPLke8oXGfOg2Bnag=;
	b=K3Dlg1kKwQ9lTQQ3uTS31IitaVznFWE0w5/ibLPlTOTWiLfWwwEVv6YAfjJK/E8aA4bLt0
	5bQzgZN7zaf7nDfMdQhcqzxLDFnTIfzwqlJ5tunJU86mqIhZYstcImJZsUwsZv9w5LixK1
	/7hDz1IpYhGxMET9hRsVnIghwyhBE35y1i20+Zvic7v+D+++yywU0pECs5PWYiNVLOWASh
	djiGZJUQq3WIZFcTaK4wgN30MovGHDARFtT9Dl0p0AE/vKBRrmRdQccnwVkcYvTRAPh8Qi
	0uaunGhVt5+3UnGzLBECIExXmOEFff42V2L7hoJUzttzGOEWGfGbwK2iL6RsXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301394;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U6RpocjAoqmHsSC4HcpGL++lrYIPLke8oXGfOg2Bnag=;
	b=HzHD38CH9c2imZmUcj1OCTXD6Tkih0cLYy4BHE6EnNlNEs5wVVwwgSUhsnx5F053KXvsK0
	MsC4z7YqnkeoYwBQ==
From: "tip-bot2 for FUJITA Tomonori" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] rust: sync: atomic: Add i8/i16 xchg and cmpxchg support
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251228120546.1602275-4-fujita.tomonori@gmail.com>
References: <20251228120546.1602275-4-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830139334.510.4016267006139484191.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     584f286f822afecc1a6521a27b3caf3e2f515d41
Gitweb:        https://git.kernel.org/tip/584f286f822afecc1a6521a27b3caf3e2f5=
15d41
Author:        FUJITA Tomonori <fujita.tomonori@gmail.com>
AuthorDate:    Sun, 28 Dec 2025 21:05:46 +09:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:41 +08:00

rust: sync: atomic: Add i8/i16 xchg and cmpxchg support

Add atomic xchg and cmpxchg operation support for i8 and i16 types
with tests.

Note that since the current implementation of
Atomic::<{i8,i16}>::{load,store}() is READ_ONCE()/WRITE_ONCE()-based.
The atomicity between load/store and xchg/cmpxchg is only guaranteed if
the architecture has native RmW support, hence i8/i16 is currently
AtomicImpl only when CONFIG_ARCH_SUPPORTS_ATOMIC_RWM=3Dy.

[boqun: Make i8/i16 AtomicImpl only when
CONFIG_ARCH_SUPPORTS_ATOMIC_RWM=3Dy]

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20251228120546.1602275-4-fujita.tomonori@gmail=
.com
---
 rust/kernel/sync/atomic/internal.rs  | 8 +++++++-
 rust/kernel/sync/atomic/predefine.rs | 4 ++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/in=
ternal.rs
index 1b2a793..0dac58b 100644
--- a/rust/kernel/sync/atomic/internal.rs
+++ b/rust/kernel/sync/atomic/internal.rs
@@ -37,10 +37,16 @@ pub trait AtomicImpl: Sized + Send + Copy + private::Seal=
ed {
     type Delta;
 }
=20
+// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the at=
omicity is only
+// guaranteed against read-modify-write operations if the architecture suppo=
rts native atomic RmW.
+#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
 impl AtomicImpl for i8 {
     type Delta =3D Self;
 }
=20
+// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the at=
omicity is only
+// guaranteed against read-modify-write operations if the architecture suppo=
rts native atomic RmW.
+#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
 impl AtomicImpl for i16 {
     type Delta =3D Self;
 }
@@ -274,7 +280,7 @@ declare_and_impl_atomic_methods!(
 );
=20
 declare_and_impl_atomic_methods!(
-    [ i32 =3D> atomic, i64 =3D> atomic64 ]
+    [ i8 =3D> atomic_i8, i16 =3D> atomic_i16, i32 =3D> atomic, i64 =3D> atom=
ic64 ]
     /// Exchange and compare-and-exchange atomic operations
     pub trait AtomicExchangeOps {
         /// Atomic exchange.
diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/p=
redefine.rs
index 51e9df0..248d265 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -149,7 +149,7 @@ mod tests {
=20
     #[test]
     fn atomic_xchg_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
+        for_each_type!(42 in [i8, i16, i32, i64, u32, u64, isize, usize] |v|=
 {
             let x =3D Atomic::new(v);
=20
             let old =3D v;
@@ -162,7 +162,7 @@ mod tests {
=20
     #[test]
     fn atomic_cmpxchg_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
+        for_each_type!(42 in [i8, i16, i32, i64, u32, u64, isize, usize] |v|=
 {
             let x =3D Atomic::new(v);
=20
             let old =3D v;

