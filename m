Return-Path: <linux-tip-commits+bounces-5977-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CAAAF6D11
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 10:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347AB523BFC
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 08:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0AC298CC0;
	Thu,  3 Jul 2025 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G7qhLozv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q5I/n+B4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591452DE6E8;
	Thu,  3 Jul 2025 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751531773; cv=none; b=BZE6h4/ferWLvnxZDGAIOEe9H2zWjaWB4ek3oM7JsniHA2QYOzu4GgvuZpBRli7lgq2CwEU0j1wSKTkjYyHkMGuiqwR9bu7eanz1JozkDRihufwmAWoTj6q/LeN0D5oXsbJnXDRIcm+NRU9uSLY+mny8gyX7K5ibO7tHMDftJ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751531773; c=relaxed/simple;
	bh=4AaBcXAGwuMagPYnfvH1SAxiy/I0boKcjyogkJCy1BU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EESxT+6zZHOEKx686p6k8hRvIkJQBJEDvzXLW5Xt9F7GydPZviFNCKkWlRTw/kW9X0j5e7js/xzcxJD/mCN+wruoE7PA+z68PlXUB9Fp90XXQWuLnihIpe1BnIk9XD+OJ0EZcpRVE5e2S+xN+R0i8LZMtEmiRTB/ScaOk11TDbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G7qhLozv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q5I/n+B4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Jul 2025 08:36:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751531769;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hTQIfhJC7MOTl6NgaN15MewTKcGtMlRd6joSx3QkJBc=;
	b=G7qhLozvBPzYKj7gzVAeRIgJjxTbDw9puQwHYHW9s/Imw9ivMSYoH9nehpBP/e7Jz20NJ4
	f0lbS1mwbrfBCYV/0AmIl87tCxj9uHltZ4et8VDUG4GhRY9SK1fwFubnmD/73vmDs/olp7
	4Sw8fU2OcmugOlyTwvUsZm2WZTPES05sCBEDe+/tqJ3ybEp2ah9p8/cQtZmXSxZ9mQVVt9
	WASk8SCbQKet/HDWEsH/mWc/P3JwmiIizdXEj6pz/L7XCmAFEn0tq1xxh9e9WxTdGWGpNC
	7ooc90wOgPZhqUzYIaw71cb0kX81GGAXobxtEPR4b9gN/gcdaBLSXxDqevc61A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751531769;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hTQIfhJC7MOTl6NgaN15MewTKcGtMlRd6joSx3QkJBc=;
	b=Q5I/n+B4w9QQTx35e6Ovixztc31uFrBL3jGMQ8kq/xTPwEM+of8vjvpf4U4CTh37S8aPIZ
	dipPlHrjJ4Kx82DA==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rust: Introduce file_from_location()
Cc: Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250619151007.61767-2-boqun.feng@gmail.com>
References: <20250619151007.61767-2-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175153176837.406.18152464022910500101.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0aa2b78ce5a9eac8f3332192ea77755d63a831cd
Gitweb:        https://git.kernel.org/tip/0aa2b78ce5a9eac8f3332192ea77755d63a831cd
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Sun, 15 Jun 2025 15:14:00 -07:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Tue, 24 Jun 2025 15:53:46 -07:00

rust: Introduce file_from_location()

Most of kernel debugging facilities take a nul-terminated string for
file names for a callsite (generated from __FILE__), however the Rust
courterpart, Location, would return a Rust string (not nul-terminated)
from method .file(). And such a string cannot be passed to C debugging
function directly.

There is ongoing work to support a Location::file_with_nul() [1], which
returns a nul-terminated string from a Location. Since it's still
working in progress, and it will take some time before the feature
finally gets stabilized and the kernel's minimal rustc version might
also take a while to bump to a version that at least has that feature,
introduce a file_from_location() function, which returns a warning
string if Location::file_with_nul() is not available.

This should work in most cases because as for now the known usage of
Location::file_with_nul() is only in debugging code (e.g. might_sleep())
and there might be other information reported by the debugging code that
could help locate the problematic function, so missing the file name is
fine at the moment.

Link: https://github.com/rust-lang/rust/issues/141727 [1]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250619151007.61767-2-boqun.feng@gmail.com
---
 init/Kconfig       |  3 +++-
 rust/kernel/lib.rs | 48 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 51 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index af4c2f0..6f4ec56 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -142,6 +142,9 @@ config RUSTC_HAS_SPAN_FILE
 config RUSTC_HAS_UNNECESSARY_TRANSMUTES
 	def_bool RUSTC_VERSION >= 108800
 
+config RUSTC_HAS_FILE_WITH_NUL
+	def_bool RUSTC_VERSION >= 108900
+
 config PAHOLE_VERSION
 	int
 	default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 6b4774b..717a5b6 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -40,6 +40,10 @@
 #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(coerce_unsized))]
 #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(dispatch_from_dyn))]
 #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(unsize))]
+//
+// `feature(file_with_nul)` is expected to become stable. Before Rust 1.89.0, it did not exist, so
+// enable it conditionally.
+#![cfg_attr(CONFIG_RUSTC_HAS_FILE_WITH_NUL, feature(file_with_nul))]
 
 // Ensure conditional compilation based on the kernel configuration works;
 // otherwise we may silently break things like initcall handling.
@@ -274,3 +278,47 @@ macro_rules! asm {
         ::core::arch::asm!( $($asm)*, $($rest)* )
     };
 }
+
+/// Gets the C string file name of a [`Location`].
+///
+/// If `file_with_nul()` is not available, returns a string that warns about it.
+///
+/// [`Location`]: core::panic::Location
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::file_from_location;
+///
+/// #[track_caller]
+/// fn foo() {
+///     let caller = core::panic::Location::caller();
+///
+///     // Output:
+///     // - A path like "rust/kernel/example.rs" if file_with_nul() is available.
+///     // - "<Location::file_with_nul() not supported>" otherwise.
+///     let caller_file = file_from_location(caller);
+///
+///     // Prints out the message with caller's file name.
+///     pr_info!("foo() called in file {caller_file:?}\n");
+///
+///     # if cfg!(CONFIG_RUSTC_HAS_FILE_WITH_NUL) {
+///     #     assert_eq!(Ok(caller.file()), caller_file.to_str());
+///     # }
+/// }
+///
+/// # foo();
+/// ```
+#[inline]
+pub fn file_from_location<'a>(loc: &'a core::panic::Location<'a>) -> &'a core::ffi::CStr {
+    #[cfg(CONFIG_RUSTC_HAS_FILE_WITH_NUL)]
+    {
+        loc.file_with_nul()
+    }
+
+    #[cfg(not(CONFIG_RUSTC_HAS_FILE_WITH_NUL))]
+    {
+        let _ = loc;
+        c"<Location::file_with_nul() not supported>"
+    }
+}

