Return-Path: <linux-tip-commits+bounces-1521-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7291B915523
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 19:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2412866E0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 17:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5F419EED9;
	Mon, 24 Jun 2024 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EUo8NZUI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yLkAZguT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEB119E819;
	Mon, 24 Jun 2024 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719249277; cv=none; b=iDKCm6OgUfPe8Voz0IA7xpp5qzMJheTsRf+Dj83k+SlaOPmx5GRCtDRqFwM10kb6vfjyYR2f8usjTqeINDlKwt65Yu+SrUHpJKs8Q4hhKBTJpMZ+2W34mwAymHGi4mzKEqWRBVUjSIhxEVwTNx5CgoPsWLDnedREDK8P/tVefjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719249277; c=relaxed/simple;
	bh=Yg/73IdzVEM5oF2dJos5eCneBFCxr4eGmAAmfxtBBms=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iVMB1D+gazVB4SvasAVhV7bxxyUTxaUZz+9rmQMLnHcKQECa+CSGffyNbUwkP+ZIfg5nLDCoF7L0lrxQuFUw38c1NUnEMOsHoxsDAB0bXXgUiMM9kL2LVb/3V2MrdV6pqrwjzCwAa9Kyo7E1XYOUMG/2r3ESexviiLpctho4dN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EUo8NZUI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yLkAZguT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Jun 2024 17:14:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719249273;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HOGVyJpdKCU39MyRDDVc0SPwSXe4HrBopLpYvPxoUus=;
	b=EUo8NZUIBCMKl8hP282gzGtsmegBwoShGaduCBbaPWJtk+1H4Zhcmz+Q0kDmRuq/In6XdU
	XpvXM9sy86oomZUHaDAA7H3K9B8y1wEYzNfUhVfdPrkQMTB5rLQjVyA4P1mJ56U3AyQ3C1
	HOb98BOUh/x2D+ntUdOpesfWmJ9kspJRMf2+h98pyMF4d5SbV4hh1eESL11sPDCCmwpqKl
	eS0lY8gk+XoQ8XfMN6eEUa1BVrM3ff3Xsqwc/FE6slLS7qXHnokGQUULRUgdWZaD4u3hS2
	FOQsYv1bjC63OiK7sc3uKxvBEjMSwEdngpsOyb7yuPrpMmxcrhTMv0/WOBz9lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719249273;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HOGVyJpdKCU39MyRDDVc0SPwSXe4HrBopLpYvPxoUus=;
	b=yLkAZguTRdp+0Wi63d4gnEOLGa0o+ivG10L2e5Y2R44v5Y+KJWEzLkZiVgP2mkiqrYziDc
	vVfYlg1maFM7NzDg==
From: "tip-bot2 for Alexey Makhalov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vmware] x86/vmware: Remove legacy VMWARE_HYPERCALL* macros
Cc: Alexey Makhalov <alexey.makhalov@broadcom.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240613191650.9913-8-alexey.makhalov@broadcom.com>
References: <20240613191650.9913-8-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171924927293.10875.5123168035888699144.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/vmware branch of tip:

Commit-ID:     0a3fa818f05c794ed5e9c391b60149f4d8eb6c75
Gitweb:        https://git.kernel.org/tip/0a3fa818f05c794ed5e9c391b60149f4d8eb6c75
Author:        Alexey Makhalov <alexey.makhalov@broadcom.com>
AuthorDate:    Thu, 13 Jun 2024 12:16:49 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 24 Jun 2024 07:10:38 +02:00

x86/vmware: Remove legacy VMWARE_HYPERCALL* macros

No more direct use of these macros should be allowed. The vmware_hypercallX API
still uses the new implementation of VMWARE_HYPERCALL macro internally, but it
is not exposed outside of the vmware.h.

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240613191650.9913-8-alexey.makhalov@broadcom.com
---
 arch/x86/include/asm/vmware.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 724c8b9..d83444f 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -279,30 +279,4 @@ unsigned long vmware_hypercall_hb_in(unsigned long cmd, unsigned long in2,
 #undef VMW_BP_CONSTRAINT
 #undef VMWARE_HYPERCALL
 
-/* The low bandwidth call. The low word of edx is presumed clear. */
-#define VMWARE_HYPERCALL						\
-	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT) ", %%dx; " \
-		      "inl (%%dx), %%eax",				\
-		      "vmcall", X86_FEATURE_VMCALL,			\
-		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
-
-/*
- * The high bandwidth out call. The low word of edx is presumed to have the
- * HB and OUT bits set.
- */
-#define VMWARE_HYPERCALL_HB_OUT						\
-	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT_HB) ", %%dx; " \
-		      "rep outsb",					\
-		      "vmcall", X86_FEATURE_VMCALL,			\
-		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
-
-/*
- * The high bandwidth in call. The low word of edx is presumed to have the
- * HB bit set.
- */
-#define VMWARE_HYPERCALL_HB_IN						\
-	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT_HB) ", %%dx; " \
-		      "rep insb",					\
-		      "vmcall", X86_FEATURE_VMCALL,			\
-		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
 #endif

