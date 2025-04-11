Return-Path: <linux-tip-commits+bounces-4879-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 657CDA8591E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9AD49A070A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C83225DE9D;
	Fri, 11 Apr 2025 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Co4q5kQQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sDwbGPN6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF99E24DC43;
	Fri, 11 Apr 2025 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365742; cv=none; b=McuWPQYWkecKbg1GQzjpNGn7k7aBZfyPKf/B8Q5vWzwvUOYQ9DbaRGvjKinHWV1o0bFwMhvWq84yslrfGCat7UEO0re1tO4dxbj8txSiPb/WLqV2WD/OvqQ9Re8x41uM/AF42dxLrrGzoaO626srkU7Ef1RSQML55wNs2WVvDmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365742; c=relaxed/simple;
	bh=QPj+T2aTm3YQ/EThm5+WTuv8ki3lGSWBb4a38xZYH/w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Pm5FUUHXGKxtQEzpe9YMKu/ZyJAl/yH77AK0sHronNZYjHFLLgZOkC7/utmBrB/nW5sZhyNsvD2CQkrPpcXGt3KXWctQCJIfnTrPlOdORJ3mDIQ52RnDJ+wE0T9aJE6zbXUno+hlbnKflKwFYww8cZUvooSdVQuWoP8OzHqO9Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Co4q5kQQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sDwbGPN6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365738;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5VnJ4KBESD4ejXQG1Z5e4HgxBK38HrMq03NQyYAuk1c=;
	b=Co4q5kQQz9lKEHQiiGmsv/IXMDJlVB1vV14i18wP0TYs6/tS8fG540tpux7GYBiXTFkojl
	fPxtuEi3CT9mRow9tZ+IDP6eJOQsm25IRBRBAI8eKmeQOffjUjuPFPzff4WVLxOaPf/SOR
	nRlRHeUhLSQ35WfFMiSBZZd8n8yvOOV8eBajJKeB52SvmL7tONFhYy1LHtnVomNXauwPjO
	/dOdg9Sy1zLK0QvqXG4YKTddRYir2yiBmYGJRtJBjuFn7M8K9ZYM9CA4RybTTT2OOZcFDj
	/NWFzwJ+O1lw93cmAkHGo07thrW9+hcl2XeLcxZfGiLr9mG1uj9rC+UDKaRZfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365738;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5VnJ4KBESD4ejXQG1Z5e4HgxBK38HrMq03NQyYAuk1c=;
	b=sDwbGPN6Tsrj+0cscYfXVbraBQUTt9MNF+9AsuwOEmlXQwxDz1NuXlO+DEO7hyq7zO3y43
	Q2uPbTe5skBAhcAQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Rename
 'poke_int3_handler()' to 'smp_text_poke_int3_handler()'
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-8-mingo@kernel.org>
References: <20250411054105.2341982-8-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436573771.31282.11272916613256807782.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     5236b6a0fe921f5de53b8eeea2d8fdd6d643dd7f
Gitweb:        https://git.kernel.org/tip/5236b6a0fe921f5de53b8eeea2d8fdd6d643dd7f
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:19 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:33 +02:00

x86/alternatives: Rename 'poke_int3_handler()' to 'smp_text_poke_int3_handler()'

All related functions in this subsystem already have a
text_poke_int3_ prefix - add it to the trap handler
as well.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-8-mingo@kernel.org
---
 arch/x86/include/asm/text-patching.h | 2 +-
 arch/x86/kernel/alternative.c        | 2 +-
 arch/x86/kernel/traps.c              | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 5189188..93a6b7b 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -38,7 +38,7 @@ extern void *text_poke_copy(void *addr, const void *opcode, size_t len);
 #define text_poke_copy text_poke_copy
 extern void *text_poke_copy_locked(void *addr, const void *opcode, size_t len, bool core_ok);
 extern void *text_poke_set(void *addr, int c, size_t len);
-extern int poke_int3_handler(struct pt_regs *regs);
+extern int smp_text_poke_int3_handler(struct pt_regs *regs);
 extern void smp_text_poke_single(void *addr, const void *opcode, size_t len, const void *emulate);
 
 extern void text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 222021a..d2cd0d8 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2515,7 +2515,7 @@ static __always_inline int patch_cmp(const void *key, const void *elt)
 	return 0;
 }
 
-noinstr int poke_int3_handler(struct pt_regs *regs)
+noinstr int smp_text_poke_int3_handler(struct pt_regs *regs)
 {
 	struct text_poke_int3_vec *desc;
 	struct text_poke_loc *tp;
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9f88b8a..d67407c 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -882,16 +882,16 @@ static void do_int3_user(struct pt_regs *regs)
 DEFINE_IDTENTRY_RAW(exc_int3)
 {
 	/*
-	 * poke_int3_handler() is completely self contained code; it does (and
+	 * smp_text_poke_int3_handler() is completely self contained code; it does (and
 	 * must) *NOT* call out to anything, lest it hits upon yet another
 	 * INT3.
 	 */
-	if (poke_int3_handler(regs))
+	if (smp_text_poke_int3_handler(regs))
 		return;
 
 	/*
 	 * irqentry_enter_from_user_mode() uses static_branch_{,un}likely()
-	 * and therefore can trigger INT3, hence poke_int3_handler() must
+	 * and therefore can trigger INT3, hence smp_text_poke_int3_handler() must
 	 * be done before. If the entry came from kernel mode, then use
 	 * nmi_enter() because the INT3 could have been hit in any context
 	 * including NMI.

