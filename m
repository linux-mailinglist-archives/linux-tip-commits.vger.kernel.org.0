Return-Path: <linux-tip-commits+bounces-3329-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0493DA2621A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 19:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C3216717C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 18:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2D820B7E9;
	Mon,  3 Feb 2025 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DqZh5hhe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Eu39W8u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2278420A5CB;
	Mon,  3 Feb 2025 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738606919; cv=none; b=mq9vyEorsQkhYZrorxIg83GIXBL0gSUOMhIsD3PAxv/8jt8npdgb7BWKQ98tWqYl+g/cVaZO/8WAXdfnepsFn98uXYPU136VFh7UI8jB9pcZF9YWESnHYw5/zW+zdG+G36+AXJPcTzfPHSJKDbT8DTck1PZfE3lVPZXy24MEFC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738606919; c=relaxed/simple;
	bh=bXfW5dpiJoRn03zdqxbqvciAuG6tXDhfbLkEinuTQFY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=IFIVUK+SPOMmRZXILy3jiFoOsdnOWPAtUKsVAvsw9bACALABW2ZjQkntiXJLgBevVW7zQN1sDGGtZwxqOH11+vpRa7qkpPlAd/NdN8RLC+wt3S7xUXWJmgWpHq6eHR3FtoiogGbF3FzbFbxRgEIM+OqblgHlRCtXmJ1peo41Fq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DqZh5hhe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Eu39W8u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Feb 2025 18:21:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738606915;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6RRpTgLPPDUmbSXJAraXKAZj5t0RJMdNY2sI3UV1MyM=;
	b=DqZh5hheLY/uYvOG81TVEbzGqOYc9G34rcnl2xJ8tjLwoOvMFTju7BPAIGfwgeT1lpDoO/
	gMB73mQG4VieXGUScIKPb4oxujeHfqwxBWZ3/fgUgDRbECyRoHl6aTjmRW+JkTfFi2Kdsz
	bpbenXHq/Rb1B1Zo2HrjP9uMaBjgTBSa9L36vwH1CPIt0++qCDZO1eorEAYXysSF6ME2xX
	lpbfdhnvyfSJ4kqZTjfwyUo3jDQoPTxjQhjnpyeA06R08/loGpe+K74ZnxVg2V3hDaYhYA
	pfNCZJa87cpfbQQ2LvxSDhRB6I7Wu+OpWUCImOASlkaqn0UUk7Tj00jFqiHOvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738606915;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6RRpTgLPPDUmbSXJAraXKAZj5t0RJMdNY2sI3UV1MyM=;
	b=2Eu39W8uT4Xdrwea+lbM3rkv+L7UloYJUOmmjorvsfdHC8UbFC7vvaYPJS6TEL6rxvdNvz
	Xmq0u/W9h9V5JyDw==
From: "tip-bot2 for Vitaly Kuznetsov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/misc] x86/entry: Add __init to ia32_emulation_override_cmdline()
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173860691347.10177.12758665660119885979.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     b2f10aa2eb18d289e48097e0ed973e714322175b
Gitweb:        https://git.kernel.org/tip/b2f10aa2eb18d289e48097e0ed973e714322175b
Author:        Vitaly Kuznetsov <vkuznets@redhat.com>
AuthorDate:    Tue, 10 Dec 2024 16:16:50 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 03 Feb 2025 08:00:14 -08:00

x86/entry: Add __init to ia32_emulation_override_cmdline()

ia32_emulation_override_cmdline() is an early_param() arg and these
are only needed at boot time. In fact, all other early_param() functions
in arch/x86 seem to have '__init' annotation and
ia32_emulation_override_cmdline() is the only exception.

Fixes: a11e097504ac ("x86: Make IA32_EMULATION boot time configurable")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/all/20241210151650.1746022-1-vkuznets%40redhat.com
---
 arch/x86/entry/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 94941c5..51efd2d 100644
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

