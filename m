Return-Path: <linux-tip-commits+bounces-1453-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E33290D4A1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 16:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65742286A1A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 14:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875431A38D0;
	Tue, 18 Jun 2024 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fHXMaMZL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BxRF/gBw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FBE1A2FA3;
	Tue, 18 Jun 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719314; cv=none; b=M2+EJgx/huntwCVF/g3u6h1Ib/UZohZ6PN2S5T+mfEQoXoctqCBd8hW3/UFHP30Nr+fgDC+jgbRtEshqnXk740QDjCpNleUEeCoZ/6N3afqJw0R3lQ7xaajGMn/D3gAOEneoG4CQ9z7Wen7pFfuuqwpUK6RtXtIvXz6zl6zp34Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719314; c=relaxed/simple;
	bh=cxsOhZdf6tudcacoKU9FzawkC0oB7JbfK8Nz/4oDvSo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j2O66MWe1ACjz7Lasa25NRDNw9Rozcfj255yQRqJMnrwmCRvFl5mWJB6nnwMDq9XvMRqbsTxCeeHotCZO3fmm5P/pHJNrWid7G0LbNINVRFEqxAWBx2566VlokxEBh/5KGJAL7iG4hQiRdgxqIaMhLoVb3epWU/5Xwop4VtxAg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fHXMaMZL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BxRF/gBw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 14:01:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718719300;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IRc3KN1z4wuB7Jojkd0E9VSIfgzDze61ufdwFazwcFQ=;
	b=fHXMaMZLhUjnVoU69pS4XO3IKBqFwnkAsZZLFN6LG8614DiXLaM+/YNLzzQ8ZWTU066MkP
	KIQb0ZvjxEvJYHTVPV6Ec7+rZ9R/BNUSB+vmrOTKE60gwXCxX9cvJC2UTA171eGSZmunAR
	G2Ve7WzABlNB+8oqVOkczZzcH6AtHpX4BA4aCMoNu0oAOnUL7cRZsJqq3SDD0w+ubqyRXn
	kcvO4t6AdZy1lyXf1twyfNVDe/jGq1c+lb119q4s2J8CHqkWoYNabeRSM0E5AztoNPYUAC
	rz6T9CG1ZN//PoYc6kOtlNE1o5WWEUAr5Zmfqfy8E9WuadgZnyNXZNx/4rjzSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718719300;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IRc3KN1z4wuB7Jojkd0E9VSIfgzDze61ufdwFazwcFQ=;
	b=BxRF/gBwbKuHRQMyMbFZcMtfnqBn5rJ7rss7h7oi0MR2WDmBt452OO845UFxoyMwTozJ/k
	WVANKYZoPUz8y8Bw==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cc] x86/mm: Make e820__end_ram_pfn() cover E820_TYPE_ACPI ranges
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
 Tao Liu <ltao@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240614095904.1345461-13-kirill.shutemov@linux.intel.com>
References: <20240614095904.1345461-13-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171871930040.10875.17107246519344852310.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     06fa48d85b09b3e67afeda220bc19f7102b53beb
Gitweb:        https://git.kernel.org/tip/06fa48d85b09b3e67afeda220bc19f7102b53beb
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 14 Jun 2024 12:58:57 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Jun 2024 17:46:08 +02:00

x86/mm: Make e820__end_ram_pfn() cover E820_TYPE_ACPI ranges

e820__end_of_ram_pfn() is used to calculate max_pfn which, among other things,
guides where direct mapping ends. Any memory above max_pfn is not going to be
present in the direct mapping.

e820__end_of_ram_pfn() finds the end of the RAM based on the highest
E820_TYPE_RAM range. But it doesn't includes E820_TYPE_ACPI ranges into
calculation.

Despite the name, E820_TYPE_ACPI covers not only ACPI data, but also EFI tables
and might be required by kernel to function properly.

Usually the problem is hidden because there is some E820_TYPE_RAM memory above
E820_TYPE_ACPI. But crashkernel only presents pre-allocated crash memory as
E820_TYPE_RAM on boot. If the pre-allocated range is small, it can fit under the
last E820_TYPE_ACPI range.

Modify e820__end_of_ram_pfn() and e820__end_of_low_ram_pfn() to cover
E820_TYPE_ACPI memory.

The problem was discovered during debugging kexec for TDX guest. TDX guest uses
E820_TYPE_ACPI to store the unaccepted memory bitmap and pass it between the
kernels on kexec.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Tested-by: Tao Liu <ltao@redhat.com>
Link: https://lore.kernel.org/r/20240614095904.1345461-13-kirill.shutemov@linux.intel.com
---
 arch/x86/kernel/e820.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 68b09f7..4893d30 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -828,7 +828,7 @@ u64 __init e820__memblock_alloc_reserved(u64 size, u64 align)
 /*
  * Find the highest page frame number we have available
  */
-static unsigned long __init e820_end_pfn(unsigned long limit_pfn, enum e820_type type)
+static unsigned long __init e820__end_ram_pfn(unsigned long limit_pfn)
 {
 	int i;
 	unsigned long last_pfn = 0;
@@ -839,7 +839,8 @@ static unsigned long __init e820_end_pfn(unsigned long limit_pfn, enum e820_type
 		unsigned long start_pfn;
 		unsigned long end_pfn;
 
-		if (entry->type != type)
+		if (entry->type != E820_TYPE_RAM &&
+		    entry->type != E820_TYPE_ACPI)
 			continue;
 
 		start_pfn = entry->addr >> PAGE_SHIFT;
@@ -865,12 +866,12 @@ static unsigned long __init e820_end_pfn(unsigned long limit_pfn, enum e820_type
 
 unsigned long __init e820__end_of_ram_pfn(void)
 {
-	return e820_end_pfn(MAX_ARCH_PFN, E820_TYPE_RAM);
+	return e820__end_ram_pfn(MAX_ARCH_PFN);
 }
 
 unsigned long __init e820__end_of_low_ram_pfn(void)
 {
-	return e820_end_pfn(1UL << (32 - PAGE_SHIFT), E820_TYPE_RAM);
+	return e820__end_ram_pfn(1UL << (32 - PAGE_SHIFT));
 }
 
 static void __init early_panic(char *msg)

