Return-Path: <linux-tip-commits+bounces-1549-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8694A91CB4E
	for <lists+linux-tip-commits@lfdr.de>; Sat, 29 Jun 2024 07:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43C85B22217
	for <lists+linux-tip-commits@lfdr.de>; Sat, 29 Jun 2024 05:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD55282E2;
	Sat, 29 Jun 2024 05:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EzTwxLOR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WoiWtO6l"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F3415A8;
	Sat, 29 Jun 2024 05:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719640167; cv=none; b=i2PA/9pB7vcqVaLPPuCnxwInPrEh/zJic/B79d1nja69mhz48hZ2JQLQaz6pBQklTgUVp3d2r1Cs+BdcCSq5EkhAKIoLnLqWj21IH2LoxFLbgM8aez8u7TNrYzK/wHRIrUSa3ZemSPtI3dUPrUMmZH/L2Xj0Td1qzE/4BFrCqfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719640167; c=relaxed/simple;
	bh=Gqy1UQ1yXYzYGEL/Ta4uKWuogBt405XRzw8Pxal1UIQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qWeBF5tZGgj1boR8SxL5i7q+uyXydB+c5+nkmYgTqm9bEdPa6894PFhEliZF2MeHGO4AwqLr6i9BOP2zvDIKDWbvpgHOQngTBowoGmoQahWkJd5sw/HuUw6xaqtpHIopg/WDTPw5fI1wwkNTurozXVJmOigy7EEB9lDH++KolOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EzTwxLOR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WoiWtO6l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 29 Jun 2024 05:49:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719640163;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtSMObicGc0i8jyrqn09GjPPuuR1cAuAIeBWS8WVHFw=;
	b=EzTwxLORtG4VFgJ7mor5ZppyntNcXJMkXic5W37ObR63xIh9/Vt97Hgm25bSWfqyQ64gyt
	MYhKu74lesO/7VYg1ZFANcsqsiTZSW4XBatx/r3vN+3KEnfSUAtOqMGQXW9Qtj/9MlbLOg
	0QwjRpwRApy0EiPZPqlX33TKlWh3o/uFymgxF8bWKgcWA+PwP6WKUF3hjBJxvxkp6RXV5D
	aQVccoHvBq60yMNN02/elR16kXZDmtO1J07QurTHkOm4vZvXrtzBsWSO/5f7AdSmaTLUMZ
	LOtCjoAOE3p53QyWkUZ8P5afU2021zEtiTbdAAihmwBmCHJgfvcODgiQS5c6hA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719640163;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtSMObicGc0i8jyrqn09GjPPuuR1cAuAIeBWS8WVHFw=;
	b=WoiWtO6l55MOszLtfRXLPVMmS3I479NTgqUoV9bi1xhoAeUwiEgZw+7zA0ZCSKY9ZB7Z2U
	FI6212QAvErVv9Dg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Remove duplicate Spectre cmdline option
 descriptions
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <450b5f4ffe891a8cc9736ec52b0c6f225bab3f4b.1719381528.git.jpoimboe@kernel.org>
References:
 <450b5f4ffe891a8cc9736ec52b0c6f225bab3f4b.1719381528.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171964016299.2215.16998294900924718294.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     4586c93ebf410c2b7f480cc4762edd59012a66c0
Gitweb:        https://git.kernel.org/tip/4586c93ebf410c2b7f480cc4762edd59012a66c0
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 25 Jun 2024 23:02:01 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 28 Jun 2024 15:28:38 +02:00

x86/bugs: Remove duplicate Spectre cmdline option descriptions

Duplicating the documentation of all the Spectre kernel cmdline options
in two separate files is unwieldy and error-prone.  Instead just add a
reference to kernel-parameters.txt from spectre.rst.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Link: https://lore.kernel.org/r/450b5f4ffe891a8cc9736ec52b0c6f225bab3f4b.1719381528.git.jpoimboe@kernel.org
---
 Documentation/admin-guide/hw-vuln/spectre.rst | 86 ++----------------
 1 file changed, 10 insertions(+), 76 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index 25a04cd..132e0bc 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -592,85 +592,19 @@ Spectre variant 2
 Mitigation control on the kernel command line
 ---------------------------------------------
 
-Spectre variant 2 mitigation can be disabled or force enabled at the
-kernel command line.
+In general the kernel selects reasonable default mitigations for the
+current CPU.
 
-	nospectre_v1
+Spectre default mitigations can be disabled or changed at the kernel
+command line with the following options:
 
-		[X86,PPC] Disable mitigations for Spectre Variant 1
-		(bounds check bypass). With this option data leaks are
-		possible in the system.
+	- nospectre_v1
+	- nospectre_v2
+	- spectre_v2={option}
+	- spectre_v2_user={option}
+	- spectre_bhi={option}
 
-	nospectre_v2
-
-		[X86] Disable all mitigations for the Spectre variant 2
-		(indirect branch prediction) vulnerability. System may
-		allow data leaks with this option, which is equivalent
-		to spectre_v2=off.
-
-
-        spectre_v2=
-
-		[X86] Control mitigation of Spectre variant 2
-		(indirect branch speculation) vulnerability.
-		The default operation protects the kernel from
-		user space attacks.
-
-		on
-			unconditionally enable, implies
-			spectre_v2_user=on
-		off
-			unconditionally disable, implies
-		        spectre_v2_user=off
-		auto
-			kernel detects whether your CPU model is
-		        vulnerable
-
-		Selecting 'on' will, and 'auto' may, choose a
-		mitigation method at run time according to the
-		CPU, the available microcode, the setting of the
-		CONFIG_MITIGATION_RETPOLINE configuration option,
-		and the compiler with which the kernel was built.
-
-		Selecting 'on' will also enable the mitigation
-		against user space to user space task attacks.
-
-		Selecting 'off' will disable both the kernel and
-		the user space protections.
-
-		Specific mitigations can also be selected manually:
-
-                retpoline               auto pick between generic,lfence
-                retpoline,generic       Retpolines
-                retpoline,lfence        LFENCE; indirect branch
-                retpoline,amd           alias for retpoline,lfence
-                eibrs                   Enhanced/Auto IBRS
-                eibrs,retpoline         Enhanced/Auto IBRS + Retpolines
-                eibrs,lfence            Enhanced/Auto IBRS + LFENCE
-                ibrs                    use IBRS to protect kernel
-
-		Not specifying this option is equivalent to
-		spectre_v2=auto.
-
-		In general the kernel by default selects
-		reasonable mitigations for the current CPU. To
-		disable Spectre variant 2 mitigations, boot with
-		spectre_v2=off. Spectre variant 1 mitigations
-		cannot be disabled.
-
-	spectre_bhi=
-
-		[X86] Control mitigation of Branch History Injection
-		(BHI) vulnerability.  This setting affects the deployment
-		of the HW BHI control and the SW BHB clearing sequence.
-
-		on
-			(default) Enable the HW or SW mitigation as
-			needed.
-		off
-			Disable the mitigation.
-
-For spectre_v2_user see Documentation/admin-guide/kernel-parameters.txt
+For more details on the available options, refer to Documentation/admin-guide/kernel-parameters.txt
 
 Mitigation selection guide
 --------------------------

