Return-Path: <linux-tip-commits+bounces-4002-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE968A4F9B0
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 10:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84FF1892C00
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 09:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735C72E3387;
	Wed,  5 Mar 2025 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DIi25aln";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m9kdaBF0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17931EA7C5;
	Wed,  5 Mar 2025 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166142; cv=none; b=OEdX1wVNiDnp+Qjk64ijhuPRwC5HEa7aliZ2QZtFysvKGP5kdPI9NnbrDrG8Ym/bPlBrycpPP6Cc2AHlSPhsjPJZIG2dB4dRatlxffmFBrNpKd0ZNgH4IHxwKK2/NlS10tOaUbKUDP7bYMlqRRb4RB35yACs59lvU+Mitt9yw0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166142; c=relaxed/simple;
	bh=qskMcPhLIecxh61O8GIRR/1oooYOU4etXpowKAgsw9I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F8fvz5je+Hy9/8gvQpYnNXy4xyynXnSJ/bTsXwebAEgsNaHn4SHxuwV0gotftbcuAGEm1AQmZ0TiVZs4F/Bmxi7i0L7hSgQzZhAd7x8wQwAKc8QCsKqrdMs7LsMotILS22Fwec+c7WufANLPGwTbaSEEKTCrXPcFEo3yUBbP220=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DIi25aln; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m9kdaBF0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Mar 2025 09:15:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741166139;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PE07If5USuUI/PuupiyISWQ3+V5PhmirBThQEmg2Ues=;
	b=DIi25alnYyyVB3kYli9iGurmqqSZuLWKvaU1B/mZZvYS1i/TVKGgc9YwqOP5piUTmrrhIX
	IVNCB2xccXfmiYdwMk/fa+WvfbNBHr1n3huqeCNop1fZf+KnpTkFEbNpTOjbHDjyM5JG6C
	2cxLrQIoMa/GkRhb8j5GSgyMUNeTE88qUhaz6Qn2E7z1SUGbVN4VGJ5Ie3eDsnKh77CtqU
	Xs3OgydiJfXj1v67bvtoMl0QrAHBH+qKsWzOQKPF+sCazT/575szOtoA9DZEHTV7tMQb9G
	HNyBgEVs5zIltJTTkFPhWytiKXD5zno6b7dzXCObDlKAbawbvCdO6jAr2eP1iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741166139;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PE07If5USuUI/PuupiyISWQ3+V5PhmirBThQEmg2Ues=;
	b=m9kdaBF0sk5vJm7T3oOFXPyr8G9xKkD7u5yn1Jlwj+7C5Vc7hD1wxmJSH/m7u/4x4H5QXk
	Vvv13dyjfC3HCqDA==
From: "tip-bot2 for Charles Han" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/delay: Fix inconsistent whitespace
Cc: Charles Han <hanchunchao@inspur.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250305063515.3951-1-hanchunchao@inspur.com>
References: <20250305063515.3951-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174116613685.14745.14513872226506732439.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     f739365158a33549cf1827968b12a370ab75589e
Gitweb:        https://git.kernel.org/tip/f739365158a33549cf1827968b12a370ab75589e
Author:        Charles Han <hanchunchao@inspur.com>
AuthorDate:    Wed, 05 Mar 2025 14:35:14 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 05 Mar 2025 09:51:04 +01:00

x86/delay: Fix inconsistent whitespace

Smatch warns about this whitespace damage:

	arch/x86/lib/delay.c:134 delay_halt_mwaitx() warn: inconsistent indenting

Signed-off-by: Charles Han <hanchunchao@inspur.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250305063515.3951-1-hanchunchao@inspur.com
---
 arch/x86/lib/delay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
index 23f81ca..e86eda2 100644
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -131,7 +131,7 @@ static void delay_halt_mwaitx(u64 unused, u64 cycles)
 	 * Use cpu_tss_rw as a cacheline-aligned, seldom accessed per-cpu
 	 * variable as the monitor target.
 	 */
-	 __monitorx(raw_cpu_ptr(&cpu_tss_rw), 0, 0);
+	__monitorx(raw_cpu_ptr(&cpu_tss_rw), 0, 0);
 
 	/*
 	 * AMD, like Intel, supports the EAX hint and EAX=0xf means, do not

