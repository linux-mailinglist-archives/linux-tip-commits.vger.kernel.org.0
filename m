Return-Path: <linux-tip-commits+bounces-3069-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B49B89F206A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Dec 2024 19:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251DB167085
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Dec 2024 18:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF921A8F7B;
	Sat, 14 Dec 2024 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UyO67cLx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fl9WTib4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7521F170A13;
	Sat, 14 Dec 2024 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734202072; cv=none; b=dz6lNtObhYfnCel4V9J/fXvR3NaQ8bbcF1DwTRe5G9Lc6/PitsLcdEXGkhGzWB0ZbK9rIMgyt5WPI5Nq1I99ClHRkGuUOmviIcRgC8Yc8A/86UM8c1DMuae7KtrlbM+y1g0nBOiUlmb0Ndau0TDhyOJGjjyhDFQy3pq6krsXf9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734202072; c=relaxed/simple;
	bh=3G05AsXPIjvPIzOWNUgtbA7YI7kbUgl5kXn8B9Q/4es=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ua3jGHuhpGcbwsy/uLpQj0hhIouQzMqhLBrXYLhhK3dDOsxPnLgGodWuK1DSZ2W2G5t04hxmZKZhaKIwixqaA0+FFiVHopFLSJdGxURe/kVCn5tV1pyACxkKhA23+5z9zqLHv9jNSzVOEGDF/oyQ9B132YAOXfOj1QuMrUN+Hgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UyO67cLx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fl9WTib4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 14 Dec 2024 18:47:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734202068;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJb2WKnaE48+i6yAjI4ckOtIWsEgAu1NvcGVQq134QI=;
	b=UyO67cLxu/njoNisSVJjaMgAixmv0ZlKa6AwxNGK1kGsU5bG3OqCoP5po2wJXIsPwQjO0Y
	dDAL6tjoe9rWEVUPXCk/iG3bLqn0ZZoyKMZXcJq5Dc6TOXD9tz5X/R5bE/pCrxnDtbHxsl
	imxjj50SPRXZQLYntCGi9ym6BwpwkUD6U5ecOElsUOrDKKZyZtUtkI18cQQR61DK/AufJ8
	1JkhG/w87CaMTXnpk4HKPsnhm2Bui18k6WmCD4qlrDhYefr/BSZRlv0tIT8MzTuCxI4AGK
	1+H3elHMCB9t91MMYM/HWc3wWEWWt0a55yZKe6fZUmQECGlG0zp647s/rsMGvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734202068;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJb2WKnaE48+i6yAjI4ckOtIWsEgAu1NvcGVQq134QI=;
	b=Fl9WTib4WwRxFX5nVgzsDCKQOaGKeBC/pnTEDSTqwZrAaHSI+uHuV2jOZ8c9rn1W2/JdA+
	Qfhgo9QpIR96A2Bw==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev/docs: Document the SNP Reverse Map Table (RMP)
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Nikunj A Dadhania <nikunj@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cd3feea54912ad9ff2fc261223db691ca11fc547f=2E17331?=
 =?utf-8?q?72653=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cd3feea54912ad9ff2fc261223db691ca11fc547f=2E173317?=
 =?utf-8?q?2653=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173420206754.412.17982160297490423392.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     21fc6178e92070523e70fc5db59ac83806d269d6
Gitweb:        https://git.kernel.org/tip/21fc6178e92070523e70fc5db59ac83806d269d6
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 02 Dec 2024 14:50:53 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 14 Dec 2024 12:12:51 +01:00

x86/sev/docs: Document the SNP Reverse Map Table (RMP)

Update the AMD memory encryption documentation to include information on
the Reverse Map Table (RMP) and the two table formats.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Link: https://lore.kernel.org/r/d3feea54912ad9ff2fc261223db691ca11fc547f.1733172653.git.thomas.lendacky@amd.com
---
 Documentation/arch/x86/amd-memory-encryption.rst | 118 ++++++++++++++-
 1 file changed, 118 insertions(+)

diff --git a/Documentation/arch/x86/amd-memory-encryption.rst b/Documentation/arch/x86/amd-memory-encryption.rst
index 6df3264..bd840df 100644
--- a/Documentation/arch/x86/amd-memory-encryption.rst
+++ b/Documentation/arch/x86/amd-memory-encryption.rst
@@ -130,8 +130,126 @@ SNP feature support.
 
 More details in AMD64 APM[1] Vol 2: 15.34.10 SEV_STATUS MSR
 
