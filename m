Return-Path: <linux-tip-commits+bounces-5175-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE890AA6DB6
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 11:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D1B3BF0C3
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 09:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FE626A1BB;
	Fri,  2 May 2025 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Yr+TuqD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GQGYbXas"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AA52690D6;
	Fri,  2 May 2025 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176675; cv=none; b=ad1CN8uWfolxI6J1gZTiFtm5uAKp1FeXtBIWKRlYyk7sG+n3HWBKhbg5xccTv8WVGW+kv4NhvBKXR1cH1sT4qSr5O//wJU1wG/GPnG2U9OBwO7xyLUv4sF+PoY/DFjp+nLJBGHXCyGhjtDYgVu8PWANA/L86pPcQ6nQK+85QduE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176675; c=relaxed/simple;
	bh=gCsPQsqNPPq5oFxjeBUG4MLCfwCCxo5CwY/7WF4PNKk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=o1lfOIxpyMZeUnOrEJ9AjlQW9zmjBedR03VZqo02ogOXBQqrVtVknEm/7+yqmF8KBYJGQxAx4pWOTpXgU911al3vIvluKcgYLmwrwSXwZrCsYzHKGzEf/vn1fUpbE5eA7GOFXchoKVVlub+muiWc71JiWjyLb+WoUoGx6oADG5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Yr+TuqD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GQGYbXas; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 09:04:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746176671;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=rmqT5EU1AbsvAublSa0SnGgYVCj7zG9K9ToqPbcFk88=;
	b=2Yr+TuqDWWewptAjubEXUp11dis5WuRUhjGuNGozwxtckC/1VS9eTSNlX4htIdZhza9SQ7
	YdIXLbh+kP2dJs0iCeAf3UAhP4psv2AkBzQlBsWJfNfO17RwTjJjr7kZtGQd/wGH/muCnT
	EHG0YDvnf+Ler/1BZgsk5y4QnV+Z7i2FOVzQ98wvmI+9pZyFx66fkHm/M8NoH11sLF8FWr
	83FPBG6Ml7FMNsJHpvKkqGWDsLSlvryagqoWvKGOmAtHr1MJMnoQ61kzwQVlFjpkW0e1sK
	Qw99T5RSWMlzSZeg8kNCAy4VuLIRFV/9HIJR8h3djtWafd1+gEmxEWUysLOXlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746176671;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=rmqT5EU1AbsvAublSa0SnGgYVCj7zG9K9ToqPbcFk88=;
	b=GQGYbXasNo0NVCx4XzrXKTkgq1zXU1Voeo3KV/YUMzzQpTQXHPKTlBwLAhtTbz4gB0G6zt
	9OYFvEy6bkcnzqBw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/msr: Improve the comments of the
 DECLARE_ARGS()/EAX_EDX_VAL()/EAX_EDX_RET() facility
Cc: Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Uros Bizjak <ubizjak@gmail.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174617667063.22196.14941389876137049805.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     76deb5452e79ab86eac699ae3b6a44ab9c437ffe
Gitweb:        https://git.kernel.org/tip/76deb5452e79ab86eac699ae3b6a44ab9c437ffe
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 02 May 2025 10:07:59 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 May 2025 10:10:31 +02:00

x86/msr: Improve the comments of the DECLARE_ARGS()/EAX_EDX_VAL()/EAX_EDX_RET() facility

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/msr.h | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 2ccc78e..27bc0b5 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -37,20 +37,22 @@ struct saved_msrs {
 };
 
 /*
- * both i386 and x86_64 returns 64-bit value in edx:eax, but gcc's "A"
- * constraint has different meanings. For i386, "A" means exactly
- * edx:eax, while for x86_64 it doesn't mean rdx:rax or edx:eax. Instead,
- * it means rax *or* rdx.
+ * Both i386 and x86_64 returns 64-bit values in edx:eax for certain
+ * instructions, but GCC's "A" constraint has different meanings.
+ * For i386, "A" means exactly edx:eax, while for x86_64 it
+ * means rax *or* rdx.
+ *
+ * These helpers wrapping these semantic differences save one instruction
+ * clearing the high half of 'low':
  */
 #ifdef CONFIG_X86_64
-/* Using 64-bit values saves one instruction clearing the high half of low */
-#define DECLARE_ARGS(val, low, high)	unsigned long low, high
-#define EAX_EDX_VAL(val, low, high)	((low) | (high) << 32)
-#define EAX_EDX_RET(val, low, high)	"=a" (low), "=d" (high)
+# define DECLARE_ARGS(val, low, high)	unsigned long low, high
+# define EAX_EDX_VAL(val, low, high)		((low) | (high) << 32)
+# define EAX_EDX_RET(val, low, high)		"=a" (low), "=d" (high)
 #else
-#define DECLARE_ARGS(val, low, high)	u64 val
-#define EAX_EDX_VAL(val, low, high)	(val)
-#define EAX_EDX_RET(val, low, high)	"=A" (val)
+# define DECLARE_ARGS(val, low, high)	u64 val
+# define EAX_EDX_VAL(val, low, high)		(val)
+# define EAX_EDX_RET(val, low, high)		"=A" (val)
 #endif
 
 /*

