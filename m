Return-Path: <linux-tip-commits+bounces-4486-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05D2A6EC42
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82B0716F61E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9642571BF;
	Tue, 25 Mar 2025 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IUUP1agJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zQIe9s0D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84F82566E7;
	Tue, 25 Mar 2025 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893549; cv=none; b=lk6hWT8FmkMpwuB1gZGBgzIuudGUarvDjIQMx+jGYX8aP83XMug7xi1UgrgcvG+Gjr0crcGN3RI1+8dXy1tq3CDIc9I74Gvult3XjZCjKjjyRYyG6Vk+DuebO1yGrB3bC9nmAfltav6Qk5tTrcJXE4yth5ekar8sz0Eqb4e2M20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893549; c=relaxed/simple;
	bh=5AjOoxUjn7/zKgJE1wFi83xGSABtL1gO+B680Ti6VuU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VnUxM4Ny+Ftw1wYwNXnEUqxNm48ZE9rsR4Mj+DxoHNuizV0NHULt08YnAUc/sp/eKJoIWk3SuaZhje9iVOj8uWSGUWsHEyAvLrBLSpUh+l8wcVsuPdrYMIrxV2zpupxQyXuATOWokUXLviM4jBtmjUbbvCpPeptSlNibV6OvwTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IUUP1agJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zQIe9s0D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:05:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742893546;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YMI78yy7S7QQu1xjQI72A/aRo7Mh2An8r2fkYAcQnAI=;
	b=IUUP1agJdx72aoYtrlajpxWE3t8gd3A5BMHUKQbdUCBbBEQcQcX1iXFFK9rTry0utIxFp1
	fqgOnI38pRjItKwlTMRqk55dudChwXq8vQj15WlzG3fp5E9nGhI9HkJHo/JNqLRvkUzabX
	fEI1TkSiHpoQKOOneRgFWeph/Uf2edZg68/Ayefd71YR8Z1hKZRCkvUkQco2SR6pfPKxjD
	CGgRDm5T96e4oWNoFPfxSfCk/2CuyedXCwKNbHTabc97wbeSO+mrRpnPFeWn692gf3K+ib
	mSaAe8ULsV8Z7hAcRSTtUoTIUe/ib+vLVeluyfbpumZDKZ6YpQBmzWzw3sTu/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742893546;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YMI78yy7S7QQu1xjQI72A/aRo7Mh2An8r2fkYAcQnAI=;
	b=zQIe9s0DQTVr6NLVy3IK4I5tQdrlQgi3oIoE5Y7g6HePGaoA/Oz4ZJkGwmEyQoyD2kruPy
	qu/ZdLICtEmjsVCA==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] tools/x86/kcpuid: Save CPUID output in an array
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324142042.29010-5-darwi@linutronix.de>
References: <20250324142042.29010-5-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289354545.14745.3592894898931165685.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     6bef74cab03ada39f16f1fb86b732f7c71a9f07a
Gitweb:        https://git.kernel.org/tip/6bef74cab03ada39f16f1fb86b732f7c71a9f07a
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 15:20:25 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:53:44 +01:00

tools/x86/kcpuid: Save CPUID output in an array

For each CPUID leaf/subleaf query, save the output in an output[] array
instead of spelling it out using EAX to EDX variables.

This allows the CPUID output to be accessed programmatically instead of
calling decode_bits() four times.  Loop-based access also allows "kcpuid
--detail" to print the correct output register names in next commit.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250324142042.29010-5-darwi@linutronix.de
---
 tools/arch/x86/kcpuid/kcpuid.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index a90ac0b..8da0e07 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -51,7 +51,7 @@ static const char * const reg_names[] = {
 struct subleaf {
 	u32 index;
 	u32 sub;
-	u32 eax, ebx, ecx, edx;
+	u32 output[NR_REGS];
 	struct reg_desc info[NR_REGS];
 };
 
@@ -119,11 +119,11 @@ static void leaf_print_raw(struct subleaf *leaf)
 		if (leaf->sub == 0)
 			printf("0x%08x: subleafs:\n", leaf->index);
 
-		printf(" %2d: EAX=0x%08x, EBX=0x%08x, ECX=0x%08x, EDX=0x%08x\n",
-			leaf->sub, leaf->eax, leaf->ebx, leaf->ecx, leaf->edx);
+		printf(" %2d: EAX=0x%08x, EBX=0x%08x, ECX=0x%08x, EDX=0x%08x\n", leaf->sub,
+		       leaf->output[0], leaf->output[1], leaf->output[2], leaf->output[3]);
 	} else {
-		printf("0x%08x: EAX=0x%08x, EBX=0x%08x, ECX=0x%08x, EDX=0x%08x\n",
-			leaf->index, leaf->eax, leaf->ebx, leaf->ecx, leaf->edx);
+		printf("0x%08x: EAX=0x%08x, EBX=0x%08x, ECX=0x%08x, EDX=0x%08x\n", leaf->index,
+		       leaf->output[0], leaf->output[1], leaf->output[2], leaf->output[3]);
 	}
 }
 
@@ -163,10 +163,10 @@ static bool cpuid_store(struct cpuid_range *range, u32 f, int subleaf,
 
 	leaf->index = f;
 	leaf->sub = subleaf;
-	leaf->eax = a;
-	leaf->ebx = b;
-	leaf->ecx = c;
-	leaf->edx = d;
+	leaf->output[R_EAX] = a;
+	leaf->output[R_EBX] = b;
+	leaf->output[R_ECX] = c;
+	leaf->output[R_EDX] = d;
 
 	return false;
 }
@@ -490,10 +490,8 @@ static void show_leaf(struct subleaf *leaf)
 				leaf->index, leaf->sub);
 	}
 
-	decode_bits(leaf->eax, &leaf->info[R_EAX], R_EAX);
-	decode_bits(leaf->ebx, &leaf->info[R_EBX], R_EBX);
-	decode_bits(leaf->ecx, &leaf->info[R_ECX], R_ECX);
-	decode_bits(leaf->edx, &leaf->info[R_EDX], R_EDX);
+	for (int i = R_EAX; i < NR_REGS; i++)
+		decode_bits(leaf->output[i], &leaf->info[i], i);
 
 	if (!show_raw && show_details)
 		printf("\n");

