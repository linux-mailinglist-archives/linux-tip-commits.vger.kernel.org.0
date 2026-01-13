Return-Path: <linux-tip-commits+bounces-7929-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEF9D1837C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3E3C301881F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A1038F24C;
	Tue, 13 Jan 2026 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IygiXxGd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xfjRcR1D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E592B3382DB;
	Tue, 13 Jan 2026 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301404; cv=none; b=Pd3Tlzl2TzHfzr++TBksXS/lhg5bFrTFmucmGHwhsCvJibS8wX+dHbZ/parfTW85CJO4FG6vjAQ5z5bYcGUDT3D+gDg1djGVGY1Cn7WNQNlp6TNit7GDas1B28G2wh91DHcmg81Y9h+RXSg8OiOZjmHEQYL0FvEgZZTLwx1J3X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301404; c=relaxed/simple;
	bh=LspetAfkChFFOL4lvfR4lUN4wVI0PvbuyB761riOptI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cS2p2DAg416ZponYsSOVJBu9ZIvbz58jKbeJIc4LP+xyYsFjtqsBmJlykheYlPDrM4Y/3yu13voc8WwKZX0LHGdUxlB+qUPSl2AJh77ivm91RsyTi6CuAX7NWaVvQTxS624OyUI0zrLmFV7X4dRfaQ5OhynBLLbwoZcZeo9vvbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IygiXxGd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xfjRcR1D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:49:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xPEtPkXIlwevkk5rC8prlH6agB7E5f/aHdViCrAoQAo=;
	b=IygiXxGdOpUJDElF4CMsPaiJ0N3jGEBjBvMPO0WQdMm9UAPtFVc8xzGk/KreSkwr6cnj3Q
	kTQ416YYS15Z5KQCJDIAqVyt1vHmmX1v6YqIRb8ghnzGq0bgnU9OnWzwW4mzFOAiBiSHmj
	VljYdILovIbN1gOTEFxUUP0/GeVRDd1ijLhpZqyy/TItZ37SgUt9M12bhq30p6Lm1sPine
	zgotKzsQO+plmvJ0VliBnZjkpYrqNy5mFrRXpYMMoOCto099uMj4PNO7LH2YAO9byQgZSs
	rm/xRDu9hmLEY8kmCz/Lq2SHQpvgYlRDLmei0ZdOp8XSTdYGPHa2EahVRs18uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xPEtPkXIlwevkk5rC8prlH6agB7E5f/aHdViCrAoQAo=;
	b=xfjRcR1DR+unTvx970hj7vpV9AjgmoW+UP9V6GKXiiR14my+jfaxMLsHngoT6P9u/qK5E/
	+r+KZ/iEZUNmhCDw==
From: "tip-bot2 for FUJITA Tomonori" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: atomic: Add atomic bool support via
 i8 representation
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Gary Guo <gary@garyguo.net>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260101034922.2020334-2-fujita.tomonori@gmail.com>
References: <20260101034922.2020334-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830139219.510.11680138596134249383.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     06bd0e52bfd78eae1c7dd5db163ce64161b495e7
Gitweb:        https://git.kernel.org/tip/06bd0e52bfd78eae1c7dd5db163ce64161b=
495e7
Author:        FUJITA Tomonori <fujita.tomonori@gmail.com>
AuthorDate:    Thu, 01 Jan 2026 12:49:21 +09:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:41 +08:00

rust: sync: atomic: Add atomic bool support via i8 representation

Add `bool` support, `Atomic<bool>` by using `i8` as its underlying
representation.

Rust specifies that `bool` has size 1 and alignment 1 [1], so it
matches `i8` on layout; keep `static_assert!()` checks to enforce this
assumption at build time.

[boqun: Remove the unnecessary impl AtomicImpl for bool]

Link: https://doc.rust-lang.org/reference/types/boolean.html [1]
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20260101034922.2020334-2-fujita.tomonori@gmail=
.com
---
 rust/kernel/sync/atomic/predefine.rs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/p=
redefine.rs
index 248d265..3fc9917 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -5,6 +5,17 @@
 use crate::static_assert;
 use core::mem::{align_of, size_of};
=20
+// Ensure size and alignment requirements are checked.
+static_assert!(size_of::<bool>() =3D=3D size_of::<i8>());
+static_assert!(align_of::<bool>() =3D=3D align_of::<i8>());
+
+// SAFETY: `bool` has the same size and alignment as `i8`, and Rust guarante=
es that `bool` has
+// only two valid bit patterns: 0 (false) and 1 (true). Those are valid `i8`=
 values, so `bool` is
+// round-trip transmutable to `i8`.
+unsafe impl super::AtomicType for bool {
+    type Repr =3D i8;
+}
+
 // SAFETY: `i8` has the same size and alignment with itself, and is round-tr=
ip transmutable to
 // itself.
 unsafe impl super::AtomicType for i8 {

