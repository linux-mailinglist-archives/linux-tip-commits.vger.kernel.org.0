Return-Path: <linux-tip-commits+bounces-7916-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9B8D18370
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A871306C9BA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CDE38BF63;
	Tue, 13 Jan 2026 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VAm9GxX5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="szxkZaiO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDE938BDA9;
	Tue, 13 Jan 2026 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301388; cv=none; b=aZ8u63Ggt+mNiQYc8C+kw010F+nNwZgbDEkzGUkyMoih3XN/cwmBR0fFO07bRKoTO/ijZ0Z6qSU57Z8yBA7P3ff8lZQsCcwyfERKK0rJCaA5RdU4di2nw0cmt4AebMytkD6CBfnYyCYIubUHqIE1O169eDPEC4ArTTeaBGoM5Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301388; c=relaxed/simple;
	bh=TbdFb7GS/7RzeqyZcjKkkbQVCQxOhyqTsq0HwDKVX/c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TK0/01MF18AeoefKNecimUMsCKiKKUT45QqVKQiAxxri2TeFnWyNkcOIGM1wrYpEIcHboRMhWuNw+3LvDcEzhAYCefidcUSdczrcvZCc0qJ8f20obxfetL8fvbwfapo5HwFxXfe+5qXaiYPybVRxf5LGfXrGV89Npm2ESxvZvO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VAm9GxX5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=szxkZaiO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:49:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301385;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z56GUJj6dC5eLpQJDfC6HbRqX7n79qBOSNiRq+aFylY=;
	b=VAm9GxX53M14GShJXSW8rc2OzhmEh4h2A5nW2RSle3BLyAHMrq1p7aR5txMP/2DOhPue1b
	hnt8xV2Hnr1MrkuKRnGkqGFuzNSh/WDtKhSbgA4mplBVUipr0zX0zg2siDrRx8Wluu40Ub
	cD8Lt6nDGyB3ck0CE69N8/v37EN5LAlAk1dOfazmuYuXl6bAMkTb3XE3cOpcyRxa/3cy8d
	SiUOetssyIFLgW6eqbxLeXt/8AvZkNvPGcdGLIChcVHPmbb3RJ3o4RPIaEuLNZ6qE1NRcJ
	2XogeNIp/KfCp27gEMrx9S0v2vA460DDljJiUEHI/5W6ZwbdGx+8rkYVDb3bDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301385;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z56GUJj6dC5eLpQJDfC6HbRqX7n79qBOSNiRq+aFylY=;
	b=szxkZaiOPwtEUuHBQfpgNcxFz7wIldv0tkx13fmY9CafmqgPhbziOyAnQ6IUZH5znycims
	9sS2J4cU7HaXwoBw==
From: "tip-bot2 for Alice Ryhl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: cpu: Add __rust_helper to helpers
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105-define-rust-helper-v2-6-51da5f454a67@google.com>
References: <20260105-define-rust-helper-v2-6-51da5f454a67@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830138424.510.7602094010559325997.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9f658bd5378d5c357d5eeb1e699f1504a7498dbf
Gitweb:        https://git.kernel.org/tip/9f658bd5378d5c357d5eeb1e699f1504a74=
98dbf
Author:        Alice Ryhl <aliceryhl@google.com>
AuthorDate:    Mon, 05 Jan 2026 12:42:19=20
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:41 +08:00

rust: cpu: Add __rust_helper to helpers

This is needed to inline these helpers into Rust code.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20260105-define-rust-helper-v2-6-51da5f454a67@=
google.com
---
 rust/helpers/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/helpers/cpu.c b/rust/helpers/cpu.c
index 824e0ad..5759349 100644
--- a/rust/helpers/cpu.c
+++ b/rust/helpers/cpu.c
@@ -2,7 +2,7 @@
=20
 #include <linux/smp.h>
=20
-unsigned int rust_helper_raw_smp_processor_id(void)
+__rust_helper unsigned int rust_helper_raw_smp_processor_id(void)
 {
 	return raw_smp_processor_id();
 }

