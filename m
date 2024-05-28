Return-Path: <linux-tip-commits+bounces-1297-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FA78D20F5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 May 2024 17:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214271F22C3A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 May 2024 15:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8215C171E43;
	Tue, 28 May 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="khXtSJOW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ldc7Ke4N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0A317166F;
	Tue, 28 May 2024 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911988; cv=none; b=PRYIar43d2wSupCwaVju3Jm2CplHeA915Ruf02sIM91boe9GVv1pz8Tscpn+7AQiG1t99japQZuMYtLCXHvO2P5vv/nnvsnsiMbnGufGyp8RYYzwOP0A6l6EcY2VfkJy0P0+Y5iKApTzAZmyzm0ThQy6x+Cq7yndDL8qgis88ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911988; c=relaxed/simple;
	bh=4KjGV65nevJzZN9wUt2+pF2L7560wk8uKOA51KlaV64=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=CUEfX2sK1xKWw7GxVcOgxXmYFVjSbxjNJsWJr1GAIRyba3R/rnE1qSyqnv3/mFtFROGIc+l/q5LuP6rg3F6IKhpdL3fDcQMSZsy7ZTiodRBGNyysbQRJrSX0JG296QSrVRM7cWSfuCKRttQYJ7vZSzMPH+gH+oBCJoTSrcT1jNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=khXtSJOW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ldc7Ke4N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 May 2024 15:59:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716911985;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=edCrTL82cmdksGojdYAeBOaO8yEUnIrwiSSwOTbuEYE=;
	b=khXtSJOW3MbTMKBgg+llYpz//J3KOlOCj0lyQsoH7qqMQ7nHWnQg0S1nNjwOyuNqSJ9Jl9
	dw1T5HWg8hr/efeoL/usehyIx3on8Ot1VS3Ibu0LVkBMUa4ob3JDCcx9665wnf5q2XYkma
	5pP5HG8/l5Yq4Sri68/xD6/lzga9IM9K5uejPNTyCRbc7eAtFEaF2Q3rf8484tusP6FFwM
	kRsd497DkdpRF7ZT/w7UKpVptQYJUSiZAuI5uF/CVkaHqbMvTGDPTHy9gpMUSul9pvXZOw
	tq61q7yhmT3UIj+8BcZ6TlC9ldCWdS6jb1zU25YIdKbGI5iQ+d2Z7QWiWSFRnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716911985;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=edCrTL82cmdksGojdYAeBOaO8yEUnIrwiSSwOTbuEYE=;
	b=Ldc7Ke4N8xA1edPs1AQpjbF1KpjzpeVPofXCFmHNrUphewPlG+kOuHbagzYvAG/3Y+LdD8
	ImdBNeCpCLGx1nCg==
From: "tip-bot2 for Alison Schofield" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Remove useless work in detect_tme_early()
Cc: Alison Schofield <alison.schofield@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171691198482.10875.2782971348706799296.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     98b83cf0c1e22390ebfeb96b3c1b40f7189c558a
Gitweb:        https://git.kernel.org/tip/98b83cf0c1e22390ebfeb96b3c1b40f7189c558a
Author:        Alison Schofield <alison.schofield@intel.com>
AuthorDate:    Mon, 06 May 2024 21:24:21 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 28 May 2024 08:45:17 -07:00

x86/cpu: Remove useless work in detect_tme_early()

TME (Total Memory Encryption) and MKTME (Multi-Key Total Memory
Encryption) BIOS detection were introduced together here [1] and
are loosely coupled in the Intel CPU init code.

TME is a hardware only feature and its BIOS status is all that needs
to be shared with the kernel user: enabled or disabled. The TME
algorithm the BIOS is using and whether or not the kernel recognizes
that algorithm is useless to the kernel user.

MKTME is a hardware feature that requires kernel support. MKTME
detection code was added in advance of broader kernel support for
MKTME that never followed. So, rather than continuing to spew
needless and confusing messages about BIOS MKTME status, remove
most of the MKTME pieces from detect_tme_early().

Keep one useful message: alert the user when BIOS enabled MKTME
reduces the available physical address bits. Recovery of the MKTME
consumed bits requires a reboot with MKTME disabled in BIOS.

There is no functional change for the user, only a change in boot
messages. Below is one example when both TME and MKTME are enabled
in BIOS with AES_XTS_256 which is unknown to the detect tme code.

Before:
[] x86/tme: enabled by BIOS
[] x86/tme: Unknown policy is active: 0x2
[] x86/mktme: No known encryption algorithm is supported: 0x4
[] x86/mktme: enabled by BIOS
[] x86/mktme: 127 KeyIDs available

After:
[] x86/tme: enabled by BIOS
[] x86/mktme: BIOS enable: x86_phys_bits reduced by 8

