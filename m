Return-Path: <linux-tip-commits+bounces-6551-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A00B52A27
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 09:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F903BEFDC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 07:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556E727603B;
	Thu, 11 Sep 2025 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Os7ZarrS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5L/obEOT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7F2749D6;
	Thu, 11 Sep 2025 07:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576101; cv=none; b=EVteuIX6lVxgbvuFi74ELChLPElASDNbN7/em7oW/tLja+91jRx+NkpZu0LFQJmB/0HrnoMajLawZVK3DObdCXwNsibpCy4FmVIEF1pWooGfZyc0mh1qeJflKlIgrI4si4SNh0MLXmYgBmck3EjYVPMOM1tnO2/g7BSw8KN++d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576101; c=relaxed/simple;
	bh=mNhiYwpLWNIvfCX503oR5DKqzFPvuFk30NUIb4qJ0Ao=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=PllRGxLUi02FZCCZ221VuONxnWVB8KXv93Ko/2pYG1jF13zFwIojAPs6F1uEve4V3OpTEIGOUJFSyugUKJby6PJaSaX3B9LITDXF2xzMYbjRfWTKY7EUZRz+Q3Rt2rp1Qgtxi+3X9kEz4tJNitTggSf8CqJzj+PGlzkZH2ix1qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Os7ZarrS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5L/obEOT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Sep 2025 07:34:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757576097;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=LJJSUr/WX8FyDT9kdL9Ox4flHmIZ/Z/isGoxrkLQTJI=;
	b=Os7ZarrSFQWO3E2A3tqZF52iDdBkqKwN03lEhxhRaZ5siFdgpfQf9JM/lTQoWTnzZ0fRZb
	FCh8Bkkt3AmOScjjiFlvXQBV0iYktDOrAJiRnL4CuwYnDZFMNdFlUx97zmbdq7xcooTcLV
	HFom/ZmFA/Gz6UHWlA4stq/vAwpDv5dJ4azWFbJw5D2d/seXnFzB2cMExKjcOcfYiaMllg
	J2dpD0guQc0D2ii+pPa9ZQGylZKpfmmZqE7Y56/QBdcmQFVOdZd149pxg3NxrIA3EoLj+2
	8vq1b5Y1cV5CmizCK3mMZfNcK/5twYDeCSJdfYbyMP+d1CNrtXB2vdSggERgjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757576097;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=LJJSUr/WX8FyDT9kdL9Ox4flHmIZ/Z/isGoxrkLQTJI=;
	b=5L/obEOTRMWLw/Wdb4dpllvguSzhKLRrqsKIvwDpx3kC8RTJl45hkDOMJjYijT3RFM4ftY
	TuM5bqPwItp0AlBg==
From: "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/cfi: Standardize on common "CFI:" prefix for CFI reports
Cc: Kees Cook <kees@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175757609651.709179.1236637162490468258.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     9f303a35d1df27cdc7b895b077985b0e1c4473c2
Gitweb:        https://git.kernel.org/tip/9f303a35d1df27cdc7b895b077985b0e1c4=
473c2
Author:        Kees Cook <kees@kernel.org>
AuthorDate:    Wed, 03 Sep 2025 20:46:43 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Sep 2025 21:59:08 +02:00

x86/cfi: Standardize on common "CFI:" prefix for CFI reports

Use a regular "CFI:" prefix for CFI reports during alternatives setup,
including reporting when nothing has happened (i.e. CONFIG_FINEIBT=3Dn).

Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20250904034656.3670313-4-kees@kernel.org
---
 arch/x86/kernel/alternative.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 7bde682..d8f4ac9 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1266,26 +1266,26 @@ static __init int cfi_parse_cmdline(char *str)
 		} else if (!strcmp(str, "norand")) {
 			cfi_rand =3D false;
 		} else if (!strcmp(str, "warn")) {
-			pr_alert("CFI mismatch non-fatal!\n");
+			pr_alert("CFI: mismatch non-fatal!\n");
 			cfi_warn =3D true;
 		} else if (!strcmp(str, "paranoid")) {
 			if (cfi_mode =3D=3D CFI_FINEIBT) {
 				cfi_paranoid =3D true;
 			} else {
-				pr_err("Ignoring paranoid; depends on fineibt.\n");
+				pr_err("CFI: ignoring paranoid; depends on fineibt.\n");
 			}
 		} else if (!strcmp(str, "bhi")) {
 #ifdef CONFIG_FINEIBT_BHI
 			if (cfi_mode =3D=3D CFI_FINEIBT) {
 				cfi_bhi =3D true;
 			} else {
-				pr_err("Ignoring bhi; depends on fineibt.\n");
+				pr_err("CFI: ignoring bhi; depends on fineibt.\n");
 			}
 #else
-			pr_err("Ignoring bhi; depends on FINEIBT_BHI=3Dy.\n");
+			pr_err("CFI: ignoring bhi; depends on FINEIBT_BHI=3Dy.\n");
 #endif
 		} else {
-			pr_err("Ignoring unknown cfi option (%s).", str);
+			pr_err("CFI: Ignoring unknown option (%s).", str);
 		}
=20
 		str =3D next;
@@ -1757,7 +1757,7 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *=
end_retpoline,
 	switch (cfi_mode) {
 	case CFI_OFF:
 		if (builtin)
-			pr_info("Disabling CFI\n");
+			pr_info("CFI: disabled\n");
 		return;
=20
 	case CFI_KCFI:
@@ -1766,7 +1766,8 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *=
end_retpoline,
 			goto err;
=20
 		if (builtin)
-			pr_info("Using kCFI\n");
+			pr_info("CFI: Using %sretpoline kCFI\n",
+				cfi_rand ? "rehashed " : "");
 		return;
=20
 	case CFI_FINEIBT:
@@ -2005,6 +2006,8 @@ bool decode_fineibt_insn(struct pt_regs *regs, unsigned=
 long *target, u32 *type)
 static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 			    s32 *start_cfi, s32 *end_cfi, bool builtin)
 {
+	if (IS_ENABLED(CONFIG_CFI) && builtin)
+		pr_info("CFI: Using standard kCFI\n");
 }
=20
 #ifdef CONFIG_X86_KERNEL_IBT

