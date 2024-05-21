Return-Path: <linux-tip-commits+bounces-1274-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE43D8CA9D9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 May 2024 10:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5592F2817BA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 May 2024 08:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7163953E36;
	Tue, 21 May 2024 08:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mJBvQFsj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wup5wBrW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD3E4D9EA;
	Tue, 21 May 2024 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716279691; cv=none; b=CwYJrggU0K+yFjot3LlsfyiayePrd3dHciFArqLDjnB/XY8CFIqsRjt47XfjpWZ5DziQzDlEP4IQtZ0jHkUq91S3esXY1ByhFLU57V/yY5nzr7P9VHcuqGdVxAjtMIWQhgeklNbq7ED5THvvzmODJWfb9GVQnsEJSWNiKv0+xTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716279691; c=relaxed/simple;
	bh=3LQ/giQeL+p+EpzBLijm4U2fZPnJx68A5w/UUwyooPc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=amw9l61Jx65UXsP6ji2JYM7vnMyNV8Ge8TQ5GZtPgXpEO7VG1eodorQ7/WNUsSDT+VH39LHJ6IqgpfdA/7JG5ZK7vYXfFx4zTdYN0rN4vISSFl0FO/bJaSXOLKBYbHz8k45FnPpN2z/4aHknDyB4QQvKVxHsSUWhSmEv3QKOxJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mJBvQFsj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wup5wBrW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 May 2024 08:21:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716279687;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMv8kqcqNwxHCGusjyVyQBedIyoLP2alQ916eSqbmNM=;
	b=mJBvQFsjszyRTBs70B3X6MAZvltgdRuM0SkBkEhwVUu362JlLfzBllehverE6sfFANlUi2
	Bi0TFCotDmeCrGe4iKYtpIGZJ3WEfjJaEUK9ALFbTeUmQKFJjP1j7l+u76pZXIV54ijRw/
	nw0X7ZbF4fCUiig5cS1nP8TWCuFgbXV+WCfLzDzItV5C2yQuUot6Ws9KA4H/OO11gnNXQJ
	TUuyZWCkFAuJz1vGsbF0cVfTazcZ+qd6IjRnpFDCihQ/DFFDHMLQhVo4WKn25duQZRL8sd
	AsSNuX1HjWTvyHclvfuLdPg208L2iiMLlwkzriYiYEh1G1y8z0wBxch4RKP6oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716279687;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMv8kqcqNwxHCGusjyVyQBedIyoLP2alQ916eSqbmNM=;
	b=wup5wBrWjtN+2prHaGdlE570xLF+RlWBZ/b5+gvKhpYaIwpKCFSDs1FlkDmi8xh8IlTUcY
	+qFNQPt/kAaS86Cw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Rename percpu_stable_op() to
 __raw_cpu_read_stable()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240520080951.121049-1-ubizjak@gmail.com>
References: <20240520080951.121049-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171627968687.10875.5726493930151442367.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     48908919c9062bf9472def7389dd7cd9c6a45b70
Gitweb:        https://git.kernel.org/tip/48908919c9062bf9472def7389dd7cd9c6a45b70
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 20 May 2024 10:09:24 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 20 May 2024 10:17:10 +02:00

x86/percpu: Rename percpu_stable_op() to __raw_cpu_read_stable()

Rename percpu_stable_op() to __raw_cpu_read_stable() to be
in line with other read/write percpu accessors.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240520080951.121049-1-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index c77393c..39762fc 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -190,10 +190,10 @@ do {									\
 
 #endif /* CONFIG_USE_X86_SEG_SUPPORT */
 
-#define percpu_stable_op(size, op, _var)				\
+#define __raw_cpu_read_stable(size, _var)				\
 ({									\
 	__pcpu_type_##size pfo_val__;					\
-	asm(__pcpu_op2_##size(op, __force_percpu_arg(a[var]), "%[val]")	\
+	asm(__pcpu_op2_##size("mov", __force_percpu_arg(a[var]), "%[val]") \
 	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
 	    : [var] "i" (&(_var)));					\
 	(typeof(_var))(unsigned long) pfo_val__;			\
@@ -480,9 +480,9 @@ do {									\
 
 #define this_cpu_read_const(pcp)	__raw_cpu_read_const(pcp)
 
-#define this_cpu_read_stable_1(pcp)	percpu_stable_op(1, "mov", pcp)
-#define this_cpu_read_stable_2(pcp)	percpu_stable_op(2, "mov", pcp)
-#define this_cpu_read_stable_4(pcp)	percpu_stable_op(4, "mov", pcp)
+#define this_cpu_read_stable_1(pcp)	__raw_cpu_read_stable(1, pcp)
+#define this_cpu_read_stable_2(pcp)	__raw_cpu_read_stable(2, pcp)
+#define this_cpu_read_stable_4(pcp)	__raw_cpu_read_stable(4, pcp)
 
 #define raw_cpu_add_1(pcp, val)		percpu_add_op(1, , (pcp), val)
 #define raw_cpu_add_2(pcp, val)		percpu_add_op(2, , (pcp), val)
@@ -535,7 +535,7 @@ do {									\
  * 32 bit must fall back to generic operations.
  */
 #ifdef CONFIG_X86_64
-#define this_cpu_read_stable_8(pcp)	percpu_stable_op(8, "mov", pcp)
+#define this_cpu_read_stable_8(pcp)	__raw_cpu_read_stable(8, pcp)
 
 #define raw_cpu_add_8(pcp, val)			percpu_add_op(8, , (pcp), val)
 #define raw_cpu_and_8(pcp, val)			percpu_binary_op(8, , "and", (pcp), val)

