Return-Path: <linux-tip-commits+bounces-1291-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 998AC8CFC57
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 May 2024 11:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38054B21AB4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 May 2024 09:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6E153361;
	Mon, 27 May 2024 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jE+6m/Fs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZaZfAChV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC60433C8;
	Mon, 27 May 2024 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716800426; cv=none; b=iAtbcfbz/mKcHUorIavXHHMP1ZkScrg40Dnl7PhViXvpOPVxLykGV0GhEEYzh9gsP7bOuYxXUnuV4S2CyfZEnBoEF1p8b9pIy2jSN7uSYzjoKUKD71FKE5XDn7leBUBm1YZraaZc3HddTJNapKrabgg0JCVRR/h7rgDwc8FqlTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716800426; c=relaxed/simple;
	bh=pE7wNx4RmD1KZYOO17e9mTjebj5seCNsUhTgYb094pY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IvMVDk0Ru1QZxtJaMjt6gVvmcdH2saTYquds3F/IKmrP7AvyY8j3xz0PFbxIb5zYFy2QLU6So8jqPlqcdxFeVNSBr1jhQBa6VPmH0kz7HP50doe2E5z/dGSoEpBb2ocbhkVDyi8qUSrd7lXTwxRedakAMKuk+OFZfMfiF8K1QWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jE+6m/Fs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZaZfAChV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 May 2024 09:00:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716800423;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9kR4hJlnkW0zeTviAk6KMshftx7e43hk1TUPz3Gw5u8=;
	b=jE+6m/FsnyrljPc2HMaTU7MxIieaX9qcMYInUh1s4ErgMqwyHoqFWh0KAsOxPExMFBY6O4
	dZ/MnF1wYnmU90upNWIDcUKxJKTF/bruypN3cQbFoQZDRTpoI+sISqVCLLXaygJ7h9m3kq
	3++oIgoSLz4hkBil2N4Ec54wdL4F8x1E+mxkKqUR/IoA1IRN6KiEPnsft+lGBMMklj2ZgY
	jlgB/2rknxTih1PYm/FEKSpUOjZoaoDS/DR8WAxBBmK6lhJaUZAJ/AUim5syaos/a2Tsll
	dTNjOkOuOVey/eQf64q2C4iepi2TRqQMoRp0nqLmfi2q2r7/wef2o7kqVQjTfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716800423;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9kR4hJlnkW0zeTviAk6KMshftx7e43hk1TUPz3Gw5u8=;
	b=ZaZfAChVEz6ns/m+XAezTjodRhfjCxM1+ObXXRoTg2PO7/VVjTM4g7Vpj/1V7MCBdBIqPf
	FCEwHEzLEHgOavCQ==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Remove unused variable and return value in
 machine_check_poll()
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240523155641.2805411-3-yazen.ghannam@amd.com>
References: <20240523155641.2805411-3-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171680042301.10875.10924638422600185854.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     5b9d292ea87c836ec47483f98344cb0e7add82fe
Gitweb:        https://git.kernel.org/tip/5b9d292ea87c836ec47483f98344cb0e7add82fe
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Thu, 23 May 2024 10:56:34 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 27 May 2024 10:49:25 +02:00

x86/mce: Remove unused variable and return value in machine_check_poll()

The recent CMCI storm handling rework removed the last case that checks
the return value of machine_check_poll().

Therefore the "error_seen" variable is no longer used, so remove it.

Fixes: 3ed57b41a412 ("x86/mce: Remove old CMCI storm mitigation code")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240523155641.2805411-3-yazen.ghannam@amd.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/mce.h     | 3 ++-
 arch/x86/kernel/cpu/mce/core.c | 7 +------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index dfd2e96..3ad29b1 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -261,7 +261,8 @@ enum mcp_flags {
 	MCP_DONTLOG	= BIT(2),	/* only clear, don't log */
 	MCP_QUEUE_LOG	= BIT(3),	/* only queue to genpool */
 };
-bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
+
+void machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
 
 int mce_notify_irq(void);
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index ad0623b..b85ec7a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -677,10 +677,9 @@ DEFINE_PER_CPU(unsigned, mce_poll_count);
  * is already totally * confused. In this case it's likely it will
  * not fully execute the machine check handler either.
  */
-bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
+void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
-	bool error_seen = false;
 	struct mce m;
 	int i;
 
@@ -754,8 +753,6 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		continue;
 
 log_it:
-		error_seen = true;
-
 		if (flags & MCP_DONTLOG)
 			goto clear_it;
 
@@ -787,8 +784,6 @@ clear_it:
 	 */
 
 	sync_core();
-
-	return error_seen;
 }
 EXPORT_SYMBOL_GPL(machine_check_poll);
 

