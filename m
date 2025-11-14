Return-Path: <linux-tip-commits+bounces-7353-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C70FC5E3F3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 17:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC2BC4F72A4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 15:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EE6338F2F;
	Fri, 14 Nov 2025 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S0Hl6UNa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JOahEyx9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CA1330339;
	Fri, 14 Nov 2025 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134396; cv=none; b=ZXP7u24oNvr5OySdivxvlyVMxL0bu5IxzD1jQPRuoJTNc6jekg5TVXJRFOttTdhrW7za+m3BCYOu3vdnNZXQSTgzAH4Bk2wZD1YnyC1waV4wN9+EMKYm7FESIFi6XZoJS0iigtkkOZR3YYomVlEbcxLigE84/CS21udFf1wgGNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134396; c=relaxed/simple;
	bh=6jrvOWpYc1u8xRVFrgsjWa0PNaERgc+XTaeCfas74ho=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DgcFEDV6vCdauJSM9kS/hpOw2riTbKFXwRHgCnahceYsju46Bu88YXCO18DWcqGK18VSZR6/qE0IoSlvZvPHpLF5l6hOKcSdCU/TQHqlhpGVNZhQjzEJsLEZIhOJxNrTdLavWdrYiykbstovdoFCJYZjgJ/PBt8XyKj1BtUJesU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S0Hl6UNa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JOahEyx9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 15:33:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763134393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lI3i2dIsSTsPWI+1MM/TOKlVPbzOTxUOulzoXCTAoFA=;
	b=S0Hl6UNaksK22lTO4HpU9IzPLcghmdH1JnoyCMZ9csqNeICfzJOcHQE9aO4YqH8SL5sc1t
	X1/AxEZL+iTlyTDiePRg3hHiDGnU3QVG5GLagCMTH67Tunn0tXMMyY9RZU16RHkoD5v1u2
	K9BpusPJwmz/zrxQyVRh6zlmjb8ZNAoQjwu2WpcbQ4ug2pIAZVF/9aZidzJV6IG05Yf733
	TnUDx7cv9U2uA5JRpFvIUSUBFg841Re4Oe5FrCZ0vc5xI1K2tF2TIzfYUG21cS0sRMasVm
	9HMjOSHRPh9FJ5+3QqRDG5v4Y7Np24s454mBPUk5ILo9WQHpOpyZOqgfyxQMHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763134393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lI3i2dIsSTsPWI+1MM/TOKlVPbzOTxUOulzoXCTAoFA=;
	b=JOahEyx9T/kOSUUEiAknTeT/maY+xYCSt4X+SxRMcmPLj0K1zwUOr8qFQHhDN+WWZD3PkL
	47l2AiavUb0up6AQ==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: atomic: Make Atomic*Ops pub(crate)
Cc: David Gow <davidgow@google.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251022035324.70785-2-boqun.feng@gmail.com>
References: <20251022035324.70785-2-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176313439183.498.16191411006958532656.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     14e9a18b07ec463a85094cc8942788336164319f
Gitweb:        https://git.kernel.org/tip/14e9a18b07ec463a85094cc894278833616=
4319f
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Tue, 21 Oct 2025 23:53:22 -04:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Wed, 12 Nov 2025 08:56:38 -08:00

rust: sync: atomic: Make Atomic*Ops pub(crate)

In order to write code over a generate Atomic<T> we need to make
Atomic*Ops public so that functions like `.load()` and `.store()` are
available. Make these pub(crate) at the beginning so the usage in kernel
crate is supported.

Tested-by: David Gow <davidgow@google.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20251022035324.70785-2-boqun.feng@gmail.com
---
 rust/kernel/sync/atomic.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 016a6bc..0bc6e7b 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -22,9 +22,10 @@ mod predefine;
=20
 pub use internal::AtomicImpl;
 pub use ordering::{Acquire, Full, Relaxed, Release};
+pub(crate) use internal::{AtomicArithmeticOps, AtomicBasicOps, AtomicExchang=
eOps};
=20
 use crate::build_error;
-use internal::{AtomicArithmeticOps, AtomicBasicOps, AtomicExchangeOps, Atomi=
cRepr};
+use internal::AtomicRepr;
 use ordering::OrderingType;
=20
 /// A memory location which can be safely modified from multiple execution c=
ontexts.

