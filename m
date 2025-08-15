Return-Path: <linux-tip-commits+bounces-6253-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB8CB282DE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Aug 2025 17:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E764CAC0144
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Aug 2025 15:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB852C0323;
	Fri, 15 Aug 2025 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TIHv+2op";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WxoIyMcs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3C4291C38;
	Fri, 15 Aug 2025 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271342; cv=none; b=R7sTrCVG9yK09uCCCU9VAjLnhffD+kWzCFrqi5ClI1wOw3FQD6itwTfEm/XZsp1BJqW06oqD6pEwwmvf3rNjYanERjFuewZkAr11pMEguBZyKLdcdlLmEDLXf31wU7RAH7OyYViu4bTzr4u4hjYoaunW2BlDvT25jL1HTzoG47U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271342; c=relaxed/simple;
	bh=W7duCh9vwStWYND2FGfRWdyPnr1VbWzyqp8PVEU9Y6w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nxAEB+xpCSuczjKteR9KcuF71sdcmEgx9YTuonatxpgmvZxyq0363P71w+Ddeh0Ik9fYDV2YkmluIWRDmduZQ447vYM6UQxPzvLJeOyE0QZ5LdZo0gfvC2tNBrfllHuVJ3ekZJpROYAp6NuvbwiwPDuRwz0zYfvTon/jnOXS0kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TIHv+2op; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WxoIyMcs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 15 Aug 2025 15:22:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755271338;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKC+2cAb2bXUpps4iXYctWhXv6D5E9MG9vfYvoBWHsI=;
	b=TIHv+2opCaN8wxpJ4dsJxCzQLVVbrh84frB16VUDw304fCC4K5oY6G6c/9DUgHDNI1L1X4
	ZsvMMBnNZTTjKUBFtAVzDmXoNtOrFp99/p88Z4usApsD2nnMBTz1DrLHDDOmyAP8dyUsIt
	Ep3KvHQkxRmuSV9jKCl/gp6bmfdL0yul5JEr1UMcarFDqQaTNYDAhY4FfsmsRjw/4A5rSk
	NR0Z9CQeIBIUlXCTbeQROIDHiHFZnGqGbcWld7tu0lphtMmqJlVT+Vje3FK5glgYjsGYEo
	V1H7a7aZvyWKjZweTMGoxXp4F0Vpxa3YBzj/I5rq+LO4al7nBqsFJOepStaOeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755271338;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKC+2cAb2bXUpps4iXYctWhXv6D5E9MG9vfYvoBWHsI=;
	b=WxoIyMcsemLYmT1+jsUaAZ4MNZTpRO0eqp8yaiT3dDIFeGs3L069AjGrcZc2JTMOVCHuI/
	AW4RO3oydQQmpMBw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpuid: Remove transitional <asm/cpuid.h> header
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250815070227.19981-2-darwi@linutronix.de>
References: <20250815070227.19981-2-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175527133652.1420.12101759486360166993.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ed6c4b657bca3b39f7b11cba1405931aeb490f3d
Gitweb:        https://git.kernel.org/tip/ed6c4b657bca3b39f7b11cba1405931aeb4=
90f3d
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 15 Aug 2025 09:01:54 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 15 Aug 2025 17:06:23 +02:00

x86/cpuid: Remove transitional <asm/cpuid.h> header

All CPUID call sites were updated at commit:

    968e30006807 ("x86/cpuid: Set <asm/cpuid/api.h> as the main CPUID header")

to include <asm/cpuid/api.h> instead of <asm/cpuid.h>.

The <asm/cpuid.h> header was still retained as a wrapper, just in case
some new code in -next started using it.  Now that everything is merged
to Linus' tree, remove the header.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250815070227.19981-2-darwi@linutronix.de
---
 arch/x86/include/asm/cpuid.h | 8 --------
 1 file changed, 8 deletions(-)
 delete mode 100644 arch/x86/include/asm/cpuid.h

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
deleted file mode 100644
index d5749b2..0000000
--- a/arch/x86/include/asm/cpuid.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef _ASM_X86_CPUID_H
-#define _ASM_X86_CPUID_H
-
-#include <asm/cpuid/api.h>
-
-#endif /* _ASM_X86_CPUID_H */

