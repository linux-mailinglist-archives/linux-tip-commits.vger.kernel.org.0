Return-Path: <linux-tip-commits+bounces-4371-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2398A68AC8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1C407AD080
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA80B25D915;
	Wed, 19 Mar 2025 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UYfCSGuP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/dOEvj1P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8664E25D522;
	Wed, 19 Mar 2025 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382238; cv=none; b=DTgLP2LPIe1Tr2aal5TOsmvGLppBKsWJiV+yMNAWRfDZTiaeOtfTZJLZgn1g37pMPubEBLeHTz6xFrm78jGQ0ZSkvbAwVXh0hrZDOOXBnv7aHwgi6pPZEI4eqk0sGVMAhZwk0jNxhJEtYBWoNX7TB1WI/Go2QpBRkNjzxWhsKDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382238; c=relaxed/simple;
	bh=c7VfyxFtGdEtRsIYd9LnsA6Vk1Han/316+5MXgCunZM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=O/Ulr68IihF2TiTCK4iAz0vgSalaUVWLKoMlv1jSJkgTCw7lCybyg/wlo5vHAxDhOsVWzrA8jeKsuAlP6J8N+s2e+6559d9dcGpuumd+PKCv35dUPMkIJLC+MzFS7D5muES/mMacqoCNclV9fIRZa62WbtdeWg0V3kZOpzYR7fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UYfCSGuP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/dOEvj1P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382235;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cYaHEQwvUNMcgnekc/MDMQj/lHhs04OGjv+7Bh4Fd/k=;
	b=UYfCSGuPtUDHNEJ6eh0j6ojFnwYFeigkNRMrpR5ea6VbZ7tOSoHVLABLiMc67VMvzQXLoQ
	/U0ff8fqWI+HGmFNCa7c52n3jsJCjVM5eALsZqBzvFvA6KUdQyRzAJic4RZVn2y2FhQsuj
	ReJdMxvgE78mKRCVyYxqwFtfVFQz1jslVdom5VSM/Zt98E/EC18OPf/lDBMHaNZaInafD1
	2qI1507N3sf5HY0GYXkRGGKICRoBmJ7c9NHb2rkRpXHU8LrREgZDvUKkbIfUQymmm57Ecj
	qknCwjtEGOVtHGoeuCVpzC1PDAlbX0wuyN8p9ks+X/Hc27P6KTR1rtXY53T8GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382235;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cYaHEQwvUNMcgnekc/MDMQj/lHhs04OGjv+7Bh4Fd/k=;
	b=/dOEvj1P950ou90HLta0vGupxKn6wlrkDSuIMsERDyqKi+0QU7/y7DOfucPMax/Al/UorX
	dyrbvDmoqxlcuNCA==
From: "tip-bot2 for Vitaly Kuznetsov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/entry: Add __init to ia32_emulation_override_cmdline()
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238223431.14745.16670941601155538166.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     d55f31e29047f2f987286d55928ae75775111fe7
Gitweb:        https://git.kernel.org/tip/d55f31e29047f2f987286d55928ae75775111fe7
Author:        Vitaly Kuznetsov <vkuznets@redhat.com>
AuthorDate:    Tue, 10 Dec 2024 16:16:50 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:17:37 +01:00

x86/entry: Add __init to ia32_emulation_override_cmdline()

ia32_emulation_override_cmdline() is an early_param() arg and these
are only needed at boot time. In fact, all other early_param() functions
in arch/x86 seem to have '__init' annotation and
ia32_emulation_override_cmdline() is the only exception.

Fixes: a11e097504ac ("x86: Make IA32_EMULATION boot time configurable")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/all/20241210151650.1746022-1-vkuznets%40redhat.com
---
 arch/x86/entry/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 14db5b8..3514bf2 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -142,7 +142,7 @@ static __always_inline int syscall_32_enter(struct pt_regs *regs)
 #ifdef CONFIG_IA32_EMULATION
 bool __ia32_enabled __ro_after_init = !IS_ENABLED(CONFIG_IA32_EMULATION_DEFAULT_DISABLED);
 
-static int ia32_emulation_override_cmdline(char *arg)
+static int __init ia32_emulation_override_cmdline(char *arg)
 {
 	return kstrtobool(arg, &__ia32_enabled);
 }

