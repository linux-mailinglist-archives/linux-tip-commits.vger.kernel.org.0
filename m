Return-Path: <linux-tip-commits+bounces-3713-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394FDA47E4F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 13:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01DF9169659
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 12:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0215522E011;
	Thu, 27 Feb 2025 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CTpk+HRc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sFrquKpB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F72522D4F9;
	Thu, 27 Feb 2025 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660923; cv=none; b=G4sy2Jo82glw0EaIanIXh5G9Scl4KYnEMYf2ImefySCNzT/Pdf5n54EsJG4MDKEb0ISxT39aI/xP4RDdwqgGllb8IaXM0PPxjEE8oN9PQyP536L74wcBe+z/a0hzuhimYUu9Q+RUyJN61nBM7F+DJKT0YFV6x+D/WSs/+My6kD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660923; c=relaxed/simple;
	bh=YQUi7a8cpG9iECYYLBkvIN1TJHrRJtGgc/e/IP2e+7k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jgHdllYXc+2MGaGwBxwYX064/Aih54gh8VLluXYyLYh3c8tEVFblCCjEOGt7YTIX9u6pRlhWgTO0+pGYW9eOzCibsfCAwhPTIEoJ/KGJ+NgUFODyCosHziFxNaG8Pmc69rQLTxMYUwI3OD801MpBmLCyMCc99xjVk5RZLa2tbAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CTpk+HRc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sFrquKpB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 12:55:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740660920;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fiWV96N4fiNPVPQmP5dPvRkad3s8Y4OQ9okbq4n8PWo=;
	b=CTpk+HRcB9i++rQDii8Sdk+aydK65iZUX1nE3a4xd/wnRpuBDguPRT4seZ1ARhrzm0YJig
	x6bNqmTItDmjoSHpcUHXh1USoZDZmadLdwZqVKA7h43PFp/x0wnF0tOIRThceO6SLI0B6C
	1+hh1aMVM8aAgF2cbZaBUzKElIU57yTVCOgfbf0DENRBtpDKq8sR2shWcJXtZh7qNx2Ndp
	yew1eiMT/wbKBFQ2S5rmaXDDROYijBX6Pwy0tx3N+ZnweUvReUe6ORPp5GBQQIsLEY/8Bh
	ec6h9ZrOUgPtvnB5tNYSjpZ6yY9q83OZtdn4bVP5qNE1GgQaDm7BkrrkleVR0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740660920;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fiWV96N4fiNPVPQmP5dPvRkad3s8Y4OQ9okbq4n8PWo=;
	b=sFrquKpBP8awWqUGq3asb0cc8IBDFTCmFkLRZmrMvdBrkWWaqIsFmxEciImPsSmwd4Ypow
	xrkjYeeFGALUnBCA==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpu: Prefix hexadecimal values with 0x in cpu_debug_show()
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241211-add-cpu-type-v5-1-2ae010f50370@linux.intel.com>
References: <20241211-add-cpu-type-v5-1-2ae010f50370@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174066092024.10177.4988636186525757873.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     4a412c70af674198749fd16be695d53e1c41b5f9
Gitweb:        https://git.kernel.org/tip/4a412c70af674198749fd16be695d53e1c41b5f9
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Wed, 11 Dec 2024 22:57:24 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 13:26:53 +01:00

x86/cpu: Prefix hexadecimal values with 0x in cpu_debug_show()

The hex values in CPU debug interface are not prefixed with 0x. This may
cause misinterpretation of values. Fix it.

[ mingo: Restore previous vertical alignment of the output. ]

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20241211-add-cpu-type-v5-1-2ae010f50370@linux.intel.com
---
 arch/x86/kernel/cpu/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
index cacfd3f..1976fef 100644
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -16,8 +16,8 @@ static int cpu_debug_show(struct seq_file *m, void *p)
 	if (!c->initialized)
 		return 0;
 
-	seq_printf(m, "initial_apicid:      %x\n", c->topo.initial_apicid);
-	seq_printf(m, "apicid:              %x\n", c->topo.apicid);
+	seq_printf(m, "initial_apicid:	    0x%x\n", c->topo.initial_apicid);
+	seq_printf(m, "apicid:		    0x%x\n", c->topo.apicid);
 	seq_printf(m, "pkg_id:              %u\n", c->topo.pkg_id);
 	seq_printf(m, "die_id:              %u\n", c->topo.die_id);
 	seq_printf(m, "cu_id:               %u\n", c->topo.cu_id);

