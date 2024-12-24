Return-Path: <linux-tip-commits+bounces-3134-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3903A9FC16D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 19:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F4B165A9B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 18:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00B62135DF;
	Tue, 24 Dec 2024 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D3dJgmZn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eoUVrDcn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB753213253;
	Tue, 24 Dec 2024 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066428; cv=none; b=Qa8I9yeAVSKsb+3ro1YPWrCXXRnAaj7276A27YBlcDhzMBc9S+kr87U+1s6zmG2LP1B29+R8WSsm6o19QM1kwxvLDZbrd0XXvLMHpzGu5w40Kew1FkEd0cBGwZv+mWgj9ejgAmkwXRNNznmTcVkd/4DGT0aoaeir33OnhdvOiaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066428; c=relaxed/simple;
	bh=zNuqaSRygkLH7jl9Rpp+SrgKemIXbc8csP5PDHIWR1k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=guYpBCLL7PV6LZLc/ZqmmrsSX3JK182gDwNl+gB1x48raerWx5iDRYyrB+F+vB2jMkgpGBZnn7kPlDTbMsep78qs7LdpebiPKdU8P+F5MRwGBOetYX1eosSuNYKWYJNuTXDINNN1dW7d8iHeRynXNivMBATVBODm6MTvzaZxxH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D3dJgmZn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eoUVrDcn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 18:53:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735066425;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+zylyYa0Yccz3ca2y6GL/jeYwIL7k5mQ9LNP4FHXzoI=;
	b=D3dJgmZn0RMRcbIhh1kZzVJ0TMZkMcOWO7WLxKqR8UuzeAeHRG+5kpy6LPO2MGfNbZ4bDR
	HipCfaBP66qVVfGrCL1+Bcno75zTx+AMRgddGri0aHsWHjyBidEn7+SBr+s2mjTczr8XF6
	decljxgkzuwM8GpCWnxFLwh3a9IgFknuLnAWzeQA7LKKahOrlmTLjXbLqIbxV4r8jd4/8f
	e2YGSkkJ87zCrtAeGpNJygKaiYbMmAIOc3dv+ayXN0Ru4Pl/bjzbBMvk70pzkojSSBQoGL
	+Zyl+w49C7mTM+vonmlz5PaYlRwr5HX4zwvEYadueuk0fx3h9kvVfhRmKYZjWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735066425;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+zylyYa0Yccz3ca2y6GL/jeYwIL7k5mQ9LNP4FHXzoI=;
	b=eoUVrDcn0eFL7XRunMkEotqGT97fSuPWSURzUpkTRRVD6Clz3mvvyP9cGHl/xCCj56EiQK
	RSAlt5M9AkS47SAA==
From: "tip-bot2 for Carlos Llamas" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] lockdep: Fix upper limit for LOCKDEP_*_BITS configs
Cc: "J. R. Okajima" <hooanon05g@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Will Deacon <will@kernel.org>, Carlos Llamas <cmllamas@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241024183631.643450-2-cmllamas@google.com>
References: <20241024183631.643450-2-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173506642458.399.3711754785836379126.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e638072e61726cae363d48812815197a2a0e097f
Gitweb:        https://git.kernel.org/tip/e638072e61726cae363d48812815197a2a0e097f
Author:        Carlos Llamas <cmllamas@google.com>
AuthorDate:    Thu, 24 Oct 2024 18:36:26 
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Sun, 15 Dec 2024 11:49:35 -08:00

lockdep: Fix upper limit for LOCKDEP_*_BITS configs

Lockdep has a set of configs used to determine the size of the static
arrays that it uses. However, the upper limit that was initially setup
for these configs is too high (30 bit shift). This equates to several
GiB of static memory for individual symbols. Using such high values
leads to linker errors:

  $ make defconfig
  $ ./scripts/config -e PROVE_LOCKING --set-val LOCKDEP_BITS 30
  $ make olddefconfig all
  [...]
  ld: kernel image bigger than KERNEL_IMAGE_SIZE
  ld: section .bss VMA wraps around address space

Adjust the upper limits to the maximum values that avoid these issues.
The need for anything more, likely points to a problem elsewhere. Note
that LOCKDEP_CHAINS_BITS was intentionally left out as its upper limit
had a different symptom and has already been fixed [1].

Reported-by: J. R. Okajima <hooanon05g@gmail.com>
Closes: https://lore.kernel.org/all/30795.1620913191@jrobl/ [1]
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20241024183631.643450-2-cmllamas@google.com
---
 lib/Kconfig.debug | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 49a3819..7635b36 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1504,7 +1504,7 @@ config LOCKDEP_SMALL
 config LOCKDEP_BITS
 	int "Bitsize for MAX_LOCKDEP_ENTRIES"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 30
+	range 10 24
 	default 15
 	help
 	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_ENTRIES too low!" message.
@@ -1520,7 +1520,7 @@ config LOCKDEP_CHAINS_BITS
 config LOCKDEP_STACK_TRACE_BITS
 	int "Bitsize for MAX_STACK_TRACE_ENTRIES"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 30
+	range 10 26
 	default 19
 	help
 	  Try increasing this value if you hit "BUG: MAX_STACK_TRACE_ENTRIES too low!" message.
@@ -1528,7 +1528,7 @@ config LOCKDEP_STACK_TRACE_BITS
 config LOCKDEP_STACK_TRACE_HASH_BITS
 	int "Bitsize for STACK_TRACE_HASH_SIZE"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 30
+	range 10 26
 	default 14
 	help
 	  Try increasing this value if you need large STACK_TRACE_HASH_SIZE.
@@ -1536,7 +1536,7 @@ config LOCKDEP_STACK_TRACE_HASH_BITS
 config LOCKDEP_CIRCULAR_QUEUE_BITS
 	int "Bitsize for elements in circular_queue struct"
 	depends on LOCKDEP
-	range 10 30
+	range 10 26
 	default 12
 	help
 	  Try increasing this value if you hit "lockdep bfs error:-1" warning due to __cq_enqueue() failure.

