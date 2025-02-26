Return-Path: <linux-tip-commits+bounces-3685-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCE8A463CD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 15:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547481884B19
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 14:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF8822171E;
	Wed, 26 Feb 2025 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kODoTOrp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+H40pGWK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE59B21E0AF;
	Wed, 26 Feb 2025 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581565; cv=none; b=hau3yZi5IRurN0qaveE+Kldah4nNnHR0xxp7GZVnIUY2Cb1L2V/fvszSXT/tocTR5rY+VO4YZQguw8ZcEwgr4KO0YfJHqOTga3tiHEpohwgEwuODl8VskzcO9ZgesWziZdD+fofsLibl/eKPqutvrDNOojDlXdJz0lfxViYLRLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581565; c=relaxed/simple;
	bh=E22Fc9jL05Pf7IMChCFtieu2H7spK/k6Zt+c8r2L2VY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ne86K7V3IWwJDZB7XLS4etIsGaXShYlT1pvFtRCrjEQW0Ezp0BCwnYuqXiyubFKCrY5KmyE6pBT1+En/Vt6SMayeHto3Hbs7zRhx2ZJ0c7BDW8iZMShf4Qqh2VW7sBLmodnJZUZZIuvxYnmeSLVmrOX1E0bqE6+9vwiQwXJ/YV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kODoTOrp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+H40pGWK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 14:52:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740581561;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8tL8KtgpEZ3APLVc/11YQHWXuhZ0UhYFw0RN3Q847SY=;
	b=kODoTOrpLBER6/VB2djq+3lJx1kPY1eYT5Wep7yNvvmRnaiz4CurIrfBFobBwseQpxaI6i
	ZuzP1L1ApZdF+QNDXLFEyAnLCUt30Z6OiQbvNaUU/nN3QE1sBYa5Cf8WJF02o/k34XOkVE
	xz0sLEqig7CBmiYGQQsl2ieaZYHwYwDl3iZS2tfcYZ1V3kAKBNSbnYpNmN8aRFkI3S6tGh
	31waOirhmai3OqDX8suuDLN3FZ74R6XLR8wnpy61tKzG1MrsKP2ouizhlzBflwd04lNhQf
	CAxFBXgH6yjNevH4GWO/J0g8vWHmmL9aK2tEcX2jXfXb1E8CNzrXBqCLNVOeWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740581561;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8tL8KtgpEZ3APLVc/11YQHWXuhZ0UhYFw0RN3Q847SY=;
	b=+H40pGWKgp5um3VTOf9kLzz2Pcvw5Zk4G7AkRkEHlZgITdSAvGyi4KX/r+BNUfwH/hLEIq
	K5zm1DDe16tpLtAw==
From: "tip-bot2 for Zhou Ding" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Add missing has_cpuflag() prototype
Cc: Zhou Ding <zhouding@cmss.chinamobile.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241217162859.1167889-1-zhouding@cmss.chinamobile.com>
References: <20241217162859.1167889-1-zhouding@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174058155738.10177.10551712962774765029.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     7d8f03f7dd9f7d108b8d5af12fdc57e10555981f
Gitweb:        https://git.kernel.org/tip/7d8f03f7dd9f7d108b8d5af12fdc57e1055=
5981f
Author:        Zhou Ding <zhouding@cmss.chinamobile.com>
AuthorDate:    Wed, 18 Dec 2024 00:28:59 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 15:40:23 +01:00

x86/boot: Add missing has_cpuflag() prototype

We get a warning when building the kernel with W=3D1:

  arch/x86/boot/compressed/cpuflags.c:4:6: warning: no previous prototype for=
 =E2=80=98has_cpuflag=E2=80=99 [-Werror=3Dmissing-prototypes]
      4 | bool has_cpuflag(int flag)
        |      ^~~~~~~~~~~

Add a function declaration to cpuflags.h

Signed-off-by: Zhou Ding <zhouding@cmss.chinamobile.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241217162859.1167889-1-zhouding@cmss.chinam=
obile.com
---
 arch/x86/boot/cpuflags.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/cpuflags.h b/arch/x86/boot/cpuflags.h
index 475b8fd..fdcc2aa 100644
--- a/arch/x86/boot/cpuflags.h
+++ b/arch/x86/boot/cpuflags.h
@@ -18,5 +18,6 @@ extern u32 cpu_vendor[3];
 int has_eflag(unsigned long mask);
 void get_cpuflags(void);
 void cpuid_count(u32 id, u32 count, u32 *a, u32 *b, u32 *c, u32 *d);
+bool has_cpuflag(int flag);
=20
 #endif

