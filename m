Return-Path: <linux-tip-commits+bounces-7764-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB13CCB850
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Dec 2025 12:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 286B3304FA87
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Dec 2025 11:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2B831353D;
	Thu, 18 Dec 2025 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="09bjdTtx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D+SBuChL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A6831329E;
	Thu, 18 Dec 2025 11:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055808; cv=none; b=blD5ZtPIQhNiWD7aIM7IVlpGjQx5hcZVLg5DDe+wKYnIMAh5Zk7JB3tUbtIhhI25P66oz/5Hfaux0bK9WSQpFvXf4IHYQsfeZdNxAgpqNLUSNEFIaKmyHUR0lb2z/4DMnA0G7BFO581uFQBMWva66yPND0uwhuYcZ5TfOaSBa5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055808; c=relaxed/simple;
	bh=bgrY3kf2TtkuYIWZgcgWHlrKk2XXmCreHldVCnGCOqA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RwGiXxrmZmZMofuhBfSSvxRt8f/9o7PpfA75vD5wIsSsRJHBu4nuSXKC87A4B3c00zSNG8JHX+kfjZKmkIgMjSPW5zNmF2TYQmslLtPWekImyX+xNF0fs05mquBz+pas9SYdBZeYkaYvDWkXJSbedoqSsqMoE9MZm9ycAIbQD2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=09bjdTtx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D+SBuChL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Dec 2025 11:03:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766055799;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jc89sek63E/5OMdPfol8LddeSPYoiXuj1WKItPMgh5Y=;
	b=09bjdTtxcqyXKSFjZmi7bweHWZAslCnhvw0t02PmnUAfsNDPJWAzWgwQZeD9BNx2zbKVRw
	VSfi2i9vkQyqqOOfcyUb11heg226VmmAtp4y11yINGWcWVbtmGhXjMY9Sf7V2i2ax0Vvq9
	bok7Jup235aZWk0y+Ic6uHKq9lrMUASSgfEGMhHww5hBGmyLRbJcd6RQh1QjIHW8hn92eB
	3HuQHxgzkiP0yKEsQA94txYj1ZFXOZYTTaYcJ7GxYLjaBdQtT6dE4s7ngRqdX7ErvJ7Upd
	in+JQcnpVPues1aid5tb7TV9V27viPiIMQogiOMgzL6fU2xFiT+xUTfQ9ocQ7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766055799;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jc89sek63E/5OMdPfol8LddeSPYoiXuj1WKItPMgh5Y=;
	b=D+SBuChLf9Sk0Ec1SI/rCFgarxaq4eqohQbuxx2GHBl/+0Mzg0Tse78mmthVvHCuB9SS1U
	ANd5I3fOejYYa+Cw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bug: Fix old GCC compile fails
Cc: Jean Delvare <jdelvare@suse.de>, Uros Bizjak <ubizjak@gmail.com>,
 stable@kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251218104659.GT3911114@noisy.programming.kicks-ass.net>
References: <20251218104659.GT3911114@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176605579804.510.611059138660243857.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c56a12c71ad38f381105f6e5036dede64ad2dfee
Gitweb:        https://git.kernel.org/tip/c56a12c71ad38f381105f6e5036dede64ad=
2dfee
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 18 Dec 2025 11:47:38 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 18 Dec 2025 11:55:40 +01:00

x86/bug: Fix old GCC compile fails

For some mysterious reasons the GCC 8 and 9 preprocessor manages to
sporadically fumble _ASM_BYTES(0x0f, 0x0b):

$ grep ".byte[ ]*0x0f" defconfig-build/drivers/net/wireless/realtek/rtlwifi/b=
ase.s
        1:       .byte0x0f,0x0b ;
        1:       .byte 0x0f,0x0b ;

which makes the assembler upset and all that. While there are more
_ASM_BYTES() users (notably the NOP instructions), those don't seem
affected. Therefore replace the offending ASM_UD2 with one using the
ud2 mnemonic.

Reported-by: Jean Delvare <jdelvare@suse.de>
Suggested-by: Uros Bizjak <ubizjak@gmail.com>
Fixes: 85a2d4a890dc ("x86,ibt: Use UDB instead of 0xEA")
Cc: stable@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251218104659.GT3911114@noisy.programming.kic=
ks-ass.net
---
 arch/x86/include/asm/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index ee23b98..40de579 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -15,7 +15,7 @@ extern void __WARN_trap(struct bug_entry *bug, ...);
 /*
  * Despite that some emulators terminate on UD2, we use it for WARN().
  */
-#define ASM_UD2		_ASM_BYTES(0x0f, 0x0b)
+#define ASM_UD2		__ASM_FORM(ud2)
 #define INSN_UD2	0x0b0f
 #define LEN_UD2		2
=20

