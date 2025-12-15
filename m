Return-Path: <linux-tip-commits+bounces-7694-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 846B3CBCBF8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 08:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ADCD3007C6F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 07:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F692D7DE4;
	Mon, 15 Dec 2025 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TKhXyvkX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vxZ5Z30b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDBE2222B6;
	Mon, 15 Dec 2025 07:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765783123; cv=none; b=r4ggOiiyZEqgtOPGDfit9KlPQlWa4pPCTE62XzprecVeM6Bd22HY1FWp7v42raHsk8J8+yNNlfL/4/XsKFDuIw9Fg5EMjLYahkysqRJhHbH/wNEx7U32q1dWnyp1jT134GGLO5d4SNttSgp/BHPcxouWXXEnAh0Hro9cA0aOOr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765783123; c=relaxed/simple;
	bh=BkrOo9B4f1jbZAGHZ9+kErImDRzr7mRfhdhaqecSGnQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FoAks4oJqQxCt4xysJUUUaroUYhBhrnMDHAgM9SZJC/JKBxKNZS4QJDeE0uydmfi+5GjpORuqLV/XoCDo2Fsv0iuvjvqI09rWh+Zzd+dUsyLYvoTLjjUqbX41ESbc3DrMEmm+Dh9ckr72iL9cNYzrGb4uPIzNVC0nPXlsntBVyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TKhXyvkX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vxZ5Z30b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 07:18:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765783119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uuw+12DsJ7ameAUEDlAZaliFXEdZrO+9D9kyowPLz6Y=;
	b=TKhXyvkXLRXSn/0427YMLB1SX98SnTJiSKtgPfZ1HOlTVjkRPTsRNWLlm7qjN4Cfx4Fx/g
	M/jie684Berexuhxij3ag4F4LsYTZotft+rbyfwvFNtQWbBbLGSi/Zc7GZZ278nRYp5g6D
	AL6BOwMHGltlRHQByjTSIqytn0ie4rmAd7Y8XQpo6sOU0XErELXJqWst0GEZgjc0h1ZrfB
	4sdCncnQlsSL54PWvCGatNVhFEF/Qbo5Gpi5q8sjEX720njS05tjKwrExpwaylXDwtHVfP
	NJjCgEVLzfBWqZcWEHd/9GTQHxDkMkW9KUNQ15F/bpEyUA3/ikMMPPkaTN4H1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765783119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uuw+12DsJ7ameAUEDlAZaliFXEdZrO+9D9kyowPLz6Y=;
	b=vxZ5Z30bXOOW0XneCzWcPqTkSliLAAjc4r+rpfcCx24A+mTwhmTd/G8iMqYxJ5Zf6AIG+3
	qTuCuxLKP03RI1Cg==
From: "tip-bot2 for Andrew Cooper" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/amd: Correct the microcode table for Zenbleed
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, Ingo Molnar <mingo@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Mario Limonciello <mario.limonciello@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251126130352.880424-1-andrew.cooper3@citrix.com>
References: <20251126130352.880424-1-andrew.cooper3@citrix.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176578311818.498.18390208161254339658.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     fb7bfa31b8e8569f154f2fe0ea6c2f03c0f087aa
Gitweb:        https://git.kernel.org/tip/fb7bfa31b8e8569f154f2fe0ea6c2f03c0f=
087aa
Author:        Andrew Cooper <andrew.cooper3@citrix.com>
AuthorDate:    Wed, 26 Nov 2025 13:03:52=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:54:46 +01:00

x86/cpu/amd: Correct the microcode table for Zenbleed

The good revisions are tied to exact steppings, meaning it's not valid to
match on model number alone, let alone a range.

This is probably only a latent issue.  From public microcode archives, the
following CPUs exist 17-30-00, 17-60-00, 17-70-00 and would be captured by the
model ranges.  They're likely pre-production steppings, and likely didn't get
Zenbleed microcode, but it's still incorrect to compare them to a different
steppings revision.

Either way, convert the logic to use x86_match_min_microcode_rev(), which is
the preferred mechanism.

Fixes: 522b1d69219d ("x86/cpu/amd: Add a Zenbleed fix")
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: x86@kernel.org
Link: https://patch.msgid.link/20251126130352.880424-1-andrew.cooper3@citrix.=
com
---
 arch/x86/kernel/cpu/amd.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index bc94ff1..86059f2 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -951,26 +951,14 @@ static void init_amd_zen1(struct cpuinfo_x86 *c)
 	}
 }
=20
-static bool cpu_has_zenbleed_microcode(void)
-{
-	u32 good_rev =3D 0;
-
-	switch (boot_cpu_data.x86_model) {
-	case 0x30 ... 0x3f: good_rev =3D 0x0830107b; break;
-	case 0x60 ... 0x67: good_rev =3D 0x0860010c; break;
-	case 0x68 ... 0x6f: good_rev =3D 0x08608107; break;
-	case 0x70 ... 0x7f: good_rev =3D 0x08701033; break;
-	case 0xa0 ... 0xaf: good_rev =3D 0x08a00009; break;
-
-	default:
-		return false;
-	}
-
-	if (boot_cpu_data.microcode < good_rev)
-		return false;
-
-	return true;
-}
+static const struct x86_cpu_id amd_zenbleed_microcode[] =3D {
+	ZEN_MODEL_STEP_UCODE(0x17, 0x31, 0x0, 0x0830107b),
+	ZEN_MODEL_STEP_UCODE(0x17, 0x60, 0x1, 0x0860010c),
+	ZEN_MODEL_STEP_UCODE(0x17, 0x68, 0x1, 0x08608107),
+	ZEN_MODEL_STEP_UCODE(0x17, 0x71, 0x0, 0x08701033),
+	ZEN_MODEL_STEP_UCODE(0x17, 0xa0, 0x0, 0x08a00009),
+	{}
+};
=20
 static void zen2_zenbleed_check(struct cpuinfo_x86 *c)
 {
@@ -980,7 +968,7 @@ static void zen2_zenbleed_check(struct cpuinfo_x86 *c)
 	if (!cpu_has(c, X86_FEATURE_AVX))
 		return;
=20
-	if (!cpu_has_zenbleed_microcode()) {
+	if (!x86_match_min_microcode_rev(amd_zenbleed_microcode)) {
 		pr_notice_once("Zenbleed: please update your microcode for the most optima=
l fix\n");
 		msr_set_bit(MSR_AMD64_DE_CFG, MSR_AMD64_DE_CFG_ZEN2_FP_BACKUP_FIX_BIT);
 	} else {

