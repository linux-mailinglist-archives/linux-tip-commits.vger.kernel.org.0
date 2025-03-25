Return-Path: <linux-tip-commits+bounces-4456-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87496A6EBB2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A707D18950DC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3C52566FB;
	Tue, 25 Mar 2025 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fNUbxOw7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kb2I86pR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFA52561D9;
	Tue, 25 Mar 2025 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891703; cv=none; b=RSRQGmkQ7qrNQuxENIeFH3u01SRyphQqmhaSCBFPQxsrpGwtoY/KgaUjsMZwsaEEQieAO27MOfNcM5YntBAZRmFIIbTgAJzGUUcfP6cMAz9SPZMMOCZCjUuW1AhLxVEbj8laOqMjp3sxH9JADfqo6jjPMGfFCQTSz/Pb1ZKB7Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891703; c=relaxed/simple;
	bh=483kroRhc7CL0HaJOO0PSVJDS34TvdOX8K1+0wx1oQo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I8jGsNZAlwsDXl5zHMXyZOHyYUyqbQXwaVg1x/mMZjlaoKpOB1b9PGEnV0MxHMHPh8pLCNxvQPOmdpLnuQ/yOVB606UePd9cxgc/c7kHBjeoMAFll5828ZObqn5k2vVXCzm8AUC8tCj6gKvW3/7NcaYRxNmIMqK/Qe1Et8cIbtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fNUbxOw7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kb2I86pR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:34:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742891700;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wb8dvXvDxKd+03XSOSUz56MJDXcmpPHjB2fshQcIYZo=;
	b=fNUbxOw7hIF3JoTQjOojuVGY66N13f1XNoFGcKeb7qstduD4M9TLEHMYNVjajP/Is17BA6
	CDd+DeGRfS6RJTflnsuRoCkdqPwC4INeDKqR0rL+WCQg/LBL5fc+fR0QExHP2JVamCXiy7
	C/kqpWd3p726dncsZJ0GE95zVfWfBx2cN6wol/XL2wxoGlVxUu8bpostplpoNRie1xvHHC
	uwZ2pMw4p7WF70ZEXS8CKo8KX9amZhgrLuBlZAGEfH0CXVtxscbmksE7RsvyN67xwz1FlZ
	UAINIGAJ+J/4xYRPjoCN745+jKTZmVEf/DCSXsaWTo6v4Y4ipUFXZuXVKnlu6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742891700;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wb8dvXvDxKd+03XSOSUz56MJDXcmpPHjB2fshQcIYZo=;
	b=kb2I86pRJBZGMvTQKdIK/LlTbY/gYCfxU/h8BVf+PTkoJ+6QtAZ88T79+OPCnPdUfRvJti
	r51UbuKR5mQYFwAg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/urgent] objtool: Remove redundant opts.noinstr dependency
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <0ead7ffa0f5be2e81aebbcc585e07b2c98702b44.1742852847.git.jpoimboe@kernel.org>
References:
 <0ead7ffa0f5be2e81aebbcc585e07b2c98702b44.1742852847.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289169944.14745.7163030171233610939.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     a8d39a62c6f5ad76b8a1ebfbf10dd9fe8ca2bbcc
Gitweb:        https://git.kernel.org/tip/a8d39a62c6f5ad76b8a1ebfbf10dd9fe8ca2bbcc
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:56:03 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:20:28 +01:00

objtool: Remove redundant opts.noinstr dependency

The --noinstr dependecy on --link is already enforced in the cmdline arg
parsing code.  Remove the redundant check.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/0ead7ffa0f5be2e81aebbcc585e07b2c98702b44.1742852847.git.jpoimboe@kernel.org
---
 tools/objtool/check.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ac21f28..0caabf0 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -340,12 +340,7 @@ static void init_insn_state(struct objtool_file *file, struct insn_state *state,
 	memset(state, 0, sizeof(*state));
 	init_cfi_state(&state->cfi);
 
-	/*
-	 * We need the full vmlinux for noinstr validation, otherwise we can
-	 * not correctly determine insn_call_dest(insn)->sec (external symbols
-	 * do not have a section).
-	 */
-	if (opts.link && opts.noinstr && sec)
+	if (opts.noinstr && sec)
 		state->noinstr = sec->noinstr;
 }
 

