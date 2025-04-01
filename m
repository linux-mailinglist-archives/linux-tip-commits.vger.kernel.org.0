Return-Path: <linux-tip-commits+bounces-4617-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662D0A783A4
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 22:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B3107A4246
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 20:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17545214A7A;
	Tue,  1 Apr 2025 20:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oZ3VY7jH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wjYez3Yh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6369204875;
	Tue,  1 Apr 2025 20:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540808; cv=none; b=pN3q10Okotvme0VaFIdRsCN4kPTyG1q41ITZLWHDOMeAZXAcqe1PYWW969GZSzezCpoi6ZQrFzOtUsBU7VxrZYQQndm8yDuuAUPvUY0rclFLYU63JX+7NKA5wkOLj1mXfnFvyk/JIr3qq2b05kNlMX1al8GucP8JhXT+jo9H59M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540808; c=relaxed/simple;
	bh=rezkbcoOFKwTz7C5NqmHCDUWOf4SRkyuFzLRBTFOe6s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EBGps19eXfoXByTOVOhcpgMSsADa8UzUKGLjUV7xY91JVeAZ6n1hJt0KiOyyzYlazqvm20pacQSPOcL0cRUklVpJehfQtCfQWInUBMuRlQu+XwQnYNnyPZ1uJ5rADcymkpnCly5wiS6iW82lYez46f84R51+GIhMGA4i2l1I4pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oZ3VY7jH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wjYez3Yh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Apr 2025 20:53:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743540802;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bbyYn80ysDKfOOOUjXfZJIarNJI5LVfzzo9T/D0gY9k=;
	b=oZ3VY7jHlzLSikDR1jV9je6T+X3ysta8EaGsu2EMYEE5oIxWSGt9I0N+8wZmiYmJOE03Fs
	ROlUpkoHov9TOVlgOM0PNFFMYOg44PBqKtBXzKGiG4ifdlFq3g1EehMgYWxXFiB0G84CsJ
	Yl5+EQyHYP/TeBR+CpyIYNSn5aEsbIFE3VspMnGYF41EMk8Ts9QIddNTmHtFDVRGwHnShJ
	0dwksgnwJODiBSU3L+6zAs4HKxDWeAt3E4TxldWlMx1jj2jYKP2gOurqg2VAN1gwV9qEua
	P46ac8IuI0yLz+Th8dTr7TvOT+zStBHSFEk5pwFB4iYZ19YulmNRRrO0+mj1xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743540802;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bbyYn80ysDKfOOOUjXfZJIarNJI5LVfzzo9T/D0gY9k=;
	b=wjYez3Yhz6bDhiEDkPtYo2zt2cRHNGuM5b9zq30OcbQ33pUyr5mfZcSnimBLa9G99dnU4D
	Lx4CNjKmXe/JNYCw==
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
Message-ID: <174354080164.14745.16617051817056445612.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     0b2695d58e800ad53e718d003310829db492a39c
Gitweb:        https://git.kernel.org/tip/0b2695d58e800ad53e718d003310829db492a39c
Author:        Mateusz Guzik <mjguzik@gmail.com>
AuthorDate:    Tue, 01 Apr 2025 16:35:20 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 22:47:02 +02:00

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

