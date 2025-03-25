Return-Path: <linux-tip-commits+bounces-4462-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15617A6EBBC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620553AA5C5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA4A257428;
	Tue, 25 Mar 2025 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uv0FcZqC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UDZ4vAc5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8F62571D1;
	Tue, 25 Mar 2025 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891711; cv=none; b=gvJTDCLjmxcciODZRVBTUqlofte3C6RlSYfxlv2dMS7XVuAynUZ3FqiQWjLLF9LrkBSBmutUFn0vvhO12zDBPd5aN3nTqCx5C+Snu5i93blgs6erZ9vfUu3Q0GN9dxwbE/NMkSq3yITGfV7B25vbUfOpM3Ib9MIfShymkd3TViM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891711; c=relaxed/simple;
	bh=R5/Y1drLQwgMvbxLh9dIelr4GjzkicZ+F1kOgEMlHkU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Em1bz7uvnAtqB3PbEFSQ6qrqCPCPbxJkhpyT4IAGCLpKgqFJTl4kdGaxsPNRHj1TxxbGpyj7f6lrcWF0jFFMDElIpodUziqNbVGLcc34b9Y1U9l2EBXY/rJPh1YbR+Wefe8hCeAG/NLnXPEnLSX6vsOsWt8sed2sSarEp7OC4ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uv0FcZqC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UDZ4vAc5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:35:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742891707;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/yfm0fdo1Ru0tHqiNxX1NPVQkzd0AJYL4OW1RbQJek=;
	b=uv0FcZqCzm1NoEm8E/n8Hwxfi1Gtzugqn/Xs4bFJVmNp9pWCmLk7D2hSIenb0pVppKkhNU
	+nNNpekoAv/pNxu9Xa/ins63UaJi2dcM0wfl26g9H538muIPfEGkLfHbxesjjdsd1+2Uqw
	yvJfdBwOJoADMHCplNAgPB7J9Dz+HJa/EmR0BJWR9WPOrp/H49Dqv/0MGfPcarcbTVKs4w
	/QOn4VXzlw3ceG7KMCs147Y1zev3pg/D9mzIxV8I5GYoqOGXVZGwuM9EhKPVR0PKg1EOgU
	qLRounNRBs0AMC4vezBtVLlyNVfl4H4n/T+wVoZMHXpmWK3LqU3wT5+hsSUrYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742891707;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/yfm0fdo1Ru0tHqiNxX1NPVQkzd0AJYL4OW1RbQJek=;
	b=UDZ4vAc5MTqaqX4FqT07TuEpuGXq9fbWmoJejpBalb6RPIBy81oSItcqzdiUK7Dj9UkWkO
	PFuQ28DJPlZA8jCA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Silence more KCOV warnings
Cc: Ingo Molnar <mingo@kernel.org>, kernel test robot <lkp@intel.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <66a61a0b65d74e072d3dc02384e395edb2adc3c5.1742852846.git.jpoimboe@kernel.org>
References:
 <66a61a0b65d74e072d3dc02384e395edb2adc3c5.1742852846.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289170727.14745.16099451430887766436.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     6b023c7842048c4bbeede802f3cf36b96c7a8b25
Gitweb:        https://git.kernel.org/tip/6b023c7842048c4bbeede802f3cf36b96c7a8b25
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:55:57 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:20:26 +01:00

objtool: Silence more KCOV warnings

In the past there were issues with KCOV triggering unreachable
instruction warnings, which is why unreachable warnings are now disabled
with CONFIG_KCOV.

Now some new KCOV warnings are showing up with GCC 14:

  vmlinux.o: warning: objtool: cpuset_write_resmask() falls through to next function cpuset_update_active_cpus.cold()
  drivers/usb/core/driver.o: error: objtool: usb_deregister() falls through to next function usb_match_device()
  sound/soc/codecs/snd-soc-wcd934x.o: warning: objtool: .text.wcd934x_slim_irq_handler: unexpected end of section

All are caused by GCC KCOV not finishing an optimization, leaving behind
a never-taken conditional branch to a basic block which falls through to
the next function (or end of section).

At a high level this is similar to the unreachable warnings mentioned
above, in that KCOV isn't fully removing dead code.  Treat it the same
way by adding these to the list of warnings to ignore with CONFIG_KCOV.

Reported-by: Ingo Molnar <mingo@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/66a61a0b65d74e072d3dc02384e395edb2adc3c5.1742852846.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/Z9iTsI09AEBlxlHC@gmail.com
Closes: https://lore.kernel.org/oe-kbuild-all/202503180044.oH9gyPeg-lkp@intel.com/
---
 tools/objtool/check.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2f7aff1..cb66e6b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3485,6 +3485,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			    !strncmp(func->name, "__pfx_", 6))
 				return 0;
 
+			if (file->ignore_unreachables)
+				return 0;
+
 			WARN("%s() falls through to next function %s()",
 			     func->name, insn_func(insn)->name);
 			return 1;
@@ -3694,6 +3697,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		if (!next_insn) {
 			if (state.cfi.cfa.base == CFI_UNDEFINED)
 				return 0;
+			if (file->ignore_unreachables)
+				return 0;
+
 			WARN("%s: unexpected end of section", sec->name);
 			return 1;
 		}

