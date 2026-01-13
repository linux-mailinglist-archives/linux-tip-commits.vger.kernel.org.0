Return-Path: <linux-tip-commits+bounces-7936-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D40D183F2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB97F3034A78
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF683921E5;
	Tue, 13 Jan 2026 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="emtluCI9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SHqL3oXp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DCA38F239;
	Tue, 13 Jan 2026 10:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301412; cv=none; b=J5v8EzyN5BL8eKaGF8WVZItpKTZBCatCtBnyq3fEBeL3iFC+dOViFskJGlR7vCcX0C7e7AbW+/Gf8In/TtyE4G3yxswRZXqwAgDadxRdSzXzFas6iKxHTrADrmycN+xtgncnT4lzKyJwHwgVSaUGvM9qABbV+0eVW8oYvR8XB7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301412; c=relaxed/simple;
	bh=UQWhfReeExBt/vu+MySD1Y145zlNfmBUI9Jwc46j73E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OvqbQvxCeeYsg4TVpXa78AJ5k1hhExvy/9x7IhFqqqluLyMWS2ls64FBPpMOE5FNZ8Z0GO9BeBdudLr8ry9FO0dINWl6vEEQcM3MWqyrj79kxrqSHacw9gwcEzSOSsfy99xRx0U4GWxfzLLnlx6AFK7mldIicApqAuVUQTrRbWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=emtluCI9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SHqL3oXp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:50:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301408;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UsSl1A7Wb2JTscooJ0dUCBpeFfF4d7ZyhWdhnpyQREc=;
	b=emtluCI9EJTxyc/Vo5oPbApcjCO0AtVuVcNQdgyrWbzUxX8DULHk0Pv/Fka/yd9HOLEq4Y
	OmZ5xLR82i2TivP7l74ICv0VW1b6dnchFsTSRhpODplKswD+88PnE9Q9gsBXlkLgoGWkyK
	X9Ms2d409M8hjHQRG6MNp1Vh23drER2xGL2s9zvxBeebKU8qPWKw67qK8TWx5Y8ADdO670
	4bXTo95IMxrXGNPR7c9cLb4iPeggFiZGFOlzX7WzFQfh4VE7a39Tw9QCDZu4GKoJjkE7If
	ZnivGeTgQ7GMkI49PDVqQfU2BxBP3zywwgczrwtP+UzmX3LU31WF7RXG4K6Puw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301408;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UsSl1A7Wb2JTscooJ0dUCBpeFfF4d7ZyhWdhnpyQREc=;
	b=SHqL3oXpMKFnWj9F3x0JjnFMgGKmeCyY4NvxJxbj/xrMWZmYp3bfrYZ2RsP6jPGIfYLJGU
	xW3vN4aiS0WlKTCg==
From: "tip-bot2 for FUJITA Tomonori" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: helpers: Add i8/i16 relaxed atomic helpers
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Gary Guo <gary@garyguo.net>,
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251211113826.1299077-3-fujita.tomonori@gmail.com>
References: <20251211113826.1299077-3-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830140769.510.10398950538996490358.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     300e53b3d3b59e72a972a12ee5c6438aab4860a4
Gitweb:        https://git.kernel.org/tip/300e53b3d3b59e72a972a12ee5c6438aab4=
860a4
Author:        FUJITA Tomonori <fujita.tomonori@gmail.com>
AuthorDate:    Thu, 11 Dec 2025 20:38:24 +09:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:40 +08:00

rust: helpers: Add i8/i16 relaxed atomic helpers

Add READ_ONCE/WRITE_ONCE based helpers for i8 and i16 types to support
relaxed atomic operations in Rust.

While relaxed operations could be implemented purely in Rust using
read_volatile() and write_volatile(), using C's READ_ONCE() and
WRITE_ONCE() macros ensures complete consistency with the kernel
memory model.

These helpers expose different symbol names than their C counterparts
so they are split into atomic_ext.c instead of atomic.c. The symbol
names; the names make the interface Rust/C clear, consistent with
i32/i64.

[boqun: Rename the functions from {load,store} to {read,set} to avoid
future adjustment]

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20251211113826.1299077-3-fujita.tomonori@gmail=
.com
---
 rust/helpers/atomic_ext.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
index 1fb6241..02e05b4 100644
--- a/rust/helpers/atomic_ext.c
+++ b/rust/helpers/atomic_ext.c
@@ -1,22 +1,43 @@
 // SPDX-License-Identifier: GPL-2.0
=20
 #include <asm/barrier.h>
+#include <asm/rwonce.h>
+
+__rust_helper s8 rust_helper_atomic_i8_read(s8 *ptr)
+{
+	return READ_ONCE(*ptr);
+}
=20
 __rust_helper s8 rust_helper_atomic_i8_read_acquire(s8 *ptr)
 {
 	return smp_load_acquire(ptr);
 }
=20
+__rust_helper s16 rust_helper_atomic_i16_read(s16 *ptr)
+{
+	return READ_ONCE(*ptr);
+}
+
 __rust_helper s16 rust_helper_atomic_i16_read_acquire(s16 *ptr)
 {
 	return smp_load_acquire(ptr);
 }
=20
+__rust_helper void rust_helper_atomic_i8_set(s8 *ptr, s8 val)
+{
+	WRITE_ONCE(*ptr, val);
+}
+
 __rust_helper void rust_helper_atomic_i8_set_release(s8 *ptr, s8 val)
 {
 	smp_store_release(ptr, val);
 }
=20
+__rust_helper void rust_helper_atomic_i16_set(s16 *ptr, s16 val)
+{
+	WRITE_ONCE(*ptr, val);
+}
+
 __rust_helper void rust_helper_atomic_i16_set_release(s16 *ptr, s16 val)
 {
 	smp_store_release(ptr, val);

