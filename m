Return-Path: <linux-tip-commits+bounces-6303-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384F8B2E832
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Aug 2025 00:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8FB5C7846
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 22:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17D7242D6E;
	Wed, 20 Aug 2025 22:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y+m6NGiw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="beJbbedK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC731D86DC;
	Wed, 20 Aug 2025 22:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755729075; cv=none; b=uRESeepWjAypNatkIHPJqNAjavr2kVhuL2O7UgrVTDlpP4Zr6xyxiaAoVZFhvUM8/XuqUqfbQhSWUb5p75E/alyeBAKjeTQZzfqdaS0Y253L2cdo6Gos96XBbimhNEf6AGv4ZHlSMN17iQHg1896D9jGXDFmBQMiWdpDJ53gUMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755729075; c=relaxed/simple;
	bh=eBN6CmGu/BlA46l7oAyCvP0wJsOgebWNxZ9xk/aRIEs=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Mab9KWPe1ikxnFz3sCcVipGMOtvpxq47mMWJSqsPtqoK/P7WkPMl2NW01l+pU/ilnsRwH8zDxfL8AZirVotrJfpSGH5UmN4G5SWXsVBveMoCwjl0LU2/lV/Fa4vvMhjaf/djxY2H/FbWs4ohfTHhgO9B9dwaJ3Mkf8iKHgQJ1tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y+m6NGiw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=beJbbedK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Aug 2025 22:31:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755729069;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=l3iRSH+zOB5/NqxJtUwVrpa4XBiV8Dl1voex2EWu8Yw=;
	b=y+m6NGiwoG2I7ujQBx78dUnWR/eTyvGMs3YH5b3ZA4eRrXJp7Q7wwETk6vhUggIj8yznqD
	KYMcqi5ZKRMvgBsI/yGi7cyg0frPwnooUEtkjUyP8XVwhbcliEh8yQljzZf1glpdXU6kIU
	m//KBG0sGvtYMvikjsOKXWJXhZnUZ5v5xlPdCruuOPHDDobuQ+ZjhLLHGf5qfE9qRnF2dl
	U8vKZq4MhKczsxGj5surBw6W1rMpCwyKMxCJlq6MsVGhY/XBMLbgnlNDW1+zJsq+3UGAoX
	42aRLYvlguKm28ebEBKaKP8Qn64tvmXeITUfdKdN3w3cSMr78wrVdQEmyYbNrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755729069;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=l3iRSH+zOB5/NqxJtUwVrpa4XBiV8Dl1voex2EWu8Yw=;
	b=beJbbedKTSLSixg+Fxb6ii4xbAXf2By+42U6BoHjkCKHPG53yYJrkjbARSTizmfmmf5cFM
	FjCcOdSAf3QqOXBw==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Refresh the revisions that
 determine old_microcode
Cc: Sohil Mehta <sohil.mehta@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175572906735.1420.8346253834412468730.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     952df63ef426b21d6da14bb48748f12b0ae2fe36
Gitweb:        https://git.kernel.org/tip/952df63ef426b21d6da14bb48748f12b0ae=
2fe36
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Mon, 18 Aug 2025 12:01:36 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 20 Aug 2025 15:11:48 -07:00

x86/microcode/intel: Refresh the revisions that determine old_microcode

Update the minimum expected revisions of Intel microcode based on the
microcode-20250512 (May 2025) release.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20250818190137.3525414-2-sohil.mehta%40inte=
l.com
---
 arch/x86/kernel/cpu/microcode/intel-ucode-defs.h | 86 ++++++++-------
 1 file changed, 48 insertions(+), 38 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h b/arch/x86/kern=
