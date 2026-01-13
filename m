Return-Path: <linux-tip-commits+bounces-7925-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49936D183C1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF02D304C66D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698A338E5CD;
	Tue, 13 Jan 2026 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X5nPntno";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RMcE85FN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E4336CDFA;
	Tue, 13 Jan 2026 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301402; cv=none; b=iT9gAVHW3SxnZQ+keWDWkWcN1+CQc7ssn7smhp2iyxK9P2yMIC6Nqoy2Z1wvFVACKi5Sr6yUHpoTHBlQT0Rvvk8AUkDenCGu52iheqIzBNHfoukF/Z3Lp9gdJ8rB3S3caqO+/3keib1HEKX1jOzXTaphnjc5v2dWEHFjro+1dtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301402; c=relaxed/simple;
	bh=kDsMSbimHedRN2tTMwKk0ZjOHi1VQuNcqr5rUWgKuE4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Whh1b8nmOkO4muhFU8QekzIZhNAjMIGVA/iCh3gPbmSIVNBb2Bz4IOpOIWRD2lCBF/pt9Z1mgZiejEJvnjVRN69h2LpS6CLqfpQHkHlxz39bfvVfb4xFGlvYlsehgJtcMQH1doDQX6CY7sr5R1ayqCeSbdqmEWuyu5XJTUQg7S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X5nPntno; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RMcE85FN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:49:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xPDOxtCgPg1nwtpGPBJj6UDH/JfsOelf1PdZ67a8XvM=;
	b=X5nPntnompiXB7By+ddfOyQOcIbivCKfAU+YZgOrb5aObg8v/SkuySWh3X5vrENX1spjCm
	G7u8l7UEYxWjCgJHrm5PxkvgSoHLnduLEfhxbc1PgajWkorymIZ+6o5R/SvCxB8nHa3/8/
	/BWCDdYhFKSgXPlumJwEsBZnHUG2T4cYis9f5IcxlqYoX57l/4D33zR/G60T6G1n7RLsZH
	Pz2OZhnWFY1ZCewm+fqyZ4GbqYmCvrxaFWoEdjLgQRLYs9ywstQxGL6DojAk0HEqIiSed5
	k4TNEIqAjeRd2jE8ng8VX/kBdz7D+drG2puMnNx4Hacf+5JSwyNZXlMPXk0VdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xPDOxtCgPg1nwtpGPBJj6UDH/JfsOelf1PdZ67a8XvM=;
	b=RMcE85FN+1/1VfMgmPnAomuoEGPAFgK1ZpxF/tuUt8HTvmT3BrNteYP2u+BigC9DluPfuq
	6M2eA/n2Xh4AgVDQ==
From: "tip-bot2 for FUJITA Tomonori" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: atomic: Prepare AtomicOps macros for
 i8/i16 support
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251228120546.1602275-2-fujita.tomonori@gmail.com>
References: <20251228120546.1602275-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830139814.510.6100687170582710842.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     2bb8c41e61b29ccdf7b6d716c3a8fe8488aa202a
Gitweb:        https://git.kernel.org/tip/2bb8c41e61b29ccdf7b6d716c3a8fe8488a=
a202a
Author:        FUJITA Tomonori <fujita.tomonori@gmail.com>
AuthorDate:    Sun, 28 Dec 2025 21:05:44 +09:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:41 +08:00

rust: sync: atomic: Prepare AtomicOps macros for i8/i16 support

Rework the internal AtomicOps macro plumbing to generate per-type
implementations from a mapping list.

Capture the trait definition once and reuse it for both declaration
and per-type impl expansion to reduce duplication and keep future
extensions simple.

This is a preparatory refactor for enabling i8/i16 atomics cleanly.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20251228120546.1602275-2-fujita.tomonori@gmail=
.com
---
 rust/kernel/sync/atomic/internal.rs | 85 +++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 19 deletions(-)

diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/in=
ternal.rs
index 6fdd8e5..41b4ce2 100644
--- a/rust/kernel/sync/atomic/internal.rs
+++ b/rust/kernel/sync/atomic/internal.rs
@@ -156,16 +156,17 @@ macro_rules! impl_atomic_method {
     }
 }
