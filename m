Return-Path: <linux-tip-commits+bounces-3623-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB91A44F40
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 22:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 174C07AA57D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 21:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921E8210185;
	Tue, 25 Feb 2025 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ymeh3v5E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LsIZlg5z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048FE21148B;
	Tue, 25 Feb 2025 21:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740520344; cv=none; b=g5xU5Xehn5xHa913J9f49VA1J7qqkCcy66Y9H5KnLfK8VrOwEUV2PORTxUYlG69HObLxY/pFtNfFVSoxyvvdSnwUHeY0ui5dcPdLgt4aONlFBEa9/hlZUI9z8UTsvgkEngQQC3es4ixOBI99srYu7nRahtW1nQn/zIgQyPVUpP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740520344; c=relaxed/simple;
	bh=y7yMCyWsuZWBMZH5KXtQiGCDq087C3dstOqgkiUnP80=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WbD0xJzhsgEopI53zNwD2g5HGR1LoAThsLo9eyjO1q/LUO7FSLY7+Ybrlcjp5mYzYyYXpS1w40GcuJkugvqg+gp8C91zCBd+T1XdzBXLdJ/qLDgX/zNS2Dr7H+5Ht2F3mU3vyKOSRClT7dm8LyVk1+zXM7nIrB/liGtQU4Hz4Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ymeh3v5E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LsIZlg5z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Feb 2025 21:52:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740520341;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lBhJOylJ+OLIQFryBP3tOj16303aC7B/najmWZcUY28=;
	b=Ymeh3v5EHXrNOx0C/6kupjothACXmLmjOWG1n4tsxSyo9eKnj1WEWJAFua81vdWOzEWNB8
	hpgnq4q3e9H1aDg2wZyU5XdWbWzQN+Aen8EqtV4n0I8kaHzzjTWRmPjdxba3XaNT6Jv8Ud
	pwlASClWAt9uVXy5jqw8ZQ69ECzTjyDUIriU68raZGNb01h2E4saXIZQSAhI/QqI2KRBpx
	3ABWmMn2gVYQZoSLLQqfm08nCdEO/hzH67R1L+d4cLnfTQWXqIY14hx4tvdj4bfRiiu+d3
	MLcI8YYqmViMQ4+pPJG2qthZ6ndyPShzWFW+EX+t1vkJZ7STFGVmSXqIiI4Wgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740520341;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lBhJOylJ+OLIQFryBP3tOj16303aC7B/najmWZcUY28=;
	b=LsIZlg5z8YWQkXXkbSTwoc4mp/g33VrvvuDJeSLpLCCeUeenOahOlyjDz23LizSnuR1xfl
	tGP0mO8ioiYdjDCg==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/irq: Define trace events conditionally
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250225213236.3141752-1-arnd@kernel.org>
References: <20250225213236.3141752-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174052033997.10177.1903746293341301608.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     9de7695925d5d2d2085681ba935857246eb2817d
Gitweb:        https://git.kernel.org/tip/9de7695925d5d2d2085681ba935857246eb2817d
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 25 Feb 2025 22:32:33 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Feb 2025 22:44:35 +01:00

x86/irq: Define trace events conditionally

When both of X86_LOCAL_APIC and X86_THERMAL_VECTOR are disabled,
the irq tracing produces a W=1 build warning for the tracing
definitions:

  In file included from include/trace/trace_events.h:27,
                 from include/trace/define_trace.h:113,
                 from arch/x86/include/asm/trace/irq_vectors.h:383,
                 from arch/x86/kernel/irq.c:29:
  include/trace/stages/init.h:2:23: error: 'str__irq_vectors__trace_system_name' defined but not used [-Werror=unused-const-variable=]

Make the tracepoints conditional on the same symbosl that guard
their usage.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250225213236.3141752-1-arnd@kernel.org
---
 arch/x86/kernel/irq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 385e3a5..feca4f2 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -25,8 +25,10 @@
 #include <asm/posted_intr.h>
 #include <asm/irq_remapping.h>
 
+#if defined(CONFIG_X86_LOCAL_APIC) || defined(CONFIG_X86_THERMAL_VECTOR)
 #define CREATE_TRACE_POINTS
 #include <asm/trace/irq_vectors.h>
+#endif
 
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);

