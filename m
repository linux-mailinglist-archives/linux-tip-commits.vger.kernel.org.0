Return-Path: <linux-tip-commits+bounces-7917-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3783D18382
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51C763078239
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBAC387582;
	Tue, 13 Jan 2026 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="24N4KrPX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s5vpEoLO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BB13816FE;
	Tue, 13 Jan 2026 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301389; cv=none; b=gSR0q8RGYotf1BxIjC+e5LkgNARQDSgTdiI6Bf8lGfgDnGrgkOUGkaXSvno3aV7noKbvt+h/bnTU5Ja8/El8EgH4s7A6xnFCvsJej7tipBAe/Ob3l0USWqzKqtvk9Uqj+c56ow2XgEOf5T0CWCGlQpJMFobbOTc5PgnKxGe+His=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301389; c=relaxed/simple;
	bh=BGFtmJanpWzye4QmR4mYr4Qbs9RC6NhmY/NLIxZbn3E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nHKSLyRWqyLVNjlwxN2GN+9i/fP7dt3lZRMhsyHUB3kxdv7j4zuCxrAT2wyukpCUPp73Rlk54FMDJX/86ikaR0POxktZNOvmhNP3biFQ6EMmOtdlz7qECGB0vmsxOIm9+Df4VXV7G7F92FMO/biP1K3ZxlNqpHz68j5wIslKW+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=24N4KrPX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s5vpEoLO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:49:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301386;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4YqRXUmviP4OyaV1PB7+oNm0TXEGGtcojhhN/oJg3Ug=;
	b=24N4KrPXMANnTZtW3m5shktqL0teC7WMUl0johP1r2lgzElCRpel1msgrLHVIyoMDp2j2s
	3+fUiqce70jW4dKpPqeC2Ug3S36hnxEWOUGg+W+MnjbOu3kFA+Lt8KXqkUZYVBDLc30MwL
	sBQFHsQ23fpVXBSk8WyLnp05rTQDd0FQpndE6fUC4qyLdpQQ1kUik0PtQ4tvv+ddtVVaNZ
	RzMA+EhW17wyC2AnSVmpHszYDhU5fuaxTMGHOfrzFoclC2u50Qbv8sk1/YDkU0mOwyfInC
	EepBxZsP8q/uP6hERsS743a6sbDE3Khf7AavtLj9EA+VrWJo/vSZid1ebU5vrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301386;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4YqRXUmviP4OyaV1PB7+oNm0TXEGGtcojhhN/oJg3Ug=;
	b=s5vpEoLOEtzbF7miFp5+5iFkrDQv68AEiWIF78hrv/QT7aEMkMJ/EJF+RYDUVK7FcT3A6n
	iIA1hT6y2RK0k+CA==
From: "tip-bot2 for Alice Ryhl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: completion: Add __rust_helper to helpers
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105-define-rust-helper-v2-5-51da5f454a67@google.com>
References: <20260105-define-rust-helper-v2-5-51da5f454a67@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830138528.510.17859214990451219870.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     1c7a6f48f7eeb3014584d2fc55fc67f0cbaeef69
Gitweb:        https://git.kernel.org/tip/1c7a6f48f7eeb3014584d2fc55fc67f0cba=
eef69
Author:        Alice Ryhl <aliceryhl@google.com>
AuthorDate:    Mon, 05 Jan 2026 12:42:18=20
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:41 +08:00

rust: completion: Add __rust_helper to helpers

This is needed to inline these helpers into Rust code.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20260105-define-rust-helper-v2-5-51da5f454a67@=
google.com
---
 rust/helpers/completion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/helpers/completion.c b/rust/helpers/completion.c
index b244326..0126767 100644
--- a/rust/helpers/completion.c
+++ b/rust/helpers/completion.c
@@ -2,7 +2,7 @@
=20
 #include <linux/completion.h>
=20
-void rust_helper_init_completion(struct completion *x)
+__rust_helper void rust_helper_init_completion(struct completion *x)
 {
 	init_completion(x);
 }

