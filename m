Return-Path: <linux-tip-commits+bounces-3150-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9209FE94F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Dec 2024 18:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7044161128
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Dec 2024 17:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D89194094;
	Mon, 30 Dec 2024 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y6r63GLn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2+8dBPpN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF1C33C9;
	Mon, 30 Dec 2024 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735578171; cv=none; b=QCnpvCWEofVpTzezMzqaLlYkl9l2vaRTbC1L9GQSNC6svs0mLxV9jwssWzZwh4Aqlk7E7iTUd9sMNs5cBVtI/SygxEu2IHyvZt4JmaVYoU/BRVkHChOEnmEi6OmelqLHf/I29Aa+31LmJUuAwxZ4XaTJFm6byK2232QvJuWTsiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735578171; c=relaxed/simple;
	bh=cQu8gUYn7oDKJSDmjffSsvA0zh+1IJZhOv6rmht78Sc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uQdUM7sk89XCo0MxXbKGwzeV0XudjS1JkYpk2YRlS6X2e7aw95BwIHWBJ/jZrRjU8CLJUkNoX97Ib90lrjq0M/NblrZn/TjK5UYtznIAzumT0tcI8cxgPRMbfXnwEDZopYBA70YjMycgasTzwYTian4URCePeUyhv7K1wSELyFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y6r63GLn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2+8dBPpN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Dec 2024 17:02:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735578167;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYtOO/74kZ2CO6GKwtEwiJiEVEoxgoEtdq6cU94w7es=;
	b=Y6r63GLnUzlmYe+OeAp5NpNGqRLsk9pj5YMKvjSro2o9DY67h3XKQiUc+RQV8MEGKr6FHB
	sfuOyxwiuAQ78Q1oAZdrxoiPdBNQt5A+ik+Z1g69YHh8GmW2DgYS7+oWbbqXFqpbDPEzB5
	hwgSicaoHS+2uCGKMl96EcuZyJr6vyIz7Bol8TpbwLJkeMPgn2m9vtlKJanOrLIOsztewN
	keYtdzHrKHJ1pW/m4SlTf16RWwXtEnvZt9Ts+jcecpO5G9xn6JBta8cAJy+zzmBauDrpA8
	uc5zWNE0tO29jXaR+Hv/K0i5zjFWusFCBHJve0aWd1r4Mi9swoY0FnCbbavnUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735578167;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYtOO/74kZ2CO6GKwtEwiJiEVEoxgoEtdq6cU94w7es=;
	b=2+8dBPpNNtGYUJYgWIxv0CdUZFfiuJRVtSDBRWbbtWkQmK6/F3ahnv/dIL2aY32EbVkDHS
	1e+aJkhIHlzRSDBA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] KVM: x86: Advertise SRSO_USER_KERNEL_NO to userspace
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241202120416.6054-3-bp@kernel.org>
References: <20241202120416.6054-3-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173557816376.399.2112285867166912291.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     716f86b523d8ec3c17015ee0b03135c7aa6f2f08
Gitweb:        https://git.kernel.org/tip/716f86b523d8ec3c17015ee0b03135c7aa6f2f08
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 13 Nov 2024 13:28:33 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 30 Dec 2024 17:56:00 +01:00

KVM: x86: Advertise SRSO_USER_KERNEL_NO to userspace

SRSO_USER_KERNEL_NO denotes whether the CPU is affected by SRSO across
user/kernel boundaries. Advertise it to guest userspace.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/20241202120416.6054-3-bp@kernel.org
---
 arch/x86/kvm/cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index ae0b438..f7e2229 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -821,7 +821,7 @@ void kvm_set_cpu_caps(void)
 	kvm_cpu_cap_mask(CPUID_8000_0021_EAX,
 		F(NO_NESTED_DATA_BP) | F(LFENCE_RDTSC) | 0 /* SmmPgCfgLock */ |
 		F(NULL_SEL_CLR_BASE) | F(AUTOIBRS) | 0 /* PrefetchCtlMsr */ |
-		F(WRMSR_XX_BASE_NS)
+		F(WRMSR_XX_BASE_NS) | F(SRSO_USER_KERNEL_NO)
 	);
 
 	kvm_cpu_cap_check_and_set(X86_FEATURE_SBPB);

