Return-Path: <linux-tip-commits+bounces-4612-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CFCA78264
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 20:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074FA1889399
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 18:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0A020D505;
	Tue,  1 Apr 2025 18:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WCM9S8vA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mD2B0nFs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C981F098E;
	Tue,  1 Apr 2025 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743533054; cv=none; b=QD+956q7/IeFWxmFDcKeQyvgzyez6kG+ZiuDr+La2f4Zi3jvy+qhTn6+1f6SmDvUN4CpQq6FoVd84r7Bra/0Uc6QrB1MPrgqgy0GgX5gYt73LNlJGS7OPn+xVEkPx07RXdj82oHGAwyL5P0bKnP8UcvIpvJniYQQrhMR7LYJan4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743533054; c=relaxed/simple;
	bh=stkJClXc+qlc/z2KaTYsOiRp+OEJu9HsDS/7Zvvs+B4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=H1J+kQtXYxb84KFiutXShxLiGf7fn7Ywvzk17csD0c77A79aiBQ+y+MYnMY1Pc+Gy3NGtSk75zOCWyleVh7Q2jamey4ikFw21dtfvBdLyJ44etzCFl8NjVH+aqhrRyTa5XMcAbtQmAhdVxnFCr38AWxCwgkxXrqRVetQuaeaR9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WCM9S8vA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mD2B0nFs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Apr 2025 18:44:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743533048;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LODUgePV22AsV5XcEl2nBwhZPcv4XOTtohDO54gmYSo=;
	b=WCM9S8vAlbmj9WkpSDsRTMaIcpxNGaKfLeW3gU5fhEBqEBsz6WhZpdef9lSqasTxPi1t8h
	XXCWVifJwh0dorxWS98EjZuHR/VfnaimupKA5H1KDQCUiZJPYKIKtBpTDdIWk/MjsACWml
	Cc387kPEjRQz1JCdE9sAMC/bJNekFYV8YXkRbXalCViJQjh6ljQ0Ol/TxXFAh/H8Ut/OGc
	y8s0PBZpzqEYIx1dlrpH0aEZrnlt3p7wf6egQbvnbM5Btx5isBiyPN3r1INMNk1QXvYlBO
	scodP1t4EEnL7e0N3+OIlARan81hOzE13ycAQu4bS4DZOgXKbNuoeU0QLodmEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743533048;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LODUgePV22AsV5XcEl2nBwhZPcv4XOTtohDO54gmYSo=;
	b=mD2B0nFsIVIsJ2OwPTjNPYHJjN7WPqSt2K7FLzP957nUA8u4fl0w9FfFUro6NPEwDzICIb
	Bp3l2Gj+BSouuOCg==
From: "tip-bot2 for Mateusz Guzik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/mm] x86/mm: Stop prefetching current->mm->mmap_lock on page faults
Cc: Mateusz Guzik <mjguzik@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Rik van Riel <riel@surriel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250401143520.1113572-1-mjguzik@gmail.com>
References: <20250401143520.1113572-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174353304768.14745.8808578254812639633.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     0f0a9bf602449c0114117a72eab4329c9a22176d
Gitweb:        https://git.kernel.org/tip/0f0a9bf602449c0114117a72eab4329c9a22176d
Author:        Mateusz Guzik <mjguzik@gmail.com>
AuthorDate:    Tue, 01 Apr 2025 16:35:20 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 20:26:35 +02:00

x86/mm: Stop prefetching current->mm->mmap_lock on page faults

The prefetchw() dates back decades and the fundamental notion of doing
something like this on a lock is shady.

Moreover, for a few years now in the fast path faults are handled with RCU
+ per-vma locking, hopefully not even looking at the lock to begin with.

As such just remove it.

I did not see a point benchmarking this. Given that it is not expected
to be looked at by default justifies not doing the prefetch.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250401143520.1113572-1-mjguzik@gmail.com
---
 arch/x86/mm/fault.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 296d294..697432f 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -13,7 +13,6 @@
 #include <linux/mmiotrace.h>		/* kmmio_handler, ...		*/
 #include <linux/perf_event.h>		/* perf_sw_event		*/
 #include <linux/hugetlb.h>		/* hstate_index_to_shift	*/
-#include <linux/prefetch.h>		/* prefetchw			*/
 #include <linux/context_tracking.h>	/* exception_enter(), ...	*/
 #include <linux/uaccess.h>		/* faulthandler_disabled()	*/
 #include <linux/efi.h>			/* efi_crash_gracefully_on_page_fault()*/
@@ -1496,8 +1495,6 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 
 	address = cpu_feature_enabled(X86_FEATURE_FRED) ? fred_event_data(regs) : read_cr2();
 
-	prefetchw(&current->mm->mmap_lock);
-
 	/*
 	 * KVM uses #PF vector to deliver 'page not present' events to guests
 	 * (asynchronous page fault mechanism). The event happens when a

