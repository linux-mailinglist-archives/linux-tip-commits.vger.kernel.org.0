Return-Path: <linux-tip-commits+bounces-2636-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2B29B47CB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 12:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFC42848F1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 11:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D785205E24;
	Tue, 29 Oct 2024 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O0mbOpre";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lEdMhMtK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51769204920;
	Tue, 29 Oct 2024 11:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199657; cv=none; b=i43XnkaYLlWESR0FEAb1nWbnP3m2zPqWvK2k8NJBpt/HnZGwwl1krnr4Dkw5bhaVSLBR9wzKDWHcMLP9eo/BPhAPzm1ksfyo6w4rxUCd60HbIM6pT8lZxRtqZMQwazvtT/X3SCytCgVJHFPar9i4yjP04k9taGXbf7Nl9SRKPi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199657; c=relaxed/simple;
	bh=d0Z4ObN46Fk8U2e4ZoISVPyhtpk5snmnYYWX1Qwtyyg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UmNZ3z/3sh9alVheQYTl1iA203FNDGQApPqtzxwcdcd+3g8j2vAOrChqd4m4QXHCkln3PkFL3YRcyFtiyHniO76Ukp/gfvJanZJHKZnjHYbahgxvooivhzlaC7FQ0JuucbF7P8kZkxZkMxmaHwkjJJch23TX3E9epXtWckYheXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O0mbOpre; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lEdMhMtK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 29 Oct 2024 11:00:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730199653;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mId0OUh17dofr+uBJPBqWZKxuWE5fkaKVwATqueCyz4=;
	b=O0mbOpretIv8aOn0DE/a5ym040aABkcOySUoji+Q5Zs8RspMPL9PG0FyeADa4i/IvbxVB2
	5jv/Tn/+XfdPYBAYNv+K+j0N1uhInANAJEcPQlWwj2FTnJD1cJTkctjEOBzJ7RSkZaLKBp
	g2ufvHTMebJiYBNvekft3Uo58m3O7PbVme5IXGpwYw3jE0AC6fezIPw9e+zWwedO6hH2h6
	pFm9KRuC6bxoVbAt0x19GiDxBtgEVDit46TLPWjawGt78MYW5OSUhAdr4ACc5pfOrllM2c
	QnnzmyW3e3d5OGmohH0JSl1XqzTrBLp+nD6we9EIIwi7fMIzEFUi1d2wBlqRXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730199653;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mId0OUh17dofr+uBJPBqWZKxuWE5fkaKVwATqueCyz4=;
	b=lEdMhMtKoZLBFiQ4HIm/iTfsLs188pUP6TdLl81EDAmEv4pHiQF70xuZc41CA8jjcJzwUB
	eeCdbq3jDARii1Bw==
From: "tip-bot2 for Ashish Kalra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/boot: Skip video memory access in the decompressor
 for SEV-ES/SNP
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Thomas Lendacky <thomas.lendacky@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C8a55ea86524c686e575d273311acbe57ce8cee23=2E17225?=
 =?utf-8?q?20012=2Egit=2Eashish=2Ekalra=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C8a55ea86524c686e575d273311acbe57ce8cee23=2E172252?=
 =?utf-8?q?0012=2Egit=2Eashish=2Ekalra=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173019965256.1442.17892938606871476783.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     f30470c190c2f4776e0baeba1f53fd8dd3820394
Gitweb:        https://git.kernel.org/tip/f30470c190c2f4776e0baeba1f53fd8dd3820394
Author:        Ashish Kalra <ashish.kalra@amd.com>
AuthorDate:    Thu, 01 Aug 2024 19:14:17 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 28 Oct 2024 16:54:16 +01:00

x86/boot: Skip video memory access in the decompressor for SEV-ES/SNP

Accessing guest video memory/RAM in the decompressor causes guest
termination as the boot stage2 #VC handler for SEV-ES/SNP systems does
not support MMIO handling.

This issue is observed during a SEV-ES/SNP guest kexec as kexec -c adds
screen_info to the boot parameters passed to the second kernel, which
causes console output to be dumped to both video and serial.

As the decompressor output gets cleared really fast, it is preferable to
get the console output only on serial, hence, skip accessing the video
RAM during decompressor stage to prevent guest termination.

Serial console output during decompressor stage works as boot stage2 #VC
handler already supports handling port I/O.

  [ bp: Massage. ]

Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
Suggested-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/8a55ea86524c686e575d273311acbe57ce8cee23.1722520012.git.ashish.kalra@amd.com
---
 arch/x86/boot/compressed/misc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 04a35b2..0d37420 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -385,6 +385,19 @@ static void parse_mem_encrypt(struct setup_header *hdr)
 		hdr->xloadflags |= XLF_MEM_ENCRYPTION;
 }
 
+static void early_sev_detect(void)
+{
+	/*
+	 * Accessing video memory causes guest termination because
+	 * the boot stage2 #VC handler of SEV-ES/SNP guests does not
+	 * support MMIO handling and kexec -c adds screen_info to the
+	 * boot parameters passed to the kexec kernel, which causes
+	 * console output to be dumped to both video and serial.
+	 */
+	if (sev_status & MSR_AMD64_SEV_ES_ENABLED)
+		lines = cols = 0;
+}
+
 /*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
@@ -440,6 +453,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	 */
 	early_tdx_detect();
 
+	early_sev_detect();
+
 	console_init();
 
 	/*

