Return-Path: <linux-tip-commits+bounces-7933-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24065D183C7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4FC0300E8EC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D5038FEEA;
	Tue, 13 Jan 2026 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WDk7tvjJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ncv4NLCD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D873803E1;
	Tue, 13 Jan 2026 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301408; cv=none; b=reGjAwVjk60v+ACI3qwTf2T7EDIYCGfeWIebG62PBgTEYkIbwh7kCbY13KHyA20tbf9GaPkEEVKkswvGCMFEDLGAw2nExbwPWSrxBfwdLDivqUPRScbB21fDkTxXQI621ho85WwaW7D0kpLb+39oMLCqCuojgp2XhvGnnWlZVXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301408; c=relaxed/simple;
	bh=1GF4CQiv/jb4x2JxKG4+qD6b3gkOwjBDtCltWLi2GqE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bcTZC3BQ7EgLk1gikQaQHnS5xqaJYu+SxRzUAkuitYQollClcn0rdbH3ntc/bjSYyTjydfBaZcl9rvo2wBqAoz+uQQGC1MNPfRpi+rYeHMB6llASnWtCfNidgk7TNmetdV/SNcRqTvmZ+Q74pR4sA7/cwzfRYZDgoEUjeNKASPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WDk7tvjJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ncv4NLCD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:50:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301404;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUWMQtaADUMKj8FwZODhDKven6BIBcl+xeNFz63+A3c=;
	b=WDk7tvjJG70fMiafiBxk+py1S9fmhVl6fUmUQvt9UEH8VsfvTEknw3aeW3oQP/IZhvHubB
	a3o+Z8hlDsFNfs4KukoEPFH92yiY+4EyiRkSa7Yb0zGusoHdoPZJ6vv+fDtHmtGj6VqmNu
	TEl4raLEv39HSq4nLKULg7P9AU8vCjJwXHGYE/2txfDjcfLKxlwOz/f9Ria0HrVN7+/71E
	qC6t9vCZ6QI/LXHt46HnreOY+OExfN7UZcz/SDSDWXicDF0lxAp/LYitsUlWQPwt4j91En
	rsg88q7woM557PY6YZ1Fxm3v1l1WHi9DOp7Sut1EwrnjqNp3Fzk05ctZnvHUJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301404;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUWMQtaADUMKj8FwZODhDKven6BIBcl+xeNFz63+A3c=;
	b=ncv4NLCDOoHJ5D7CTZImjTVY0wC52P3xjj/sh2OEIzn5g1XrqiodSptuI6ik0dSquSNEXV
	eGvh1IAGkVG2deAg==
From: "tip-bot2 for FUJITA Tomonori" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] rust: helpers: Add i8/i16 atomic xchg_relaxed helpers
Cc: Alice Ryhl <aliceryhl@google.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Gary Guo <gary@garyguo.net>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251223062140.938325-5-fujita.tomonori@gmail.com>
References: <20251223062140.938325-5-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830140333.510.1571175755033980626.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     910cbddc416cc30d83966baf378f44e59f3dc5d7
Gitweb:        https://git.kernel.org/tip/910cbddc416cc30d83966baf378f44e59f3=
dc5d7
Author:        FUJITA Tomonori <fujita.tomonori@gmail.com>
AuthorDate:    Tue, 23 Dec 2025 15:21:40 +09:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:41 +08:00

rust: helpers: Add i8/i16 atomic xchg_relaxed helpers

Add i8/i16 atomic xchg_relaxed helpers that call xchg_relaxed() macro
implementing atomic xchg_relaxed using architecture-specific
instructions.

[boqun: Use xchg_relaxed() instead of raw_xchg_relaxed()]

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20251223062140.938325-5-fujita.tomonori@gmail.=
com
---
 rust/helpers/atomic_ext.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
index 2b976a7..76e392c 100644
--- a/rust/helpers/atomic_ext.c
+++ b/rust/helpers/atomic_ext.c
@@ -80,3 +80,13 @@ __rust_helper s16 rust_helper_atomic_i16_xchg_release(s16 =
*ptr, s16 new)
 {
 	return xchg_release(ptr, new);
 }
+
+__rust_helper s8 rust_helper_atomic_i8_xchg_relaxed(s8 *ptr, s8 new)
+{
+	return xchg_relaxed(ptr, new);
+}
+
+__rust_helper s16 rust_helper_atomic_i16_xchg_relaxed(s16 *ptr, s16 new)
+{
+	return xchg_relaxed(ptr, new);
+}

