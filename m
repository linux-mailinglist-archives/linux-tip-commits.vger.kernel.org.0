Return-Path: <linux-tip-commits+bounces-3748-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C858CA4AD9A
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 21:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1CB61700BE
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 20:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13941E0B66;
	Sat,  1 Mar 2025 20:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TEsmn/27";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="npM1c/Rx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BC51B6CE4;
	Sat,  1 Mar 2025 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740859616; cv=none; b=WKSoYTHL/XksIKTfLlXhAyLAs331w4UufjkewLCpBO8ZyIJa3Nl4hAtmrUCASipAjrciie3xevZ/KqW8B35KA5EKuixIxLQm/MZHbf43j3ncvp7rDSa7cZi2skXAXq9jOoE3j7wc+nUf8U8gpyybgi/ufhmC4O2EpwNBe6vD4a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740859616; c=relaxed/simple;
	bh=PYyB7YwmrlG009fsQk4A7jukJuG9/pwqDYSwoVD33jU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nqYz+iBYLabdfM+0XVjHK3aKO4g++gGvenXNDROHmcWilROA11troDJyVP4vi9AZfRYfSJdOUoHs2/KDDAAzD9IfXTkmsw8wiWREXH6mXtb6+2/LijK7Y6FgfAcSv5+Bmdry+alPx81yvcD8f6VKkAZ71Gsqw0he8YSyHObLf3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TEsmn/27; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=npM1c/Rx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Mar 2025 20:06:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740859612;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nR4zMjIoJrT/0YK9rcfMeS/K0pDznaVH36OZgOuN11Y=;
	b=TEsmn/278vPbW75jq3hy41IuAU0psZGbPatXpaU0QfC6NpjZBrDQnjC75z9Y0T5LtRT0WR
	q4lV3yGfv3V1px9pMPy2L/LP5XtR4sEHqVEU6nIx0ycyiMffmXcbG9CVQa5BgosDgknQkj
	As5ppfMZxktWwQ5SvNMLihTdOrW0eRbU6fQNhl0qYYwkL3ugl4xwum+CmpogWjgW/0tC3H
	ZEJs7vIqel6vfCeJjrmgkPYYfsr7RWqjz46ICuhTgFhCFIONIehpInz53StLwTK7XKRMAm
	alIs6kEpDIAATP9yq3/4Tq8jUAQ7T2HUqafXXvZeMPyDTFyC3ln0kBGbQLXpgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740859612;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nR4zMjIoJrT/0YK9rcfMeS/K0pDznaVH36OZgOuN11Y=;
	b=npM1c/RxWoNGBDGJBRMhvc21iuqInkD93+MRZkik1CLIBPe4sM/E8+/eQOki8NFCKOsboE
	px8DDwnbQAcMZsAw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep/mm: Fix might_fault() lockdep check of
 current->mm->mmap_lock
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241104135517.536628371@infradead.org>
References: <20241104135517.536628371@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174085960856.10177.3015043471401493148.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a1b65f3f7c6f7f0a08a7dba8be458c6415236487
Gitweb:        https://git.kernel.org/tip/a1b65f3f7c6f7f0a08a7dba8be458c6415236487
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:10 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 01 Mar 2025 19:32:41 +01:00

lockdep/mm: Fix might_fault() lockdep check of current->mm->mmap_lock

Turns out that this commit, about 10 years ago:

  9ec23531fd48 ("sched/preempt, mm/fault: Trigger might_sleep() in might_fault() with disabled pagefaults")

... accidentally (and unnessecarily) put the lockdep part of
__might_fault() under CONFIG_DEBUG_ATOMIC_SLEEP=y.

This is potentially notable because large distributions such as
Ubuntu are running with !CONFIG_DEBUG_ATOMIC_SLEEP.

Restore the debug check.

[ mingo: Update changelog. ]

Fixes: 9ec23531fd48 ("sched/preempt, mm/fault: Trigger might_sleep() in might_fault() with disabled pagefaults")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/r/20241104135517.536628371@infradead.org
---
 mm/memory.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 539c0f7..1dfad45 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6835,10 +6835,8 @@ void __might_fault(const char *file, int line)
 	if (pagefault_disabled())
 		return;
 	__might_sleep(file, line);
-#if defined(CONFIG_DEBUG_ATOMIC_SLEEP)
 	if (current->mm)
 		might_lock_read(&current->mm->mmap_lock);
-#endif
 }
 EXPORT_SYMBOL(__might_fault);
 #endif

