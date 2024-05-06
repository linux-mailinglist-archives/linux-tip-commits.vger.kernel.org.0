Return-Path: <linux-tip-commits+bounces-1242-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 536FF8BCA63
	for <lists+linux-tip-commits@lfdr.de>; Mon,  6 May 2024 11:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0235F1F23121
	for <lists+linux-tip-commits@lfdr.de>; Mon,  6 May 2024 09:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5559A1422C7;
	Mon,  6 May 2024 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YDUdk1il";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4GMSV0KV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C916F2AF1B;
	Mon,  6 May 2024 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714987162; cv=none; b=U2LPYtoQonFydCKJZ0EB+9PvuS4+3tH+ZKnMn9DPkuProSmlGP57Vz+Bf1w43hZBQnJndJlu6nIs9Vid38mO0gnovfTKGOl//d316l4J0S9mYy3ptC4ECWZR/lgqv0dNMSzlzsgAiU8TWHe5ceXI/6dIoqjLHLTL7qfY0Xh3h6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714987162; c=relaxed/simple;
	bh=71M9w46I/cLFH+CARXBA7sjpLR5jgwQHTI1fMim/mXo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HLPgKUoX4HIBmOVE8m8gpD+3bAIKuHYQjtwMh749ueLq4VwHLLMsV/NL+rXVcuhMgqR4j1YM+4H7u8UvlDYv+JltKh65AP1nxG7V0zSILVOttGiXsBs7xGOnwxjI7lHHgsK69YVnoQOGMfzBlAk930wgfA0nO73bUV+pPmWDK2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YDUdk1il; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4GMSV0KV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 06 May 2024 09:19:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714987158;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KSf9tPI5EEAB+E2PKDW1X9Yflu/p927vFuEals/I3WE=;
	b=YDUdk1ilLuQcpeKu6DfkAcf3JzffnalQZWs2Zl3JlXr4BVbwtqLzXh0i51IQsp16ahHifM
	3BIG2NJA6saxwBzC1aHM5t2CVduvh4I2KpXZFfpzkCp5YCA9/PXEFw7Hc+LZSc7aC3lbFT
	YKA+4y0q41QGprNLryIS5JSWaaet3sDOHKmeYnovV0bRmcbHb3NNK9pHZS5F/fKvlME425
	CrVnPKo91cKnwOpFOH67tl/Mq3UQkim/+lwiudrxIadGVx0sGJzZJWGez8+47Rhzd9nU/9
	KilGieONmmvl4sKSmSOa97QpEdKVTESGuGUI/Ug/WGov+/t6TM89KocDTdPC4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714987158;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KSf9tPI5EEAB+E2PKDW1X9Yflu/p927vFuEals/I3WE=;
	b=4GMSV0KVEdsaVapkL+64BDalHJbl6dK6irLQBM1EQTshOIwkW+/OFbAhy3LzDbxIPiD3z1
	x70Xg/HHKaMCQFCA==
From: "tip-bot2 for Dr. David Alan Gilbert" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Remove unused struct cpu_info_ctx
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240506004300.770564-1-linux@treblig.org>
References: <20240506004300.770564-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171498715845.10875.15059417568143881021.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     57f6d0aed7b0a6829044c7f1cea57b1e3ddb9a47
Gitweb:        https://git.kernel.org/tip/57f6d0aed7b0a6829044c7f1cea57b1e3ddb9a47
Author:        Dr. David Alan Gilbert <linux@treblig.org>
AuthorDate:    Mon, 06 May 2024 01:43:00 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 06 May 2024 11:00:57 +02:00

x86/microcode: Remove unused struct cpu_info_ctx

This looks unused since

  2071c0aeda22 ("x86/microcode: Simplify init path even more")

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240506004300.770564-1-linux@treblig.org
---
 arch/x86/kernel/cpu/microcode/core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 232026a..b3658d1 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -60,11 +60,6 @@ module_param(force_minrev, bool, S_IRUSR | S_IWUSR);
  */
 struct ucode_cpu_info		ucode_cpu_info[NR_CPUS];
 
-struct cpu_info_ctx {
-	struct cpu_signature	*cpu_sig;
-	int			err;
-};
-
 /*
  * Those patch levels cannot be updated to newer ones and thus should be final.
  */

