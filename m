Return-Path: <linux-tip-commits+bounces-7099-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 184B1C1B09B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 15:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1EF91B21951
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 13:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9905534F47A;
	Wed, 29 Oct 2025 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="znqZ9PNP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jM42F88i"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039AA1B4257;
	Wed, 29 Oct 2025 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745122; cv=none; b=AsTJrnv510HRbUnxDaCKAZAlaCrMO6aId0u4jiwzqvW/wEovTwiXDqtZ5AULo8KkWZFzDzxhSsNy46GE0D/Q+QESdqzf4uDid+KqQuoWl3R2MuFzHFEg0+/Ce0nRQIkrdGBiFvvIX3GikU78157L8ofdUzOX3whmBXObRemfLRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745122; c=relaxed/simple;
	bh=hFZLjU9NPVF/W1rkjz2cM6ZlnNo6t2/RL2LgX2vWtaQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=FttviHGp3icClzvzkoGsD1tQC1af2GHyx/TU+p9tD8UPpAKfO2c2+0HK3YW1vfm1UeDTIwruKzSU+uvCTDhYr3vHl0J41KGJZoovKH1Z43vzZRJ2CJbkIQ0vGmZAtkje3WOk7kBHP0jA1fD6lCnFpCuJLS7RvRu9jBOI8aIMdmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=znqZ9PNP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jM42F88i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 13:38:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761745119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lpHN9woy0RN37Ctf4Men1kb0Bi10pWWNAL9apjOKfIc=;
	b=znqZ9PNPfGLQXmrWCb1sRMfHr7KCKEAuo5+GhdShXw3ZP/Z/dI05dASg1Y9hsCXLJm43zP
	uIqUexeOrxw4TqbVKEtr5mn7rbzJyBpaurAGGMdUfMjttz0/41C20G27dAkEN9NnIRX1JP
	1P/fcCdoHpCrXCdkJdQwLYlA+pqvDXKRMr+urfGC6M0bPp+WJjj0J+15RGsJmqWmtEi7OO
	LAMCNx3gj1JBeWoGq41ycc6uDT4VkqSuD/Gto2OD8g1T1/dheqxqEIImb54o7TizMUeusc
	hOdBp0UV57vvgkhh5heoWDxQ8nbGdcL5c8McwqP6fiR94htiskOyXyh7c6dQ7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761745119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lpHN9woy0RN37Ctf4Men1kb0Bi10pWWNAL9apjOKfIc=;
	b=jM42F88ioC2IiLZgWmJTiE7I+MzvcO+wZPyny6DJQX00m12o8Wwh10CAjlXMdJa9wZGY05
	0iYiAvE9G0edz1DQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] Subject: unwind_user/x86: Fix arch=um build
Cc: kernel test robot <lkp@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176174511766.2601451.10946132380682286777.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e56b519d9d7742f3b2ad1debb4e231c46cdda218
Gitweb:        https://git.kernel.org/tip/e56b519d9d7742f3b2ad1debb4e231c46cd=
da218
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 29 Oct 2025 14:24:57 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 14:29:08 +01:00

Subject: unwind_user/x86: Fix arch=3Dum build

Add CONFIG_HAVE_UNWIND_USER_FP guards to make sure this code
doesn't break arch=3Dum builds.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Closes: https://lore.kernel.org/oe-kbuild-all/202510291919.FFGyU7nq-lkp@intel=
.com/
---
 arch/x86/include/asm/unwind_user.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind=
_user.h
index c4f1ff8..1206428 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_UNWIND_USER_H
 #define _ASM_X86_UNWIND_USER_H
=20
+#ifdef CONFIG_HAVE_UNWIND_USER_FP
+
 #include <asm/ptrace.h>
 #include <asm/uprobes.h>
=20
@@ -34,4 +36,6 @@ static inline bool unwind_user_at_function_start(struct pt_=
regs *regs)
 	return is_uprobe_at_func_entry(regs);
 }
=20
+#endif /* CONFIG_HAVE_UNWIND_USER_FP */
+
 #endif /* _ASM_X86_UNWIND_USER_H */

