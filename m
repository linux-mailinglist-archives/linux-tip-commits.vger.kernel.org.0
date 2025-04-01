Return-Path: <linux-tip-commits+bounces-4620-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32247A783C4
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 23:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8963B18903B6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 21:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62079204087;
	Tue,  1 Apr 2025 21:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DcPJs6he";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zK+DAdKg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4803234;
	Tue,  1 Apr 2025 21:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743541431; cv=none; b=SsS2v88X/D4nxcNtaW26sKvJ1fDn2R9Q6yOgnlGFvhNXoqrzZmxUL/biso8I9dyuVtDvXDHEhRSGEEOtE7Spi46Edc6IqwNKHkhDGu+KumCxVt1gv4jDra6mzttPKmyegha/q2pah60Gc68RkPHaAfJ36dieCI7pNwK9dFE0O90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743541431; c=relaxed/simple;
	bh=RHG5mnA4Pa5+KcHBkPJkMWJyRYQ6/9Uh4ZMdzI7Rs7s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Lu3JWerUT9ASehn6qXBYjdQINv6Av8n5UeM5gyZa6CP9/d1edSio3v0xT34JXNFuYdz1y5Ak7sDrG5rP7UPop7JuITYKm3oE/16zDy2WH+wvSvq2ehYFjDXv59tmHuqGnjEAuTBXM7tFtdlspLgtBUCjPRMRXOV7C0gKTyLZpx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DcPJs6he; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zK+DAdKg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Apr 2025 21:03:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743541426;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FOOtHtZokLDTphOetkEBkEV1ez5v2HtE8u/QzNWrwmY=;
	b=DcPJs6helbJ/oNtwDX3qUU7wHhgfhwnlNMHw9kLAtwV6eeJfHLFHHMhQfCTMrxgX/e+n2y
	hTl91mhtlvY46nDZAvtAdCjXrhLfuw6mbtsQQbBeujH6OH3BpmWx4DW1aCbCxJ/lnzWZIb
	xzM/dL2dIExU2xlzJKMltGx5MnetQTigQwZXmI5OhUoOCcu6SziPXJwy4cizOEfWIBOgUu
	oX6882DkqJAGLDSshyz7LEHcko4PqaG2VGXpwMRvjPWZFKX3VIoz26EgvA68oIi1i2TtoC
	nIjPlcU6qnUEIgFfDpnMllvNqb19FotM7NSMy6+/MXNhT31EnIAKgVD1YIvPPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743541426;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FOOtHtZokLDTphOetkEBkEV1ez5v2HtE8u/QzNWrwmY=;
	b=zK+DAdKgrGUKzm6fEvFjC9XzniRoRGZCEAF5Z9F/8OsrSM1p6v1xMXAB2gDl4DP38McqZ3
	ApAV0BEm+Cyn+jCg==
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
Message-ID: <174354142522.14745.424930535016495945.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     1701771d3069fbee154ca48e882e227fdcfbb583
Gitweb:        https://git.kernel.org/tip/1701771d3069fbee154ca48e882e227fdcfbb583
Author:        Mateusz Guzik <mjguzik@gmail.com>
AuthorDate:    Tue, 01 Apr 2025 16:35:20 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 22:48:56 +02:00

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

