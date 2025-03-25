Return-Path: <linux-tip-commits+bounces-4493-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5152FA6EC92
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610BA3B3C9A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07208253F38;
	Tue, 25 Mar 2025 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nQ/bcP5Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6KuuME/D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671811EB9F4;
	Tue, 25 Mar 2025 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895380; cv=none; b=RGlwHOrewoVYeh/EE9FNOlKoQga0kLZYK14Fa5y2inSfNNfe2tREtiVXys2p3po3hy+kkdgOWNq+dG+xcG6HsMDKLbssWXVn8NtDavRCOuS4DzdqQVdVjatnhTWmWx0aKaFt6yrOhL8vsjtx5OAzEcIT4VdQNn/WtO0A0N4IrDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895380; c=relaxed/simple;
	bh=S0cD0I5+fnwwJa0RQqod6lCizgTpcJ0ooNGlIVzViHs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WBPsbqfNeaXiHp+xo9NNE8hVLkEACzCmbqwaJ6heIwqdmbGDd8DKcxbXz7cuAuYYUHM4bkgArGHw+T/dhV7zF4vT/DzCvOXdIXIlmVBH1KOUj9bSiBIw+KtZTaWxsqp80yLIHB9utfhbTom0VzHyMHoVK2VDfIW07Q9MQA/ckJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nQ/bcP5Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6KuuME/D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:36:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895377;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6dh6uf3rysuZQVjR5Gy+yRTQcMrbXJrxq8iC/iZ3QZs=;
	b=nQ/bcP5QkIyR9nnYG/nw3U2FMZcurpfS+H21IvkfLIC97UNp1Iy2qlnGpy6hBn0itXatBb
	IBSFQUcvhZ1m860myZZum51hFWCNMl5zBGznXk/MgoINXdkYUEGUil1qWTUZtC5zTHDox2
	OkKAjgyjbWYeXyO1DPs9dxzDZSwiisVz4M+igvzGBCaVyqWjaNscYqPcediGiXYCIy7QEM
	gFpttJASe+7279p0zHzreeeSj5beBfKl7SQPhDa1uIyS0RqWWb77kp1kA9gJ4R1ocnu7eN
	k3R8hHdTJEI4CN26KngdXcxMzAw0wFmeazJIPvd4bxZDTpO9xCkEsjKEfzi13w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895377;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6dh6uf3rysuZQVjR5Gy+yRTQcMrbXJrxq8iC/iZ3QZs=;
	b=6KuuME/DQiLFy5Tv+YvUdC4Gdo9BXJdBdoj+v2ZdltvdKcAiUnUjJ/Aw6TGNiA/7CyxM9q
	YhwfottQO5V5phCQ==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cacheinfo: Extract out cache self-snoop checks
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-27-darwi@linutronix.de>
References: <20250324133324.23458-27-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289537692.14745.2045042442113389501.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     05d48035e5f69cfe3c125b2bac47e4003b4acccf
Gitweb:        https://git.kernel.org/tip/05d48035e5f69cfe3c125b2bac47e4003b4acccf
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:33:21 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:23:24 +01:00

x86/cacheinfo: Extract out cache self-snoop checks

The logic of not doing a cache flush if the CPU declares cache self
snooping support is repeated across the x86/cacheinfo code.  Extract it
into its own function.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324133324.23458-27-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 7b274da..231470c 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -646,6 +646,17 @@ int populate_cache_leaves(unsigned int cpu)
 static unsigned long saved_cr4;
 static DEFINE_RAW_SPINLOCK(cache_disable_lock);
 
+/*
+ * Cache flushing is the most time-consuming step when programming the
+ * MTRRs.  On many Intel CPUs without known erratas, it can be skipped
+ * if the CPU declares cache self-snooping support.
+ */
+static void maybe_flush_caches(void)
+{
+	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
+		wbinvd();
+}
+
 void cache_disable(void) __acquires(cache_disable_lock)
 {
 	unsigned long cr0;
@@ -663,14 +674,7 @@ void cache_disable(void) __acquires(cache_disable_lock)
 	cr0 = read_cr0() | X86_CR0_CD;
 	write_cr0(cr0);
 
-	/*
-	 * Cache flushing is the most time-consuming step when programming
-	 * the MTRRs. Fortunately, as per the Intel Software Development
-	 * Manual, we can skip it if the processor supports cache self-
-	 * snooping.
-	 */
-	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
-		wbinvd();
+	maybe_flush_caches();
 
 	/* Save value of CR4 and clear Page Global Enable (bit 7) */
 	if (cpu_feature_enabled(X86_FEATURE_PGE)) {
@@ -685,9 +689,7 @@ void cache_disable(void) __acquires(cache_disable_lock)
 	if (cpu_feature_enabled(X86_FEATURE_MTRR))
 		mtrr_disable();
 
-	/* Again, only flush caches if we have to. */
-	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
-		wbinvd();
+	maybe_flush_caches();
 }
 
 void cache_enable(void) __releases(cache_disable_lock)

