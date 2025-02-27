Return-Path: <linux-tip-commits+bounces-3726-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF99A48B13
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 23:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DB91886975
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 22:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD97271826;
	Thu, 27 Feb 2025 22:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z9bhSFUr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FGkJBS7A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1E026E968;
	Thu, 27 Feb 2025 22:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693915; cv=none; b=YH8gYPBggoHAam8m9WM0xJ5ngxiNBuV6wFC29eBfloYrx5x5boqAGRc9AMCXVFPsfjWQ3h1V30ZUILjb25DtyVUXznW6/v7jKdKmqoRRilkSIySoGGYNr2ZR1SjtOtPxL936NR9dWLXPAR2zs/mk59YwpumJdU8BUFCeJgpmHyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693915; c=relaxed/simple;
	bh=rrMMQ4RuSU/fzVhFTjtSaVkA7T+HR8rsRoSbvnXcc3w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=e9CpHJKaeC2vzylNdSIJV0vWhgduGMkbyDTEs7zuQsjSXazWghCsGKOsD7JoZ04IGRHXa7iHAjhP7YCrukVJIXdnkucncYoY7HpGOgBKYZc+/hP7IrPaBtGuPzf9qsJO9BuSUr9NVBFX/58V309D7dpMaiw3rYqhItYXi1UJ1Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z9bhSFUr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FGkJBS7A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 22:05:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740693912;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EeqDjTacZuOQvihxZsxkaCV6E8LYUVjjoq5w9R0ZOr8=;
	b=z9bhSFUr9lWHtRfTGh+gJ6x+v5DKKhrxh4EcK5OiuaLLPv9PCU8KC4hXxlVr0cZ7oLRq3d
	juh5wj9eN3xDPYFv++NtL3py3i3YHwEos9V01sGOIMdAgciSt4TwvVTPcTEmMcCkTDglcD
	ZxLPKilU6MtMIPq8nquyUlT7MtGKAv+OCK8hAlKFncE9k04cy9dXjb+r2WGjbf/xZorveu
	p/DgH5r1KHqrV0p6VCOB1maBenJ2dkVTAL3NGqOTjQ6JXVsbGiF+xankRkR55YWzfQLuKD
	rIrZDSDYWPa+PyQY73UeTJ+o4Ex3di8Ml4BiJAEhQ3U040Alu08phabk3pjYWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740693912;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EeqDjTacZuOQvihxZsxkaCV6E8LYUVjjoq5w9R0ZOr8=;
	b=FGkJBS7AxDvzFHYALfgfzLVCPP5fBaXHN+MgNvJb3bM6uMc8cYgPr5vY/VTnV250MCJSCr
	DaACJoKWXIUhDWAQ==
From: "tip-bot2 for Zhang Kunbo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cleanups] x86/irq: Fix missing declaration of 'io_apic_irqs'
Cc: Zhang Kunbo <zhangkunbo@huawei.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241126020511.3464664-1-zhangkunbo@huawei.com>
References: <20241126020511.3464664-1-zhangkunbo@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174069391186.10177.2478590686499344604.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     b8ffd979356e33a3af0854d47375bba611126f3b
Gitweb:        https://git.kernel.org/tip/b8ffd979356e33a3af0854d47375bba611126f3b
Author:        Zhang Kunbo <zhangkunbo@huawei.com>
AuthorDate:    Tue, 26 Nov 2024 02:05:11 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 22:52:37 +01:00

x86/irq: Fix missing declaration of 'io_apic_irqs'

Fix this sparse warning:

  arch/x86/kernel/i8259.c:57:15: warning: symbol 'io_apic_irqs' was not declared. Should it be static?

Signed-off-by: Zhang Kunbo <zhangkunbo@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241126020511.3464664-1-zhangkunbo@huawei.com
---
 arch/x86/kernel/i8259.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index c20d183..2bade73 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -23,6 +23,7 @@
 #include <asm/desc.h>
 #include <asm/apic.h>
 #include <asm/i8259.h>
+#include <asm/io_apic.h>
 
 /*
  * This is the 'legacy' 8259A Programmable Interrupt Controller,