el/cpu/microcode/intel-ucode-defs.h
index cb6e601..2d48e65 100644
--- a/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h
+++ b/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h
@@ -67,9 +67,8 @@
 { .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x55, .steppings =3D 0x0008, .driver_data =3D 0x1000=
191 },
 { .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x55, .steppings =3D 0x0010, .driver_data =3D 0x2007=
006 },
 { .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x55, .steppings =3D 0x0020, .driver_data =3D 0x3000=
010 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x55, .steppings =3D 0x0040, .driver_data =3D 0x4003=
605 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x55, .steppings =3D 0x0080, .driver_data =3D 0x5003=
707 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x55, .steppings =3D 0x0800, .driver_data =3D 0x7002=
904 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x55, .steppings =3D 0x0080, .driver_data =3D 0x5003=
901 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x55, .steppings =3D 0x0800, .driver_data =3D 0x7002=
b01 },
 { .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x56, .steppings =3D 0x0004, .driver_data =3D 0x1c },
 { .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x56, .steppings =3D 0x0008, .driver_data =3D 0x7000=
01c },
 { .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x56, .steppings =3D 0x0010, .driver_data =3D 0xf000=
01a },
@@ -81,51 +80,62 @@
 { .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x5f, .steppings =3D 0x0002, .driver_data =3D 0x3e },
 { .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x66, .steppings =3D 0x0008, .driver_data =3D 0x2a },
 { .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x6a, .steppings =3D 0x0020, .driver_data =3D 0xc000=
2f0 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x6a, .steppings =3D 0x0040, .driver_data =3D 0xd000=
3e7 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x6c, .steppings =3D 0x0002, .driver_data =3D 0x1000=
2b0 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x6a, .steppings =3D 0x0040, .driver_data =3D 0xd000=
404 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x6c, .steppings =3D 0x0002, .driver_data =3D 0x1000=
2d0 },
 { .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x7a, .steppings =3D 0x0002, .driver_data =3D 0x42 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x7a, .steppings =3D 0x0100, .driver_data =3D 0x24 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x7e, .steppings =3D 0x0020, .driver_data =3D 0xc6 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x7a, .steppings =3D 0x0100, .driver_data =3D 0x26 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x7e, .steppings =3D 0x0020, .driver_data =3D 0xca },
 { .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8a, .steppings =3D 0x0002, .driver_data =3D 0x33 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8c, .steppings =3D 0x0002, .driver_data =3D 0xb8 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8c, .steppings =3D 0x0004, .driver_data =3D 0x38 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8d, .steppings =3D 0x0002, .driver_data =3D 0x52 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8c, .steppings =3D 0x0002, .driver_data =3D 0xbc },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8c, .steppings =3D 0x0004, .driver_data =3D 0x3c },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8d, .steppings =3D 0x0002, .driver_data =3D 0x56 },
 { .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8e, .steppings =3D 0x0200, .driver_data =3D 0xf6 },
 { .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8e, .steppings =3D 0x0400, .driver_data =3D 0xf6 },
 { .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8e, .steppings =3D 0x0800, .driver_data =3D 0xf6 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8e, .steppings =3D 0x1000, .driver_data =3D 0xfc },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8f, .steppings =3D 0x0100, .driver_data =3D 0x2c00=
0390 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8f, .steppings =3D 0x0080, .driver_data =3D 0x2b00=
0603 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8f, .steppings =3D 0x0040, .driver_data =3D 0x2c00=
0390 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8f, .steppings =3D 0x0020, .driver_data =3D 0x2c00=
0390 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8f, .steppings =3D 0x0010, .driver_data =3D 0x2c00=
0390 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8e, .steppings =3D 0x1000, .driver_data =3D 0x100 =
},
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8f, .steppings =3D 0x0010, .driver_data =3D 0x2c00=
03f7 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8f, .steppings =3D 0x0020, .driver_data =3D 0x2c00=
03f7 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8f, .steppings =3D 0x0040, .driver_data =3D 0x2c00=
03f7 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8f, .steppings =3D 0x0080, .driver_data =3D 0x2b00=
0639 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x8f, .steppings =3D 0x0100, .driver_data =3D 0x2c00=
03f7 },
 { .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x96, .steppings =3D 0x0002, .driver_data =3D 0x1a },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x97, .steppings =3D 0x0004, .driver_data =3D 0x37 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x97, .steppings =3D 0x0020, .driver_data =3D 0x37 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xbf, .steppings =3D 0x0004, .driver_data =3D 0x37 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xbf, .steppings =3D 0x0020, .driver_data =3D 0x37 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9a, .steppings =3D 0x0008, .driver_data =3D 0x435 =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9a, .steppings =3D 0x0010, .driver_data =3D 0x435 =
},
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x97, .steppings =3D 0x0004, .driver_data =3D 0x3a },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x97, .steppings =3D 0x0020, .driver_data =3D 0x3a },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9a, .steppings =3D 0x0008, .driver_data =3D 0x437 =
},
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9a, .steppings =3D 0x0010, .driver_data =3D 0x437 =
},
 { .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9c, .steppings =3D 0x0001, .driver_data =3D 0x2400=
0026 },
 { .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9e, .steppings =3D 0x0200, .driver_data =3D 0xf8 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9e, .steppings =3D 0x0400, .driver_data =3D 0xf8 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9e, .steppings =3D 0x0400, .driver_data =3D 0xfa },
 { .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9e, .steppings =3D 0x0800, .driver_data =3D 0xf6 },
 { .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9e, .steppings =3D 0x1000, .driver_data =3D 0xf8 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9e, .steppings =3D 0x2000, .driver_data =3D 0x100 =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xa5, .steppings =3D 0x0004, .driver_data =3D 0xfc },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xa5, .steppings =3D 0x0008, .driver_data =3D 0xfc },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xa5, .steppings =3D 0x0020, .driver_data =3D 0xfc },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xa6, .steppings =3D 0x0001, .driver_data =3D 0xfe },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xa6, .steppings =3D 0x0002, .driver_data =3D 0xfc },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xa7, .steppings =3D 0x0002, .driver_data =3D 0x62 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xaa, .steppings =3D 0x0010, .driver_data =3D 0x20 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xb7, .steppings =3D 0x0002, .driver_data =3D 0x12b =
},
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xba, .steppings =3D 0x0004, .driver_data =3D 0x4123=
 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xba, .steppings =3D 0x0008, .driver_data =3D 0x4123=
 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xba, .steppings =3D 0x0100, .driver_data =3D 0x4123=
 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xbe, .steppings =3D 0x0001, .driver_data =3D 0x1a },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xcf, .steppings =3D 0x0004, .driver_data =3D 0x2100=
