Return-Path: <linux-tip-commits+bounces-7910-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D967D18331
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 669EE3045753
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3065538A70F;
	Tue, 13 Jan 2026 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c0CQ4heQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NgcXs4V0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49AA3659ED;
	Tue, 13 Jan 2026 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301382; cv=none; b=s3vMtuE+Yz+97moBGnpGOl5NfGcZ02kQdi2bdvtXlm4mMtvEZr0DIy19vPOB0QXLWC1R3ajipmXAJCN2XUXBZ2/Df3/nERRFuigIR2qED2w3fD73/5TmAw49MKPbg4iG729otWTxNqhgunrGNFeTRLiEdF0LdWwH+aRQ529GAYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301382; c=relaxed/simple;
	bh=yIBhiNutV5FSmig0u0tuB8+qLrhzExpSBXIAcwD65zc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Fr2XTHeqtuhNeAODvHr9tz2bMiTGpxd7jnQ9j00jSEIHstMYwlFyx7D1xUu01l79EWsz8DvAoH6Vk7KDOFpJrwZqGvhuQl9HLxeZ0+Y3pW9QezXlmQA09AMyiZL0nAXmG4Rkw9QW1jMxKguaxb7tfiTGm6z8LsjQzMMMOApw524=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c0CQ4heQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NgcXs4V0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:49:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301379;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/e269CkuIimSKKF8Ku5sLRXjEEHttMDdqol222NCyw=;
	b=c0CQ4heQggX1Ht74WLC3EutHr0N9NQFQUFgNLzxOV7jfKiDBYAC/jY918IkGbxjxp3ayvU
	DZDVRL7PXAGpJI1ncJ86Ub5ySVT1ksOaUP2LOWZHPwgImgJmnX0PDPplXwQRM/cwTuWrZh
	GfjHQnqKgg6q4sGaku4CMitTsVnXrrZZnQSjwwAMqarVK1PSMUFeU/86CDmf/8fuJvulAk
	52KKU4Z5XKXaIbDdCU0+xPe76EmGJGn0eLSpgrDjNnm+vm5Zbq5vaONG47f8EylymM7wwF
	JjeugIDHHs8oU/wjquJaIhyLOiE4qFV23MwGCnPis19oYYHbJ/HLgihuksnhIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301379;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/e269CkuIimSKKF8Ku5sLRXjEEHttMDdqol222NCyw=;
	b=NgcXs4V0dbL/nvi83WvgOOoEBuDTlVyTK6WnLZeTc6vH9+yh/phBA8CqmVxU3LEeJ08gS/
	ZWWomU9Z02bWG4BA==
From: "tip-bot2 for Alice Ryhl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: time: Add __rust_helper to helpers
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105-define-rust-helper-v2-22-51da5f454a67@google.com>
References: <20260105-define-rust-helper-v2-22-51da5f454a67@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830137700.510.15890434766266812872.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     75b6034780e8dc8c71096313534ccb720fa633f9
Gitweb:        https://git.kernel.org/tip/75b6034780e8dc8c71096313534ccb720fa=
633f9
Author:        Alice Ryhl <aliceryhl@google.com>
AuthorDate:    Mon, 05 Jan 2026 12:42:35=20
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:42 +08:00

rust: time: Add __rust_helper to helpers

This is needed to inline these helpers into Rust code.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20260105-define-rust-helper-v2-22-51da5f454a67=
@google.com
---
 rust/helpers/time.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/rust/helpers/time.c b/rust/helpers/time.c
index 67a36cc..32f4959 100644
--- a/rust/helpers/time.c
+++ b/rust/helpers/time.c
@@ -4,37 +4,37 @@
 #include <linux/ktime.h>
 #include <linux/timekeeping.h>
=20
-void rust_helper_fsleep(unsigned long usecs)
+__rust_helper void rust_helper_fsleep(unsigned long usecs)
 {
 	fsleep(usecs);
 }
=20
-ktime_t rust_helper_ktime_get_real(void)
+__rust_helper ktime_t rust_helper_ktime_get_real(void)
 {
 	return ktime_get_real();
 }
=20
-ktime_t rust_helper_ktime_get_boottime(void)
+__rust_helper ktime_t rust_helper_ktime_get_boottime(void)
 {
 	return ktime_get_boottime();
 }
=20
-ktime_t rust_helper_ktime_get_clocktai(void)
+__rust_helper ktime_t rust_helper_ktime_get_clocktai(void)
 {
 	return ktime_get_clocktai();
 }
=20
-s64 rust_helper_ktime_to_us(const ktime_t kt)
+__rust_helper s64 rust_helper_ktime_to_us(const ktime_t kt)
 {
 	return ktime_to_us(kt);
 }
=20
-s64 rust_helper_ktime_to_ms(const ktime_t kt)
+__rust_helper s64 rust_helper_ktime_to_ms(const ktime_t kt)
 {
 	return ktime_to_ms(kt);
 }
=20
-void rust_helper_udelay(unsigned long usec)
+__rust_helper void rust_helper_udelay(unsigned long usec)
 {
 	udelay(usec);
 }

