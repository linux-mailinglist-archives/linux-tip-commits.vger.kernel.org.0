Return-Path: <linux-tip-commits+bounces-4864-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 528E7A858E4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A7C67B1826
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9072B2D4B69;
	Fri, 11 Apr 2025 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J0McIWMz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gBZZCwHL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28352D3A85;
	Fri, 11 Apr 2025 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365728; cv=none; b=PGbHFZnDDPScOdgKPW2nhkL1Km6+SPVlSuGxijBQrqVXrJcG/1UVdulkZia7kB7Jb9TmTUxFUTcIP5GoFHgOON61gNrEVJV+peVYuwGO887BQQfLV2Ik4AD7d39rj/cuYXqQVwvaV63rAE6Jt+mhfDrEGRIFps+s7BPa1kyOkSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365728; c=relaxed/simple;
	bh=dnWzwKDS+j7HJEIJ4NFwZ0T4iUjZ0Ksz63MlKA+yYXs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=K6dMpfyBGzWMrz+IxG4o4WCrZOYawKRv8rRCGHXeb+xZBthYM04miKrS6HkHLjDUXY/vBXRaE1t/pXzrscaxU2GjQKIh4+ukFjtF7V9/p8kUjWnBb+y5Gab6aq/LYieks6kXEacvSU19IDbbRxbC3l+uiWnP2gYKFk5frJmFd00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J0McIWMz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gBZZCwHL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365725;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8kzLDh+bOPf8mCITH3fDySgxXpbKmkB/a3noAfFDKs=;
	b=J0McIWMz6lG8l9pIwYx4HmmO1K7kr9V1gExFXqHrnvqpOG81v3AV8jg1KeKpa+r9q8gNBt
	oU2IFDZN0An2aPMp2e/ahEhg6hjGkRDX90e9qOS1P3Q3dhnZDN0UqTotI0BFuNKgqcKu8Q
	9mAQRo7l8+Rlg58n2obGJAr9gfg33nMrkOWHe8ur2RbjovJvLLTZl8pwcDtnMuPhmeM7R5
	3R0u2hB95t8PzRGtywapXz2UVXcdjbHRyayWe98roPJ/fy1+0CaY5fQEq/ALx+uGGy5/zB
	8ja9jHtoCBjxyNyJX0/ypjDbxuBamNOdFWXoNEdXY7YgyILFZQ2V6Msujdxrnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365725;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8kzLDh+bOPf8mCITH3fDySgxXpbKmkB/a3noAfFDKs=;
	b=gBZZCwHLFl3/nfYfJSWW39wCDm1kh3qGkXuawzl36ubNAV+OuTgYlP3tmi5wg+/KPp6d6v
	/KfbcIEHVs3DqYCQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Simplify
 smp_text_poke_single() by using tp_vec and existing APIs
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-25-mingo@kernel.org>
References: <20250411054105.2341982-25-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436572446.31282.13069052465341572273.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     c8976ade0c1b4c0629b8a080d712ff402e8343b3
Gitweb:        https://git.kernel.org/tip/c8976ade0c1b4c0629b8a080d712ff402e8343b3
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:36 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:34 +02:00

x86/alternatives: Simplify smp_text_poke_single() by using tp_vec and existing APIs

Instead of constructing a vector on-stack, just use the already
available batch-patching vector - which should always be empty
at this point.

This will allow subsequent simplifications.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-25-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 16a41e2..b4cb867 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2904,8 +2904,13 @@ void __ref smp_text_poke_batch_add(void *addr, const void *opcode, size_t len, c
  */
 void __ref smp_text_poke_single(void *addr, const void *opcode, size_t len, const void *emulate)
 {
-	struct smp_text_poke_loc tp;
+	struct smp_text_poke_loc *tp;
+
+	/* Batch-patching should not be mixed with single-patching: */
+	WARN_ON_ONCE(tp_vec_nr != 0);
+
+	tp = &tp_vec[tp_vec_nr++];
+	text_poke_int3_loc_init(tp, addr, opcode, len, emulate);
 
-	text_poke_int3_loc_init(&tp, addr, opcode, len, emulate);
-	smp_text_poke_batch_process(&tp, 1);
+	smp_text_poke_batch_finish();
 }

