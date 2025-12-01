Return-Path: <linux-tip-commits+bounces-7562-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56903C95BDB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 01 Dec 2025 07:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151003A24CA
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Dec 2025 06:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D38209F5A;
	Mon,  1 Dec 2025 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EswU6l2b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T4h1CGqu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3A7188A3A;
	Mon,  1 Dec 2025 06:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764568881; cv=none; b=p5SpMiPhhxBhw7yYnLdB8gMUuvPGwpjC54VHfbURIic2OOSLBzrwbZxzz35jSjxsew6KMMKV2xS5BpJIAi4J/p4kTDGca3bg+MG087y/dmmQIMLq/0hgqrgUDwwha0vk3bZU+iBpEnMLfLStR82XPmUBDBoIWQC6fpQIUm8jcV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764568881; c=relaxed/simple;
	bh=6t1Mxu5gcr71j78OXA0rWrlDt+foJ8qHi945950GGhQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WGLNVMb+DUesEqLBJGaAu242AgfppdLmmTQw8Tn4t1a9aSRwLMHghZtrosH0+lDUtxs/INdtp9sEAuocJqni+XKgPER+BulheRHce4gJosQBOpK6xM96PkJ819i1IZnvy3GjR1msxToUPSLOLQPZqidOgExYx23GBzvXEGX/v7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EswU6l2b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T4h1CGqu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 01 Dec 2025 06:01:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764568872;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oqa0wLrys4XCkd/nOtI876eV3tb3PHrpn1onMDZWHW4=;
	b=EswU6l2bm+xYkvhgxzzjFLesxgRNoHjnAc1fkP0RUCI2DjT2cm8c924htWztP4D8bzgN//
	2aXNxQcjJ8TERtbU5dQKXnrhybqDBWyM1DCzH26rXaIKgVwT4YZ4/kN2Y43P22R4dlYldx
	M2DAEBJt/l7pPPntDc6p3d3gGgGAs+1nlkNXiGUT91pGJY4Oyn+yfLRjQojHjUTvFt2HGu
	RsHZ7Yt89Vjur+hwzWQxw1iiSssHUxj9rAKALfNsgyglUKCdOWxqrYfLokaBFcHh0P0ulM
	ddv2yA2q774x8JGBKP48IAHfQzTqakksRhC6I4C9gCbWiq6XxC/iBzfcenLrTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764568872;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oqa0wLrys4XCkd/nOtI876eV3tb3PHrpn1onMDZWHW4=;
	b=T4h1CGquOkJ5FhcZtQ2LSr38EwtvrMVRHn+BF6PxFeV/JiPRfROAc0ALGnEoIJTVqGrK4+
	ixXxCpNgXyICW7DA==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/local_lock: Fix all kernel-doc warnings
Cc: Randy Dunlap <rdunlap@infradead.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251128065925.917917-1-rdunlap@infradead.org>
References: <20251128065925.917917-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176456886646.498.14099959256524694123.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     43decb6b628eb033a1b6188e5018773c0d38be1d
Gitweb:        https://git.kernel.org/tip/43decb6b628eb033a1b6188e5018773c0d3=
8be1d
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Thu, 27 Nov 2025 22:59:25 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 01 Dec 2025 06:56:16 +01:00

locking/local_lock: Fix all kernel-doc warnings

Modify kernel-doc comments in local_lock.h to prevent warnings:

  Warning: include/linux/local_lock.h:9 function parameter 'lock' not describ=
ed in 'local_lock_init'
  Warning: include/linux/local_lock.h:56 function parameter 'lock' not descri=
bed in 'local_trylock_init'
  Warning: include/linux/local_lock.h:56 expecting prototype for local_lock_i=
nit(). Prototype was for local_trylock_init() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/20251128065925.917917-1-rdunlap@infradead.org
---
 include/linux/local_lock.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 0d91d06..b0e6ab3 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -6,6 +6,7 @@
=20
 /**
  * local_lock_init - Runtime initialize a lock instance
+ * @lock:	The lock variable
  */
 #define local_lock_init(lock)		__local_lock_init(lock)
=20
@@ -52,7 +53,8 @@
 	__local_unlock_irqrestore(this_cpu_ptr(lock), flags)
=20
 /**
- * local_lock_init - Runtime initialize a lock instance
+ * local_trylock_init - Runtime initialize a lock instance
+ * @lock:	The lock variable
  */
 #define local_trylock_init(lock)	__local_trylock_init(lock)
=20

