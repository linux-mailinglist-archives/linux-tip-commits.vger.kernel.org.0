Return-Path: <linux-tip-commits+bounces-7939-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 452F8D18406
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE0A63070AAE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DC7392814;
	Tue, 13 Jan 2026 10:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4p7zpY2y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FsNUXypa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705D53921F3;
	Tue, 13 Jan 2026 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301415; cv=none; b=QyBI3+o0Oo4UFBMuYAkuEznB6cbdaEZV2wHxWJmYjdQ3mA7on/QXJx/0uSN2OsW2OUrorr/wWhUIhXHpM2kjJOP/Dn+SyYN/9cN7K4NRyUGkzaWL7fGwhh3yN9yMkjeiT5qpkEtmaYfjVVXZOYjThvqum/XUW3Ve6E4/71clH58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301415; c=relaxed/simple;
	bh=syijjlu3tre9Xp7kXflU7BfiY5b6UAO4IK+LAuRmrjw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jp6cw0FHJvVF3ijH28OGN0M8pwx/lYG6MngYLgcxjza2d2TO+tMDRnJxeC0oivvg+WmYM/c7coLRNXQhdh1jFUXIoG/Hoij74RnI0TTdqb6VR+BruIATDj5RI9qUlGvU4psVoPh7HEGAaobXscakp9l04Bi7WV60wIWFjduGcYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4p7zpY2y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FsNUXypa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:50:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301412;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeO0RYgBFoOrFrtbMqUl16CUgQb9uOoQC3uC/7ndzBA=;
	b=4p7zpY2yLttOCvdwgtOb95fNXpoyw+lZkjtbC2f6b6J04eitFu4YNoO58y9VloyFtMr+zh
	1EA/4Crxe+I9j0VhsBEUH4CE5JffHxAJ6L+USrR31wgPib2HNACBX22Jndory1Iet5JGuW
	ca6OgFK5NFLzbwXXfXyw31QXTwRcJrTOJsMFS01M0LJ/Q3Ib9sXpYwKVDFfE1Ve57i7DTx
	pQ1o+84q6TwY0siN8HQwD5Vh3TATSisbm4vHLBfCdzC18mQfQzRfgOx00E5fLLDnUvsZXz
	5Vauhroiykf02G+G4tGpgTiuyqUQY1vl+efdkvyaTuOEl4y5NTL8bXPf1nROrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301412;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeO0RYgBFoOrFrtbMqUl16CUgQb9uOoQC3uC/7ndzBA=;
	b=FsNUXypakADuauEqDiiZ4PcPwFF4XiJRS+P9amehAAlvDQpwNNHGL8WDoSp47EzW/z73TI
	bMR/PRIL0cWLZYAg==
From: "tip-bot2 for FUJITA Tomonori" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: set_once: Implement Send and Sync
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Gary Guo <gary@garyguo.net>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251216000901.221375-1-fujita.tomonori@gmail.com>
References: <20251216000901.221375-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830141082.510.4677710192596737229.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8a581130b1cbc17c702298b8325e3df98c792760
Gitweb:        https://git.kernel.org/tip/8a581130b1cbc17c702298b8325e3df98c7=
92760
Author:        FUJITA Tomonori <fujita.tomonori@gmail.com>
AuthorDate:    Tue, 16 Dec 2025 09:09:01 +09:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:40 +08:00

rust: sync: set_once: Implement Send and Sync

Implement Send and Sync for SetOnce<T> to allow it to be used across
thread boundaries.

Send: SetOnce<T> can be transferred across threads when T: Send, as
the contained value is also transferred and will be dropped on the
destination thread.

Sync: SetOnce<T> can be shared across threads when T: Sync, as
as_ref() provides shared references &T and atomic operations ensure
proper synchronization. Since the inner T may be dropped on any
thread, we also require T: Send.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20251216000901.221375-1-fujita.tomonori@gmail.=
com
---
 rust/kernel/sync/set_once.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/sync/set_once.rs b/rust/kernel/sync/set_once.rs
index bdba601..139cef0 100644
--- a/rust/kernel/sync/set_once.rs
+++ b/rust/kernel/sync/set_once.rs
@@ -123,3 +123,11 @@ impl<T> Drop for SetOnce<T> {
         }
     }
 }
+
+// SAFETY: `SetOnce` can be transferred across thread boundaries iff the dat=
a it contains can.
+unsafe impl<T: Send> Send for SetOnce<T> {}
+
+// SAFETY: `SetOnce` synchronises access to the inner value via atomic opera=
tions,
+// so shared references are safe when `T: Sync`. Since the inner `T` may be =
dropped
+// on any thread, we also require `T: Send`.
+unsafe impl<T: Send + Sync> Sync for SetOnce<T> {}

