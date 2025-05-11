Return-Path: <linux-tip-commits+bounces-5519-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA163AB2780
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 May 2025 11:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C133BAFAF
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 May 2025 09:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2AF191F6A;
	Sun, 11 May 2025 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="21QlskRt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="euE0Iun4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30897184E;
	Sun, 11 May 2025 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746956836; cv=none; b=k/r83Ilp4rP5IzBp4Z8tITpEgHBHcS/7AlFk3mutPeXTg8ktQFvLcfhVsvoNGZAQnbmLcj4D0AEzct1ZLNxeS0PwrwkCZAyj5zYDB/eIY34xh7JRKIQAcFpYZWmyldRr6b4LqtpAVgos2ImpTRafERQJqhc0541kEzc8hQSxYtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746956836; c=relaxed/simple;
	bh=JgsLRPoHfVI0FmkKHM8XYJ+TGri+MUoSNGaKcxhktoM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PaA4cOcW4AsETXb+/Dg7YdB/tXSURpKwA0bHKZhABZ+8ULwG03rlyHw4iMPphxcDJz8hsKliTgtTnIV5oZ8EE9svfJnzsmpNF61LhZOLcBWWiqPYgTLfAof4sdXTtOCU53zgZZ3hMoGFFgjbqVlvaQerYTB/zu3AYdXLrc7YoDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=21QlskRt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=euE0Iun4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 11 May 2025 09:47:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746956832;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hd8PphlBAuMqIEqPyAgnkP+emeIlQvZgqNZrMmBw4lg=;
	b=21QlskRtDuil9abS7mKtqu22Khz/KgpQhATR+ZhAcAXT9vEBsZEUJMzC2zCKm8eRqrSOH9
	FyTNVMVlipIcadBUmvxszFUgd4/J+mwBC0nzXR3/lD8RiS0gTCs8UVn87PlynC93NAoTGi
	TIxgTfIrofwrcW0c6kD3A0nGkUtgGuWtxRCcqovY6GQOWYi9yKMjb0/F6IfWXdymscx8L2
	jeoSwwtG5dk5poI1i+TEcjR90gKw4oa05iRseDdnZsah/bgsfo0MKCQ+0m238+kbFsSZkD
	R/G4HEFwIlb6uV8Dpb/IZa1aIuNtGFptDogfwJmC6mngnueGPagBITmsYkVYQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746956832;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hd8PphlBAuMqIEqPyAgnkP+emeIlQvZgqNZrMmBw4lg=;
	b=euE0Iun4YBea9SFqIrpzttFTrzNnVxu0Hf9jBrHBUMqp1RTc47f+N3cltl7dss8fiiPYoR
	gfuzKGMHInja2YCA==
From: "tip-bot2 for Seongman Lee" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev: Fix operator precedence in
 GHCB_MSR_VMPL_REQ_LEVEL macro
Cc: Seongman Lee <augustus92@kaist.ac.kr>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250511092329.12680-1-cloudlee1719@gmail.com>
References: <20250511092329.12680-1-cloudlee1719@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174695683185.406.15235858727409884425.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f7387eff4bad33d12719c66c43541c095556ae4e
Gitweb:        https://git.kernel.org/tip/f7387eff4bad33d12719c66c43541c095556ae4e
Author:        Seongman Lee <augustus92@kaist.ac.kr>
AuthorDate:    Sun, 11 May 2025 18:23:28 +09:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 11 May 2025 11:38:03 +02:00

x86/sev: Fix operator precedence in GHCB_MSR_VMPL_REQ_LEVEL macro

The GHCB_MSR_VMPL_REQ_LEVEL macro lacked parentheses around the bitmask
expression, causing the shift operation to bind too early. As a result,
when requesting VMPL1 (e.g., GHCB_MSR_VMPL_REQ_LEVEL(1)), incorrect
values such as 0x000000016 were generated instead of the intended
0x100000016 (the requested VMPL level is specified in GHCBData[39:32]).

Fix the precedence issue by grouping the masked value before applying
the shift.

  [ bp: Massage commit message. ]

Fixes: 34ff65901735 ("x86/sev: Use kernel provided SVSM Calling Areas")
Signed-off-by: Seongman Lee <augustus92@kaist.ac.kr>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250511092329.12680-1-cloudlee1719@gmail.com
---
 arch/x86/include/asm/sev-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index acb85b9..0020d77 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -116,7 +116,7 @@ enum psc_op {
 #define GHCB_MSR_VMPL_REQ		0x016
 #define GHCB_MSR_VMPL_REQ_LEVEL(v)			\
 	/* GHCBData[39:32] */				\
-	(((u64)(v) & GENMASK_ULL(7, 0) << 32) |		\
+	((((u64)(v) & GENMASK_ULL(7, 0)) << 32) |	\
 	/* GHCBDdata[11:0] */				\
 	GHCB_MSR_VMPL_REQ)
 

