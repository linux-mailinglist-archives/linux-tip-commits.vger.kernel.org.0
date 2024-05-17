Return-Path: <linux-tip-commits+bounces-1260-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE468C817B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 May 2024 09:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE756B217A6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 May 2024 07:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AC3179BC;
	Fri, 17 May 2024 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gApQhwtK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GT/09WRZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F141756A;
	Fri, 17 May 2024 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715931128; cv=none; b=gIoAqQpezVnZ6ZCKya6o1N89jFHwAxjjsX7+EKUbS5FD9nc8qcXV8UtO+EmA+s1CLaqcyOhIrOJVrBpbmghZ+JFGVPsdyN2KEb7xOEo+pvHI0Zl7+gSy+GoInIMD7msDGQ6ZxMDyL4bSHDa15c0teL0k9XvUIdAnSJbFPvcVPn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715931128; c=relaxed/simple;
	bh=gqkcCZvRiX/k4GA5Gbpege5eQAqhiSNpdUJT5RFobHc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KA8XNebuOxfHdFvxvPoGh+4tbHhrGY+gfiS7pplGIMuSvP446VS39oPnImCbG6KKP7FR1cpzZpKh6dl+2CghBm6CaUs0Sx/wi9JFykZY4IDJ3lKbRO5HKC6EPDgUWtPLjcfts8GEy3QpWfaSJuwYc9zzftcJ9mcNfjLsD3CKi7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gApQhwtK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GT/09WRZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 17 May 2024 07:32:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715931123;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJgv8HCEHdeT5gFLGPPWCUknS6qLxbtHeyTM557449M=;
	b=gApQhwtKUdAM/GQ0tURarEFlISi5xZThd0H3yZv7n0BnnAanOF4ERfC4Q38ouPWe+3H+qu
	XXZ9hcitueelpwwEhHKMuf+wj6fOefeeKxVeYGV05jZazmMLxGy26ElZeId2GNML8k5by2
	hUhC2gVblVTAL8Yfsq2FFGX6SoueKF00unBrU1xGDFjBGwqMtoV98UfgkxrKAjH5m28FPt
	tRGbdSBH6R/2c/Qn1xcDXnBM1f5hNACVkFWRfh2dFcjGpve6KPL/MUky47n19coIpvpmV7
	BEb9QymtXpoZ83Yip0crYM2GTsdYWS0kfzmlrJqPMXRx8GU7yTJZU8+6QtDq1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715931123;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJgv8HCEHdeT5gFLGPPWCUknS6qLxbtHeyTM557449M=;
	b=GT/09WRZcbZSM0bTnf+GwY34yrrQWhoX+HlrfYj+tmaQgQ1mO+72kfltca/0Dhjx4x86sG
	QXUKFjcgUFfERWCg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/alternatives: Use the correct length when
 optimizing NOPs
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240515104804.32004-1-bp@kernel.org>
References: <20240515104804.32004-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171593112299.10875.11428072723979116425.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     9dba9c67e52dbe0978c0e86c994891eba480adf0
Gitweb:        https://git.kernel.org/tip/9dba9c67e52dbe0978c0e86c994891eba480adf0
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 15 May 2024 12:48:04 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 17 May 2024 09:27:06 +02:00

x86/alternatives: Use the correct length when optimizing NOPs

Commit in Fixes moved the optimize_nops() call inside apply_relocation()
and made it a second optimization pass after the relocations have been
done.

Since optimize_nops() works only on NOPs, that is fine and it'll simply
jump over instructions which are not NOPs.

However, it made that call with repl_len as the buffer length to
optimize.

However, it can happen that there are alternatives calls like this one:

  alternative("mfence; lfence", "", ALT_NOT(X86_FEATURE_APIC_MSRS_FENCE));

where the replacement length is 0. And using repl_len is wrong because
apply_alternatives() expands the buffer size to the length of the source
insn that is being patched, by padding it with one-byte NOPs:

	for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
		insn_buff[insn_buff_sz] = 0x90;

Long story short: pass the length of the original instruction(s) as the
length of the temporary buffer which to optimize.

Result:

  SMP alternatives: feat: 11*32+27, old: (lapic_next_deadline+0x9/0x50 (ffffffff81061829) len: 6), repl: (ffffffff89b1cc60, len: 0) flags: 0x1
  SMP alternatives: ffffffff81061829:   old_insn: 0f ae f0 0f ae e8
  SMP alternatives: ffffffff81061829: final_insn: 90 90 90 90 90 90

=>

  SMP alternatives: feat: 11*32+27, old: (lapic_next_deadline+0x9/0x50 (ffffffff81061839) len: 6), repl: (ffffffff89b1cc60, len: 0) flags: 0x1
  SMP alternatives: ffffffff81061839: [0:6) optimized NOPs: 66 0f 1f 44 00 00
  SMP alternatives: ffffffff81061839:   old_insn: 0f ae f0 0f ae e8
  SMP alternatives: ffffffff81061839: final_insn: 66 0f 1f 44 00 00

Fixes: da8f9cf7e721 ("x86/alternatives: Get rid of __optimize_nops()")
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240515104804.32004-1-bp@kernel.org
---
 arch/x86/kernel/alternative.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 7555c15..89de612 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -372,7 +372,7 @@ static void __apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen,
 void apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen, u8 *repl, size_t repl_len)
 {
 	__apply_relocation(buf, instr, instrlen, repl, repl_len);
-	optimize_nops(instr, buf, repl_len);
+	optimize_nops(instr, buf, instrlen);
 }
 
 /* Low-level backend functions usable from alternative code replacements. */

