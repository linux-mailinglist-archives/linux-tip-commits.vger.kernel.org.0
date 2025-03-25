Return-Path: <linux-tip-commits+bounces-4467-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D90EFA6EBCC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57EEC3B0CA1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13BA2580F9;
	Tue, 25 Mar 2025 08:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qSYdqHoI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F1P8BSd/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24022257AD8;
	Tue, 25 Mar 2025 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891714; cv=none; b=MzevzhvtXYYXl4skDeNMxuYr2ryIKN3jrvXWxKMtfVt0V4/7Yi43rAa0ZdHyC2M28+XvToQwkd3GOT9UW87Eb/DKTC+g/Cf4e1R0hyjbznr+5A33COWUsIZ8CWLw5/0RdnCNNELnIqPZTByQgZ3R66kbaYZa5jOapWd+aH5VZ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891714; c=relaxed/simple;
	bh=wmxNcxZZn3P5rcn7I5ppsfqfQQ3ULpDvKB/0x6U1+mw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mvcDd2LLhMflMgwt9eQ4YVqyCcmVKzcxJeSJY1Ze/tpndubcCBGjw0KgIDastj2lCWFCerK0iI3EEhxTECnQSGkc36WOrK4jWzWrX8/PyolmdpALXwmULFGeiwS3d/6UzKMPrZWd7FXPNasc/NTxMHM5Kv4hj5eki/WmqWWXwjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qSYdqHoI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F1P8BSd/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:35:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742891711;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BUZAxF8sTs7D5heGOjhPy/vu06ohrAXCLw94w+Wxz+4=;
	b=qSYdqHoIyrz52yKYqYFP0S5+O7xVF4EibWJJmdROL2BYLblrYRgJKn+EG9WAXvKxiMr2op
	b6MVa40Zk5wqCmXl7msCbHbNW56uMV2Dr/E5TjEYoMqcD+4RARmDq6OjleZy8l88DY5i2u
	OkvhMffOHJ0ACX7z3wnanQPmns82N/xJunJvc/V0p5yHu1LuvOxBqeqhHqHWjO9MNgzHv4
	gyjagVsOapJcyoeWP2f0/+cqVN3SqP7bcpLXWxD96Bb7i9eexzjBMe+MMYAGdq7tc+cJt4
	3JDnlJr3iJca8niNbyiPHsleNkXbne9ecYHcldqveRugcnSDmT27KjxV/GC0ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742891711;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BUZAxF8sTs7D5heGOjhPy/vu06ohrAXCLw94w+Wxz+4=;
	b=F1P8BSd/kECHREAr4hqpu1YuPcKpdoR8lfKgUfRPrWsmoCIqhcQtVrOMKvF0gIUVsPG14N
	yd8xLFvK2JGIurAw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/urgent] objtool: Warn when disabling unreachable warnings
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <df243063787596e6031367e6659e7e43409d6c6d.1742852846.git.jpoimboe@kernel.org>
References:
 <df243063787596e6031367e6659e7e43409d6c6d.1742852846.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289171080.14745.17027999769688870053.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     eeff7ac61526a4a9c3916cf46885622078ad886b
Gitweb:        https://git.kernel.org/tip/eeff7ac61526a4a9c3916cf46885622078ad886b
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:55:52 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:20:25 +01:00

objtool: Warn when disabling unreachable warnings

Print a warning when disabling the unreachable warnings (due to a GCC
bug).  This will help determine if recent GCCs still have the issue and
alert us if any other issues might be silently lurking behind the
unreachable disablement.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/df243063787596e6031367e6659e7e43409d6c6d.1742852846.git.jpoimboe@kernel.org
---
 tools/objtool/arch/x86/special.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 9c1c9df..5f46d4e 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -3,6 +3,7 @@
 
 #include <objtool/special.h>
 #include <objtool/builtin.h>
+#include <objtool/warn.h>
 
 #define X86_FEATURE_POPCNT (4 * 32 + 23)
 #define X86_FEATURE_SMAP   (9 * 32 + 20)
@@ -156,8 +157,10 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
 	 * indicates a rare GCC quirk/bug which can leave dead
 	 * code behind.
 	 */
-	if (reloc_type(text_reloc) == R_X86_64_PC32)
+	if (reloc_type(text_reloc) == R_X86_64_PC32) {
+		WARN_INSN(insn, "ignoring unreachables due to jump table quirk");
 		file->ignore_unreachables = true;
+	}
 
 	*table_size = 0;
 	return rodata_reloc;

