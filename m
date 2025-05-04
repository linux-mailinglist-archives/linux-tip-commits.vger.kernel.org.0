Return-Path: <linux-tip-commits+bounces-5217-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C1AAA84E8
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 10:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE813B98D4
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 08:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C4019CC0E;
	Sun,  4 May 2025 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ODYdDAJz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BqyZ7lWZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D381019755B;
	Sun,  4 May 2025 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746348869; cv=none; b=A7LFgT5+ry7XPqKZaIIPW6EvWl8jKwoqf2iyl38kDXUVqY2BuXZMJDH5/R775MgFiwsL6O6B4Mr5CbJ0u32NSUjVVoPbKmW1MTyUeRSMEB++osNYxF9FcsgDW4eR1w+C9qjZJr1XY+B+MgphaIVdbkt/5t8BNxLl8dR8GCiEtQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746348869; c=relaxed/simple;
	bh=3VDFUwtXcDb1CFVcuTHl26o7ChheT/KCXCxoDJk7UMo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RFLODXdSEJ1koWZa9Gu9GvVUITXAJ+cPpDiuR2VZ2XWdnN6d1KpPCGGbr4whXoCR2FTGXHvsGr1mrUo5jg8RYsiyHD2clfU8NVtQuklspFuP3e4b31kMVb+OZD8N5KNDi29quRs9ydatiTLXZoAgrx2omPpYk3i9PNzEUotldI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ODYdDAJz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BqyZ7lWZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 04 May 2025 08:54:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746348866;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWtdp1XSdJDj26lT2BpRFnmlAcXGnpied73XXMUUuFQ=;
	b=ODYdDAJzIPpBjz5v8WLGMt+Qzy4PPBEpyqhxmoGtBJqBncJU+8FuJRGdQU0oA/aKQL6zit
	W34CQ30Q94QeASDHPTHcJnAoefcySGgyY5tf8XuwFtjZIPxgBkAnnHBbXAepMGYAohX98j
	sXjHyoRQU3tu/pRwBFBHx/cuS/XYxTCBbxTH9XIQMIEPGptc4HaU/WFMHQw6wH+SJ6U5gI
	Y5FUsxNeR0XnHKfoWuNlJgYkG/TOkHtmR5nN00Hcieu0gwBZP9tL+Vx1z+TVScitkBannG
	+IOBKVhAux7eHsGF68WxZb3vVcRc7mh3G1BcY98u7q1Uv36/Ml+VMrmbTlONHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746348866;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWtdp1XSdJDj26lT2BpRFnmlAcXGnpied73XXMUUuFQ=;
	b=BqyZ7lWZ3oNasUFSdoySCjMuXRIR2er+tqpv7JGjwehzTQHVnPqFNCjAiWbaDjBP/mPkt3
	G7RbNicNGcMqR9DA==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Remove x86_init_fpu
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 "Chang S . Bae" <chang.seok.bae@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@amacapital.net>, Brian Gerst <brgerst@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250503143837.GA8985@redhat.com>
References: <20250503143837.GA8985@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174634886518.22196.736214432807661559.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     392bbe11c7cf90e65cba32e90af3b969a981c4fe
Gitweb:        https://git.kernel.org/tip/392bbe11c7cf90e65cba32e90af3b969a981c4fe
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Sat, 03 May 2025 16:38:37 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 04 May 2025 10:29:24 +02:00

x86/fpu: Remove x86_init_fpu

It is not actually used after:

  55bc30f2e34d ("x86/fpu: Remove the thread::fpu pointer")

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Chang S . Bae <chang.seok.bae@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250503143837.GA8985@redhat.com
---
 arch/x86/kernel/fpu/init.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 2d9b5e6..6bb3e35 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -71,13 +71,9 @@ static bool __init fpu__probe_without_cpuid(void)
 	return fsw == 0 && (fcw & 0x103f) == 0x003f;
 }
 
-static struct fpu x86_init_fpu __attribute__ ((aligned (64))) __read_mostly;
-
 static void __init fpu__init_system_early_generic(void)
 {
-	fpstate_reset(&x86_init_fpu);
 	set_thread_flag(TIF_NEED_FPU_LOAD);
-	x86_init_fpu.last_cpu = -1;
 
 	if (!boot_cpu_has(X86_FEATURE_CPUID) &&
 	    !test_bit(X86_FEATURE_FPU, (unsigned long *)cpu_caps_cleared)) {

