Return-Path: <linux-tip-commits+bounces-3947-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81026A4EA49
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B788E7600
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 17:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164C827CCFE;
	Tue,  4 Mar 2025 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uux8NV77";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FOi/iE3l"
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A88284B52
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108910; cv=pass; b=ZhTkOUslbKYnyF+BtEEd4ePcFgN/kaOXTVKoBsJj7EGTt+yC++K0x8T+D5ThVMseOoCdoFpk1CkhZ0HH2ktE2hbi3iV86O/i9OdMNFTqrCB2YpY3291BUDFvFQ4oeHT11CbPYqshInE7mQ6YFSRsq66sRG0JhZtx4QWTXGIbdyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108910; c=relaxed/simple;
	bh=abJXjbt0QNdzHR1CaggoycF4Eu2X+o/tIXvg+vtuf1E=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=JuIlFYwBTXEpNS99qe4g2c/t1GRx5PenT9w9UmRkVaBYw8bPSTcw84wresujqt/cmEz3cxHrxYRXJhflY4luc/WnKsc+xDe2DK0HUOzYsXoxlWhTUmS/oSNN4nqntR3hWJbylW23s5nMiMUQRjmvq9vIbRFMRy8fWf17ZLbp9Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uux8NV77; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FOi/iE3l; arc=none smtp.client-ip=193.142.43.55; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id B2BBD40D0B90
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 20:21:46 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=uux8NV77;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=FOi/iE3l
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6flN1sRPzG0ZQ
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 18:30:40 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id DA48D42724; Tue,  4 Mar 2025 18:30:28 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uux8NV77;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FOi/iE3l
X-Envelope-From: <linux-kernel+bounces-541487-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uux8NV77;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FOi/iE3l
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 7818642080
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:07:33 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 2BCDA2DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:07:33 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731A6173B26
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B131F540F;
	Mon,  3 Mar 2025 11:02:50 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44F91F3BB2;
	Mon,  3 Mar 2025 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999767; cv=none; b=jp1IWsK+wm047tOBfKbe0zDt4hRrWI3/z/4HNIFwgxYjkAW/MiIRPuWEUwUt7dCK2UQF8DS00+Nh6BrpKPW7wQf40BAmBbDPeByHnSQ94Yr4ywnUf/oBymShPDM+jcsHWR5euOlyJSqH7IXZuTKVMO/YHLriUJK69HRDr3t9pbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999767; c=relaxed/simple;
	bh=abJXjbt0QNdzHR1CaggoycF4Eu2X+o/tIXvg+vtuf1E=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=JcW8qx3MvTprQLjDIfl+DF8TN4Fwr9Iy59ZfsFoP24fuQL9ajWi8A5LSF+UzeMyiyPwbsMoFabUaAx2fE/CsndqC4CJx0V4kaqr1T9nYudxMiD+2v55lRIhYSVzCFAJWhU6Xq3uqCY4uDX9xJlxo91+d7WyoCohlQcmKYc0ztYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uux8NV77; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FOi/iE3l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 11:02:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740999764;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cOWBUmZ+W30ERdUzKWprcZa86+fY9MVo6XhRucTIH/A=;
	b=uux8NV77MPBZsLMFmxDqLTVO875gJTffI8kBXk7r1gTVvL6daPZms6IRBkyGYUT0YnLUCa
	uZx10ZCE6nAzLePBxV56tFm10URnVlDeFNa0/T3SK6NFFLPuGV0T3dfSu43yw/4XFY1Tjp
	dQYhJES4eyD0/sTR0D5qHgGkxbLSLFNTVicibSZhqGgVC4W51S3HB3Thn5icW32Rv1Yaz8
	30NEW4UK1+oI39AF3i1M3x1tORrh2l+iTpTgM0yx4dtKjFfB7IMxzYy1iYr5MRJM6q5szZ
	+JCRhNPqePGs2SXKVr99A/AkVIbWvayn+vwyNpteIk7FN/6iemulP5qWTiA4RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740999764;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cOWBUmZ+W30ERdUzKWprcZa86+fY9MVo6XhRucTIH/A=;
	b=FOi/iE3llT0NRJwR+6WEKeOPfqwrLESwJaiaagDLpaApJqxGfrPgjqZpXqU1zzsBJM1Otu
	KaeE7irFWDTllADA==
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
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174099976350.10177.10962388060201277125.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6flN1sRPzG0ZQ
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741713576.90054@pRSuw2ox76PpcM4wHqvG1A
X-ITU-MailScanner-SpamCheck: not spam

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     2668d7b4aff83a7999cdafa984927f87a6e51922
Gitweb:        https://git.kernel.org/tip/2668d7b4aff83a7999cdafa984927f87a6e51922
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Sun, 02 Mar 2025 17:21:00 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 11:39:53 +01:00

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


