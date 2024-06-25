Return-Path: <linux-tip-commits+bounces-1537-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F95916D01
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Jun 2024 17:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDB51C21A63
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Jun 2024 15:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7638716EC01;
	Tue, 25 Jun 2024 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tg5fb84C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lXb5Jfuc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB6F2E62F;
	Tue, 25 Jun 2024 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329230; cv=none; b=RzfA6Gslj6mGlwEvv8sXAjZV71jZCvrhSxaGS4BsPD29FzZQEb9S5VdOy+vyU0dAVJnRHu08xI3jIn60pm34RSvUWyEKCYgTl9CQRBFF/Fs+krpRi/LYbrJWCMqZSpjhTbMipe0Z0y4rrnprr4ySuvll5RI4IfOO0MvD4f6GQk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329230; c=relaxed/simple;
	bh=CuUWmLNusNNXjCLhsaTHIqSDZDW05k03owEZLBOXes4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kFgdiTSxUgHPo7XT+ZBQYW73FJDKuc40ttkWH8MDkRM5rmLgmiWF3AEd+yQkFDyJzEJzsggXlgOqDRiw2hsjmVaI48DwDTAO0S5Q2qk7yj7MPmnlBMdURSVJH3Y1zWNYc0Dr4MO0cicpVq6ZtH+iKZvO6umoMiGvJyi+4Dq6rpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tg5fb84C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lXb5Jfuc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Jun 2024 15:27:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719329227;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yUOhF202hi2njEu/q0kPfULtfLuEvD2Kss8dNb/stek=;
	b=tg5fb84CPekj2ZcHlkMBeS+hCanP1PNhDaCmvK66ZyhlhfAIRnGKVMhi+ohN9jOHJXupan
	BEqUmvVtRMWoYY4GsBwU6TBn3vElGFu109LIg6KrJgVv2cLdXw0lTrnTMkWPTYkQUkfT5I
	Do11ctuE5RVcQCmCIpqFTd7+sb2v8S17nFFoPe3PzveRO2XuaVVjHrKtj1WCCsqRJpxkqA
	PqBuNRjnM3o+yaZIs37/+jZwDThL2x9d9pQB4hL1BG2koLcfaa2roZBQXMetjEPT+SQjCx
	pyW+AUNv7H75rhlxYAnwacYqojsISbRXSL60Vr+BSdwbnrjKwJXVMtZL60j/rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719329227;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yUOhF202hi2njEu/q0kPfULtfLuEvD2Kss8dNb/stek=;
	b=lXb5JfucZOQN1+3vEKE10ABm8mE6P0JDP98OQEvSrrTNpPTcTzPLuh9Uh3WpX+FhQlvZ2c
	MrUXroYamUHIJJCQ==
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
Message-ID: <171932922685.2215.6945909603120879149.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/vmware branch of tip:

Commit-ID:     9dfb18031f0df2378b3d33a13fc485ef89caa285
Gitweb:        https://git.kernel.org/tip/9dfb18031f0df2378b3d33a13fc485ef89caa285
Author:        Alexey Makhalov <alexey.makhalov@broadcom.com>
AuthorDate:    Thu, 13 Jun 2024 12:16:49 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 25 Jun 2024 17:15:48 +02:00

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