0283 },
-{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xcf, .steppings =3D 0x0002, .driver_data =3D 0x2100=
0283 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0x9e, .steppings =3D 0x2000, .driver_data =3D 0x104 =
},
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xa5, .steppings =3D 0x0004, .driver_data =3D 0x100 =
},
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xa5, .steppings =3D 0x0008, .driver_data =3D 0x100 =
},
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xa5, .steppings =3D 0x0020, .driver_data =3D 0x100 =
},
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xa6, .steppings =3D 0x0001, .driver_data =3D 0x102 =
},
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xa6, .steppings =3D 0x0002, .driver_data =3D 0x100 =
},
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xa7, .steppings =3D 0x0002, .driver_data =3D 0x64 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xaa, .steppings =3D 0x0010, .driver_data =3D 0x24 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xad, .steppings =3D 0x0002, .driver_data =3D 0xa000=
0d1 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xaf, .steppings =3D 0x0008, .driver_data =3D 0x3000=
341 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xb5, .steppings =3D 0x0001, .driver_data =3D 0xa },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xb7, .steppings =3D 0x0002, .driver_data =3D 0x12f =
},
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xb7, .steppings =3D 0x0010, .driver_data =3D 0x12f =
},
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xba, .steppings =3D 0x0004, .driver_data =3D 0x4128=
 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xba, .steppings =3D 0x0008, .driver_data =3D 0x4128=
 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xba, .steppings =3D 0x0100, .driver_data =3D 0x4128=
 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xbd, .steppings =3D 0x0002, .driver_data =3D 0x11f =
},
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xbe, .steppings =3D 0x0001, .driver_data =3D 0x1d },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xbf, .steppings =3D 0x0004, .driver_data =3D 0x3a },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xbf, .steppings =3D 0x0020, .driver_data =3D 0x3a },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xbf, .steppings =3D 0x0040, .driver_data =3D 0x3a },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xbf, .steppings =3D 0x0080, .driver_data =3D 0x3a },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xc5, .steppings =3D 0x0004, .driver_data =3D 0x118 =
},
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xc6, .steppings =3D 0x0004, .driver_data =3D 0x118 =
},
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xc6, .steppings =3D 0x0010, .driver_data =3D 0x118 =
},
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xca, .steppings =3D 0x0004, .driver_data =3D 0x118 =
},
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xcf, .steppings =3D 0x0002, .driver_data =3D 0x2100=
02a9 },
+{ .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0x6,  .model =3D 0xcf, .steppings =3D 0x0004, .driver_data =3D 0x2100=
02a9 },
 { .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x00, .steppings =3D 0x0080, .driver_data =3D 0x12 },
 { .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x00, .steppings =3D 0x0400, .driver_data =3D 0x15 },
 { .flags =3D X86_CPU_ID_FLAG_ENTRY_VALID, .vendor =3D X86_VENDOR_INTEL, .fam=
ily =3D 0xf,  .model =3D 0x01, .steppings =3D 0x0004, .driver_data =3D 0x2e },

