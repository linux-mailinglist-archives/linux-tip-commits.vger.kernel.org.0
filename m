Return-Path: <linux-tip-commits+bounces-5677-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1088EABF0B5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5592D1BA34AE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 10:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B7F23496F;
	Wed, 21 May 2025 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hMHbUL13";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZPkLyCPf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7E723BCF4;
	Wed, 21 May 2025 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821824; cv=none; b=urY+ANQbLj6Nea5uE1/3VOGwIGRnIVHG6KCcUQ2OZ4eluUTxWkW8xJsFi2nlezEd96Xx/CY561WqBxM/j8xrIAaYxh3RXTRPt14i2vdea7OpWACVq3gRfl7ONVlbPSyO7qPgjNuP/HpVdrtGh4pwzO10wu8EUy8G6L1yps6zuIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821824; c=relaxed/simple;
	bh=OJ97p5B8Aw7zqzfQjB2nKZ8UX+vEV3Agwas2C74Qi/w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=abNBj9VksjmuKwtKNkerkInvXoSWETX/MyzG3oNBpc7BWnVVat5DcJ8iiXvOKXCdzazPeuDnsCH8n+w9YHdPlLCAKE0/Fg5KqH+YVVY+Ii0eF7sKbYtsXN24QPUMzEb8/ynZ6Bz/+2+VjgX2es7CLnOqY6j1zYrbJ1W4HYvWCQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hMHbUL13; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZPkLyCPf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 10:03:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747821820;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2NmAOPTvxvertRMNfAVoVd9vAR6Cr22OmQ9PU0AvO7Y=;
	b=hMHbUL13Ybr1mhqfKVh64FGrp99saxrevmSeg12Sb+OruP/0zW7kanh7X8IbsfeOB2+Exg
	2nvmarpoTrK35XIq8mJs6SHZGsPMetHHh3801wpv4lPSD5O/zhit4iPoBYeCAvuxaoh2bH
	BxVqp75sN9V1PimwpWCUii8N/MVIHXeoAszQzyC3wjsOjjfr3b7ioMgows2eEC7CwXHtCh
	Yn9c2w/iccdpP48h+ZY0nzODqS6pHQX93YahEU33exZFjudKG/7Q5oWUNHfYa8z4GoxRpG
	ud75U5WuERCup7ROVHdFMTPN832YooL2q/NFqLL275rjbx7iU+Sc4s97TRmNXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747821820;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2NmAOPTvxvertRMNfAVoVd9vAR6Cr22OmQ9PU0AvO7Y=;
	b=ZPkLyCPfKu+hO4PxZXIOZeGmxXn3OsDEPoNfW5DulLzCO8bz5m3hqkyYmBCPtOwi/JUhUk
	uxKEZE8C4kpr5EAQ==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/bugs: Fix spectre_v2 mitigation default on Intel
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250520-eibrs-fix-v1-1-91bacd35ed09@linux.intel.com>
References: <20250520-eibrs-fix-v1-1-91bacd35ed09@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782181894.406.10038998736172191302.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     6a7c3c2606105a41dde81002c0037420bc1ddf00
Gitweb:        https://git.kernel.org/tip/6a7c3c2606105a41dde81002c0037420bc1ddf00
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Tue, 20 May 2025 22:35:20 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 21 May 2025 11:51:32 +02:00

x86/bugs: Fix spectre_v2 mitigation default on Intel

Commit

  480e803dacf8 ("x86/bugs: Restructure spectre_v2 mitigation")

inadvertently changed the spectre-v2 mitigation default from eIBRS to IBRS on
Intel. While splitting the spectre_v2 mitigation in select/update/apply
functions, eIBRS and IBRS selection logic was separated in select and update.

This caused IBRS selection to not consider that eIBRS mitigation is already
selected, fix it.

Fixes: 480e803dacf8 ("x86/bugs: Restructure spectre_v2 mitigation")
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250520-eibrs-fix-v1-1-91bacd35ed09@linux.intel.com
---
 arch/x86/kernel/cpu/bugs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 3d5796d..7f94e6a 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2105,7 +2105,8 @@ static void __init spectre_v2_select_mitigation(void)
 
 static void __init spectre_v2_update_mitigation(void)
 {
-	if (spectre_v2_cmd == SPECTRE_V2_CMD_AUTO) {
+	if (spectre_v2_cmd == SPECTRE_V2_CMD_AUTO &&
+	    !spectre_v2_in_eibrs_mode(spectre_v2_enabled)) {
 		if (IS_ENABLED(CONFIG_MITIGATION_IBRS_ENTRY) &&
 		    boot_cpu_has_bug(X86_BUG_RETBLEED) &&
 		    retbleed_mitigation != RETBLEED_MITIGATION_NONE &&

