Return-Path: <linux-tip-commits+bounces-7938-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 236ADD183D0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 383B33010BC8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175D13921EA;
	Tue, 13 Jan 2026 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kZ1pY/b9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2cC09OmB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3118938FF09;
	Tue, 13 Jan 2026 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301412; cv=none; b=hjAFZE2NCTSO+6BtGDl4lpt3cEfJzyeYKb7tGlVmZ+nCU8WvY/U0sMA4g82pVbFg6ee8uTkXKxRCWgNJU9jGMwIvWsWjJ07bG5RMeRTUmCPkBqy9axeoSF0VGZh3KqCd50K2U6HAaZS+jxK+P2025suzr6FTyYJUxsOTQPrdJhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301412; c=relaxed/simple;
	bh=/66V4NngTItnHuM82PwpEiDJ/kJKXhr7Iw5YQ6L+SE4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YaDTYYIOVjrv4eXSEG1M1oYXaVrfG/ZEasl513Qhno1II3/ZILUWXXU/0jEq2wXkvcTIl7MBVto5rkamCTTDzRrTLzG7p1d1K/kuVaJCA15QskAcSnftd06uS2tUvGvSAp/YOEIONoJvEdxMZxx3oZA18znhTTlNxMLfbGjsVCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kZ1pY/b9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2cC09OmB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:50:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301407;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zicaFuq6KHQ2m30WhBCR9gFrIdDkks9z13+EPxlqZKI=;
	b=kZ1pY/b90og1KjfewvIoIX2+wLbT3ikKdgViW/WfJZ39A20h8vbFH1y4dYIndT6R/lXdQZ
	qc2y59JreTy0MIWVO9h5W98yBjtcNKwNydOr0mkemeex+CAz1ziSk1PCiMXkrz8KnEYLmC
	c6xFS6A4Pvz3+zEIF38Ap4Q75vHZixLDn5wLbfAYMFFye97wdsCo1VwTm/+dTeHsxGlNvV
	2zjR4Xz4XnTvsfHzs1mc5wPapvIkfvmxVSQZkNwIW+kSyXzI4QGc66fX4pjGt8nZvjbAsW
	5CSQPu7lpuwaCfl2GNusK1aJiNhL6gC+0c7gy/1ph7eT+RcZG0MPFogUuhUiSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301407;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zicaFuq6KHQ2m30WhBCR9gFrIdDkks9z13+EPxlqZKI=;
	b=2cC09OmB2163w4GlIItxs0JsqPJwDR2aa4dPO4g0f7h0DR6oFwBvo/23ZB2EPPeza06rhF
	tHUA0+1B+lBNX/CQ==
From: "tip-bot2 for FUJITA Tomonori" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: helpers: Add i8/i16 atomic xchg helpers
Cc: Alice Ryhl <aliceryhl@google.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Gary Guo <gary@garyguo.net>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251223062140.938325-2-fujita.tomonori@gmail.com>
References: <20251223062140.938325-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830140660.510.14397509933345561510.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5dbc0a692459bc49cdb7add281086291da547750
Gitweb:        https://git.kernel.org/tip/5dbc0a692459bc49cdb7add281086291da5=
47750
Author:        FUJITA Tomonori <fujita.tomonori@gmail.com>
AuthorDate:    Tue, 23 Dec 2025 15:21:37 +09:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:40 +08:00

rust: helpers: Add i8/i16 atomic xchg helpers

Add i8/i16 atomic xchg helpers that call xchg() macro implementing
atomic xchg using architecture-specific instructions.

[boqun: Use xchg() instead of raw_xchg()]

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20251223062140.938325-2-fujita.tomonori@gmail.=
com
---
 rust/helpers/atomic_ext.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
index 02e05b4..3136255 100644
--- a/rust/helpers/atomic_ext.c
+++ b/rust/helpers/atomic_ext.c
@@ -2,6 +2,7 @@
=20
 #include <asm/barrier.h>
 #include <asm/rwonce.h>
+#include <linux/atomic.h>
=20
 __rust_helper s8 rust_helper_atomic_i8_read(s8 *ptr)
 {
@@ -42,3 +43,20 @@ __rust_helper void rust_helper_atomic_i16_set_release(s16 =
*ptr, s16 val)
 {
 	smp_store_release(ptr, val);
 }
+
+/*
+ * xchg helpers depend on ARCH_SUPPORTS_ATOMIC_RMW and on the
+ * architecture provding xchg() support for i8 and i16.
+ *
+ * The architectures that currently support Rust (x86_64, armv7,
+ * arm64, riscv, and loongarch) satisfy these requirements.
+ */
+__rust_helper s8 rust_helper_atomic_i8_xchg(s8 *ptr, s8 new)
+{
+	return xchg(ptr, new);
+}
+
+__rust_helper s16 rust_helper_atomic_i16_xchg(s16 *ptr, s16 new)
+{
+	return xchg(ptr, new);
+}

