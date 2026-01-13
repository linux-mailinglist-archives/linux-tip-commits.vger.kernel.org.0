Return-Path: <linux-tip-commits+bounces-7937-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04122D18403
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CE3E30239FD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED14438B9BA;
	Tue, 13 Jan 2026 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cuhRLzt7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zaZMC1y9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B6F3921D5;
	Tue, 13 Jan 2026 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301412; cv=none; b=GJrHMvjW9B8kQP5tveAqgdRWUUbQCTNqIU5UEkF7qZDeW8WfpO8a215f5/LXY8v9j8vo1SL3b9pXCfekOKCksxquP2y1QZkCxcHQUyzY4vFYa8N3kqZsohklIrz5eWM19iFrMLyY8Iv9od45GwKzHOjXB+IVpSgWEFbCEh++rDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301412; c=relaxed/simple;
	bh=7G7MpveluuD809YamWumWzh8Du+CAiqCLs27gu8GTaQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gk6u8yiOnoGwEL2qbi7N9IfV55g+8u7Qf5vXnB0J+GUPV+7/xh6zg5VvXiKur4Rm2ngyYN+77UJ7E5le/TRWbA5udR2svXQQ9fM/ofzRHdnpXnmYmgm+NHwVTje87s8j2nWVN9I3qAb3g+W4ZfCg4eQwiOy8W9mMC21xRH6qL3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cuhRLzt7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zaZMC1y9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:50:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301409;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qDPjnLNNcVYZjLUMsMfY7BEsV9b4UdMTVp0Z6hl7F8U=;
	b=cuhRLzt7HObe6t1m1iQatQIlA3zsImhsN4bCbLHTBJWDkpze1jrJb3v1lOmERRWH+qUoe/
	eH1mR3gJA5FTYZ4H/pzmZtgDTsrd28EaQxFZ2CoMQOxiIyuvokDyGqA5XqCrCUt1e/kw0u
	BMEXy6jqAd0NDGv05IDNrdT1SSmLp9vPZmdhmB1rJTDUE5Eb6rLNp+IXq4cHi6ZsMjsQuh
	KZUCMzpafo2YJhCaXye9+BHDYXRBdj6sqzLTgmjVYjAw10lM4j54o3SgSGXwzi4vcAUqLu
	9vr/1FDIUUOFC2xQbZCzmPVxjzU8oveYZ7LzaCRkZEjz9JnbobfHLUhf1SuWmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301409;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qDPjnLNNcVYZjLUMsMfY7BEsV9b4UdMTVp0Z6hl7F8U=;
	b=zaZMC1y9tAhL+JnsynV1DM0uQLbojZSBofX2GY6Z6O5/Bb517nNF6vyVCTMXf95Gbbq9ud
	wfX0dTX3BTuPGCBw==
From: "tip-bot2 for FUJITA Tomonori" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: helpers: Add i8/i16
 atomic_read_acquire/atomic_set_release helpers
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Gary Guo <gary@garyguo.net>,
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251211113826.1299077-2-fujita.tomonori@gmail.com>
References: <20251211113826.1299077-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830140877.510.15255115321235116733.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     2cc3d5d6adbee058858f2e66de701a203b032746
Gitweb:        https://git.kernel.org/tip/2cc3d5d6adbee058858f2e66de701a203b0=
32746
Author:        FUJITA Tomonori <fujita.tomonori@gmail.com>
AuthorDate:    Thu, 11 Dec 2025 20:38:23 +09:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:40 +08:00

rust: helpers: Add i8/i16 atomic_read_acquire/atomic_set_release helpers

Add helper functions to expose smp_load_acquire() and
smp_store_release() for i8 and i16 types.

The smp_load_acquire() and smp_store_release() macros require type
information (sizeof) to generate appropriate architecture-specific
memory ordering instructions. Therefore, separate helper functions are
needed for each type size.

These helpers expose different symbol names than their C counterparts
so they are split into atomic_ext.c instead of atomic.c. The symbol
names; atomic_[i8|i16]_read_acquire and atomic_[i8|i16]_set_release
makes the interface Rust/C clear, consistent with i32/i64.

These helpers will be used by the upcoming Atomic<i8> and Atomic<i16>
implementation to provide proper Acquire/Release semantics across all
architectures.

[boqun: Rename the functions from {load,store} to {read,set} to avoid
future adjustment]

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20251211113826.1299077-2-fujita.tomonori@gmail=
.com
---
 rust/helpers/atomic_ext.c | 23 +++++++++++++++++++++++
 rust/helpers/helpers.c    |  1 +
 2 files changed, 24 insertions(+)
 create mode 100644 rust/helpers/atomic_ext.c

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
new file mode 100644
index 0000000..1fb6241
--- /dev/null
+++ b/rust/helpers/atomic_ext.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <asm/barrier.h>
+
+__rust_helper s8 rust_helper_atomic_i8_read_acquire(s8 *ptr)
+{
+	return smp_load_acquire(ptr);
+}
+
+__rust_helper s16 rust_helper_atomic_i16_read_acquire(s16 *ptr)
+{
+	return smp_load_acquire(ptr);
+}
+
+__rust_helper void rust_helper_atomic_i8_set_release(s8 *ptr, s8 val)
+{
+	smp_store_release(ptr, val);
+}
+
+__rust_helper void rust_helper_atomic_i16_set_release(s16 *ptr, s16 val)
+{
+	smp_store_release(ptr, val);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 79c7276..15d7557 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -8,6 +8,7 @@
  */
=20
 #include "atomic.c"
+#include "atomic_ext.c"
 #include "auxiliary.c"
 #include "barrier.c"
 #include "binder.c"

