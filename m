Return-Path: <linux-tip-commits+bounces-1454-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C9090D4A7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 16:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F207C284A4C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 14:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5A11A38D5;
	Tue, 18 Jun 2024 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q3BAFEb9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N5/tVKaF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D381A2FAC;
	Tue, 18 Jun 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719314; cv=none; b=SQ3wGPrrX/0ejXEnDugp/OQ05PIsg+cXVnDTPtZ+kZ93ZsStHWh9Urk6K1bi7HPzAooEduo53eO+zDfXaGXXrmwsOPwkVmrjzD7KLI3l3eZ5cv+FdWtOjcJ2CGR6BhcvtCYS6xJ3R50I7wMTWIokuWSznI8bYrimVthb7Mhme+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719314; c=relaxed/simple;
	bh=0jdHezPBWe+kNe+HRCzZf6w6ruy+nn+tN2J4ZD4iVTA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gsmaMzQn77tm6HqSLhecveNa93tE+k5kgxhcLsQS1OjYTFsfs2MPVBg4z8PSCtEG+n8Fn2RmIyQTf4SBk7waWcIdpiSFPllEemxgaukXNVowVGBPNj2B+vcSu6YkHelkrSMsrh1hUbufCAXm2Jqlh4IKLgxU/JoXhqD1z+RNXFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q3BAFEb9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N5/tVKaF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 14:01:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718719301;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3XA7PCboLb5Mo8grNovBTZjA/sQnI1sb97xD2fnGdY=;
	b=Q3BAFEb9LiqWWVjAilqNV4mkDlgzpMCLY2A3lst3M0CZES2B9ilf84g0VxA2sVz6dFVkIS
	Ll6XHK4DLHPCsOfc14l+Khn86HsBoyumMb9kavNK4ejVql3PWijMOIKgIsMkSfYZzlwo0r
	EHoKXd7rh2ZpLvLIh9cBGCqBwIlZmrYpPLQIdcvdk4VBNqyR+TNk68rV7C+5QWoT6+caMQ
	wDD+WAaZRN1qV4abCfPp3agR63tnigfdsWx97zVEq6EhRS7dq5CFzcl5sfsA2uQrYT1vH+
	arDvjXS1DP+E9BBoIZ40+AKHde+TSfo7UoBAQPY95IONBipyYd0In1fzIE8QmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718719301;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3XA7PCboLb5Mo8grNovBTZjA/sQnI1sb97xD2fnGdY=;
	b=N5/tVKaFpdBRBstBk+LUOmyQRFb41PfohNBuP6Y3BmSaS8jCy8C+A1hWE8xpiq0+4B8JAX
	mxh/gY4MK1aix+Dg==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/tdx: Account shared memory
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Kai Huang <kai.huang@intel.com>,
 Tao Liu <ltao@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240614095904.1345461-10-kirill.shutemov@linux.intel.com>
References: <20240614095904.1345461-10-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171871930127.10875.6668721524099904982.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     c3abbf1376874f0d6eb22859a8655831644efa42
Gitweb:        https://git.kernel.org/tip/c3abbf1376874f0d6eb22859a8655831644efa42
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 14 Jun 2024 12:58:54 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Jun 2024 17:45:59 +02:00

x86/tdx: Account shared memory

The kernel will convert all shared memory back to private during kexec.
The direct mapping page tables will provide information on which memory
is shared.

It is extremely important to convert all shared memory. If a page is
missed, it will cause the second kernel to crash when it accesses it.

Keep track of the number of shared pages. This will allow for
cross-checking against the shared information in the direct mapping and
reporting if the shared bit is lost.

Memory conversion is slow and does not happen often. Global atomic is
not going to be a bottleneck.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Tao Liu <ltao@redhat.com>
Link: https://lore.kernel.org/r/20240614095904.1345461-10-kirill.shutemov@linux.intel.com
---
 arch/x86/coco/tdx/tdx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 26fa47d..979891e 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -38,6 +38,8 @@
 
 #define TDREPORT_SUBTYPE_0	0
 
+static atomic_long_t nr_shared;
+
 /* Called from __tdx_hypercall() for unrecoverable failure */
 noinstr void __noreturn __tdx_hypercall_failed(void)
 {
@@ -821,6 +823,11 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc))
 		return -EIO;
 
+	if (enc)
+		atomic_long_sub(numpages, &nr_shared);
+	else
+		atomic_long_add(numpages, &nr_shared);
+
 	return 0;
 }
 

