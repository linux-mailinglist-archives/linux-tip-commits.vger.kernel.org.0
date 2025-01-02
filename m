Return-Path: <linux-tip-commits+bounces-3167-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104119FFB94
	for <lists+linux-tip-commits@lfdr.de>; Thu,  2 Jan 2025 17:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F263C3A3315
	for <lists+linux-tip-commits@lfdr.de>; Thu,  2 Jan 2025 16:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335B213C8FF;
	Thu,  2 Jan 2025 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="avBLb+sM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D4lxeCGj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC7322083;
	Thu,  2 Jan 2025 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835459; cv=none; b=dOH2YIPb8XqFlb0gASYWLkBwdVzzUmuUzE26TWh25MHb2WALAtKO+aHvWqNtBxnn2dkjz2CUeD1DfYz1vcSu9vKzvUN9o/7x0YniyRDkYElsbNCZcXaM6sDVTLiQ9UGB1EsVjR+0ebiUtC3PUG+1U+1LHZVNS7L69Kx+RMqFuhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835459; c=relaxed/simple;
	bh=+6fPYAIGVOg3eUhSnjXbZUpV9fK6I5Iq7DRWtU2xa6o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DgxmV81L18jjB9ZG/M/Cc2uOFP14DZ8TA0Gn0jas0Sgykxbhikpxok9AZuQrVaNUAHShoTuj+UglqOKTETXWfL/fpww+Aaq/qnTUKVk/hrWNBL3XiF8ohSSOvVYioQpIRyoB9KSHgEjcX1GKU+H56+ezeMADubm83AVAsEgQ0r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=avBLb+sM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D4lxeCGj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 02 Jan 2025 16:30:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735835454;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=APmqNIf5hl93oox5Sf5K1w7T125IlDaElsY8NEvoiQo=;
	b=avBLb+sMox6T+aT1OWbSU1BCMrIJm5H2RZIOpo5H9+pQycEzw6x9LfGZN6G2pyIoAZPr71
	3gSx1iY5GVVskVLo00Xf2C7aJNPzSxOU/Twvxf7iHfiEcSmCpLhJAPUHptNSK1xqyc4qWK
	qVZSrHeOO7WFWh2r1/zA7URE8l7t+KBF3yR0+xt8s/oMdwpdN2btx9aTeLqWEOPc1W5GWS
	WXYVCSJ6pDCGIb4XmuCwDwhtAVIVY4D4/vG7c3KELgf8DsoQlgvCwmpEpLjJ425rukWbze
	6NjAM1Qts5H8JZlDDbEiQEljPasnlf0o9ZaoQ4/V4EaoBOXsIikjzU8VHEoWVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735835454;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=APmqNIf5hl93oox5Sf5K1w7T125IlDaElsY8NEvoiQo=;
	b=D4lxeCGj1/QG2L5idQlSKvSWbxAPIPZUI/o36H3S16rfMmT7pfnGfGzihePNn+LYjZPCSG
	NcbmJVnjlS0vI/AA==
From: "tip-bot2 for Andrew Cooper" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/static-call: Remove early_boot_irqs_disabled
 check to fix Xen PVH dom0
Cc: Alex Zenla <alex@edera.dev>, Peter Zijlstra <peterz@infradead.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Juergen Gross <jgross@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241221211046.6475-1-andrew.cooper3@citrix.com>
References: <20241221211046.6475-1-andrew.cooper3@citrix.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173583545134.399.16153310662792685625.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     5cc2db37124bb33914996d6fdbb2ddb3811f2945
Gitweb:        https://git.kernel.org/tip/5cc2db37124bb33914996d6fdbb2ddb3811f2945
Author:        Andrew Cooper <andrew.cooper3@citrix.com>
AuthorDate:    Sat, 21 Dec 2024 21:10:46 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 02 Jan 2025 17:11:29 +01:00

x86/static-call: Remove early_boot_irqs_disabled check to fix Xen PVH dom0

__static_call_update_early() has a check for early_boot_irqs_disabled, but
is used before early_boot_irqs_disabled is set up in start_kernel().

Xen PV has always special cased early_boot_irqs_disabled, but Xen PVH does
not and falls over the BUG when booting as dom0.

It is very suspect that early_boot_irqs_disabled starts as 0, becomes 1 for
a time, then becomes 0 again, but as this needs backporting to fix a
breakage in a security fix, dropping the BUG_ON() is the far safer option.

Fixes: 0ef8047b737d ("x86/static-call: provide a way to do very early static-call updates")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219620
Reported-by: Alex Zenla <alex@edera.dev>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Alex Zenla <alex@edera.dev>
Link: https://lore.kernel.org/r/20241221211046.6475-1-andrew.cooper3@citrix.com
---
 arch/x86/kernel/static_call.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 9eed0c1..9e51242 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -175,7 +175,6 @@ EXPORT_SYMBOL_GPL(arch_static_call_transform);
 noinstr void __static_call_update_early(void *tramp, void *func)
 {
 	BUG_ON(system_state != SYSTEM_BOOTING);
-	BUG_ON(!early_boot_irqs_disabled);
 	BUG_ON(static_call_initialized);
 	__text_gen_insn(tramp, JMP32_INSN_OPCODE, tramp, func, JMP32_INSN_SIZE);
 	sync_core();

