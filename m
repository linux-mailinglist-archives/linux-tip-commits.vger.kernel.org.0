Return-Path: <linux-tip-commits+bounces-4581-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A427A74BF1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Mar 2025 15:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CBCD16AE05
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Mar 2025 14:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B9D171092;
	Fri, 28 Mar 2025 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kCvuQbAS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MFWugy7g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A7135972;
	Fri, 28 Mar 2025 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743170391; cv=none; b=XT2ZwsWmxdedpDYMaZmdJpiE4heoy1nJBXNMsfZSMljdSqzhGurI5+erVpDy6eqEkIDtrBzly1JaOyTxI5gw4X30pOdv1gC3yz4KHL4hzWE112JOu/vM2NCVmcCjXaL79tDEtP0nAoj70wbEdCXhA26eQtKtEnzVMtpz01C8vVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743170391; c=relaxed/simple;
	bh=queargUwgwhFoLJSm0V6spQZc3Od+p+0HdswVa4qUVU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UHaJHEJBhGZm8rWZWp9cYWR/EGkimPB95NajYg2jOhr6Gd5lYM8AYd57F0W1+2pACAbSgCckYrwGMaGnKSOIwamH5M2oit03YNvLdINvZPdwz916WgcpYTy6hxyE07X56r/CiSoN+BrzKMCGaPIJat20tXONihzmX0gqE6XEGMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kCvuQbAS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MFWugy7g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Mar 2025 13:59:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743170388;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fv2yoDSisQExJbWofZwhHnrEfc7qQm6vG6yJ0U8B1tQ=;
	b=kCvuQbAS8TruogIQTqiujp5XRBZQ2IviyWxVoW/9u7sphlyf4jbxlQT76TfZlNruXalqZP
	M/QubmuAAmllPwdgQjwF/dq/NpR835GZBCHjT/bDjJ3YsyZ6n4h136ecVBhBy1ZSxgkzQT
	yg30rrBj3E8JAYoH81Klb5Zle/artqHRn8fof258w9CAIHzc259EeYQz2J6MfUqZwP4ViK
	psGn/Hlwp/dN9JJdO5dOuVxab53flgCRVqB2fOJov3UN71tgnoH93bYCJAP8ZF5qh+OjAX
	G99Zan2VlBqPBNcTGBM+x4IePG1VwPkuAye4unZDfR7lmqDDJKvEGUzJxaYkrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743170388;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fv2yoDSisQExJbWofZwhHnrEfc7qQm6vG6yJ0U8B1tQ=;
	b=MFWugy7giBbhWggZIOWEtvdoHfk8QtanbgajR8cxZeNmnvWdaTnlJQDANzh2yff9Qj6ZBp
	yN+KZ7f+Js7Y/SBQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/urgent] objtool: Fix segfault in ignore_unreachable_insn()
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <5df4ff89c9e4b9e788b77b0531234ffa7ba03e9e.1743136205.git.jpoimboe@kernel.org>
References:
 <5df4ff89c9e4b9e788b77b0531234ffa7ba03e9e.1743136205.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174317038796.14745.5274581486617831611.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     69d41d6dafff0967565b971d950bd10443e4076c
Gitweb:        https://git.kernel.org/tip/69d41d6dafff0967565b971d950bd10443e4076c
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 27 Mar 2025 22:04:21 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 28 Mar 2025 14:47:02 +01:00

objtool: Fix segfault in ignore_unreachable_insn()

Check 'prev_insn' before dereferencing it.

Fixes: bd841d6154f5 ("objtool: Fix CONFIG_UBSAN_TRAP unreachable warnings")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/5df4ff89c9e4b9e788b77b0531234ffa7ba03e9e.1743136205.git.jpoimboe@kernel.org

Closes: https://lore.kernel.org/d86b4cc6-0b97-4095-8793-a7384410b8ab@app.fastmail.com
Closes: https://lore.kernel.org/Z-V_rruKY0-36pqA@gmail.com
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3bf2992..29de170 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4037,7 +4037,7 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 	 * It may also insert a UD2 after calling a __noreturn function.
 	 */
 	prev_insn = prev_insn_same_sec(file, insn);
-	if (prev_insn->dead_end &&
+	if (prev_insn && prev_insn->dead_end &&
 	    (insn->type == INSN_BUG ||
 	     (insn->type == INSN_JUMP_UNCONDITIONAL &&
 	      insn->jump_dest && insn->jump_dest->type == INSN_BUG)))

