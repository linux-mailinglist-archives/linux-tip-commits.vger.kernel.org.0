Return-Path: <linux-tip-commits+bounces-3725-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F5BA48B11
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 23:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC4B3B6EDB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 22:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1242E26FA5C;
	Thu, 27 Feb 2025 22:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ve8MGxtF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bmAbfUEg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE7018FC84;
	Thu, 27 Feb 2025 22:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693915; cv=none; b=pvAhCRyH1pyj93vYcbjXGzXvrf5UqroLoGvRmcryBo2UnKf9Ym468fX1QLv5baDuO2e1uVv3hvSmrFuWCdzJtmUeb91NEch1V8eYsyCtdHYxn1+bWbrk2C33MtHU/pt2cWcK8dKcfMMELfPf226rdCJMGTiqCUmboxYk9modBts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693915; c=relaxed/simple;
	bh=rJSmZUwx8MohAUR29+yGNNXCOA264ZiiiycjMhuevVE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m87K667UaQpV9XyHZOaNUFRk/xOjfQ8ucIKqEb8eB4yyGkEQl+SSj7wCv3UtczY/3J+PGcnVrB0aqcuTGpHCHdiF3kCXtQvSbQwjeHp8N89gys1PSDfK43qgqobChcJ34gz9byZP9BJ1ztonp5d/W3LV/HBc7xy6nzRiCyKQBSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ve8MGxtF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bmAbfUEg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 22:05:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740693911;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GTpQ5EbG6SjGpPpOAiVkwn+OGtwO6bWLpX9/T3ss4bY=;
	b=Ve8MGxtFb/9LEj6PF9rGE7llHjQjXe+XIiGIHBqyDFgMH0SEmgw2vsvWS4tWt+yyNKBIeu
	qWbyXALlBNJ16zXyvXibuL1vv6pz4AYy2lfQjGqTpVPsMTZ+59+oEDQ9KjQ7Cwu97RUIl9
	KWvJiwxsgk0twECSGniVjwANtV1b22Pq5vZ6rZSOaHYb1nJBXz5z2MbEerK+gH68wUxFQk
	mNvEvjDgbMVQnDEsW+queXB9U0W6Mb2YL/goxtfdsC9mwoNx19gOhFEJlyZu17ziDpvOma
	RAgZHdTZeavVkuYYucfn8a8xDQu+cgKfq6yAzLapN/wL3UueJLRI9caLONEeiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740693911;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GTpQ5EbG6SjGpPpOAiVkwn+OGtwO6bWLpX9/T3ss4bY=;
	b=bmAbfUEgJ8yrnLUyqarufYE2NL24sjmtqxakkKnfZLXOe63cWH01BlZdUGSGgpbq8koWtl
	pDtsOrIQcdZpQIAg==
From: "tip-bot2 for Zhang Kunbo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/platform: Fix missing declaration of
 'x86_apple_machine'
Cc: Zhang Kunbo <zhangkunbo@huawei.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241126015636.3463994-1-zhangkunbo@huawei.com>
References: <20241126015636.3463994-1-zhangkunbo@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174069391043.10177.15698259773482528147.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     e008eeec7868a9ca6e159726aeb9bdbf2ab86647
Gitweb:        https://git.kernel.org/tip/e008eeec7868a9ca6e159726aeb9bdbf2ab86647
Author:        Zhang Kunbo <zhangkunbo@huawei.com>
AuthorDate:    Tue, 26 Nov 2024 01:54:57 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 22:52:37 +01:00

x86/platform: Fix missing declaration of 'x86_apple_machine'

Fix this sparse warning:

  arch/x86/kernel/quirks.c:662:6: warning: symbol 'x86_apple_machine' was not declared. Should it be static?

Signed-off-by: Zhang Kunbo <zhangkunbo@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241126015636.3463994-1-zhangkunbo@huawei.com
---
 arch/x86/kernel/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index 6d0df6a..a92f18d 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -10,6 +10,8 @@
 #include <asm/setup.h>
 #include <asm/mce.h>
 
+#include <linux/platform_data/x86/apple.h>
+
 #if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_SMP) && defined(CONFIG_PCI)
 
 static void quirk_intel_irqbalance(struct pci_dev *dev)

