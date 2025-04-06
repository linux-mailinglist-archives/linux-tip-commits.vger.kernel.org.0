Return-Path: <linux-tip-commits+bounces-4705-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E530A7CF5B
	for <lists+linux-tip-commits@lfdr.de>; Sun,  6 Apr 2025 20:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC314188955B
	for <lists+linux-tip-commits@lfdr.de>; Sun,  6 Apr 2025 18:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E28D13DDAA;
	Sun,  6 Apr 2025 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="27buf1mG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fl1f9B/y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69EAC8CE;
	Sun,  6 Apr 2025 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743963175; cv=none; b=VPZegZMYFQGnlRk83TI5zGPEWckqmo6yoT87oJ+T2odrSLgWzTo/ionGI4EBhlQVuKIcCLu9KaBTdyjqoR/RgYyyh/JLseR8A2ltm4MoHRq3HonUaBLxWMljH0NB4IHJVJHkthc+cinSUy2ofJLVfFuHgl4nSPwtdp2w1hBv6BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743963175; c=relaxed/simple;
	bh=kFrp5kg1fjNMEphENS5riaAFwEdjbq+CSQx0/vhpbI4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QQlXHM5L5uSr7BJ2Y3RUxIYNLZJoUrsQb7TmJ2kihole2d1OnDPrFmn86+FckEyn6AP44qJC8pzZRKneMk/bSzMBLKXt4t7k5/81UIN9gg5vpm7ZGB6egaSLWRqlP8YoIU8FBvZZ+ob0jO2JSEs8Lxr7KD4mUTrWzBcgk0leps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=27buf1mG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fl1f9B/y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 06 Apr 2025 18:12:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743963171;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+J/5yjQAy1jmBGTg4B5Xy0Qpk1W208QSvR1EwTT9xks=;
	b=27buf1mGVbBHsB6nieVh5L0Y45EU/ervxkOdK0ikUIl+ODV9RQp4NHAlrUsJVd+EKQFLGr
	hhql1QyZItJoUsha559GOUm6PKSayBx1aFL2wfJWnlvlRSgI9l7lPD3eKIdshxgrMO+Uov
	5WRkvxrRvOCfiHgj9ddxI6C/up0ipk3S0FpcFj3c19vGVL3fKvAMLGhaFTsrP4Q4RnbIw0
	sMuyvlt8EJs7ESrc4lIsazAgVfsSLDFUOTjcByy5w2A2QzTctMzARqS9QqxKXqwW7ecoJC
	olQVcftrPQ3rt0uQr1qcvqjfqnt5WqL/R1r2bti3AwmNU5lUrLSdOsVRIahImg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743963171;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+J/5yjQAy1jmBGTg4B5Xy0Qpk1W208QSvR1EwTT9xks=;
	b=fl1f9B/y7WR42X3N2qp7F8uERYrfj9xZ1WBL1X5y8vivTdh4O31weKAdDHBEEmAZno86w1
	3e68dS5xc/DjNhDA==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Use __ALIGN_KERNEL_MASK() instead of open
 coded analogue
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250404165303.3657139-1-andriy.shevchenko@linux.intel.com>
References: <20250404165303.3657139-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174396317035.31282.12416521179148509030.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     0ee07a07920285d519152974872ca6e43f8742e8
Gitweb:        https://git.kernel.org/tip/0ee07a07920285d519152974872ca6e43f8742e8
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Fri, 04 Apr 2025 19:53:03 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 06 Apr 2025 20:06:36 +02:00

x86/boot: Use __ALIGN_KERNEL_MASK() instead of open coded analogue

LOAD_PHYSICAL_ADDR is calculated as an aligned (up) CONFIG_PHYSICAL_START
with the respective alignment value CONFIG_PHYSICAL_ALIGN. However,
the code is written openly while we have __ALIGN_KERNEL_MASK() macro
that does the same. This macro has nothing special, that's why
it may be used in assembler code or linker scripts (on the contrary
__ALIGN_KERNEL() may not). Do it so.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250404165303.3657139-1-andriy.shevchenko@linux.intel.com
---
 arch/x86/include/asm/page_types.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
index 9f77bf0..018a8d9 100644
--- a/arch/x86/include/asm/page_types.h
+++ b/arch/x86/include/asm/page_types.h
@@ -29,9 +29,7 @@
 #define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
 
 /* Physical address where kernel should be loaded. */
-#define LOAD_PHYSICAL_ADDR ((CONFIG_PHYSICAL_START \
-				+ (CONFIG_PHYSICAL_ALIGN - 1)) \
-				& ~(CONFIG_PHYSICAL_ALIGN - 1))
+#define LOAD_PHYSICAL_ADDR	__ALIGN_KERNEL_MASK(CONFIG_PHYSICAL_START, CONFIG_PHYSICAL_ALIGN - 1)
 
 #define __START_KERNEL		(__START_KERNEL_map + LOAD_PHYSICAL_ADDR)
 

