Return-Path: <linux-tip-commits+bounces-3911-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C70A4DACA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6194716373B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF141FCD04;
	Tue,  4 Mar 2025 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YuYF3I3G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AGVSzqgm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34381FE44D;
	Tue,  4 Mar 2025 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084587; cv=none; b=VoUzyFfEE0CDVNCugo66VUisyv98GKmqWZ4MyuQYWEuSQ1wVT1Uwb+YvLgg0i+BvBpZQ2J2x0XV7Cpy7pgOmEMPbymJoNpkW87qSQPgueRN5vpEkjzRHiXBjl6yEe2kGlD22ZWSLDeA3ASY4g2/8JlI3tmVrjYwKvx9iJ5XxEKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084587; c=relaxed/simple;
	bh=6PYCH9VmILr4x2bHoXYgSrMai4wuG2N7QnX80DYeFf4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ryc4OXjBubY5oPsAmuJ93lk90xANVYXodHNS9EkgtJC8KVoSrGdF7NPUe0ds+g2h80rEVoBTCaIUfvwoOzzPtmB1KVdfUe4JRlqkBvyBx9Nv9HZTg/DqSvL4uPaM2MCyPv0/VRr3Vn/Ub8bC+TIRFwDZw8kCOFDYc4JbMJTe9+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YuYF3I3G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AGVSzqgm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:36:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741084583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4n+rPMtmOJmPFJoJ71Tm7LI4YAS6d9A7F1SujUs2G4=;
	b=YuYF3I3G7lW4eKP5QXzwZKFWWOujf4SBcfwxv9gUSNQ0ihyDrzWSJ7kUFHA/i73GBRKYgr
	vggLnrL/XOwyBiVAYCJFmhd4cEX4Kw15By3CrN8ynizQcbzX9VKrx3TKoZh2CFc4+ba//N
	G+dv9vxu+xqaEaIOkka6Mn30lK59bTaqb9n9gN05m/OwSn52lsz0SOdFr9v7kRTRAJr6ex
	LlaUp6busLQe8ckcVwqR3kQtaubcAr4BjShlSNTkAE8ximNBCmujPPGEramxcrKy7Vxpgi
	D5eb2dv1niEw9hc5cX81Q+76K74L/RYczh9dRSpmzZg38YimL00OdiiS478Tag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741084583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4n+rPMtmOJmPFJoJ71Tm7LI4YAS6d9A7F1SujUs2G4=;
	b=AGVSzqgmfvy+UfVxyFIoIdt/8X4s+xHKUMe1dVL17ozYKtFBKOQ+Wv16oktJ1Lxm0hi17m
	c+fAyBok1uneA8Bg==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/irq/32: Add missing clobber to inline asm
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303155446.112769-2-ubizjak@gmail.com>
References: <20250303155446.112769-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108458303.14745.14098610716192022436.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     40d9cd9bb08cbe36900efd1600e2228698d52b4a
Gitweb:        https://git.kernel.org/tip/40d9cd9bb08cbe36900efd1600e2228698d52b4a
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 16:54:22 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:21:40 +01:00

x86/irq/32: Add missing clobber to inline asm

i386 ABI declares %edx as a call-clobbered register.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303155446.112769-2-ubizjak@gmail.com
---
 arch/x86/kernel/irq_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index c4719c4..eab4580 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -98,7 +98,7 @@ static inline int execute_on_irq_stack(int overflow, struct irq_desc *desc)
 		     "movl %[sp], %%esp"
 		     : "+a" (desc), [sp] "+b" (isp)
 		     : [thunk_target] "D" (desc->handle_irq)
-		     : "memory", "cc", "ecx");
+		     : "memory", "cc", "edx", "ecx");
 	return 1;
 }
 

