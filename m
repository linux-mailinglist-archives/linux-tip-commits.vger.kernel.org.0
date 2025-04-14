Return-Path: <linux-tip-commits+bounces-4975-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A470A87DCE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 12:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E588189190F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 10:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52771269D15;
	Mon, 14 Apr 2025 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aBeogvZV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FTnQFD6/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98696269AF5;
	Mon, 14 Apr 2025 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744627174; cv=none; b=QGJhFU7ZyXHW5rsPq1Tzyi/YYBUBGb0UbE05ATGPcD+YzjW9WdO2qon5QGPV1xL7D7UOClqA10fIMb2nU3x0Rncdc1EBKcBDQ4gFhQZmcIf07LxxwSF82eboA0ZxJbP7Q56CleeQPvOcj7+6dq7KQGV3uqocTUqi5B2zx5Xkm1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744627174; c=relaxed/simple;
	bh=HjglrSyJ2tSpQiJyI5wpv+9UpTySLF/2riHUKoXpc2A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nQ0Wf+FDKVtawZdnzdhLnlXOLDmGwBqrxALibZFKZ5DAvAVl27+qlgGxDuuF1/0ixy62RLeAe+yMrHqhJw67APtO1AHWAbH8HcJ+ZuEgOGs6cEVZEKI5UK4/2fCWNu8JrQh9weCzWehixYzKAXrw0NgXZw2yV4XmhaZ4jRyNKJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aBeogvZV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FTnQFD6/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 10:39:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744627170;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XMA7W/raqp2c5c9HM5jIBbN0RqrpzxROJrG6tfTjsHo=;
	b=aBeogvZVymTylvyB9TVT1rT0/52chSPteMFjhXTSNu8XnA1/hjK8tAknVQB15eo0FfAkUP
	Eq67852YuYH31GtryD3x3kLWy3rMuiFmLXjSMmd+SoUms/yNBouAinRv2ZQSlANXWD9wil
	khOva3bWbzcC8lyAFITGoPQX/f/dxEfntJxg5ZXzT9ELIeQr5PVswwphpDadVORn5C4Txk
	RmYERggpwqX7TtiDj0sEhy3mAdF2bj7tChX64sRCatK+aD5knEnQFERRij8DR9UxkbUuoL
	EIQ49Hjxp/UPsHDyWZjyNBdSLc6DO4MqObDvXGPsrXERGk/nQWWIZGI6EZcZhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744627170;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XMA7W/raqp2c5c9HM5jIBbN0RqrpzxROJrG6tfTjsHo=;
	b=FTnQFD6/S3AyJ60URiJf6ki46NB2+nSHDMlZ4blAzKRb6PxSDzSzIEJBQTDg2tNHTFN93+
	DOfry1mZHmiXfECw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpuid: Align macro linebreaks vertically
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250414094130.6768-1-bp@kernel.org>
References: <20250414094130.6768-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174462716551.31282.552662882996396507.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     9fb6938d55348ee3e47deff9646fae59a15ed1c9
Gitweb:        https://git.kernel.org/tip/9fb6938d55348ee3e47deff9646fae59a15ed1c9
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 14 Apr 2025 11:41:29 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 14 Apr 2025 12:25:50 +02:00

x86/cpuid: Align macro linebreaks vertically

Align the backspaces vertically again, after recent cleanups.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Ahmed S. Darwish <darwi@linutronix.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250414094130.6768-1-bp@kernel.org
---
 arch/x86/include/asm/cpuid/api.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index bf75c62..bf76a17 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -36,9 +36,9 @@ static inline void native_cpuid(u32 *eax, u32 *ebx,
 }
 
 #define NATIVE_CPUID_REG(reg)					\
-static inline u32 native_cpuid_##reg(u32 op)	\
+static inline u32 native_cpuid_##reg(u32 op)			\
 {								\
-	u32 eax = op, ebx, ecx = 0, edx;		\
+	u32 eax = op, ebx, ecx = 0, edx;			\
 								\
 	native_cpuid(&eax, &ebx, &ecx, &edx);			\
 								\

