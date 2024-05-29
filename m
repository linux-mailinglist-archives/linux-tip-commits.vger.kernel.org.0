Return-Path: <linux-tip-commits+bounces-1308-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 355C08D3BE1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 May 2024 18:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9571C23CF9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 May 2024 16:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421F11836DF;
	Wed, 29 May 2024 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m7LIY1sE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BVIzFoiS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BDB184132;
	Wed, 29 May 2024 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998856; cv=none; b=ZxMkuSdc+IgidJwKHt5v5yGL0Iw0Hns/IutkT9FGFq/Ga4oHi0zFE7cWuRdd2KuP9el6STYvAm62cmjkxKgYxc8QC/SvzJNdICPX+zYs8cHGutsXyZymXC5DFMvV6wBPAFbnZk9el4XjOjSYid8pMUlL4h/jffyqjO4xmA/ZQKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998856; c=relaxed/simple;
	bh=vUdByjXl2zg+uUnpkmlVAihlQDf9yJ+YyNK0BBAvWvE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=GH2y7hVHFkVnSx6epCoKby0UxzId0A3nTvdDJF9GThcYB6ecxX38haq9UNs7kIrl+n50cJRFGnOHqqtbrS3xPSdZJH4ZaPxdlR+ZI/rNA7U5XhFZJoZSIy27eYKSf6tiOEKWUgLjxGN63OOLhcXrsORV2r6QJzqedlaqMJNdvkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m7LIY1sE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BVIzFoiS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 May 2024 16:07:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716998852;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=IZ5KrLuQPjQcfxHwIY9kyaClanAHjDrIe9KVBwV9SRg=;
	b=m7LIY1sERjaxG9VqA+hjyq94Td1CnS6+Oqu/TuvBsrFQivooX4G5u3Pz2GdyFC6EB95fNA
	POTCW9b50iamafKKtCiPUQRx0fFoBB9c2xmz44lPNPtydXBUZ5Vp6yxq89Hl6dlkKainuC
	/Vc70oZj+b3kjIM0a0A0egh3juJ234ruDRmPYDfKBeja33ehwyLMIitQI1o3kLhp0MXjNq
	l4qWrgr3TpjZL1QrWSRJsjy0zInIkyarQbeGGd9p0fa1Hg/uJuzNHljMPBHKJq8H1fmwLP
	s6HKrPUcQT0455kVUVUU7o9SvAlbCIMGT2aP5cKxf5CgrGsWK929N/S85qOQGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716998852;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=IZ5KrLuQPjQcfxHwIY9kyaClanAHjDrIe9KVBwV9SRg=;
	b=BVIzFoiSEvrPssplanhIs4bXyN9L4NFkQ0RF4PyvU+quQ4j4PWziLRQ0DWs7dkKg3Ldqm5
	rVB2Xj1MBWPp7rDw==
From: "tip-bot2 for Nikolay Borisov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/kexec: Remove spurious unconditional JMP from from
 identity_mapped()
Cc: Nikolay Borisov <nik.borisov@suse.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171699885209.10875.2411538078061299720.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     3f3d80f505f3d7273f374935558db5188acdd162
Gitweb:        https://git.kernel.org/tip/3f3d80f505f3d7273f374935558db5188acdd162
Author:        Nikolay Borisov <nik.borisov@suse.com>
AuthorDate:    Wed, 29 May 2024 18:28:50 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 29 May 2024 17:53:57 +02:00

x86/kexec: Remove spurious unconditional JMP from from identity_mapped()

This seemingly straightforward JMP was introduced in the initial version
of the the 64bit kexec code without any explanation.

It turns out (check accompanying Link) it's likely a copy/paste artefact
from 32-bit code, where such a JMP could be used as a serializing
instruction for the 486's prefetch queue. On x86_64 that's not needed
because there's already a preceding write to cr4 which itself is
a serializing operation.

  [ bp: Typos. Let's try this and see what cries out. If it does,
    reverting it is trivial. ]

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/55bc0649-c017-49ab-905d-212f140a403f@citrix.com/
---
 arch/x86/kernel/relocate_kernel_64.S | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 56cab1b..54e6200 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -153,9 +153,6 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 1:
 	movq	%rax, %cr4
 
-	jmp 1f
-1:
-
 	/* Flush the TLB (needed?) */
 	movq	%r9, %cr3
 

