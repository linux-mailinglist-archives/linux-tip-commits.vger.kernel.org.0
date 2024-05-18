Return-Path: <linux-tip-commits+bounces-1268-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F998C903F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 18 May 2024 11:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEB82B21446
	for <lists+linux-tip-commits@lfdr.de>; Sat, 18 May 2024 09:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4E428387;
	Sat, 18 May 2024 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hF3U/sM9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="alx1B85r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C423D28373;
	Sat, 18 May 2024 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716025496; cv=none; b=GgQqua7oU8ZPZvftnyGdPDOjQQkyOCq6lTLDIbViYmxEDTdYxkzkIKb1BCQVvLT30Pr0IPGXz70jXPS0G4te/hysW5X4wzkz4xYWEYKtHW36Sc1bptigXp5DQYSZYM6YNLT/r4R78CSW5FjsyuACuxldG2BnSePF+Twf6+Yr8HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716025496; c=relaxed/simple;
	bh=ehmUU5DrSg7e7UVvhbwUWBH+UYuQcSC511rfaxLNOpM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FLJbMQ3Mw9J81cLW13eY91wSFmpHjaZG94Zcg6O8SYCQJbHH9SKseJhwriOCPVEAxyAFTdZg7pjLc9fXJUhyWzygtRnmG7+qapCJ6v9hppYs7/6X6hCfIEfHq7Fb6ZDxcqM6rM1CaLLob1Kc9i/uy/QexerwIggQ25Je5UQB410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hF3U/sM9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=alx1B85r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 18 May 2024 09:44:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716025493;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CXb2zhViL9/cb+MGhd87dpFhnyoKIP/1oxdzA10sf5A=;
	b=hF3U/sM9i1IGebuLUgOQufKQ0iew+WjjHxUKdKCe/q6M+oSoz9lQnGQtDom9L8bzQfX6O1
	AybTgunqXp44LFrSCE1k99bD9KI0F/QtD2ULxxS8tOUmOrMp4CtHOF+3AtvsRwzGADQCIa
	rBcBrfo6lHlzq5tHR7OYshuJ0AVEiqIeF6ViARwVCKffGFXGej4t2rFantOlPEqU5XiAuS
	eeJEqWhX27FLR9iDdMspj3LuEjqM1YfUQMp5yEKvuZZUyB/EdFf2nZV/OzLwv1vhE0cyCc
	p6UcwSVvfMwTDGQnmrO86gq0XMRjcLhDTe+H/muEH0Uk/VHvyDUE9c2J0IqQrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716025493;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CXb2zhViL9/cb+MGhd87dpFhnyoKIP/1oxdzA10sf5A=;
	b=alx1B85r5oQaMe2E5I/IYYKar4fcF0c15E3jAcoDxYw/EHAtiZqXyVkWcF6+nf/B3FOJb0
	swPARmw5yBmmuMAQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Fix operand constraint modifier in
 __raw_cpu_write()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240430091833.196482-5-ubizjak@gmail.com>
References: <20240430091833.196482-5-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171602549262.10875.7562387052692287292.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     1fe67aee8ab3fdab4357afc983a9e9ff3892d694
Gitweb:        https://git.kernel.org/tip/1fe67aee8ab3fdab4357afc983a9e9ff3892d694
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 30 Apr 2024 11:17:24 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 18 May 2024 11:18:42 +02:00

x86/percpu: Fix operand constraint modifier in __raw_cpu_write()

__raw_cpu_write() with !USE_X86_SEG_SUPPORT config uses read/write
operand constraint modifier "+" for its memory location. This signals
the compiler that the location is both read and written by the asm.
This is not true, because MOV insn only writes to the output.

Correct the modifier to "=" to inform the compiler that the memory
location is only written to. This also prevents the compiler from
value tracking the undefined value from the uninitialized memory.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240430091833.196482-5-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index d202551..c77393c 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -178,7 +178,7 @@ do {									\
 		(void)pto_tmp__;					\
 	}								\
 	asm qual(__pcpu_op2_##size("mov", "%[val]", __percpu_arg([var])) \
-	    : [var] "+m" (__my_cpu_var(_var))				\
+	    : [var] "=m" (__my_cpu_var(_var))				\
 	    : [val] __pcpu_reg_imm_##size(pto_val__));			\
 } while (0)
 