=20
-// Delcares $ops trait with methods and implements the trait for `i32` and `=
i64`.
-macro_rules! declare_and_impl_atomic_methods {
-    ($(#[$attr:meta])* $pub:vis trait $ops:ident {
-        $(
-            $(#[doc=3D$doc:expr])*
-            fn $func:ident [$($variant:ident),*]($($arg_sig:tt)*) $( -> $ret=
:ty)? {
-                $unsafe:tt { bindings::#call($($arg:tt)*) }
-            }
-        )*
-    }) =3D> {
+macro_rules! declare_atomic_ops_trait {
+    (
+        $(#[$attr:meta])* $pub:vis trait $ops:ident {
+            $(
+                $(#[doc=3D$doc:expr])*
+                fn $func:ident [$($variant:ident),*]($($arg_sig:tt)*) $( -> =
$ret:ty)? {
+                    $unsafe:tt { bindings::#call($($arg:tt)*) }
+                }
+            )*
+        }
+    ) =3D> {
         $(#[$attr])*
         $pub trait $ops: AtomicImpl {
             $(
@@ -175,21 +176,25 @@ macro_rules! declare_and_impl_atomic_methods {
                 );
             )*
         }
+    }
+}
=20
-        impl $ops for i32 {
+macro_rules! impl_atomic_ops_for_one {
+    (
+        $ty:ty =3D> $ctype:ident,
+        $(#[$attr:meta])* $pub:vis trait $ops:ident {
             $(
-                impl_atomic_method!(
-                    (atomic) $func[$($variant)*]($($arg_sig)*) $(-> $ret)? {
-                        $unsafe { call($($arg)*) }
-                    }
-                );
+                $(#[doc=3D$doc:expr])*
+                fn $func:ident [$($variant:ident),*]($($arg_sig:tt)*) $( -> =
$ret:ty)? {
+                    $unsafe:tt { bindings::#call($($arg:tt)*) }
+                }
             )*
         }
-
-        impl $ops for i64 {
+    ) =3D> {
+        impl $ops for $ty {
             $(
                 impl_atomic_method!(
-                    (atomic64) $func[$($variant)*]($($arg_sig)*) $(-> $ret)?=
 {
+                    ($ctype) $func[$($variant)*]($($arg_sig)*) $(-> $ret)? {
                         $unsafe { call($($arg)*) }
                     }
                 );
@@ -198,7 +203,47 @@ macro_rules! declare_and_impl_atomic_methods {
     }
 }
=20
+// Declares $ops trait with methods and implements the trait.
+macro_rules! declare_and_impl_atomic_methods {
+    (
+        [ $($map:tt)* ]
+        $(#[$attr:meta])* $pub:vis trait $ops:ident { $($body:tt)* }
+    ) =3D> {
+        declare_and_impl_atomic_methods!(
+            @with_ops_def
+            [ $($map)* ]
+            ( $(#[$attr])* $pub trait $ops { $($body)* } )
+        );
+    };
+
+    (@with_ops_def [ $($map:tt)* ] ( $($ops_def:tt)* )) =3D> {
+        declare_atomic_ops_trait!( $($ops_def)* );
+
+        declare_and_impl_atomic_methods!(
+            @munch
+            [ $($map)* ]
+            ( $($ops_def)* )
+        );
+    };
+
+    (@munch [] ( $($ops_def:tt)* )) =3D> {};
+
+    (@munch [ $ty:ty =3D> $ctype:ident $(, $($rest:tt)*)? ] ( $($ops_def:tt)=
* )) =3D> {
+        impl_atomic_ops_for_one!(
+            $ty =3D> $ctype,
+            $($ops_def)*
+        );
+
+        declare_and_impl_atomic_methods!(
+            @munch
+            [ $($($rest)*)? ]
+            ( $($ops_def)* )
+        );
+    };
+}
+
 declare_and_impl_atomic_methods!(
+    [ i32 =3D> atomic, i64 =3D> atomic64 ]
     /// Basic atomic operations
     pub trait AtomicBasicOps {
         /// Atomic read (load).
@@ -216,6 +261,7 @@ declare_and_impl_atomic_methods!(
 );
=20
 declare_and_impl_atomic_methods!(
+    [ i32 =3D> atomic, i64 =3D> atomic64 ]
     /// Exchange and compare-and-exchange atomic operations
     pub trait AtomicExchangeOps {
         /// Atomic exchange.
@@ -243,6 +289,7 @@ declare_and_impl_atomic_methods!(
 );
=20
 declare_and_impl_atomic_methods!(
+    [ i32 =3D> atomic, i64 =3D> atomic64 ]
     /// Atomic arithmetic operations
     pub trait AtomicArithmeticOps {
         /// Atomic add (wrapping).

