Return-Path: <linux-tip-commits+bounces-6031-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9757AFCE2C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 16:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0E4A3A64BF
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 14:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E431E521B;
	Tue,  8 Jul 2025 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oA8Q5VFZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F5CBpyFU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D412DC33F;
	Tue,  8 Jul 2025 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986236; cv=none; b=IlK8Vk3S2xsqMMtFIZnda9dKFAnLNuIMqDdkq+C3KKe6GJl3HMQC2dHC6AdjBQsmCbteCnFhClhsyTz3vbKw9Ml3Q1UL4st1gMOrFD33BSlTWlLgNrmK0SqyRbwYJ4nJ3CJ5UasDJDXhhKGTXvfPlhHTBJsrR7owCvkxTRS41Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986236; c=relaxed/simple;
	bh=30EX7jJESKsjwkWzWViCv6tuvmFjkRhzQYntrJlibVs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jLEkPGJ4m7ETx5oSgU06jaPCvapMz7enW7L+jaaSiboxfHHRkAMKMFlrq488h0AJOr4n+uZ7xSPOXXP/03esGR8rUPkAPicLnM3N6Sg12o7e9iNnfkzTnEhw49fFHhvlZk4EjWTePEe7Mo9YsFRbvNVUd/tpUH3I7/DpkUHtPk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oA8Q5VFZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F5CBpyFU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 14:50:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751986232;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tcv9dUt6DW9SX2+bc7Jc3KQ/LRNkUdpgQgaLI3kv24=;
	b=oA8Q5VFZN4E19adxZb7l6Ra4HJn5IBagVI2Esqo4CF4VxeB7eWdRVFbC/hLKnCD2rcNmwj
	kk3pArnCqlezZeYUsA2HZ7JOBwLAsQkgOHCxnooFXfrAQ6vUuzdIMsTTf7luFzFaK5zhul
	StyOjopQdMsrs+lof1Nh91Rc6Pjp4NLjxVcG3HSJEFd7F9IBB7RZSAiz5uufs07cFgko3F
	iXruh8nTklsJVwF2ZrBOdeFoINxR43qj8Ob9RA3YYBxBMD/6b405EhGH4qbIPEHpQH/TUF
	qGvTuVrSGjkMIRo45HKM9euQIoQbALqE0m1uV/1T5aD0N2wVhDaX+ddi4/7S+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751986232;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tcv9dUt6DW9SX2+bc7Jc3KQ/LRNkUdpgQgaLI3kv24=;
	b=F5CBpyFUbF+ANa6opJrZLzoKPsO45gd1SyTObkgTXqsRYRsagICPOxmuSdRzA3jBCjEq4p
	eI3U+pDFW3XKOVAw==
From: "tip-bot2 for Mikhail Paulyshka" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/CPU/AMD: Disable INVLPGB on Zen2
Cc: Mikhail Paulyshka <me@mixaill.net>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1ebe845b-322b-4929-9093-b41074e9e939@mixaill.net>
References: <1ebe845b-322b-4929-9093-b41074e9e939@mixaill.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175198623117.406.3528096569299632559.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     5a97aa3a4f1f19656aea5c76c1da66ce9dc5ddaf
Gitweb:        https://git.kernel.org/tip/5a97aa3a4f1f19656aea5c76c1da66ce9dc5ddaf
Author:        Mikhail Paulyshka <me@mixaill.net>
AuthorDate:    Tue, 08 Jul 2025 16:39:10 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 08 Jul 2025 16:41:59 +02:00

x86/CPU/AMD: Disable INVLPGB on Zen2

AMD Cyan Skillfish (Family 17h, Model 47h, Stepping 0h) has an issue
that causes system oopses and panics when performing TLB flush using
INVLPGB.

However, the problem is that that machine has misconfigured CPUID and
should not report the INVLPGB bit in the first place. So zap the
kernel's representation of the flag so that nothing gets confused.

  [ bp: Massage. ]

Signed-off-by: Mikhail Paulyshka <me@mixaill.net>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
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

