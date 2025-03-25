Return-Path: <linux-tip-commits+bounces-4484-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A08A6EC35
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD963A6FC8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C868D256C82;
	Tue, 25 Mar 2025 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZX/Jhix5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="usU9fqdb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48D62561C3;
	Tue, 25 Mar 2025 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893548; cv=none; b=svbL1hjbc+qXMMk2+4y9sjJJ4XElFBOYTy8wYYg2Q3Hd5mwPOkzJpGsg1r1tzpzx4mM2y49OFKWjBUM2D23ItnbQS/LjUvBHX9ccb+UmH1dgTqPkxPwdKSxylgVWgsrAjUxqcj8Lv+vkAvXELBG4bYpWxJaV7YLi2P4KUPnz6aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893548; c=relaxed/simple;
	bh=9QfDJSC9LrLUWFCbtMPuQ4mP7gbyExc6m8RoMKtx2/c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=R84nkpqeLwK7zv1IleeyvfU8czSK28KGxoHh2UwO4SPlrYVs6ufVdGsdeNQGOtPFOodmGF7whdi247iXCQ3SWwv5qdGJOTawgY0hsNrSpJ3llDOyyZVv3U0us8gmySsf1edHI8LIg2nRZfeCPxH61vh1XtEx+ldef8x58B+pVZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZX/Jhix5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=usU9fqdb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:05:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742893545;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBd2vKdG44FsVzBNTO0dO25YLQVREiu4FBDgcbY0r14=;
	b=ZX/Jhix5AqONsFjAFExR5NRT270UHp4FdBif2NNVGCslKc1KCCo1xwAiFWM+7FAF8I55L+
	ku+WOjmnJILFUO3h7BhVyro+toAlrjmSKs4cB9MeeQpKeCLJWqvUEzTSNgmHvg2XYYTJZf
	lB17KqhkLzFBtCJSWhGVRFFGTRZTlfPz0+1VWoQg1LAxc9BNxmnnJwLbKzuHB+0GByCJWE
	dTdp8oHPMfJmo5gtmqY0iiFc1Zmw8aI9Iuz627gfOJ4oXFwSWp6BtwyW2tAe1PgWb6R/jY
	7DPfq5GxZBSJffTx1UPzT2jb0cdFB/kxmCQt1UiQLlRPmhLs7jGEHNLRaHZC0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742893545;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBd2vKdG44FsVzBNTO0dO25YLQVREiu4FBDgcbY0r14=;
	b=usU9fqdbtotLuX8sU/GjQLtNKtXHDBD9qBCt1MjfP4TqFnffvpIq2RwGCTRyy5Drjod29U
	+6Fm+pETZxE/mjAQ==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] tools/x86/kcpuid: Remove unused local variable
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324142042.29010-7-darwi@linutronix.de>
References: <20250324142042.29010-7-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289354432.14745.16198913248919565755.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     c061ded035b5bdeb21adc1046c0bfbba4bcee2d2
Gitweb:        https://git.kernel.org/tip/c061ded035b5bdeb21adc1046c0bfbba4bcee2d2
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 15:20:27 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:53:44 +01:00

tools/x86/kcpuid: Remove unused local variable

The local variable "index" is written to, but is not read from
anywhere.  Remove it.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250324142042.29010-7-darwi@linutronix.de
---
 tools/arch/x86/kcpuid/kcpuid.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index aa0e037..f1dac5b 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -181,10 +181,6 @@ static void raw_dump_range(struct cpuid_range *range)
 
 	for (f = 0; (int)f < range->nr; f++) {
 		struct cpuid_func *func = &range->funcs[f];
-		u32 index = f;
-
-		if (range->is_ext)
-			index += 0x80000000;
 
 		/* Skip leaf without valid items */
 		if (!func->nr)

