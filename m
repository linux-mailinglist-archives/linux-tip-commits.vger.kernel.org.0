Return-Path: <linux-tip-commits+bounces-2233-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AA59720A7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9152858AE
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D520189903;
	Mon,  9 Sep 2024 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CadyinSL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BuSxIGMk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB0818787E;
	Mon,  9 Sep 2024 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902873; cv=none; b=X9/vaxQ3a4BYADhRlGXO/01VS82Na9xUYAMXVqwtuknf/P1abDA7bYHVqWdVhvCqZ6u7CiFRG2BAhtpRxT90H7XOp7jYzCz5uJbvdGrVnDjv+Pypybe7IiwLaa9SCcMTg+9bGLajkuO/nVoK4z+xFCIwyVP7hTRyzFvNg2ZAqfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902873; c=relaxed/simple;
	bh=PbHAIUGof3Sx7JORqgYi/Cw1bypksZIKsgFQz0rtENs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j/eFm4IVo7AaKDJK7Xw9ktnuBOHs/tQkJ8yMlmuqpxaJw4gPqxvzuP8mmnE07kfAiu8KD9jRLQhKrYk5F7668ZyTXmAzq66oxHMPmqHepBjJFqK/jfMSHwE157LRYv9CeI4Ah6WLbGoxy18LFHg2cT5VA//6h3p3z++j85E+Ono=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CadyinSL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BuSxIGMk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZD0p0+hdK6TUGbT7H3+dRUW13r2e/JsM31ThNXrWs1c=;
	b=CadyinSLA6iEaR2/laU3BGrnBZ3jGZnLpj/g83p3gC10hiR4LCbcfUVarN+dyZfbqrrcAn
	wUSmR7vVm2BsFFChH8hU40F+t/Bn+zoRTzlLs9xEvUP+1VZHA995fjm+zVAJlQBe010Yf/
	rQrSU5qq0a73Sz+qbowwoasEabFsexDLzrbDcmIzM2FNgfBqqAVzMFoFpfiCg9JGbM/LxR
	ivQ2ZdUFWaS9BSm5tUGOh5fpMCa++N2zygOXozSADC46S0jG1u1+CmI6u7xnqJ/Oi1rF33
	F3C81x/EIPXSJ0PG+t3am9Ny/GgR6W8OXLwK+i1vYHFvgTksEsBGUwUZWA3p1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZD0p0+hdK6TUGbT7H3+dRUW13r2e/JsM31ThNXrWs1c=;
	b=BuSxIGMkwPISM7UratB8XCg1kbPnly33LFRiB1dl6c6yTSVKUna3dZHoUWKYov6Te7YeCm
	KD1mQ6CmdCAsi0CA==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/rt] printk: nbcon: Use raw_cpu_ptr() instead of open coding
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87plpum4jw.fsf@jogness.linutronix.de>
References: <87plpum4jw.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286740.2215.7528446558549427301.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     d33d5e683b0d3b4f5fc6a49ce17583f8ca663944
Gitweb:        https://git.kernel.org/tip/d33d5e683b0d3b4f5fc6a49ce17583f8ca663944
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 27 Aug 2024 16:25:31 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 04 Sep 2024 12:28:25 +02:00

printk: nbcon: Use raw_cpu_ptr() instead of open coding

There is no need to open code a non-migration-checking
this_cpu_ptr(). That is exactly what raw_cpu_ptr() is.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/87plpum4jw.fsf@jogness.linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/nbcon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 92ac5c5..cf62f67 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -998,8 +998,7 @@ static __ref unsigned int *nbcon_get_cpu_emergency_nesting(void)
 	if (!printk_percpu_data_ready())
 		return &early_nbcon_pcpu_emergency_nesting;
 
-	/* Open code this_cpu_ptr() without checking migration. */
-	return per_cpu_ptr(&nbcon_pcpu_emergency_nesting, raw_smp_processor_id());
+	return raw_cpu_ptr(&nbcon_pcpu_emergency_nesting);
 }
 
 /**

