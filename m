Return-Path: <linux-tip-commits+bounces-1366-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC839041E1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 18:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EDA828BC80
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 16:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D82E4D8AB;
	Tue, 11 Jun 2024 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cDMhZyge";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rv1RE2gj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A973E4644C;
	Tue, 11 Jun 2024 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124838; cv=none; b=m+rZZqQXOPDUSehzqOh3qxUnztvyn5xs0eAtVNmxmt93vms0JZ/ipV+w9/+Q8ZpWhiBt9XXON2dN4xb0X/0CURavAQtF04kKtNLt1fHjt/oJESgPrz1c13HRUJm0J/FFdn2SR7RGW5+QINoMVGPVRPXODK9Gm0kQPrAIPsxuIuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124838; c=relaxed/simple;
	bh=3Ma9C32kfSDJryVc00eJ7KFkpByb9Qt3TMRjlBO3xbw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lnrhq6I62u6gGMozquXsFNuhWxO2U9YrOxRsLoE27SNkvkIdQFVUwpuE/LuGIh74PEWgjmIFHmfplcBg/iBg0ewm91dykU75lDISA3r6KO5+WuyTOsr6E5xFJ4zFYl2Z5G1vx6MWrqL0GIBd8ryDapF5CGN5K4R0FN4NdqXL83w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cDMhZyge; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rv1RE2gj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Jun 2024 16:53:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718124827;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+hjt4Z/0LAf7Zw7Fl/GmDhRIH7PpR6e4+SLHZhL/qs=;
	b=cDMhZyge/WzZYNbiOD6NYzehWYmxePXw6k9qM5UGoJVlLGEyvO/DnlZTwcIlNWPWHBj4RD
	10pDTz1txG018nfc9uhijJr3E2+8mplY5RxGMokANXrW7Lq8ISfm4TpbUu2pgOzHaIPLPa
	NS9cpzcIHXrp+RECdMMN0OMURmaQbyiit0uyZV8dFwB1ZBUFmpCZWUlRbHCUemVSlNk0Oe
	6cuVyOC7VquLqo6i6y+2uSTcmcuQl9caGccE7uo0SXJSzwFMYjToOgtcYi1Q1bL6FKwCO+
	TML3NG01E9Cz4eAMOzbg8n68CppSIEYuAZ82qPl9mCdmQ6KJbhVyFlXqqn2G/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718124827;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+hjt4Z/0LAf7Zw7Fl/GmDhRIH7PpR6e4+SLHZhL/qs=;
	b=rv1RE2gjUg58xzVuHHemnBJrnnIMzNl1QdyGxMY8Mr/sT3HW7dy8pUwYLDb6Autv9loAyk
	g5QgZnN7opVz2yBw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternative: Convert the asm
 ALTERNATIVE_3() macro
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240607111701.8366-14-bp@kernel.org>
References: <20240607111701.8366-14-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171812482705.10875.5055811724400884708.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     1a6ade825079243f08846870561aca0e1fdfb803
Gitweb:        https://git.kernel.org/tip/1a6ade825079243f08846870561aca0e1fdfb803
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 07 Jun 2024 13:17:00 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 11 Jun 2024 18:29:26 +02:00

x86/alternative: Convert the asm ALTERNATIVE_3() macro

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240607111701.8366-14-bp@kernel.org
---
 arch/x86/include/asm/alternative.h | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 28e07a0..5278cfb 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -466,31 +466,6 @@ void nop_func(void);
 .endm
 
 .macro ALTERNATIVE_3 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2, newinstr3, ft_flags3
-140:
-	\oldinstr
-141:
-	.skip -((alt_max_3(new_len1, new_len2, new_len3) - (old_len)) > 0) * \
-		(alt_max_3(new_len1, new_len2, new_len3) - (old_len)),0x90
-142:
-
-	.pushsection .altinstructions,"a"
-	altinstr_entry 140b,143f,\ft_flags1,142b-140b,144f-143f
-	altinstr_entry 140b,144f,\ft_flags2,142b-140b,145f-144f
-	altinstr_entry 140b,145f,\ft_flags3,142b-140b,146f-145f
-	.popsection
-
-	.pushsection .altinstr_replacement,"ax"
-143:
-	\newinstr1
-144:
-	\newinstr2
-145:
-	\newinstr3
-146:
-	.popsection
-.endm
-
-.macro N_ALTERNATIVE_3 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2, newinstr3, ft_flags3
 	__N_ALTERNATIVE(N_ALTERNATIVE_2(\oldinstr, \newinstr1, \ft_flags1, \newinstr2, \ft_flags2),
 		      \newinstr3, \ft_flags3)
 .endm

