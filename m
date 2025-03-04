Return-Path: <linux-tip-commits+bounces-3968-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B028A4ED6C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD2A188379D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3895124C097;
	Tue,  4 Mar 2025 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="onR4S4cK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wOIyOsWV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BECF25F988;
	Tue,  4 Mar 2025 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116841; cv=none; b=GxQynVtSSyW+KJR5Ti9SNa7lweANF9JfdCaFBPPuc2fuvg7vwvA0PwMEmlzkPZVE1C+7/I/AMt7Oh7fvPnk2aSBnPleXcgZsgdGDSzsx9xjOaoz90dHlrGA5lRGETipjygqtiPbUoMyBSC6hZnOggjCW3zDm9bIyI/mKfnRFBbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116841; c=relaxed/simple;
	bh=LA5nZ6JRpNOhzFj1LOrPV8LXi6jWqmY8A3c+jMizKp4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uSZNRhxd4/8SXGXcPQiBXt10O0ojzxmPSEcsPi+jF9B/V3SoPo8S73LgyEDulbHa7MNGIvkeMUTgjpJ2WDRFIcL0uofleHUxR5oVTYBSE8afRXKw98oi8ytkFuzcYGd25vgBkUrmXVv2Z8DlkQ8SeU9Ahu9+4iSyhF4sJ+nKDww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=onR4S4cK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wOIyOsWV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 19:33:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741116837;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IdCJsnWbkVXpVUEr6nOWhY//3Ihqr6MRTz2x18djjvg=;
	b=onR4S4cK/1YIQS1cIxN/lL9SCWfYoI7CX7a/d2gdnlu7yk8ScvIfVFk+Gi2vbLXD9W2xK3
	AdFRziqRsT77/b/GWq/cP4WhsojVl3rrYJCzxqz0QeOtj9ez63azZuxTutnaCSw0ORv+dj
	yb095jPeP0Nb4KhlX2mNyiGY5gaqyWKZ6073cS25ZTRPLE0r3O6Ua7VVtEM6q4OpY8zZXe
	dDmPUSdYOC7OkUiwG7p4u+jE6mDPSwJrf3U1We2jMCTB61w63/yz6/LZTt6iM9CMrXn93Y
	XZqK+PYdnWuWbtPyIt6DNJWx+kvt0PFcXTbUjiE9THvjmfvf7cdvt96QEfQgvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741116837;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IdCJsnWbkVXpVUEr6nOWhY//3Ihqr6MRTz2x18djjvg=;
	b=wOIyOsWVdxU7+QjU5rQVil3WIs5TvxZXRBhTl4gEBl6P031AOltWYkuIghv9cK8zz3H9So
	7zAgidTgYTudTxCQ==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/smp: Move this_cpu_off to percpu hot section
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303165246.2175811-12-brgerst@gmail.com>
References: <20250303165246.2175811-12-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174111683722.14745.13977274048161906067.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     6a75fb34742d94d2de49b755ed5c6dbe77be0857
Gitweb:        https://git.kernel.org/tip/6a75fb34742d94d2de49b755ed5c6dbe77be0857
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 11:52:46 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 20:18:02 +01:00

x86/smp: Move this_cpu_off to percpu hot section

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303165246.2175811-12-brgerst@gmail.com
---
 arch/x86/include/asm/percpu.h  | 2 +-
 arch/x86/kernel/setup_percpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 8cc9548..462d071 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -586,7 +586,7 @@ do {									\
 #include <asm-generic/percpu.h>
 
 /* We can use this directly for local CPU (faster). */
-DECLARE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
+DECLARE_PER_CPU_CACHE_HOT(unsigned long, this_cpu_off);
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 175afc3..bfa48e7 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -26,7 +26,7 @@
 DEFINE_PER_CPU_CACHE_HOT(int, cpu_number);
 EXPORT_PER_CPU_SYMBOL(cpu_number);
 
-DEFINE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
+DEFINE_PER_CPU_CACHE_HOT(unsigned long, this_cpu_off);
 EXPORT_PER_CPU_SYMBOL(this_cpu_off);
 
 unsigned long __per_cpu_offset[NR_CPUS] __ro_after_init;

