Return-Path: <linux-tip-commits+bounces-4859-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2E3A858E6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12084E4B73
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9452D1F4B;
	Fri, 11 Apr 2025 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="votGILnm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XjMgnFa9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4366C2BEC36;
	Fri, 11 Apr 2025 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365724; cv=none; b=A7UhoFZ97clb0HNgVuvYfrs6/yDyvbkQ0UtSBGNXpce5DOkQQSS1EcXqQ+4u/AQpCnLaOTcMQIJLQW5/8zN2kPhx8ogyH2bb2gSwO3mfZkd9hbwp+kdAYwsvx++6vPOgTnmqdw7PGTOmLFT0QKPPldxcNBo0L4iY1GUpp99gDlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365724; c=relaxed/simple;
	bh=FCjw2GU0mnKF/AlCf5y8WOt6FLfsmB2iFJI8Hfw+kcE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RbdA/hpjORHKcqpILHNKTuhX5SFzHE89sSAFJczTp8POBZXokOqu7TjVyRUYnYDn63rP7UMogt9nPa6KRtlKJT50CCeQJjyIsbT5UEBx5vCMhqpvEea1RY3pXHlD/LsSLaO/9PAmnwtpZb9HaXnuC2oB2lbVVqwZz49rbAzNODA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=votGILnm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XjMgnFa9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:01:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365719;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9yBD4er/14tb1hcqqwJU0DF2GI9EP7Cv8gaAizw8uHU=;
	b=votGILnmwLqA03PyMCckscmH+rk5oZKoehJcq1APq4P6R+JoLYEOQ/0fkhZ4VXT8144EwX
	6q/GXhxQwIv+5vfXynTbDw0k47PVZ0UJsjVsXpprwQvDvweABbyt6C0Uz4EkzF2h0iepJs
	NC2LPv/rBJ249VCTcrFxKfHGhcevikzFdVbM5P5USpxM1NI0+RGur+pi33NUT647RU2sDH
	uqCGoN0+ngjYY5JTqjocav1rK2cT0IfUfue1WekobRwPtN3ucKklX2oVJU0qF9wY8R+qn5
	Ara/zoZZmnr5JkbbiivgXXG+92Enm/2qa/SP6M+Dp9V3Mg2WBWd66yVzZQS+Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365719;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9yBD4er/14tb1hcqqwJU0DF2GI9EP7Cv8gaAizw8uHU=;
	b=XjMgnFa9/pTzkPh0c4Qzgio6VOpjiG+TPmDqqTDWisbxWPB55A2LIzrM2E4/Cc3dkprvR2
	lfI8VTbl1/Af3VAQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Rename 'put_desc()' to
 'put_text_poke_array()'
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-31-mingo@kernel.org>
References: <20250411054105.2341982-31-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436571811.31282.5803724821461508729.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     3916eec5160dd42c8409c2032149470a474cb5f2
Gitweb:        https://git.kernel.org/tip/3916eec5160dd42c8409c2032149470a474cb5f2
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:42 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:34 +02:00

x86/alternatives: Rename 'put_desc()' to 'put_text_poke_array()'

Just like with try_get_text_poke_array(), this name better reflects
what the underlying code is doing, there's no 'descriptor'
indirection anymore.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-31-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 02f123c..f909f4e 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2486,7 +2486,7 @@ struct smp_text_poke_array *try_get_text_poke_array(void)
 	return &text_poke_array;
 }
 
-static __always_inline void put_desc(void)
+static __always_inline void put_text_poke_array(void)
 {
 	atomic_t *refs = this_cpu_ptr(&text_poke_array_refs);
 
@@ -2590,7 +2590,7 @@ noinstr int smp_text_poke_int3_handler(struct pt_regs *regs)
 	ret = 1;
 
 out_put:
-	put_desc();
+	put_text_poke_array();
 	return ret;
 }
 

