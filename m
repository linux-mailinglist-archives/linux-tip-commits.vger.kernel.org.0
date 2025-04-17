Return-Path: <linux-tip-commits+bounces-5047-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D189A92589
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 20:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8BFC4672E6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 18:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C40256C79;
	Thu, 17 Apr 2025 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hIvKH9gK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d7pVJp6/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD67B19F40A;
	Thu, 17 Apr 2025 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913008; cv=none; b=bqWbOBnnmuDyXj9YgSawk5MmUi6xUjFPnyFxkrGfD2yTBkAQPtlx+VNArGGG426VA4f91d6jr2cPlLqYFf8ki5o9Rb6J1I+h9nib+Jm7dSrxoVd93IGxKVaHSRuZlNnLIVSxQCAx8J43AxIhP+ljiOyuqJ2RAFUlbSrawVJsqBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913008; c=relaxed/simple;
	bh=ANL1Toy+0ImBXUuxPswm+sLTAmgl/8PughozZYIOgi8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=jbT9FfT9cX9jibAxFlmNGR8NoRsPOaFlPHVmjQ8HdS3FDADF2iHhb5nN1ejrZIcIyPHJ93wUndcai0rE+GOppuiv1Os+tEfnt2tCJBOOL6t32w3tfTA2sdavb5eKnN8SxIvKMlWlD2oERRw+Lut+M0fHAvIUqaTH4UbRD9C6sEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hIvKH9gK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d7pVJp6/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 18:03:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744913004;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cdIGvKpuC1EB/I008YvHqoLyHnLf5RaklvgzjVg2jl0=;
	b=hIvKH9gKp58z/265EcSt1OK446drUhuhsKLcF72xRVYvgc8YCnCdso1O4rRPta3fJoaSHS
	OCHrpWxxp+l9c/DzIVr6FLNaxTu/GVA6Q/ioQLvf+CoZxgrHCi5LfDL8tt4o9mdQ/VmtTf
	HEirJCxFh+D2wU/AeTExxss5haqiJa9exAPUb3Lbckd1WF9JMDHgQsqgIlDESmluUegWUi
	GhNQ46hrcE2Rnu6goH6ck8ZYT2YOB7ME1B7UOwEfwXZDbBLhKvRF08bUuRgcA/8FLln7mQ
	xGKkbMrJtdtOKq9fsD/1YBI3Nc7J2/21w/JkKHVm02n1fpFGbPkG3+ohFHUjNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744913004;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cdIGvKpuC1EB/I008YvHqoLyHnLf5RaklvgzjVg2jl0=;
	b=d7pVJp6/ExZ/aCSsmNurEBFI6goaYzqZ6ykTNXegkG2UQ77w1zFufCI9DxUJGW8Wm75TtB
	SlOH2H0o91nf17Aw==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Remove now unused SHARED_KERNEL_PMD
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174491299957.31282.7588811518982055862.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     eaa607deb29e0b6fd24b9adf230fbc765f342521
Gitweb:        https://git.kernel.org/tip/eaa607deb29e0b6fd24b9adf230fbc765f342521
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Mon, 14 Apr 2025 10:32:44 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 17 Apr 2025 10:39:25 -07:00

x86/mm: Remove now unused SHARED_KERNEL_PMD

All the users of SHARED_KERNEL_PMD are gone. Zap it.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20250414173244.1125BEC3%40davehans-spike.ostc.intel.com
---
 arch/x86/include/asm/pgtable-2level_types.h | 2 --
 arch/x86/include/asm/pgtable-3level_types.h | 2 --
 arch/x86/include/asm/pgtable_64_types.h     | 2 --
 3 files changed, 6 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-2level_types.h b/arch/x86/include/asm/pgtable-2level_types.h
index 6642542..54690bd 100644
--- a/arch/x86/include/asm/pgtable-2level_types.h
+++ b/arch/x86/include/asm/pgtable-2level_types.h
@@ -18,8 +18,6 @@ typedef union {
 } pte_t;
 #endif	/* !__ASSEMBLER__ */
 
-#define SHARED_KERNEL_PMD	0
-
 #define ARCH_PAGE_TABLE_SYNC_MASK	PGTBL_PMD_MODIFIED
 
 /*
diff --git a/arch/x86/include/asm/pgtable-3level_types.h b/arch/x86/include/asm/pgtable-3level_types.h
index 9759fa0..580b09b 100644
--- a/arch/x86/include/asm/pgtable-3level_types.h
+++ b/arch/x86/include/asm/pgtable-3level_types.h
@@ -27,8 +27,6 @@ typedef union {
 } pmd_t;
 #endif	/* !__ASSEMBLER__ */
 
-#define SHARED_KERNEL_PMD	(!static_cpu_has(X86_FEATURE_PTI))
-
 #define ARCH_PAGE_TABLE_SYNC_MASK	PGTBL_PMD_MODIFIED
 
 /*
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 5bb782d..e83721d 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -46,8 +46,6 @@ extern unsigned int ptrs_per_p4d;
 
 #endif	/* !__ASSEMBLER__ */
 
-#define SHARED_KERNEL_PMD	0
-
 #ifdef CONFIG_X86_5LEVEL
 
 /*

