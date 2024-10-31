Return-Path: <linux-tip-commits+bounces-2681-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C24A9B8553
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 22:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4BF1C217D8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 21:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178A51CCEF0;
	Thu, 31 Oct 2024 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EtAnHuC3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j9u/t+Et"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472621CB53C;
	Thu, 31 Oct 2024 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410191; cv=none; b=FFFmzogvUGrk0SXXitmZdE2W1p9C6gVmjlyW7xJQ7FxzqqCxlkh40neMYiIzxf1f0LPk3avmp/7ezDmciAi+LwFHioQb7rFKZ28aD05JN4pvVL+nMkjzKI71OMflxjYgzvTwk2Dg9FcYBG/+AdU+Sd7ONtaBZ+Um+rmEhO/HR+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410191; c=relaxed/simple;
	bh=isbgtSammbWNd4BulFtL4q95wdco7BmcCnSwgK+/vqA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=p5spHwpTocI3Di9oIyaLeExeg6H/kd/iZBCePgxMORyq8jQzMQOLxjvyZMYmd4pKtA3ZmrELh1iF+vejFXz8cvVXwYbLS0YvWBQ7FmIzOhohCnU2088LMo+x3Pbrgm5b/JPKQvDMUyWQK2cxZQncU/jln79vE0AitB3DKJQTdb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EtAnHuC3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j9u/t+Et; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 31 Oct 2024 21:29:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730410183;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=tiVfuZrxs7g4jBkrx9YFCYbEwwkSUCS+tWDrUfDpxSk=;
	b=EtAnHuC3VEdP5wdhYnU5rI34MlU4KBWTm/sLWhR6h31L76WwBbseCIh97PVNoH5SLRLlgl
	Fak0ybHYj+tHkTDGDbea9+CaLA6lvBcRVEHrqFS9PB7vkrgozF/F+9N/cP7UfYdFca7eT3
	hKt4ZNopZ1mbnIC3s16DC1Em6w3R/hSVlReMbSitZBoRDZYOdhlugmNTLZ5kIYZlrmoJaw
	40T18WCck9mVEeVUQJ9eLqVqh8GoM6Oj0xTHYIhdP+fBqoQMIUfuK5nR6X+R66ULUckgXe
	x+LR6b+XfX62rmsd2oDnu6SGt3F05Srp8sodNBTTks9JRHng/1clDyx9AdugNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730410183;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=tiVfuZrxs7g4jBkrx9YFCYbEwwkSUCS+tWDrUfDpxSk=;
	b=j9u/t+EtF5NWDWriOlbKXzUAOXknj2bmp6LYOI5zgQOpiq4S/ROMQiLhX7eBa7vsKO+7fH
	1/SSru/x29aFcGDQ==
From: "tip-bot2 for Zheng Yejian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/unwind/orc: Fix unwind for newly forked tasks
Cc: Zheng Yejian <zhengyejian@huaweicloud.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173041018251.3137.16955177475088158234.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     3bf19a0fb690022ec22ce87a5afeb1030cbcb56c
Gitweb:        https://git.kernel.org/tip/3bf19a0fb690022ec22ce87a5afeb1030cbcb56c
Author:        Zheng Yejian <zhengyejian@huaweicloud.com>
AuthorDate:    Fri, 13 Sep 2024 10:45:01 +08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Thu, 17 Oct 2024 15:13:07 -07:00

x86/unwind/orc: Fix unwind for newly forked tasks

When arch_stack_walk_reliable() is called to unwind for newly forked
tasks, the return value is negative which means the call stack is
unreliable. This obviously does not meet expectations.

The root cause is that after commit 3aec4ecb3d1f ("x86: Rewrite
 ret_from_fork() in C"), the 'ret_addr' of newly forked task is changed
to 'ret_from_fork_asm' (see copy_thread()), then at the start of the
unwind, it is incorrectly interprets not as a "signal" one because
'ret_from_fork' is still used to determine the initial "signal" (see
__unwind_start()). Then the address gets incorrectly decremented in the
call to orc_find() (see unwind_next_frame()) and resulting in the
incorrect ORC data.

To fix it, check 'ret_from_fork_asm' rather than 'ret_from_fork' in
__unwind_start().

Fixes: 3aec4ecb3d1f ("x86: Rewrite ret_from_fork() in C")
Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/unwind_orc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index d00c28a..d4705a3 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -723,7 +723,7 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 		state->sp = task->thread.sp + sizeof(*frame);
 		state->bp = READ_ONCE_NOCHECK(frame->bp);
 		state->ip = READ_ONCE_NOCHECK(frame->ret_addr);
-		state->signal = (void *)state->ip == ret_from_fork;
+		state->signal = (void *)state->ip == ret_from_fork_asm;
 	}
 
 	if (get_stack_info((unsigned long *)state->sp, state->task,

