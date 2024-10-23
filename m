Return-Path: <linux-tip-commits+bounces-2532-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 633289AC89A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Oct 2024 13:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2435A28127F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Oct 2024 11:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3EE1AAE3F;
	Wed, 23 Oct 2024 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NentQEad";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f6EO7KOs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBC31AA794;
	Wed, 23 Oct 2024 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681654; cv=none; b=ND1s/F1otqjfcAO/YCRcKOQLLUV0qNzG8c3tfutTu5trY6Hw/NOQ07+pbiNlxbKEgLwGMUnQ9KpftTsdnnmia5Wmnz9v/SphlX7UHxAugRvZ1IWQzlTsDXayddQZY1XCUnTLn5jOuPqigsNjHrENtAEZxuwo+sSzSdDsb/GrVzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681654; c=relaxed/simple;
	bh=ZCs1fw9409QEi3f89nGi4CPcpH5nuzA0D3A8PqjG4KM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mhwrwF51Xn3pBPQFbx4sX6EeTNh9RgTs8xtodqQjsGBEzd03L/0H2RvryBFa41z/AUt211qcUW2aFcM2JGNOKiDyp4nBR6CXHHJTcjoJQrfyOMvdKNFFEkNpJzFL8S5BvqIY41x3SyT0yOcRQdcn3PcY5Yjhj3qUecfmYtS/T9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NentQEad; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f6EO7KOs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Oct 2024 11:07:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729681649;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/HthCsXsFcjXMcp9quteAwOAzrZwq88g/YRAokMF+RU=;
	b=NentQEadFqENSPSHEpKl8VFYQ5OaDUYcEjsgRXxmitMHItxgCVl+HANDCixyY07PwP8fDH
	bmkfFkd1x8jI5PTOEHawhlN2HtK+F5+vUsG4Maeq3h7qqTjSlU7vE8etWdfa29Lonr9WVy
	QOnkJfZ7PkhaYEOPwJZjoTfGUl1LKpT2+7O/1er6LuXiE2ndjIFHA5v/3BvDLi3l+JKMCx
	wsKpcZJvKb+6Tx/7elY0eey9B+mJSQ9dwzjY2mIMVIyBwspohEKXLuLGO8dB/CiaJH9u9l
	Wd448qm3IniYDtFixf8dwIZVJDR/A/x81Ki7Pp8vSbCHpJTVoJLUannDGxTseQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729681649;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/HthCsXsFcjXMcp9quteAwOAzrZwq88g/YRAokMF+RU=;
	b=f6EO7KOsiLuVQT/My7N/kMD18eA+a7iULqX9REjqTERnGkElHRQeKSkmvYMu+1xzjSWKgZ
	xSYrNfXkEZ4B5yAQ==
From: "tip-bot2 for Ashish Kalra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev: Ensure that RMP table fixups are reserved
Cc: Thomas Lendacky <thomas.lendacky@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
  <stable@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240815221630.131133-1-Ashish.Kalra@amd.com>
References: <20240815221630.131133-1-Ashish.Kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172968164814.1442.8035313578482871705.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     88a921aa3c6b006160d6a46a231b8b32227e8196
Gitweb:        https://git.kernel.org/tip/88a921aa3c6b006160d6a46a231b8b32227e8196
Author:        Ashish Kalra <ashish.kalra@amd.com>
AuthorDate:    Thu, 15 Aug 2024 22:16:30 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 23 Oct 2024 12:34:06 +02:00

x86/sev: Ensure that RMP table fixups are reserved

The BIOS reserves RMP table memory via e820 reservations. This can still lead
to RMP page faults during kexec if the host tries to access memory within the
same 2MB region.

