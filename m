Return-Path: <linux-tip-commits+bounces-3330-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BD8A27987
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Feb 2025 19:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6E118818F5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Feb 2025 18:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3692165E8;
	Tue,  4 Feb 2025 18:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ErP86Tfz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C9Q5VT5o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B88378F4A;
	Tue,  4 Feb 2025 18:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738692962; cv=none; b=YN+KP1UzcRT5v2/nmAY/Uq02BdtkO0ls0B/bUZ7b+jPI0wLhs53HQX/pY+W5otSJkd30KCaNLCTqbODiTUHr8j56lF+GrHY2zsICzDfV474An4tysd0FfoFpJY4tiHQ51/6JSYRRFabljQ3BQbRmn5ccSOe5BJaPclBkYQ4dAY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738692962; c=relaxed/simple;
	bh=SFlZmlOmwT2nlW8hyicRQhNsH7DoMqiXu2vKaE6u6sY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=jEoZvXIG/2ciFdcW6C7CgTLMoceSVGh4bZ3Zz2QmK5Hp8Dt+tWSNVS3qVSXDwf70BqKj4RO4oinhAXndhDFM0VZaX1XpbP2RUDnGEUWeqTzYpJgko91KhHmYQvjCoZgboq1c6vGWYERBZQhCdSVzxfbKoumVTJNgGK9qqC+j2Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ErP86Tfz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C9Q5VT5o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Feb 2025 18:15:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738692958;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=09mZG3QvtaPMaeEMUYTFhm4jYSe7Ocgg9ZIVlsFmEJQ=;
	b=ErP86TfzXHw2LSe5zL62ox+PjQiw36aQjXiCdwy9Yd9MPg0BhpDxVr6/rvrjjoAte6GTGO
	8BjFFAFUDhVThmsGP0SqvddTY7ygSKOnc2UX7B8BHjcMvZ05WlEx2fl2NM8DnrTgrMODC0
	xvWtAU6gTePNEMCQHdfgy+Wgt6dbQPpizHF16I62XUnrlqzgpbtR3RoTOljKnrU3hfUgiQ
	FrilG1IvoEcWqfSgCs1x5YOuRqgwdTFCUJRXh/AyNJCWe3BNKoDseStClNer1JY8Ys5bg0
	6h5nXopjTis+dIhT/vcxrwnU5x49R1b+ubQgcCjt3H1j/PZIaqSzFpntgZknuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738692958;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=09mZG3QvtaPMaeEMUYTFhm4jYSe7Ocgg9ZIVlsFmEJQ=;
	b=C9Q5VT5opXUNyHg8RGL2mm0ekDRoXR34QZOFbDsnl6pqVWsNmkA/JSocrJwGunKBOekwkb
	T7/H9NPeAkHrHzBQ==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/mtrr: Use str_enabled_disabled() helper in
 print_mtrr_state()
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Thorsten Blum <thorsten.blum@linux.dev>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173869295414.10177.6949720988870543292.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     e3cd85963a20d2b92e77046a8d9f0777815f1f71
Gitweb:        https://git.kernel.org/tip/e3cd85963a20d2b92e77046a8d9f0777815f1f71
Author:        Thorsten Blum <thorsten.blum@linux.dev>
AuthorDate:    Fri, 17 Jan 2025 15:48:59 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 04 Feb 2025 09:59:40 -08:00

x86/mtrr: Use str_enabled_disabled() helper in print_mtrr_state()

Remove hard-coded strings by using the str_enabled_disabled() helper
function.

Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20250117144900.171684-2-thorsten.blum%40linux.dev
---
 arch/x86/kernel/cpu/mtrr/generic.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 2fdfda2..6be3cad 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/cc_platform.h>
+#include <linux/string_choices.h>
 #include <asm/processor-flags.h>
 #include <asm/cacheinfo.h>
 #include <asm/cpufeature.h>
@@ -646,10 +647,10 @@ static void __init print_mtrr_state(void)
 	pr_info("MTRR default type: %s\n",
 		mtrr_attrib_to_str(mtrr_state.def_type));
 	if (mtrr_state.have_fixed) {
-		pr_info("MTRR fixed ranges %sabled:\n",
-			((mtrr_state.enabled & MTRR_STATE_MTRR_ENABLED) &&
-			 (mtrr_state.enabled & MTRR_STATE_MTRR_FIXED_ENABLED)) ?
-			 "en" : "dis");
+		pr_info("MTRR fixed ranges %s:\n",
+			str_enabled_disabled(
+			 (mtrr_state.enabled & MTRR_STATE_MTRR_ENABLED) &&
+			 (mtrr_state.enabled & MTRR_STATE_MTRR_FIXED_ENABLED)));
 		print_fixed(0x00000, 0x10000, mtrr_state.fixed_ranges + 0);
 		for (i = 0; i < 2; ++i)
 			print_fixed(0x80000 + i * 0x20000, 0x04000,
@@ -661,8 +662,8 @@ static void __init print_mtrr_state(void)
 		/* tail */
 		print_fixed_last();
 	}
-	pr_info("MTRR variable ranges %sabled:\n",
-		mtrr_state.enabled & MTRR_STATE_MTRR_ENABLED ? "en" : "dis");
+	pr_info("MTRR variable ranges %s:\n",
+		str_enabled_disabled(mtrr_state.enabled & MTRR_STATE_MTRR_ENABLED));
 	high_width = (boot_cpu_data.x86_phys_bits - (32 - PAGE_SHIFT) + 3) / 4;
 
 	for (i = 0; i < num_var_ranges; ++i) {

