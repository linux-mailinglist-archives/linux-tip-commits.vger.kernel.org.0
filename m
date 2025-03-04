Return-Path: <linux-tip-commits+bounces-3885-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EBDA4D92C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D83816D123
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D649D1FCF62;
	Tue,  4 Mar 2025 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fEToKSG1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/7dMdIsW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9EB1FBEA1;
	Tue,  4 Mar 2025 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081657; cv=none; b=Fxn+ZIwXPdFrb4H9qXbQMLxFQhhA49P1bfo8TdNi+Xyna3fLueqCWlbIVcUFVQEf+tcx3QC7G4t6RDwgNu4mMIcGoq2+ReOh540X8QEst9kVoq5DD5miUF+3dL7KG4vYzaK+dzngMHacaDPMbsJFtluTDhb/sXZ26H7TZlsAhRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081657; c=relaxed/simple;
	bh=+7Vqcd7O6uY4NAbDtleofJIkRnoHI3bkdvyEOWTIgCg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WsRYPEaNqm3tYCgPOkbm4IOE1doMAtdlJiDzst1QBluZLJS7eyq6wWHoDqwYj7PDI/Pd4YkuXIaay/DozAd8QLdx5K9ZGB9l8IS2ve1cIGahXK8N120giBqP7qNKus5GqpiEMrk/RLGS64NBJdvJh7vC6MsnMZ7CRBHu9g/ckNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fEToKSG1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/7dMdIsW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 09:47:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741081654;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6w0gTY9Rrv33Mfk2x8KfH/mZydwWT6+pN3emUfHn4hw=;
	b=fEToKSG1D90vvAvSyykNpOInX2PaNElbsMveG2Lncc7qUL2TtoSWskAsEkglAbbGXByHjS
	++DvuVm1IqQMRbtyDppMgTaTwo/vxGI7G4WgjiOHiRZv9xXtRyMJpO9XvFS1ib3UmP6avL
	XfdiRyYFriKfNYk8yPd9bjni4OJeXlb2865Beo2qW9SISGQeQuFXK8L6PiFReSy70m5lPZ
	rDpFRbEez3aIfHnfylyrBv4nkV/U7T52Q/Mb8mpbpN1sgKhSMm9S/jlxJvad7duQ3rDI5y
	tG1P2U9wE+GEAOKF+PPrDjVv13pYgDKyGE7gcFjE4JxR3Nnk+sq1/cJHPcAgnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741081654;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6w0gTY9Rrv33Mfk2x8KfH/mZydwWT6+pN3emUfHn4hw=;
	b=/7dMdIsWcu4OBoc7EuR/jBI/6rQYxzopUnGxKGDbjrm7+iAf9+bffB+nG0+wf1OBHQOcYV
	MhKh0N41Um0tITAQ==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cacheinfo: Remove unnecessary headers and reorder the rest
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250304085152.51092-13-darwi@linutronix.de>
References: <20250304085152.51092-13-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108165407.14745.8231214072391474656.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     d61b5118f719b1dbad433262603337da6a9c8d68
Gitweb:        https://git.kernel.org/tip/d61b5118f719b1dbad433262603337da6a9c8d68
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Tue, 04 Mar 2025 09:51:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 10:33:56 +01:00

x86/cacheinfo: Remove unnecessary headers and reorder the rest

Remove the headers at cacheinfo.c that are no longer required.

Alphabetically reorder what remains since more headers will be included
in further commits.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250304085152.51092-13-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index eccffe2..b3a5209 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -8,21 +8,19 @@
  *	Andi Kleen / Andreas Herrmann	: CPUID4 emulation on AMD.
  */
 
-#include <linux/slab.h>
 #include <linux/cacheinfo.h>
+#include <linux/capability.h>
 #include <linux/cpu.h>
 #include <linux/cpuhotplug.h>
-#include <linux/sched.h>
-#include <linux/capability.h>
-#include <linux/sysfs.h>
 #include <linux/pci.h>
 #include <linux/stop_machine.h>
+#include <linux/sysfs.h>
 
-#include <asm/cpufeature.h>
-#include <asm/cacheinfo.h>
 #include <asm/amd_nb.h>
-#include <asm/smp.h>
+#include <asm/cacheinfo.h>
+#include <asm/cpufeature.h>
 #include <asm/mtrr.h>
+#include <asm/smp.h>
 #include <asm/tlbflush.h>
 
 #include "cpu.h"

