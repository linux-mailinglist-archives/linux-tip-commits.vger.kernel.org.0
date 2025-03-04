Return-Path: <linux-tip-commits+bounces-3915-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E24A4DAD2
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C12B27A286D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110621FFC4E;
	Tue,  4 Mar 2025 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KjpGxn+g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3nm+2ccI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D761FF1B2;
	Tue,  4 Mar 2025 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084590; cv=none; b=CixhOPlabmvoBal5uWKOuXfLgxD8/k1ys/2wIwF9Sxhsrj2LH1grMNeeVwzUhkj5ld1Fjv+NgBrxddgKH0dtv91kP35np2TgbOUH79UapE7K0HDe9wDTFO9xTxbDzmijSM+m/gLEwgM3ZrEFyqLtbSdYiZMLGQhGN13l5PsMtjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084590; c=relaxed/simple;
	bh=/pjNL7wjQywTb42xdsw4ycPyw4TRJaPXyWDNZLGoJ3Q=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=IjOVKBe95UAG+x2ANrJSnDD3Mqiyal39jsy2/f05H8WuYi17jYaNIRSPSYG0a6qjtYXj+iRCKkogqz+wnORmpr2JW1BghdDDw7snXPWPunZikLGcglWZp1sl28Z0hYwS4e6YJaHIIZzlgBiSGuSPvlJ23M9U2JZZUsEP6D7DKcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KjpGxn+g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3nm+2ccI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:36:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741084586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5WKiX8rcAKK3GTsXlqrk7FsfQEdtOs7sREmJtE24hRA=;
	b=KjpGxn+go/DjVgP0E0e45DcP2tBfmeN7MrS/LOCrpHpJVuqRYnt3sHDIUdyKENLprT53PJ
	S/Hvw46Duk3dl05EFcOThSFNBoTWOS/mn/7/8PYBSYXfOfwg+sN0ArTk4r0RxdDta++ipe
	YjdIp9lI8WzoHWaAGhx2Mx+kF1f7j1Sqflskt66/2XfcS1A5sR6FHxjnVu7nHTYTg/Muzp
	ut0HQOlDZ/Y6pvCHOzf+U+sA0ucixdoMnunx8vH3Lf/NCF78XKKwaS9ay6DicdYlCirsIm
	A5ffxqcIZOAYYUHqk3Xq5petkKQf8p6gO493YWXes+S71zgsUwsdVXiBkFPJ+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741084586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5WKiX8rcAKK3GTsXlqrk7FsfQEdtOs7sREmJtE24hRA=;
	b=3nm+2ccI7lbcdY5YCHXMoi8p3j5ZEj0cdROt5oCzbCYmkpBxUFmIZt/aqtDAsoxkt693Al
	qOVbZH/Jzy6Mr9CQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/hyperv: Use named operands in inline asm
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108458596.14745.10846308979163517610.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     9064a8e556fa70ccfd9c414350406ed4887d3059
Gitweb:        https://git.kernel.org/tip/9064a8e556fa70ccfd9c414350406ed4887d3059
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Sun, 02 Mar 2025 17:21:00 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:21:39 +01:00

x86/hyperv: Use named operands in inline asm

Use named operands in inline asm to make it easier to change the
constraint order.

Do this in preparation of changing the ASM_CALL_CONSTRAINT primitive.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/mshyperv.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index f91ab1e..5e6193d 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -77,11 +77,11 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 		return hv_tdx_hypercall(control, input_address, output_address);
 
 	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
-		__asm__ __volatile__("mov %4, %%r8\n"
+		__asm__ __volatile__("mov %[output_address], %%r8\n"
 				     "vmmcall"
 				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
 				       "+c" (control), "+d" (input_address)
-				     :  "r" (output_address)
+				     : [output_address] "r" (output_address)
 				     : "cc", "memory", "r8", "r9", "r10", "r11");
 		return hv_status;
 	}
@@ -89,12 +89,12 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 	if (!hv_hypercall_pg)
 		return U64_MAX;
 
-	__asm__ __volatile__("mov %4, %%r8\n"
+	__asm__ __volatile__("mov %[output_address], %%r8\n"
 			     CALL_NOSPEC
 			     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
 			       "+c" (control), "+d" (input_address)
-			     :  "r" (output_address),
-				THUNK_TARGET(hv_hypercall_pg)
+			     : [output_address] "r" (output_address),
+			       THUNK_TARGET(hv_hypercall_pg)
 			     : "cc", "memory", "r8", "r9", "r10", "r11");
 #else
 	u32 input_address_hi = upper_32_bits(input_address);
@@ -187,18 +187,18 @@ static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input2)
 		return hv_tdx_hypercall(control, input1, input2);
 
 	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
-		__asm__ __volatile__("mov %4, %%r8\n"
+		__asm__ __volatile__("mov %[input2], %%r8\n"
 				     "vmmcall"
 				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
 				       "+c" (control), "+d" (input1)
-				     : "r" (input2)
+				     : [input2] "r" (input2)
 				     : "cc", "r8", "r9", "r10", "r11");
 	} else {
-		__asm__ __volatile__("mov %4, %%r8\n"
+		__asm__ __volatile__("mov %[input2], %%r8\n"
 				     CALL_NOSPEC
 				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
 				       "+c" (control), "+d" (input1)
-				     : "r" (input2),
+				     : [input2] "r" (input2),
 				       THUNK_TARGET(hv_hypercall_pg)
 				     : "cc", "r8", "r9", "r10", "r11");
 	}

