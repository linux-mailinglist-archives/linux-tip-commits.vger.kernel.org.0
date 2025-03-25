Return-Path: <linux-tip-commits+bounces-4458-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F6FA6EBB5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8F473AA37B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E780256C9E;
	Tue, 25 Mar 2025 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kayOjjVi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EZ6v3Nex"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8779A256C60;
	Tue, 25 Mar 2025 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891705; cv=none; b=N4XH1+65kAd2UGqjTOrRfoForJsv21LUQPcbStuqSDeX6TEU0W0G2cb6ELD7R0cpOTil55eJdrZWttrnImqkbx19+LSoZldSeK4wcaoaPGtEq1B0Oz1KHrDI4bDVfR8N2gge2utpxN8kV1Fr/kVp/zPsiRU24aNkpcyY4vIDpnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891705; c=relaxed/simple;
	bh=RFy2YaVL/WRxR5FDpwu/TzONKKr7w+3n2ErkoV8rpWE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bBbiP0gpEUlHCny6JzMdK6BQg4SQgL7MTNypkOYFhdlMtsJRD3bWB9/fyXNQbplW3BnFNhQ97ya1PT/cEJMfjjZrANyiFSFDiuuFDhuQmJyof0D9BZk70BZvIOkI4FbosgC2Abr5HUe6Vh5JdhMqUrKVsLXZkMuLjs3X4D9WRMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kayOjjVi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EZ6v3Nex; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:35:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742891701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LllYAJFGKDmeGwt9+dhXE8Y5Rq5kHD622PpemfOYnwo=;
	b=kayOjjVigrBTDXJ0A1scJIuoh1kbd0O0QdX3kvelQmFAT6nn31BEIWqXjLPn3RkJWJ7fPd
	jAzsORhAW78V/G7Y7412uMFMvG5GeN/G51pnwn1j8lhCTgxx6B+LZHltgizcvRb3AMTglK
	B+lpsw+QIYVXY3YSB+BY26I7QzBsFSpdPoc8gwGVK52Rv6517pQDU6EKsQg2O5DkfEP27Y
	n9b8zrFUkkkT53QhFpNx9TTOBgcDfIq+6XY7yBqQ+QDhVCfm6unVd0bryxP8jLMqEpFWq4
	TBaHIWyRHqgfj3TA/dlE+hABw3Ogb7J5NlUpPUQXRBcYVFh6x1eJnUxOXwWfgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742891701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LllYAJFGKDmeGwt9+dhXE8Y5Rq5kHD622PpemfOYnwo=;
	b=EZ6v3Nex9+3SdNiBJOJrzw7+liXovImPFldSkPsv7uYFCzlN9t5nzRc20cMHopPImv8K+r
	C1B84GOQ7xvhUyAQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix up some outdated references to
 ENTRY/ENDPROC
Cc: Brendan Jackman <jackmanb@google.com>, Miroslav Benes <mbenes@suse.cz>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <5eb7e06e1a0e87aaeda8d583ab060e7638a6ea8e.1742852846.git.jpoimboe@kernel.org>
References:
 <5eb7e06e1a0e87aaeda8d583ab060e7638a6ea8e.1742852846.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289170117.14745.13411214931783001551.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     24fe172b50b5749c315349e740e4a09e3a0165d5
Gitweb:        https://git.kernel.org/tip/24fe172b50b5749c315349e740e4a09e3a0165d5
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:56:01 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:20:27 +01:00

objtool: Fix up some outdated references to ENTRY/ENDPROC

ENTRY and ENDPROC were deprecated years ago and replaced with
SYM_FUNC_{START,END}.  Fix up a few outdated references in the objtool
documentation and comments.  Also fix a few typos.

Suggested-by: Brendan Jackman <jackmanb@google.com>
Suggested-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/5eb7e06e1a0e87aaeda8d583ab060e7638a6ea8e.1742852846.git.jpoimboe@kernel.org
---
 include/linux/linkage.h                 |  4 ----
 include/linux/objtool.h                 |  2 +-
 tools/objtool/Documentation/objtool.txt | 10 +++++-----
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 5c8865b..b11660b 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -134,10 +134,6 @@
 	.size name, .-name
 #endif
 
-/* If symbol 'name' is treated as a subroutine (gets called, and returns)
- * then please use ENDPROC to mark 'name' as STT_FUNC for the benefit of
- * static analysis tools such as stack depth analyzer.
- */
 #ifndef ENDPROC
 /* deprecated, use SYM_FUNC_END */
 #define ENDPROC(name) \
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 3ca965a..366ad00 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -69,7 +69,7 @@
  * In asm, there are two kinds of code: normal C-type callable functions and
  * the rest.  The normal callable functions can be called by other code, and
  * don't do anything unusual with the stack.  Such normal callable functions
- * are annotated with the ENTRY/ENDPROC macros.  Most asm code falls in this
+ * are annotated with SYM_FUNC_{START,END}.  Most asm code falls in this
  * category.  In this case, no special debugging annotations are needed because
  * objtool can automatically generate the ORC data for the ORC unwinder to read
  * at runtime.
diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index 28ac57b..9e97fc2 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -34,7 +34,7 @@ Objtool has the following features:
 - Return thunk annotation -- annotates all return thunk sites so kernel
   can patch them inline, depending on enabled mitigations
 
-- Return thunk training valiation -- validate that all entry paths
+- Return thunk untraining validation -- validate that all entry paths
   untrain a "safe return" before the first return (or call)
 
 - Non-instrumentation validation -- validates non-instrumentable
@@ -281,8 +281,8 @@ the objtool maintainers.
    If the error is for an asm file, and func() is indeed a callable
    function, add proper frame pointer logic using the FRAME_BEGIN and
    FRAME_END macros.  Otherwise, if it's not a callable function, remove
-   its ELF function annotation by changing ENDPROC to END, and instead
-   use the manual unwind hint macros in asm/unwind_hints.h.
+   its ELF function annotation by using SYM_CODE_{START,END} and use the
+   manual unwind hint macros in asm/unwind_hints.h.
 
    If it's a GCC-compiled .c file, the error may be because the function
    uses an inline asm() statement which has a "call" instruction.  An
@@ -352,7 +352,7 @@ the objtool maintainers.
    This is a kernel entry/exit instruction like sysenter or iret.  Such
    instructions aren't allowed in a callable function, and are most
    likely part of the kernel entry code.  Such code should probably be
-   placed in a SYM_FUNC_CODE block with unwind hints.
+   placed in a SYM_CODE_{START,END} block with unwind hints.
 
 
 6. file.o: warning: objtool: func()+0x26: sibling call from callable instruction with modified stack frame
@@ -381,7 +381,7 @@ the objtool maintainers.
 
    Another possibility is that the code has some asm or inline asm which
    does some unusual things to the stack or the frame pointer.  In such
-   cases it's probably appropriate to use SYM_FUNC_CODE with unwind
+   cases it's probably appropriate to use SYM_CODE_{START,END} with unwind
    hints.
 
 

