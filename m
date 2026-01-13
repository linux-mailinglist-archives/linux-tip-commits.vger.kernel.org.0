Return-Path: <linux-tip-commits+bounces-7927-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 759BBD18376
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 329D930259DD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5D638F23C;
	Tue, 13 Jan 2026 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aXRVqkiF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yADW6eK7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BCA38E5E5;
	Tue, 13 Jan 2026 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301404; cv=none; b=E/9u8Xbwm8Y+XmgDX1sNSqbFIdShrkTD0lSP4O26uiqZaaTP1pJWBwN1dLAb/JF65h6aAw/bf7Aj8XawYHSjPnoWOkoO+x04Ic40Q6zJk65oGe7kuMq2gn22zGtahwFqWuEwSBrFLEQ8hQInfwg6P7aGQ30fz/dpPX/Lr3gxkeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301404; c=relaxed/simple;
	bh=a5/hiCwYIZ+jBvufWKkvBKoCJHBncaxQDdPC6Jh97EQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OtrHOgH3WbiZVlHTCDDJ9ZZqZf0nzm3ei4htTmgrna687vhUnNAyOWANQeEG9y2i5h8F5xXIeW8J5xRXl3mCEq+w5prqhnn9Fi5eA5sAc9xjNLGNHOX2Z+T/wQf18HiFlvKC8TjdEi0yXRfcyiBN7Vc3EdSrg1pGcNEwO8W3+6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aXRVqkiF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yADW6eK7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:50:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301401;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjMMHyctdFRtyDW4AaNZDeOf2Bs7isR8vMBeTYrN5Ao=;
	b=aXRVqkiFCfpZ8r5aEYWez4JmrOxis6ZD5HAlaNIhrLU1KJQzMux5oxVh70rZhStLZP6wUY
	t5NGA2ewE6gL353qkp1oPHplZLMjaaiSkMt/7oesg7UiJ53oPls1njGUwO6TFSSJ06v9vT
	oJXMZoJ8aJLqw8/5nYdScrA52X0NbGPsAeqVe0dMSWir+EL7VfEjmEOYTg6MTBSYCiw+jh
	9I9+Ig8qEayGYnQmpJH982E7gFssrb5Z1q6Qt3PjbVGkb3/cOZGIklCRZUVSCosIyIcw7f
	cLOP9/MSaJQsnuISuLn3yChkgF+cMlhXpEgG0JpnQZKdnt8hPqcMfNK3Cx7Nvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301401;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjMMHyctdFRtyDW4AaNZDeOf2Bs7isR8vMBeTYrN5Ao=;
	b=yADW6eK7TyQtwGdkg7CKK/NW9pOkV3hbeOpRQDc61QJa3KvO4FcPFmHdiaJd+GLtO3XiXC
	etTYzXJC5iKt4jCQ==
From: "tip-bot2 for FUJITA Tomonori" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: helpers: Add i8/i16 atomic
 try_cmpxchg_release helpers
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251227115951.1424458-4-fujita.tomonori@gmail.com>
References: <20251227115951.1424458-4-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830140020.510.5720171850048014435.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b5992f07a9736ab6279181c848f42227af9945bf
Gitweb:        https://git.kernel.org/tip/b5992f07a9736ab6279181c848f42227af9=
945bf
Author:        FUJITA Tomonori <fujita.tomonori@gmail.com>
AuthorDate:    Sat, 27 Dec 2025 20:59:50 +09:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:41 +08:00

rust: helpers: Add i8/i16 atomic try_cmpxchg_release helpers

Add i8/i16 atomic try_cmpxchg_release helpers that call
try_cmpxchg_release() macro implementing atomic try_cmpxchg_release
using architecture-specific instructions.

[boqun: Use try_cmpxchg_release() instead of raw_try_cmpxchg_release()]

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20251227115951.1424458-4-fujita.tomonori@gmail=
.com
---
 rust/helpers/atomic_ext.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
index b6efec1..962ea05 100644
--- a/rust/helpers/atomic_ext.c
+++ b/rust/helpers/atomic_ext.c
@@ -117,3 +117,13 @@ __rust_helper bool rust_helper_atomic_i16_try_cmpxchg_ac=
quire(s16 *ptr, s16 *old
 {
 	return try_cmpxchg_acquire(ptr, old, new);
 }
+
+__rust_helper bool rust_helper_atomic_i8_try_cmpxchg_release(s8 *ptr, s8 *ol=
d, s8 new)
+{
+	return try_cmpxchg_release(ptr, old, new);
+}
+
+__rust_helper bool rust_helper_atomic_i16_try_cmpxchg_release(s16 *ptr, s16 =
*old, s16 new)
+{
+	return try_cmpxchg_release(ptr, old, new);
+}