Commit

  400fea4b9651 ("x86/sev: Add callback to apply RMP table fixups for kexec"

adjusts the e820 reservations for the RMP table so that the entire 2MB range
at the start/end of the RMP table is marked reserved.

The e820 reservations are then passed to firmware via SNP_INIT where they get
marked HV-Fixed.

The RMP table fixups are done after the e820 ranges have been added to
memblock, allowing the fixup ranges to still be allocated and used by the
system.

The problem is that this memory range is now marked reserved in the e820
tables and during SNP initialization these reserved ranges are marked as
HV-Fixed.  This means that the pages cannot be used by an SNP guest, only by
the hypervisor.

However, the memory management subsystem does not make this distinction and
can allocate one of those pages to an SNP guest. This will ultimately result
in RMPUPDATE failures associated with the guest, causing it to fail to start
or terminate when accessing the HV-Fixed page.

The issue is captured below with memblock=debug:

  [    0.000000] SEV-SNP: *** DEBUG: snp_probe_rmptable_info:352 - rmp_base=0x280d4800000, rmp_end=0x28357efffff
  ...
  [    0.000000] BIOS-provided physical RAM map:
  ...
  [    0.000000] BIOS-e820: [mem 0x00000280d4800000-0x0000028357efffff] reserved
  [    0.000000] BIOS-e820: [mem 0x0000028357f00000-0x0000028357ffffff] usable
  ...
  ...
  [    0.183593] memblock add: [0x0000028357f00000-0x0000028357ffffff] e820__memblock_setup+0x74/0xb0
  ...
  [    0.203179] MEMBLOCK configuration:
  [    0.207057]  memory size = 0x0000027d0d194000 reserved size = 0x0000000009ed2c00
  [    0.215299]  memory.cnt  = 0xb
  ...
  [    0.311192]  memory[0x9]     [0x0000028357f00000-0x0000028357ffffff], 0x0000000000100000 bytes flags: 0x0
  ...
  ...
  [    0.419110] SEV-SNP: Reserving start/end of RMP table on a 2MB boundary [0x0000028357e00000]
  [    0.428514] e820: update [mem 0x28357e00000-0x28357ffffff] usable ==> reserved
  [    0.428517] e820: update [mem 0x28357e00000-0x28357ffffff] usable ==> reserved
  [    0.428520] e820: update [mem 0x28357e00000-0x28357ffffff] usable ==> reserved
  ...
  ...
  [    5.604051] MEMBLOCK configuration:
  [    5.607922]  memory size = 0x0000027d0d194000 reserved size = 0x0000000011faae02
  [    5.616163]  memory.cnt  = 0xe
  ...
  [    5.754525]  memory[0xc]     [0x0000028357f00000-0x0000028357ffffff], 0x0000000000100000 bytes on node 0 flags: 0x0
  ...
  ...
  [   10.080295] Early memory node ranges[   10.168065]
  ...
  node   0: [mem 0x0000028357f00000-0x0000028357ffffff]
  ...
  ...
  [ 8149.348948] SEV-SNP: RMPUPDATE failed for PFN 28357f7c, pg_level: 1, ret: 2

As shown above, the memblock allocations show 1MB after the end of the RMP as
available for allocation, which is what the RMP table fixups have reserved.
This memory range subsequently gets allocated as SNP guest memory, resulting
in an RMPUPDATE failure.

This can potentially be fixed by not reserving the memory range in the e820
table, but that causes kexec failures when using the KEXEC_FILE_LOAD syscall.

The solution is to use memblock_reserve() to mark the memory reserved for the
system, ensuring that it cannot be allocated to an SNP guest.

Since HV-Fixed memory is still readable/writable by the host, this only ends
up being a problem if the memory in this range requires a page state change,
which generally will only happen when allocating memory in this range to be
used for running SNP guests, which is now possible with the SNP hypervisor
support in kernel 6.11.

Backporter note:

Fixes tag points to a 6.9 change but as the last paragraph above explains,
this whole thing can happen after 6.11 received SNP HV support, therefore
backporting to 6.9 is not really necessary.

  [ bp: Massage commit message. ]

Fixes: 400fea4b9651 ("x86/sev: Add callback to apply RMP table fixups for kexec")
Suggested-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: <stable@kernel.org> # 6.11, see Backporter note above.
Link: https://lore.kernel.org/r/20240815221630.131133-1-Ashish.Kalra@amd.com
---
 arch/x86/virt/svm/sev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 0ce1776..9a6a943 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -173,6 +173,8 @@ static void __init __snp_fixup_e820_tables(u64 pa)
 		e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
 		e820__range_update_table(e820_table_kexec, pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
 		e820__range_update_table(e820_table_firmware, pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
+		if (!memblock_is_region_reserved(pa, PMD_SIZE))
+			memblock_reserve(pa, PMD_SIZE);
 	}
 }
 

