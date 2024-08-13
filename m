Return-Path: <linux-tip-commits+bounces-2043-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF84C950D7C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Aug 2024 22:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D61B1C21755
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Aug 2024 20:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3011A3BDD;
	Tue, 13 Aug 2024 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tm3BlkMk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aYLb+lQV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F73C54279;
	Tue, 13 Aug 2024 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723579409; cv=none; b=DTeNF/WaHdigPhA30Yvsz7+t1t8+9Rk0sz1n8QU5QjCW+GZnm9Z0oovMSOgzK/h2woMGWP63ySqHPK7Tk2puNp5YDzbhw+fRxLXDN2v1spUKZC1ScwUMzsDT3qK8JAWh45LzWS8xu3D9Md4MbGd+KbQ8+qWWVmz22sDaVYUWpMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723579409; c=relaxed/simple;
	bh=RzknwgPbiNhY/LKOt4GV9bGfbenUiHQcyJreWnJKU+g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QD7npFFoxJO0ssLU2uKXW0d147SvHrx8angLVFuWO3mj6WigScl3ZqCWgOE4DcjENZP9f5hXpyayNUjlnaBDWVLc1/fOVaAeArUPjwTokYA4lBSIPpdHe058spaYaP0JANbcjReh+BMTeG0OBmhTFGQmnbWxgh3HVbs+aZG9DQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tm3BlkMk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aYLb+lQV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Aug 2024 20:03:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723579406;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+n8G5bArBPaZqSqaHgGg7Oxd4c9xzaH67CrWQ3YqVU=;
	b=tm3BlkMkEjH507jo0+udvhCgZ/cXn9sUpUPql3yUj8wjyE3XGH/pVH7qz/gX9Xb5rqIPMp
	o7A1Gq0yacsIjGA3kHVWv3mk5WQlvXLjyOV6Snz+x/74iSXHC5JlPHStBqBdW8YiP7AnJn
	PV+akCnNNhmg+2U5XKGDppuGn4+10nxsTMbNftXlJVwPwtHWqabQh80PwgxHpdMti9kT0i
	2EKOpjpdRaK5Ou/Epc0iNv6Cma0e/zz49LQtCWpJkOeIUYcO7pbDOKAI9H3hYTeT4EUDWJ
	pwru069ZltBnvoV2fnBpfvV+wFFeg2eRgWD9o8SDepRJwFtCRGSPg0e7H+xaQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723579406;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+n8G5bArBPaZqSqaHgGg7Oxd4c9xzaH67CrWQ3YqVU=;
	b=aYLb+lQViJ7d0Oz2cvT9ARZa4Wzv5wCMJcBtwFNVlyzKP0xRmeU9xCULkm+GnOTWnb7bNy
	14/jRRUYNcyCGXAw==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Parse cmdline param "fred=" in
 cpu_parse_early_param()
Cc: Hou Wenlong <houwenlong.hwl@antgroup.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Xin Li (Intel)" <xin@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240709154048.3543361-2-xin@zytor.com>
References: <20240709154048.3543361-2-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172357940564.2215.7241066302191703798.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     989b5cfaa7b6054f4e1bde914470ee091c23e6a5
Gitweb:        https://git.kernel.org/tip/989b5cfaa7b6054f4e1bde914470ee091c23e6a5
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Tue, 09 Jul 2024 08:40:46 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 Aug 2024 21:59:21 +02:00

x86/fred: Parse cmdline param "fred=" in cpu_parse_early_param()

Depending on whether FRED is enabled, sysvec_install() installs a system
interrupt handler into either into FRED's system vector dispatch table or
into the IDT.

However FRED can be disabled later in trap_init(), after sysvec_install()
has been invoked already; e.g., the HYPERVISOR_CALLBACK_VECTOR handler is
registered with sysvec_install() in kvm_guest_init(), which is called in
setup_arch() but way before trap_init().

IOW, there is a gap between FRED is available and available but disabled.
As a result, when FRED is available but disabled, early sysvec_install()
invocations fail to install the IDT handler resulting in spurious
interrupts.

Fix it by parsing cmdline param "fred=" in cpu_parse_early_param() to
ensure that FRED is disabled before the first sysvec_install() incovations.

Fixes: 3810da12710a ("x86/fred: Add a fred= cmdline param")
Reported-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240709154048.3543361-2-xin@zytor.com

---
 arch/x86/kernel/cpu/common.c |  5 +++++
 arch/x86/kernel/traps.c      | 26 --------------------------
 2 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d4e539d..10a5402 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1510,6 +1510,11 @@ static void __init cpu_parse_early_param(void)
 	if (cmdline_find_option_bool(boot_command_line, "nousershstk"))
 		setup_clear_cpu_cap(X86_FEATURE_USER_SHSTK);
 
+	/* Minimize the gap between FRED is available and available but disabled. */
+	arglen = cmdline_find_option(boot_command_line, "fred", arg, sizeof(arg));
+	if (arglen != 2 || strncmp(arg, "on", 2))
+		setup_clear_cpu_cap(X86_FEATURE_FRED);
+
 	arglen = cmdline_find_option(boot_command_line, "clearcpuid", arg, sizeof(arg));
 	if (arglen <= 0)
 		return;
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4fa0b17..6afb41e 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1402,34 +1402,8 @@ DEFINE_IDTENTRY_SW(iret_error)
 }
 #endif
 
-/* Do not enable FRED by default yet. */
-static bool enable_fred __ro_after_init = false;
-
-#ifdef CONFIG_X86_FRED
-static int __init fred_setup(char *str)
-{
-	if (!str)
-		return -EINVAL;
-
-	if (!cpu_feature_enabled(X86_FEATURE_FRED))
-		return 0;
-
-	if (!strcmp(str, "on"))
-		enable_fred = true;
-	else if (!strcmp(str, "off"))
-		enable_fred = false;
-	else
-		pr_warn("invalid FRED option: 'fred=%s'\n", str);
-	return 0;
-}
-early_param("fred", fred_setup);
-#endif
-
 void __init trap_init(void)
 {
-	if (cpu_feature_enabled(X86_FEATURE_FRED) && !enable_fred)
-		setup_clear_cpu_cap(X86_FEATURE_FRED);
-
 	/* Init cpu_entry_area before IST entries are set up */
 	setup_cpu_entry_areas();
 

