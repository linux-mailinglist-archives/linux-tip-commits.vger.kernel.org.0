Return-Path: <linux-tip-commits+bounces-7909-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 92207D18319
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A05BB3033DC2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69453803E1;
	Tue, 13 Jan 2026 10:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oP7W0hhT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="maqsdWcS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E313557E0;
	Tue, 13 Jan 2026 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301379; cv=none; b=lk/7ejzwhqdbJbof89HVaI367eMHavPXIWcu3uXR0B9V6ppa9X8ao3kX0Oa97QuHw4eqll6ikbJ/RLkO+zJioWxRcmBrULtlxIQ5UwbEUwiaM+7g5Lq+/MIZlwk+TKOImkWohNSoBgWnNHeNy5t28Ij83M1QmrhgrieXcyR1bt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301379; c=relaxed/simple;
	bh=3muG8sE/nSyF4s9+rrXyuMqSdij8H784F/5noodeApM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WpZSZojavICLeuRuAUV+ya1J9mgt9Fol1lmY8syYh0dFM24RMDuJo7cprMVb+0K0zq0Y7/Gk2WbkfIyEMlUTaC76scdokpW27NVQpdwBrd8jg45PFZ97yOxhv2mQgWRW3bvZy0OaJoJ6i06UD0dDcErN3X1fpaN+zJfNu4yLr+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oP7W0hhT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=maqsdWcS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:49:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301377;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UpOt0pahLfBULo4Erp4HbY+h4WM7LtnK5sknVDPdvIQ=;
	b=oP7W0hhT9w1BwTuBc0uGaNSDvJaY3jcT+ngpEtpABrS98a11JHyIx67D10uLp0FwCINnkO
	jGj6po+MeuOr77klRdUTmkyG4Hf464yxFdpd+bjd8Kdoa5C7X+BguTLhjEJuTznp33B0qV
	QNUKj5TAf12DRIrH5Xxd+3OgHpgPP6q4jHNn1aCrYc+sVJJf1jg8ANeOgOOONkFJBXd5tW
	fmUmd64s+OHWqy6AnVIqy8AfgRF/jvQG0pS3RZatK8ukBUCxIZ1YTZsG9t615d6TrUwKVU
	H7/ZZJhu/waPRNC5wTzaVzrpEGSK9gtTlMxEt7Z3LtmRq9fAzhhbJG5aaj0X4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301377;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UpOt0pahLfBULo4Erp4HbY+h4WM7LtnK5sknVDPdvIQ=;
	b=maqsdWcSmQ6t7VyEINYekdkM7js+1Y4KDAafaW5bdOs7ttp5Jt6oeNZ6+tPlLHqjFLB46e
	DhjYk5u82p/RQpDQ==
From: "tip-bot2 for Alice Ryhl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: wait: Add __rust_helper to helpers
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105-define-rust-helper-v2-25-51da5f454a67@google.com>
References: <20260105-define-rust-helper-v2-25-51da5f454a67@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830137590.510.14657408857439796205.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5628f0510a4c64908c5d2f36a676b092e1e5d174
Gitweb:        https://git.kernel.org/tip/5628f0510a4c64908c5d2f36a676b092e1e=
5d174
Author:        Alice Ryhl <aliceryhl@google.com>
AuthorDate:    Mon, 05 Jan 2026 12:42:38=20
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:42 +08:00

rust: wait: Add __rust_helper to helpers

This is needed to inline these helpers into Rust code.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20260105-define-rust-helper-v2-25-51da5f454a67=
@google.com
---
 rust/helpers/wait.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/helpers/wait.c b/rust/helpers/wait.c
index ae48e33..2dde1e4 100644
--- a/rust/helpers/wait.c
+++ b/rust/helpers/wait.c
@@ -2,7 +2,7 @@
=20
 #include <linux/wait.h>
=20
-void rust_helper_init_wait(struct wait_queue_entry *wq_entry)
+__rust_helper void rust_helper_init_wait(struct wait_queue_entry *wq_entry)
 {
 	init_wait(wq_entry);
 }

