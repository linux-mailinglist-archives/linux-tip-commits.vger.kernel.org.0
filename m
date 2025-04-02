Return-Path: <linux-tip-commits+bounces-4621-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9960FA78BC1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Apr 2025 12:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA185188FE82
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Apr 2025 10:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4060D2356A1;
	Wed,  2 Apr 2025 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dg7KZ+NJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LkE6X16D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E71078F;
	Wed,  2 Apr 2025 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743588660; cv=none; b=uTl7LYSZmpv/T6CC16HPwLGgBjlGoyAiF2ZsNZbl/XNkTOReALS0tKtO7VgQXF6Tc5YuWClNEyLeMP7CBYCUIxgGfQbXxiUFiGJTRybmmnUeT348LPOKuuBnGu0FUN9B+TwG1jCPjFm6HDDUpURU0ZSmI7IMaJc6B4rTRbVgCBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743588660; c=relaxed/simple;
	bh=YsQ+ZEpOBzRENvI3w2Cgx7tGcPpu8PZYXcUACDmq2tk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Czi3apyTJZOaTMIxagoI8eaO9WoSgHOeKvoAmB2+CzE0jgqYvKT0DO4wH6iMOidkRGZVWou/EPSleCtw2poewmC+JyAQVqefHAt/JEZtzti20S6y1B8Alw+IiaYoQh1Y9c/XqpXYpyhop3e0RNyKYwVGyi+5CFBgeBL5+Kqnkcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dg7KZ+NJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LkE6X16D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Apr 2025 10:10:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743588655;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fNsUG8J4yHEKunPN03eOzFpqG1kg0r7jZKB13rFKnuw=;
	b=Dg7KZ+NJzjYUxrj8J4qCnji9/PzRF+N3J02+UTMBJHEcWERde0GUIlVPP0zWgbmnvrBTs/
	lxPljELBPE2uRCCaBiXr9iwQVSMr9RtBZ2A8EOGtpibjACXjikqhT7SMkt/R7gEY2j8pzW
	63VHPzNo+Bg8uNWvaBpg2wMYXssAFMp6plzKZ2ICDGf00OaSOuF+OyZyDxF9BLJFGhpyLq
	6jDE8UIHUmiAu3fM+DyF5VupnC77BBeze96wwVMhrycFDsgfM8vYvldpBemCW0wXYtoXBG
	JYvni5x+xlt+cP0aNJuUhPVjsUfTfCwQ0X56LyqjqP1KtJ76BseHXbwBB77CNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743588655;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fNsUG8J4yHEKunPN03eOzFpqG1kg0r7jZKB13rFKnuw=;
	b=LkE6X16Dz0SQfp1+7axnkWMUZbZ++DZNCG9XsWAYnqXwg0aCWfkJh3+NEOzkDeWdt5npz3
	TgX6qzjZKY2vkzBQ==
From: "tip-bot2 for Andrew Cooper" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/idle: Remove mb() barriers for
 X86_BUG_CLFLUSH_MONITOR in mwait_idle_with_hints()
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Rik van Riel <riel@surriel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Juergen Gross <jgross@suse.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250402091017.1249019-1-andrew.cooper3@citrix.com>
References: <20250402091017.1249019-1-andrew.cooper3@citrix.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174358864842.14745.908324129810950623.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     90a22a5f841490790ecb17166633582681d44945
Gitweb:        https://git.kernel.org/tip/90a22a5f841490790ecb17166633582681d44945
Author:        Andrew Cooper <andrew.cooper3@citrix.com>
AuthorDate:    Wed, 02 Apr 2025 10:10:17 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 02 Apr 2025 11:54:51 +02:00

x86/idle: Remove mb() barriers for X86_BUG_CLFLUSH_MONITOR in mwait_idle_with_hints()

The following commit, 12 years ago:

  7e98b7192046 ("x86, idle: Use static_cpu_has() for CLFLUSH workaround, add barriers")

added barriers around the CLFLUSH in mwait_idle_with_hints(), justified with:

  ... and add memory barriers around it since the documentation is explicit
  that CLFLUSH is only ordered with respect to MFENCE.

The SDM currently states:

  Executions of the CLFLUSH instruction are ordered with respect to each
  other and with respect to writes, locked read-modify-write instructions,
  and fence instructions.

  https://web.archive.org/web/20090219054841/http://download.intel.com/design/xeon/specupdt/32033601.pdf

With footnote 1 reading:

  Earlier versions of this manual specified that executions of the CLFLUSH
  instruction were ordered only by the MFENCE instruction.  All processors
  implementing the CLFLUSH instruction also order it relative to the other
  operations enumerated above.

I.e. The SDM was incorrect at the time, and barriers should not have been
inserted.  Double checking the original AAI65 errata (not available from
intel.com any more) shows no mention of barriers either.

Additionally, drop the static_cpu_has_bug() and use a plain alternative().
The workaround is a single instruction, with identical address setup to the
MONITOR instruction.

Fixes: 7e98b7192046 ("x86, idle: Use static_cpu_has() for CLFLUSH workaround, add barriers")
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20250402091017.1249019-1-andrew.cooper3@citrix.com
---
 arch/x86/include/asm/mwait.h |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index ce857ef..54dc313 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -116,13 +116,10 @@ static __always_inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
 {
 	if (static_cpu_has_bug(X86_BUG_MONITOR) || !current_set_polling_and_test()) {
-		if (static_cpu_has_bug(X86_BUG_CLFLUSH_MONITOR)) {
-			mb();
-			clflush((void *)&current_thread_info()->flags);
-			mb();
-		}
+		const void *addr = &current_thread_info()->flags;
 
-		__monitor((void *)&current_thread_info()->flags, 0, 0);
+		alternative_input("", "clflush (%[addr])", X86_BUG_CLFLUSH_MONITOR, [addr] "a" (addr));
+		__monitor(addr, 0, 0);
 
 		if (!need_resched()) {
 			if (ecx & 1) {