+Reverse Map Table (RMP)
+=======================
+
+The RMP is a structure in system memory that is used to ensure a one-to-one
+mapping between system physical addresses and guest physical addresses. Each
+page of memory that is potentially assignable to guests has one entry within
+the RMP.
+
+The RMP table can be either contiguous in memory or a collection of segments
+in memory.
+
+Contiguous RMP
+--------------
+
+Support for this form of the RMP is present when support for SEV-SNP is
+present, which can be determined using the CPUID instruction::
+
+	0x8000001f[eax]:
+		Bit[4] indicates support for SEV-SNP
+
+The location of the RMP is identified to the hardware through two MSRs::
+
+        0xc0010132 (RMP_BASE):
+                System physical address of the first byte of the RMP
+
+        0xc0010133 (RMP_END):
+                System physical address of the last byte of the RMP
+
+Hardware requires that RMP_BASE and (RPM_END + 1) be 8KB aligned, but SEV
+firmware increases the alignment requirement to require a 1MB alignment.
+
+The RMP consists of a 16KB region used for processor bookkeeping followed
+by the RMP entries, which are 16 bytes in size. The size of the RMP
+determines the range of physical memory that the hypervisor can assign to
+SEV-SNP guests. The RMP covers the system physical address from::
+
+        0 to ((RMP_END + 1 - RMP_BASE - 16KB) / 16B) x 4KB.
+
+The current Linux support relies on BIOS to allocate/reserve the memory for
+the RMP and to set RMP_BASE and RMP_END appropriately. Linux uses the MSR
+values to locate the RMP and determine the size of the RMP. The RMP must
+cover all of system memory in order for Linux to enable SEV-SNP.
+
+Segmented RMP
+-------------
+
+Segmented RMP support is a new way of representing the layout of an RMP.
+Initial RMP support required the RMP table to be contiguous in memory.
+RMP accesses from a NUMA node on which the RMP doesn't reside
+can take longer than accesses from a NUMA node on which the RMP resides.
+Segmented RMP support allows the RMP entries to be located on the same
+node as the memory the RMP is covering, potentially reducing latency
+associated with accessing an RMP entry associated with the memory. Each
+RMP segment covers a specific range of system physical addresses.
+
+Support for this form of the RMP can be determined using the CPUID
+instruction::
+
+        0x8000001f[eax]:
+                Bit[23] indicates support for segmented RMP
+
+If supported, segmented RMP attributes can be found using the CPUID
+instruction::
+
+        0x80000025[eax]:
+                Bits[5:0]  minimum supported RMP segment size
+                Bits[11:6] maximum supported RMP segment size
+
+        0x80000025[ebx]:
+                Bits[9:0]  number of cacheable RMP segment definitions
+                Bit[10]    indicates if the number of cacheable RMP segments
+                           is a hard limit
+
+To enable a segmented RMP, a new MSR is available::
+
+        0xc0010136 (RMP_CFG):
+                Bit[0]     indicates if segmented RMP is enabled
+                Bits[13:8] contains the size of memory covered by an RMP
+                           segment (expressed as a power of 2)
+
+The RMP segment size defined in the RMP_CFG MSR applies to all segments
+of the RMP. Therefore each RMP segment covers a specific range of system
+physical addresses. For example, if the RMP_CFG MSR value is 0x2401, then
+the RMP segment coverage value is 0x24 => 36, meaning the size of memory
+covered by an RMP segment is 64GB (1 << 36). So the first RMP segment
+covers physical addresses from 0 to 0xF_FFFF_FFFF, the second RMP segment
+covers physical addresses from 0x10_0000_0000 to 0x1F_FFFF_FFFF, etc.
+
+When a segmented RMP is enabled, RMP_BASE points to the RMP bookkeeping
+area as it does today (16K in size). However, instead of RMP entries
+beginning immediately after the bookkeeping area, there is a 4K RMP
+segment table (RST). Each entry in the RST is 8-bytes in size and represents
+an RMP segment::
+
+        Bits[19:0]  mapped size (in GB)
+                    The mapped size can be less than the defined segment size.
+                    A value of zero, indicates that no RMP exists for the range
+                    of system physical addresses associated with this segment.
+        Bits[51:20] segment physical address
+                    This address is left shift 20-bits (or just masked when
+                    read) to form the physical address of the segment (1MB
+                    alignment).
+
+The RST can hold 512 segment entries but can be limited in size to the number
+of cacheable RMP segments (CPUID 0x80000025_EBX[9:0]) if the number of cacheable
+RMP segments is a hard limit (CPUID 0x80000025_EBX[10]).
+
+The current Linux support relies on BIOS to allocate/reserve the memory for
+the segmented RMP (the bookkeeping area, RST, and all segments), build the RST
+and to set RMP_BASE, RMP_END, and RMP_CFG appropriately. Linux uses the MSR
+values to locate the RMP and determine the size and location of the RMP
+segments. The RMP must cover all of system memory in order for Linux to enable
+SEV-SNP.
+
+More details in the AMD64 APM Vol 2, section "15.36.3 Reverse Map Table",
+docID: 24593.
+
 Secure VM Service Module (SVSM)
 ===============================
+
 SNP provides a feature called Virtual Machine Privilege Levels (VMPL) which
 defines four privilege levels at which guest software can run. The most
 privileged level is 0 and numerically higher numbers have lesser privileges.