[1]
commit cb06d8e3d020 ("x86/tme: Detect if TME and MKTME is activated by BIOS")

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/all/86dfdf6ced8c9b790f9376bf6c7e22b5608f47c2.1715054189.git.alison.schofield%40intel.com
---
 arch/x86/kernel/cpu/intel.c | 72 ++++++------------------------------
 1 file changed, 12 insertions(+), 60 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 3c3e7e5..3ef4e01 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -190,83 +190,35 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
 #define TME_ACTIVATE_LOCKED(x)		(x & 0x1)
 #define TME_ACTIVATE_ENABLED(x)		(x & 0x2)
 
-#define TME_ACTIVATE_POLICY(x)		((x >> 4) & 0xf)	/* Bits 7:4 */
-#define TME_ACTIVATE_POLICY_AES_XTS_128	0
-
 #define TME_ACTIVATE_KEYID_BITS(x)	((x >> 32) & 0xf)	/* Bits 35:32 */
 
-#define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	/* Bits 63:48 */
-#define TME_ACTIVATE_CRYPTO_AES_XTS_128	1
-
-/* Values for mktme_status (SW only construct) */
-#define MKTME_ENABLED			0
-#define MKTME_DISABLED			1
-#define MKTME_UNINITIALIZED		2
-static int mktme_status = MKTME_UNINITIALIZED;
-
 static void detect_tme_early(struct cpuinfo_x86 *c)
 {
-	u64 tme_activate, tme_policy, tme_crypto_algs;
-	int keyid_bits = 0, nr_keyids = 0;
-	static u64 tme_activate_cpu0 = 0;
+	u64 tme_activate;
+	int keyid_bits;
 
 	rdmsrl(MSR_IA32_TME_ACTIVATE, tme_activate);
 
-	if (mktme_status != MKTME_UNINITIALIZED) {
-		if (tme_activate != tme_activate_cpu0) {
-			/* Broken BIOS? */
-			pr_err_once("x86/tme: configuration is inconsistent between CPUs\n");
-			pr_err_once("x86/tme: MKTME is not usable\n");
-			mktme_status = MKTME_DISABLED;
-
-			/* Proceed. We may need to exclude bits from x86_phys_bits. */
-		}
-	} else {
-		tme_activate_cpu0 = tme_activate;
-	}
-
 	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
 		pr_info_once("x86/tme: not enabled by BIOS\n");
-		mktme_status = MKTME_DISABLED;
 		clear_cpu_cap(c, X86_FEATURE_TME);
 		return;
 	}
-
-	if (mktme_status != MKTME_UNINITIALIZED)
-		goto detect_keyid_bits;
-
-	pr_info("x86/tme: enabled by BIOS\n");
-
-	tme_policy = TME_ACTIVATE_POLICY(tme_activate);
-	if (tme_policy != TME_ACTIVATE_POLICY_AES_XTS_128)
-		pr_warn("x86/tme: Unknown policy is active: %#llx\n", tme_policy);
-
-	tme_crypto_algs = TME_ACTIVATE_CRYPTO_ALGS(tme_activate);
-	if (!(tme_crypto_algs & TME_ACTIVATE_CRYPTO_AES_XTS_128)) {
-		pr_err("x86/mktme: No known encryption algorithm is supported: %#llx\n",
-				tme_crypto_algs);
-		mktme_status = MKTME_DISABLED;
-	}
-detect_keyid_bits:
+	pr_info_once("x86/tme: enabled by BIOS\n");
 	keyid_bits = TME_ACTIVATE_KEYID_BITS(tme_activate);
-	nr_keyids = (1UL << keyid_bits) - 1;
-	if (nr_keyids) {
-		pr_info_once("x86/mktme: enabled by BIOS\n");
-		pr_info_once("x86/mktme: %d KeyIDs available\n", nr_keyids);
-	} else {
-		pr_info_once("x86/mktme: disabled by BIOS\n");
-	}
-
-	if (mktme_status == MKTME_UNINITIALIZED) {
-		/* MKTME is usable */
-		mktme_status = MKTME_ENABLED;
-	}
+	if (!keyid_bits)
+		return;
 
 	/*
-	 * KeyID bits effectively lower the number of physical address
-	 * bits.  Update cpuinfo_x86::x86_phys_bits accordingly.
+	 * KeyID bits are set by BIOS and can be present regardless
+	 * of whether the kernel is using them. They effectively lower
+	 * the number of physical address bits.
+	 *
+	 * Update cpuinfo_x86::x86_phys_bits accordingly.
 	 */
 	c->x86_phys_bits -= keyid_bits;
+	pr_info_once("x86/mktme: BIOS enabled: x86_phys_bits reduced by %d\n",
+		     keyid_bits);
 }
 
 static void early_init_intel(struct cpuinfo_x86 *c)

