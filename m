Return-Path: <linux-tip-commits+bounces-3162-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EF49FF3F4
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2025 13:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50A318824BA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2025 12:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692911E1C01;
	Wed,  1 Jan 2025 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V7AocsyX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0javxTEr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CFD1C75E2;
	Wed,  1 Jan 2025 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735733658; cv=none; b=WsA+bCFKxBvKyIJgBi0ek+9DuAV+c9GhclYf4u9v5ktTFQs3vxw48Ygj5pzzRK8EGoEiMEdvBb7WyTNrzTJF8eYHJSV3rGcSp74kv3Yrj/HgXaWc6IgUZhIJtygHkLl8RiLZYUinhpTGjXCuss/SaBgw3WaDtZAx/BdWfKGrou8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735733658; c=relaxed/simple;
	bh=3z1D/hClfaAEf82BedEHzzs05lmvGeDEHrJKHyI+Nsc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=G04Jtfz/kqjfpDmO7wt75tvlTJV9CXpRK7mQSD2W2cJFcJYE2aOS117pNXCSEvmuTxWLHE0uvwsX7qp7ZYIzxkERq+/dz6DoAZY78mNlI07kwvR53H8Qh6jEUynG2Zxk3tu16GyrDqUeJO+Vm2/CoOYXKHD35uD/283qff5dpTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V7AocsyX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0javxTEr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 01 Jan 2025 12:14:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735733655;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=PnwY/Y4ysWtVbVouTzkeB6WxjaMfYFuUdw+wGzUMhfE=;
	b=V7AocsyXt+5/Wo3aLN+zEsAqmNVFPitBl0sukEdcTpZeQZV1zb9LjNlKxO/dbNO8ky6Xv5
	NJBlEnAUB4YYIkHx/b4di9qTs5taGcx91Tg2FKyOxeNLlMEmBHJlcEKZWwIyBlJImmE0wL
	9JIy+N9oxaEUJQ4HxgwJYCeOjKrkHIWpgTWKr+E4GYOy+N8Rq3M4BnO/PG2N5Yrmw/sAtz
	vD+eUi5Js9oBAD3HhF8DG3Mdz5DVD5wtTzjVu3Htzf11rCfKMo2CKJDygEQ3hgHsZTVW6X
	hBsh3S3zMAtyBUY1e1fVmnmxBh6r9Fj0eqyH8onisnTfsdWBXhfBFAbF4HB1og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735733655;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=PnwY/Y4ysWtVbVouTzkeB6WxjaMfYFuUdw+wGzUMhfE=;
	b=0javxTErxdWq+G9Z1ofMcQBvBmKnKW407aykEx8IkMOeiEvHvJkPKg1cttCGWL7bb3mOE2
	yQyymQWc8Hx+oeAA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Have __apply_microcode_amd()
 return bool
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173573365481.399.4600220634107593402.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     78e0aadbd4c6807a06a9d25bc190fe515d3f3c42
Gitweb:        https://git.kernel.org/tip/78e0aadbd4c6807a06a9d25bc190fe515d3f3c42
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 18 Nov 2024 17:17:24 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 31 Dec 2024 14:03:39 +01:00

x86/microcode/AMD: Have __apply_microcode_amd() return bool

This is the natural thing to do anyway.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 9a5ebbb..ac3fd07 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -484,7 +484,7 @@ static void scan_containers(u8 *ucode, size_t size, struct cont_desc *desc)
 	}
 }
 
-static int __apply_microcode_amd(struct microcode_amd *mc, unsigned int psize)
+static bool __apply_microcode_amd(struct microcode_amd *mc, unsigned int psize)
 {
 	unsigned long p_addr = (unsigned long)&mc->hdr.data_code;
 	u32 rev, dummy;
@@ -508,9 +508,9 @@ static int __apply_microcode_amd(struct microcode_amd *mc, unsigned int psize)
 	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
 
 	if (rev != mc->hdr.patch_id)
-		return -1;
+		return false;
 
-	return 0;
+	return true;
 }
 
 /*
@@ -544,7 +544,7 @@ static bool early_apply_microcode(u32 old_rev, void *ucode, size_t size)
 	if (old_rev > mc->hdr.patch_id)
 		return ret;
 
-	return !__apply_microcode_amd(mc, desc.psize);
+	return __apply_microcode_amd(mc, desc.psize);
 }
 
 static bool get_builtin_microcode(struct cpio_data *cp)
@@ -763,7 +763,7 @@ void reload_ucode_amd(unsigned int cpu)
 	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
 
 	if (rev < mc->hdr.patch_id) {
-		if (!__apply_microcode_amd(mc, p->size))
+		if (__apply_microcode_amd(mc, p->size))
 			pr_info_once("reload revision: 0x%08x\n", mc->hdr.patch_id);
 	}
 }
@@ -816,7 +816,7 @@ static enum ucode_state apply_microcode_amd(int cpu)
 		goto out;
 	}
 
-	if (__apply_microcode_amd(mc_amd, p->size)) {
+	if (!__apply_microcode_amd(mc_amd, p->size)) {
 		pr_err("CPU%d: update failed for patch_level=0x%08x\n",
 			cpu, mc_amd->hdr.patch_id);
 		return UCODE_ERROR;

