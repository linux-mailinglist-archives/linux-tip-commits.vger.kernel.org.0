Return-Path: <linux-tip-commits+bounces-7913-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A920D1832E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB6923012EA0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C284438B9A5;
	Tue, 13 Jan 2026 10:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UX6Q8/U+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ONdlKK8J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289A538B7AD;
	Tue, 13 Jan 2026 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301385; cv=none; b=qGQ0pk3+WsVT/SWfCBXkiQcYmE+jATpOD1i/QfG8bNnzRw2Rd4dxxjlJrXCsWZ7nIc43F27JWmfTcPjkH757zh5awoDYD7z4AI6hs0dv3GayU3FxRxMxmcx2U66hD1AyYxoc5mo8EZRaAUMulZ6MGRoMNbLNyhHfShw37wJ73F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301385; c=relaxed/simple;
	bh=nA8M+rMOZ5OLLimYRulvmxZE3G7OrAYJEKu22M4YO/E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HWwXn4qtPVLMCGEGrB6I3ZuXmG+40gvpWi1ZCCf3xH9m7RwdTiCrknEpRO3DxH+mNz/KtY8MG71qZE7ne60oSkL21uxBBaOgfhH3umM5Y/FH3FyXAC0MtCBXubLdL+ktoGxUyCbDpRCoujOV/fASxMNmIbGJNFBxW4CQV1a1a04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UX6Q8/U+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ONdlKK8J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:49:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301382;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5kZAbAOOVGfnHzGLLrLUKf6MjTlNbAjQOGJbKLNuRE=;
	b=UX6Q8/U+qn6T5ymjPAOxe49util8ct+6zJ7DHGCLAMT+56+s4kj+Dl2ntUrzIgXk1Mk+sS
	5Px3sMuIShvb2cts7H/5Mpwa+qxBJ05Yh2v1FWZylTiRfAIiuXSKwD3rDsrT4XKJxOzIwB
	fVyB0251NLFFUYx3zTkl+jzDrMTygUwocbPs1zwscBQgP67NnjV1MXm8EYjOQ1xViUW4Wx
	cwCyJMfKoSumvO9ixxF0kVYhCantAsIZOauSLXR+WWdy7d3fs6JNMb96A6hSMOBaw+nj5H
	ZWHDDfPCiwJz3XnKhPV1hTssDfcBkC+qRHzhCc9siUnNBOGuVRaS52SDGdYnmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301382;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5kZAbAOOVGfnHzGLLrLUKf6MjTlNbAjQOGJbKLNuRE=;
	b=ONdlKK8J4gWFHeEs2BePClp0Gb/BGI0XnrO0d7TbzMLyXlAdVCTSePlbIZtnGFpUFYJF45
	RHZoHHkgDgY2ZTCg==
From: "tip-bot2 for Alice Ryhl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: refcount: Add __rust_helper to helpers
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105-define-rust-helper-v2-17-51da5f454a67@google.com>
References: <20260105-define-rust-helper-v2-17-51da5f454a67@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830138111.510.15968522344970050896.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9ba1aaf25ab7dadb910348b6857865e87b4c5689
Gitweb:        https://git.kernel.org/tip/9ba1aaf25ab7dadb910348b6857865e87b4=
c5689
Author:        Alice Ryhl <aliceryhl@google.com>
AuthorDate:    Mon, 05 Jan 2026 12:42:30=20
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:42 +08:00

rust: refcount: Add __rust_helper to helpers

This is needed to inline these helpers into Rust code.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20260105-define-rust-helper-v2-17-51da5f454a67=
@google.com
---
 rust/helpers/refcount.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
index d175898..36334a6 100644
--- a/rust/helpers/refcount.c
+++ b/rust/helpers/refcount.c
@@ -2,27 +2,27 @@
=20
 #include <linux/refcount.h>
=20
-refcount_t rust_helper_REFCOUNT_INIT(int n)
+__rust_helper refcount_t rust_helper_REFCOUNT_INIT(int n)
 {
 	return (refcount_t)REFCOUNT_INIT(n);
 }
=20
-void rust_helper_refcount_set(refcount_t *r, int n)
+__rust_helper void rust_helper_refcount_set(refcount_t *r, int n)
 {
 	refcount_set(r, n);
 }
=20
-void rust_helper_refcount_inc(refcount_t *r)
+__rust_helper void rust_helper_refcount_inc(refcount_t *r)
 {
 	refcount_inc(r);
 }
=20
-void rust_helper_refcount_dec(refcount_t *r)
+__rust_helper void rust_helper_refcount_dec(refcount_t *r)
 {
 	refcount_dec(r);
 }
=20
-bool rust_helper_refcount_dec_and_test(refcount_t *r)
+__rust_helper bool rust_helper_refcount_dec_and_test(refcount_t *r)
 {
 	return refcount_dec_and_test(r);
 }

