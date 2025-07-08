Return-Path: <linux-tip-commits+bounces-6033-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEA9AFD78D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 21:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75261564D94
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 19:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82445239E9F;
	Tue,  8 Jul 2025 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uBcdMpJG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IpY4ppZT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8281DDA24;
	Tue,  8 Jul 2025 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004229; cv=none; b=YsWOFh1S1/s5Qr3g0B13vIw1RvZ+Guns+hRUeqR1hnSU8U60O6cOF6DdthWjuAymFOF41ESCst7ZyBvH4o7v8YSY0K4LTWAfIZKzgCoR9xKLbl2dpolfSzUSbCP5Tadm+eBRJ2nmw9kTvebpsK2Z4v30dQj6G0ZcmMUFag/U6ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004229; c=relaxed/simple;
	bh=j/11ooFHJ+TuJ5Yyl3qEEw6rT4G6qfWhuiLK7HZ0SRM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TnpbohIb0SPYIuywZ2aSTbUROtyglf27tsoAPE8g5tfexb79fHv2JVMAkwTA12G/GjMxml0qtlCLw2uo42T6eNmeWPBuXkTW3LvoD+jXTDkY1mCdNUzy0d5w5DxVortYKdazBk1cWgZzoi4u5zld3GNh7BNMTfv3bbSxVOsBIvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uBcdMpJG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IpY4ppZT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 19:50:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752004224;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxUPagzqdk1OhHBMAj+GCvU0WcRMxVznmgsYGKAXTgM=;
	b=uBcdMpJGoXVjdFCY2PTHVNkfZlO9hJK679y17ghhUQ81NWJHUyOpVg9LQJ7WFBWHUNdvH8
	mDqUilfPIE7eEGMv9b7HVLnkD54+B2ZiuwJqLoQSI1BUiwws0A6HJhEaeyy2VGyCUdIzFJ
	yHRN0NwuGT1/gUVO4vC2wyP81xT9qr4JffGie2VqKjf5b3vgMbzKAw2l60F64Ki/uAuhqQ
	OysR+EkiNUlgRBLTUegZkR6foVObNqj5q5DF8XsK2bwm96NumYWaE9o44ypIZfBuG/ROlu
	iUse/pipcBfw7TV/DC1T27a0MVPHQ3qAZOWd2275ODgH0DRLXFpb2ks83EQYDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752004224;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxUPagzqdk1OhHBMAj+GCvU0WcRMxVznmgsYGKAXTgM=;
	b=IpY4ppZTnRrcU9zJNZLFJ00j0ABD+ntR9kOMj5BOTSk4ri4AqPRfyi5PmJo7MFVf3Wsui2
	2zBNTK4YQ+lFL6Bg==
From: "tip-bot2 for Mikhail Paulyshka" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/CPU/AMD: Disable INVLPGB on Zen2
Cc: Mikhail Paulyshka <me@mixaill.net>, "Borislav Petkov (AMD)" <bp@alien8.de>,
  <stable@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1ebe845b-322b-4929-9093-b41074e9e939@mixaill.net>
References: <1ebe845b-322b-4929-9093-b41074e9e939@mixaill.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175200422348.406.18432028043091419363.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a74bb5f202dabddfea96abc1328fcedae8aa140a
Gitweb:        https://git.kernel.org/tip/a74bb5f202dabddfea96abc1328fcedae8aa140a
Author:        Mikhail Paulyshka <me@mixaill.net>
AuthorDate:    Tue, 08 Jul 2025 16:39:10 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 08 Jul 2025 21:34:01 +02:00

x86/CPU/AMD: Disable INVLPGB on Zen2

AMD Cyan Skillfish (Family 17h, Model 47h, Stepping 0h) has an issue
that causes system oopses and panics when performing TLB flush using
INVLPGB.

However, the problem is that that machine has misconfigured CPUID and
should not report the INVLPGB bit in the first place. So zap the
kernel's representation of the flag so that nothing gets confused.

  [ bp: Massage. ]

Fixes: 767ae437a32d ("x86/mm: Add INVLPGB feature and Kconfig entry")
Signed-off-by: Mikhail Paulyshka <me@mixaill.net>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/1ebe845b-322b-4929-9093-b41074e9e939@mixaill.net
---
 arch/x86/kernel/cpu/amd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index e1c4661..1b1ff60 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -937,6 +937,9 @@ static void init_amd_zen2(struct cpuinfo_x86 *c)
 		msr_clear_bit(MSR_AMD64_CPUID_FN_7, 18);
 		pr_emerg("RDSEED is not reliable on this platform; disabling.\n");
 	}
+
+	/* Correct misconfigured CPUID on some clients. */
+	clear_cpu_cap(c, X86_FEATURE_INVLPGB);
 }
 
 static void init_amd_zen3(struct cpuinfo_x86 *c)

