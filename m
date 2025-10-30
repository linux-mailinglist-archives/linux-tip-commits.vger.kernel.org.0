Return-Path: <linux-tip-commits+bounces-7100-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1450AC1F179
	for <lists+linux-tip-commits@lfdr.de>; Thu, 30 Oct 2025 09:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E942E3AD50D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 30 Oct 2025 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF60E3101D4;
	Thu, 30 Oct 2025 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xAt2phPA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NItRqiC8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE6E2E092D;
	Thu, 30 Oct 2025 08:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814224; cv=none; b=C4i3AKqCkPx8G6alhGRINUyLgvSXBIxpk93ZYlEGpoChWijzhiJGS1YMSi0gWSCoWCGPuXL5DENtMwi+w8aRtEJ8v1FRS4vshctam1Nd38eB37/CwQRbSrU7DjjCnAss+Tr4O55NgGkfQLOGEAhNsHxnR1Lw33WjBwtYSG+6GWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814224; c=relaxed/simple;
	bh=lXUeqtH4gIm8XoccOlO/XQPOggcKJBZ3QTZiY5awPDo=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=jMjkYpY6/Fa3NmmpQwP5FerhulskSLg2eKdGxO++nr8cBwzDrY7LETsElqhtkigX3o33hHbaaPCbiOAIadC/uQR6Sv+5ihzt57M3QQd6bF+fJc5ncMeM2Uc++ovkOXsnrlLRyjEtMawQ2JJDtNS/9X2O4o5SasUNLtRYFuQXOWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xAt2phPA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NItRqiC8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 30 Oct 2025 08:50:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761814214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=/q9bwbXV5yKiRZi1kfzngngrJJluuE86UWQ4jIAwznk=;
	b=xAt2phPAosr/Yt1ROy1DXbDMgXIU8VKg9nrU1Hs3zjUX7Dq8GyeMr493NowRbnZ2LzdbSY
	U5kzCIE17pMTpBjsEQnsResz2LWTqquSEmZcnCooCUg2+pEq7TqnP4Ze04R8GVjXCv16KJ
	FKNeJK/cRkHbF3qtw/nUktDEFM2RNMObnrSB3lB278iLtXB7sdIZN/I1TIGRr6EqzyH2OH
	I1G+vpNofc1n/TS7MVFCyCordT/ML2KzXc5wlwgCNndo3D4Eqw6o9Z6z66geSbC9HAqoDl
	IybmdqAmcUzWT5Yi6d2tudS4cogLClP/z+6nHfvIpQStcgiAOGNinc+cxL/XKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761814214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=/q9bwbXV5yKiRZi1kfzngngrJJluuE86UWQ4jIAwznk=;
	b=NItRqiC8xssSYiN02DsvP7I6pkqksbQzkH6KHe9nsT3FgeaBm4oZ1fC/7T/B9iKtpBtY4i
	99RuFH2KGW5LrCAA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] unwind_user/x86: Fix arch=um build
Cc: kernel test robot <lkp@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176181421034.2601451.7204934553054397570.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     aa7387e79a5cff0585cd1b9091944142a06872b6
Gitweb:        https://git.kernel.org/tip/aa7387e79a5cff0585cd1b9091944142a06=
872b6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 29 Oct 2025 14:24:57 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 30 Oct 2025 09:43:14 +01:00

unwind_user/x86: Fix arch=3Dum build

Add CONFIG_HAVE_UNWIND_USER_FP guards to make sure this code
doesn't break arch=3Dum builds.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

